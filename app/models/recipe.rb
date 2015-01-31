class Recipe < ActiveRecord::Base
  belongs_to :user

  # paperclip: user can upload photos 

  has_attached_file :image, :styles => { :medium => "200x200>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_presence :image  
  validates_attachment_size :image, :less_than => 5.megabytes  
  validates_attachment_content_type :image, :content_type => %w(image/jpeg image/png)  
end
