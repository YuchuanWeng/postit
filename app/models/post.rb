class Post < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories

  validates :title, presence: true
  #Validation is always added in the model layer
  #Validation won't be trigger until you make an 'action'
  #check the error for the validation false : post.errors.full_message
  #                                          object.errors
  #since the error is already only the object itself, then
end

