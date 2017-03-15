var map;
function initMap() {
  var bounds = new google.maps.LatLngBounds();
  var NagpurCenter = {lat: 21.144378, lng: 79.080737};
//
    //1. Karol Bagh 1.Nehru place 2.Connaught Place 3.Lajpat Nagar 4.Sarojni Nagar 5.Select City Walk
  map = new google.maps.Map(document.getElementById('map'), {
    center: NagpurCenter,
    zoom: 12
  });
  var marker = new google.maps.Marker({
      position: NagpurCenter,
      map: map,
      title: 'Hello World!'
    });
  //var contentString = //Hit a url here to get data!;
    var infowindow;
      $( document ).ready(function() {
        $.getJSON("/parkings.json", function(data, status){
        //$.getJSON("http://aditya.com:3000/parkings.json", function(data, status){
            markers=setMarkers(map,data);
             infowindow=setInfoWindows(markers,data);
         });
      });
  bounds.extend(marker.position);
  map.fitBounds(bounds);
  var listener = google.maps.event.addListener(map, "idle", function () {
    map.setZoom(12);
  google.maps.event.removeListener(listener);
  });
var i=0;
  window.setInterval(function(){
    $( document ).ready(function() {
      $.getJSON("http://localhost:3000/parkings.json", function(data, status){
    //  $.getJSON("http://aditya.com:3000/parkings.json", function(data, status){
          // alert("Data: " + JSON.stringify(data) + "\nStatus: " + status);
          infowindow.close()
          infowindow=setInfoWindows(markers,data);
          console.log(data[0].id);
       });
    });
  }, 10000);
  var centerControlDiv = document.createElement('div');
  var centerControl = new CenterControl(centerControlDiv, map,NagpurCenter);
  centerControlDiv.index = 1;
  map.controls[google.maps.ControlPosition.BOTTOM_LEFT].push(centerControlDiv);
}
function findPath(start,end,map){
 var directionsDisplay = new google.maps.DirectionsRenderer;
 var directionsService = new google.maps.DirectionsService;
 directionsDisplay.setMap(map);
 directionsDisplay.setPanel(document.getElementById('right-panel'));
   calculateAndDisplayRoute(directionsService, directionsDisplay,start,end);
}
function calculateAndDisplayRoute(directionsService, directionsDisplay,startLoc,endLoc) {
 var start = startLoc;
 var end = endLoc;
 directionsService.route({
   origin: start,
   destination: end,
   travelMode: google.maps.TravelMode.DRIVING
 }, function(response, status) {
   if (status === google.maps.DirectionsStatus.OK) {
     directionsDisplay.setDirections(response);
   } else {
     window.alert('Directions request failed due to ' + status);
   }
 });
}
function CenterControl(controlDiv, map,NagpurCenter) {
 // Set CSS for the control border.
 var controlUI = document.createElement('div');
 controlUI.style.backgroundColor = '#607D8B';
 controlUI.style.border = '2px solid  #D9D9D7';
 controlUI.style.borderRadius = '3px';
 controlUI.style.boxShadow = '0 2px 6px rgba(0,0,0,.3)';
 controlUI.style.cursor = 'pointer';
 controlUI.style.marginBottom = '22px';
 controlUI.style.textAlign = 'center';
 controlUI.title = 'Click to recenter the map';
 controlDiv.appendChild(controlUI);
 // Set CSS for the control interior.
 var controlText = document.createElement('div');
 controlText.style.color = '#D9D9D7';
 controlText.style.fontFamily = 'Roboto,Arial,sans-serif';
 controlText.style.fontSize = '16px';
 controlText.style.lineHeight = '38px';
 controlText.style.paddingLeft = '5px';
 controlText.style.paddingRight = '5px';
 controlText.innerHTML = 'Find me the nearest parking!';
 controlUI.appendChild(controlText);
 // Setup the click event listeners: simply set the map to Chicago.
 controlUI.addEventListener('click', function() {
  var location=getGeolocation(NagpurCenter);
 });
}
function getGeolocation(NagpurCenter){
var initialLocation;
var browserSupportFlag =  new Boolean();
var end = {lat: 21.144378, lng: 79.080737};
  // Try W3C Geolocation (Preferred)
  if(navigator.geolocation) {
    browserSupportFlag = true;
    navigator.geolocation.getCurrentPosition(function(position) {
      initialLocation = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);
      map.setCenter(initialLocation);
      findShortestDistance();
      findPath(initialLocation,end,map);
      start=initialLocation;
      var node = document.getElementById("placeholder");
      if (node.parentNode) {
        node.parentNode.removeChild(node);
      }
    }, function() {
      handleNoGeolocation(browserSupportFlag);
    });
  }
  // Browser doesn't support Geolocation
  else {
    browserSupportFlag = false;
    handleNoGeolocation(browserSupportFlag);
  }
  function handleNoGeolocation(errorFlag) {
    if (errorFlag == true) {
      alert("Geolocation service failed.");
      initialLocation = NagpurCenter;
    } else {
      alert("Your browser doesn't support geolocation. We've placed you in Siberia.");
      initialLocation = NagpurCenter;
    }
    map.setCenter(initialLocation);
  }
  return initialLocation;
}
/*
findShortestDistance(origin,destination){
  var service = new google.maps.DistanceMatrixService();
service.getDistanceMatrix(
    {
        origins: [origin],
        destinations: [destination],
        travelMode: google.maps.TravelMode.DRIVING,
        avoidHighways: false,
        avoidTolls: false
    },
    callback
);
function callback(response, status) {
    var orig,dest,dist;
    if(status=="OK") {
        orig.value = response.destinationAddresses[0];
        dest.value = response.originAddresses[0];
        dist.value = response.rows[0].elements[0].distance.text;
    } else {
        alert("Error: " + status);
    }
}
}
*/
function setMarkers(map,data){
 var marker, i
 markers= new Array();
for(i=0; i<data.length;i++){
  var coordinates = {lat:parseFloat(data[i].lat) , lng: parseFloat(data[i].lng)};
  var info =data[i].name
  var marker = new google.maps.Marker({
          map: map, title: info , position: coordinates
        });
        map.setCenter(marker.getPosition())
        markers[i]=marker;
}
return markers;
}
function setInfoWindows(markers,data){
  var infowindow = new google.maps.InfoWindow({
               content: ''
           });
  for(i=0; i<data.length;i++){
  contentString=
 '<center><h3 id="firstHeading" class="firstHeading">'+data[i].name+'</h3></center>'+
 '<div id="bodyContent">'+
 '<p> Total Capacity:'+data[i].total_capacity+'</p>'+
 '<p> Filled: '+data[i].filled+'</p>'+
 '<p> Current Rate(per hour):'+data[i].cost+'</p>'+
 '</div>'+
 '<a href="/parkings/'+data[i].id+'" class="btn btn-primary">Show Complete Status</a>';
// '<a href="http://localhost:3000/parkings/'+data[i].id+'" class="btn btn-primary">Show Complete Status</a>';
          var marker=markers[i];
         google.maps.event.addListener(marker,'click', (function(marker,contentString,infowindow){
         return function() {
           infowindow.close();
            infowindow.setContent(contentString);
            infowindow.open(map,marker);
         };
       })(marker,contentString,infowindow));
}
return infowindow;
}