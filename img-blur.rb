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

  def blur_size(size)
    @blur_size = size
  end

  def min_max_blur_coordinates
    @coordinates.each {|coor|
      # top
      @blur_coordinates << [ coor[0] - @blur_size , coor[1] ]
      # right
      @blur_coordinates << [ coor[0], coor[1] + @blur_size  ]
      # bottom
      @blur_coordinates << [ coor[0] + @blur_size , coor[1] ]
      # left
      @blur_coordinates << [ coor[0], coor[1] - @blur_size  ]
    }
  end

  def min_max_values
    @max_y = @coordinates[0][1] + @blur_size
    @min_y = @coordinates[0][1] - @blur_size
    @max_x = @coordinates[0][0] + @blur_size
    @min_x = @coordinates[0][0] - @blur_size
  end

  def top_mid_blur_coordinates
    width = 1
    current_min_y = @min_y + 1
    current_mid_x = @coordinates[0][1] - 1
    for i in 1..@blur_size do
      width = width + 2
      for j in 1..width
        @blur_coordinates << [current_min_y, current_mid_x]
        current_mid_x = current_mid_x + 1
      end
      current_min_y = current_min_y + 1
      current_mid_x = current_mid_x - width - 1
    end
  end

  def bottom_mid_blur_coordinates
    max_width = @max_x - 2
    puts max_width
    current_mid_y = @max_y - 2
    puts current_mid_y
    current_mid_x = @coordinates[0][1] - 2
    for i in 1..@blur_size do
      for j in 1..max_width
        @blur_coordinates << [current_mid_y, current_mid_x]
        current_mid_x = current_mid_x + 1
      end
      max_width = max_width - 2
      current_mid_y = current_mid_y + 1
      current_mid_x = current_mid_x - max_width - 1
    end
  end

  def remove_duplicates_blur_coordinates
    @blur_coordinates = @blur_coordinates.uniq
  end

  def filter_blur_coordinates
    @blur_coordinates.each {|blur_coor|
      if blur_coor[0] <= -1 || blur_coor[1] <= -1 || blur_coor[0] >= @array_2d.length || blur_coor[1] >= @array_2d.length
        blur_coor.pop(2)
      end
    }
    puts @blur_coordinates.inspect
  end

  def remove_nil_blur_coordinates
    @blur_coordinates.delete([])
  end

  def image_blur
    for i in 0..@blur_coordinates.length - 1 do
      @array_2d[@blur_coordinates[i][0]][@blur_coordinates[i][1]] = 1
    end
  end

  def output_image
    # iterate for each array inside the 2d array
    # convert each array to string
    @array_2d.each {|arr| puts arr.join("")}
  end  
end

image = Image.new([
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 1, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
])
image.find_coordinates
image.blur_size(3)
image.min_max_blur_coordinates
image.min_max_values
image.top_mid_blur_coordinates
image.bottom_mid_blur_coordinates
image.remove_duplicates_blur_coordinates
image.filter_blur_coordinates
image.remove_nil_blur_coordinates
image.image_blur
image.output_image
