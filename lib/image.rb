class Image
  attr_accessor :data

  def initialize(data)
    @data = data
  end

  def blur
    find_coordinates
    blur_coordinates
    remove_duplicates_blur_coordinates
    filter_blur_coordinates
    remove_nil_blur_coordinates
    image_blur
    return Image.new(@data)
  end

  def find_coordinates
    @coordinates = Array.new
    for i in 0..@data.length - 1 do
      for j in 0..@data[i].length - 1 do
          @coordinates << [i, j] if @data[i][j] == 1
      end
    end
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
      if blur_coor[0] == -1 || blur_coor[1] == -1 || blur_coor[0] == @data.length || blur_coor[1] == @data.length
        blur_coor.pop(2)
      end
    }
  end

  def remove_nil_blur_coordinates
    @blur_coordinates.delete([])
  end

  def image_blur
    @blur_coordinates.each {|blur_coor|
      @data[blur_coor[0]][blur_coor[1]] = 1
    }
  end

=begin  
  def output_image

    # iterate for each array inside the 2d array
    # convert each array to string
    @data.each {|arr| puts arr.join("")}
  end  
=end  
end
