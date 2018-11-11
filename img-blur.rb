class Image
  def initialize(array)
    @array = array
  end 

  def find_coordinates
    count = 0
    @coordinates = Array.new
    @array.each {|arr| 
      if arr.index(1)
        @coordinates << [count,arr.index(1)]
      end
      count = count + 1
    }
  end

  def blur_coordinates
    @blur_coordinates = Array.new
    @coordinates.each {|coor|
      @blur_coordinates << [ coor[0] -1, coor[1] ]
      @blur_coordinates << [ coor[0], coor[1] - 1 ]
      @blur_coordinates << [ coor[0], coor[1] + 1 ]
      @blur_coordinates << [ coor[0] +1, coor[1] ]
    }
  end

  def remove_duplicates_blur_coordinates
    @blur_coordinates = @blur_coordinates.uniq
  end

  def filter_blur_coordinates
    @blur_coordinates.each {|blur_coor|
      if blur_coor[0] == -1 || blur_coor[1] == -1 || blur_coor[0] == @array.length || blur_coor[1] == @array.length
        blur_coor.pop(2)
      end
    }
  end

  def remove_nil_blur_coordinates
    @blur_coordinates.delete([])
  end

  def image_blur
    @blur_coordinates.each {|blur_coor|
      @array[blur_coor[0]][blur_coor[1]] = 1
    }
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
image.find_coordinates
image.blur_coordinates
image.remove_duplicates_blur_coordinates
image.filter_blur_coordinates
image.remove_nil_blur_coordinates
image.image_blur
image.output_image
