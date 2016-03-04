class Restaurant < ActiveRecord::Base
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  belongs_to :user
  has_many :reviews,
      -> { extending WithUserAssociationExtension },
      dependent: :destroy
  validates :name, length:{minimum:3}, uniqueness: true

  # def average_rating
  #   return 'N/A' if reviews.none?
  #   puts reviews.count
  #   reviews.inject(0) {|memo, review| memo + review.rating}/reviews.count
  # end

  def average_rating
    reviews.average(:rating)
  end

end
