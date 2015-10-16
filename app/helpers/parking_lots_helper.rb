module ParkingLotsHelper

  def referer
  @env['HTTP_REFERER'] || '/'
end
end
