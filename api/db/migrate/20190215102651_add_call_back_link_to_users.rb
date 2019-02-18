class AddCallBackLinkToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :callback_link, :string
  end
end
