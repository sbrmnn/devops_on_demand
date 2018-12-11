class AddProfilePhotoToFreelancers < ActiveRecord::Migration[5.1]
  def change
    add_column :freelancers, :profile_photo, :string
  end
end
