ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span "Welcome to ParkEasy Admin Panel"
      #  small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    parking=Parking.find_by(:id =>current_admin_user.parking_id)

     columns do
       column do
         panel "Recent Transactions" do
           transactions=parking.transactions.order('created_at desc').limit(5)
           ul do
               transactions.each do |transaction|
               user=User.find_by(:id => transaction.user_id)
               li link_to(user.name, admin_transaction_path(transaction))
             end
           end
         end
       end

       parking_lots=parking.parking_lots

       column do
         panel "Empty slots" do
           ul do
               parking_lots.each do |lot|
               if (lot.availaible)
                 li "#{lot.slot_id} Empty"
               end
             end
           end
         end
       end

       column do
         panel "Filled slots" do
               i=0
               ul do
               parking_lots=parking_lots.where(:availaible =>false)
               parking_lots.each do |lot|
                 transaction=Transaction.find_by(:parking_lot_id => lot.id)
                 Rails.logger.debug { "#{i}#{transaction}" }
                 i=i+1
                 if !(transaction.nil?)

                 user=User.find(transaction.user_id)

                 if (!lot.availaible)
                   li span "#{lot.slot_id} Filled"
                   span link_to(user.name,admin_user_path(user))
                 end
                 end
               end
           end
         end
       end

     end

  end # content
end
