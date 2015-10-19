class AddImageToUsers < ActiveRecord::Migration
  def up
    add_column :users, :qrcode_uid,  :string
    add_column :users, :qrcode_name, :string  # Optional - if you want urls
                                        # to end with the original filename

    end

    def down
      remove_column :users, :image_uid,  :string
      remove_column :users, :image_name, :string  # Optional - if you want urls
                                          # to end with the original filename
    end
end
