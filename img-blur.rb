class Image
  def initialize(array)
    @array = array
  end 

  def output_image
    # iterate for each array inside the array
    # convert each array to string
    @array.each {|arr| puts arr.join("")}
  end  
end

image = Image.new([
  [0, 0, 0, 0],
  [0, 1, 0, 0],
  [0, 0, 0, 1],
  [0, 0, 0, 0]
])
image.output_image
