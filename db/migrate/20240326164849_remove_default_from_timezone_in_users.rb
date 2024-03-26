class RemoveDefaultFromTimezoneInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :timezone, from: "YourDefaultTimeZone", to: nil
  end
end
