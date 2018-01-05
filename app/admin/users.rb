ActiveAdmin.register User do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params :email, :admin

  index do
    selectable_column
    column :id
    column :user_name
    column :first_name
    column :last_name
    column :email
    column :provider
    column :admin
    column :created_at
  end

end
