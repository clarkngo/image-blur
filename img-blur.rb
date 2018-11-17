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
    puts @coordinates.inspect
  end

  def blur_size(size)
    @blur_size = size
  end

=begin
  def min_max_blur_coordinates
    @coordinates.each {|coor|
      puts coor.inspect
      distance = @blur_size
      steps = 4 * @blur_size
      f = :+
      g = :+
      for m in (distance).downto(1)
        coor_max_y = coor[0] + distance
        coor_min_y = coor[0] - distance
        coor_max_x = coor[1] + distance
        coor_min_x = coor[1] - distance
        y = coor[0]
        x = coor[1] - distance
        for i in 1..steps
          @blur_coordinates.push([y,x])
          y = y.public_send(f, 1)
          if y == coor_max_y
            f = :-
          elsif y == coor_min_y
            f = :+
          end
          x = x.public_send(g, 1)
          if x == coor_max_x
            g = :-
          elsif x == coor_min_x
            g = :+
          end
        end
        distance = distance - 1
      end
    }
    puts @blur_coordinates.inspect
  end
=end
  def min_max_blur_coordinates
    for m in 0..@coordinates.length - 1 do
      x = @coordinates[m][0]
      y = @coordinates[m][1]
      puts x
      puts y
      for i in x-@blur_size..x - 1 do
        for j in y-@blur_size..2 * i - 3 do
          @blur_coordinates.push([i, y - (i - j)])
        end
      end
    end
    puts @blur_coordinates.inspect
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
  [0, 0, 0, 0, 0, 1, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
])
image.find_coordinates
image.blur_size(3)
image.min_max_blur_coordinates
image.remove_duplicates_blur_coordinates
image.filter_blur_coordinates
image.remove_nil_blur_coordinates
image.image_blur
image.output_image
