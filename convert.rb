require 'RMagick'
require 'pry'
require 'htmltoword'

pdf_file_name = "test.pdf"
original_pdf = File.open(pdf_file_name, 'rb').read
images = Magick::Image.from_blob(original_pdf) do
  self.format = 'PDF'
  self.quality = 100
  self.density = 144
end

`rm *.png`
images.each_with_index do |image, i|
  image.format = 'JPG'
  image.to_blob
  image.write("page_#{i}.png")
end

