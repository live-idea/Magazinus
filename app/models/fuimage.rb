class Fuimage < ActiveRecord::Base
  has_attachment :content_type => :image,
                 :storage => :file_system,
                 :size => 1..5.megabytes,
                 :resize_to => '320x200>',
                 :thumbnails => { :thumb => '100x100>' }

  #validates_as_attachment
  belongs_to      :good
  #validations
  validates_presence_of :filename
end
