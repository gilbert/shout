class AddAdminOnlyToUrlWord < ActiveRecord::Migration[6.0]
  def change
    add_column :url_words, :admin_only, :boolean, default: false
  end
end
