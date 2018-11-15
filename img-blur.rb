class Image
  def initialize(array_2d)
    @array_2d = array_2d
    @coordinates = Array.new
    @blur_coordinates = Array.new
  end 

  def find_coordinates
    for i in 0..@array_2d.length - 1 do
      for j in 0..@array_2d[i].length - 1 do
          @coordinates << [i, j] if @array_2d[i][j] == 1
      end
    end
  end

  def blur_coordinates
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
      if blur_coor[0] == -1 || blur_coor[1] == -1 || blur_coor[0] == @array_2d.length || blur_coor[1] == @array_2d.length
        blur_coor.pop(2)
      end
    }
  end

  def remove_nil_blur_coordinates
    @blur_coordinates.delete([])
  end

  def image_blur
    @blur_coordinates.each {|blur_coor|
      @array_2d[blur_coor[0]][blur_coor[1]] = 1
    }
  end

  def output_image
    # iterate for each array inside the 2d array
    # convert each array to string
    @array_2d.each {|arr| puts arr.join("")}
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

