class Review < ActiveRecord::Base
  validates :rating, inclusion: (1..5)
  belongs_to :restaurant
  belongs_to :user
  has_many :endorsements
  validates :user, uniqueness: { scope: :restaurant, message: "has reviewed this restaurant already" }


  def get_email(user_id)
    user = User.find(user_id)
    user.email
  end

end
