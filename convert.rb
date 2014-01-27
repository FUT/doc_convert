require 'RMagick'
require 'pry'
require 'htmltoword'

%w{agreement annex correct}.each do |file|
  original_pdf = File.open("tmp/#{file}.pdf", 'rb').read
  images = Magick::Image.from_blob(original_pdf) do
    self.format = 'PDF'
    self.quality = 100
    self.density = 144
  end

  images.each_with_index do |image, i|
    image.format = 'JPG'
    image.to_blob
    image.write("tmp/_#{file}_#{i}.png")
  end
end

