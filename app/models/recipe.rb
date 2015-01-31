class Recipe < ActiveRecord::Base
  belongs_to :user

  # paperclip: user can upload photos 

  has_attached_file :image, :styles => { :medium => "200x200>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_presence :image  
  validates_attachment_size :image, :less_than => 5.megabytes  
  validates_attachment_content_type :image, :content_type => %w(image/jpeg image/png)  

  after_create :guaguin_parse



  def defcolor(r,g,b)
		count = 0
		shortest_dis = 441
		shortest_num = 0
		color_rgb = [	[255, 0, 0],[255, 255, 0],[0,128,0],[0, 0, 255],[77,57,0],[0,0,0],[255,255,255] ]
		color_rgb.each do |color|
			between_dis = Math.sqrt( (color[0]-r)**2 + (color[1]-g)**2 + (color[2]-b)**2 )
			if between_dis < shortest_dis
				shortest_dis = between_dis
				shortest_num = count
			end
			count=count+1
		end
		return shortest_num
	end

  def guaguin_parse
  	Gauguin::configuration.max_colors_count = 5
		Gauguin::configuration.color_similarity_threshold=25
		Gauguin::configuration.colors_limit=1000
		Gauguin::configuration.min_percentage_sum = 2

    color_array = ["red","yellow","green","blue","coffee","black","white"]
    return_hash = []

    result = Gauguin::Painting.new(self.image.queued_for_write[:original].path).palette
    return_pers=[0,0,0,0,0,0,0]

		result.keys.each do |key|
			num = defcolor(key.red,key.green,key.blue)
			return_pers[num] = return_pers[num] + key.percentage.to_f.round(3)
		end


		return_hash = Hash[color_array.zip(return_pers)]
		puts return_hash
		final =  return_hash.sort_by {|_key, value| value}.reverse

		self.high = final[0][0]
		self.medium = final[1][0]
		self.low =final[2][0]
		self.save
  end

end
