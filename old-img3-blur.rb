class Image
  def initialize(rows, columns)
      @rows = rows
      @columns = columns
      @dimensions = Array.new(rows){Array.new(columns)}
      @symbol = 0
      for j in 0..@columns - 1
          for i in 0..@rows - 1
              @dimensions[i][j] = @symbol
          end
      end
  end 

  # inserts 1 to desired row/column
  def input_pixel(input_row, input_column)
      @input_row = input_row
      @input_column = input_column 
  end
  
  def update_image
      @dimensions[@input_row][@input_column] = 1
  end

  def output_image
     for i in 0..@rows - 1
       puts "#{@dimensions[i]}"
     end
  end
  

  def copy_image
    @copyArr = @dimensions
  end
  
  def output_copy_image
    for i in 0..@rows - 1
      puts "#{@copyArr[i]}"
    end
  end

  def plot_origin
    @pixel_location = []
    for j in 0..@columns - 1
      for i in 0..@rows - 1
          if @dimensions[i][j] == 1
            @pixel_location << [i, j]
          end
      end
    end
  end

  def show_pixel_location
    puts "#{@pixel_location}"
  end

  def blur_image(n)
    for j in 1..n 
      for i in 0..@pixel_location.length - 1
          row = @pixel_location[i][0]
          column = @pixel_location[i][1]

          # if within boundary min of 0, top
          if row - j != - 1
            # top
            @dimensions[row - j][column] = 1
            if column - j != - 1 && j > 1
              # top's left and right
              @dimensions[row - j + 1][column - 1] = 1
              @dimensions[row - j + 1][column + 1] = 1
            end
          end

          # if within boundary max of image size, bottom
          if row + j != @rows 
            # bottom
            @dimensions[row + j][column] = 1
            if column - j != - 1 && j > 1
              # bottom's left and right
              @dimensions[row + j - 1][column - 1] = 1
              @dimensions[row + j - 1][column + 1] = 1
            end
          end

          # if within boundary min of 0, left
          if column - j != - 1
            # left
            @dimensions[row][column - j] = 1
            if row - j != - 1 && j > 1
              # left's top and bottom
              @dimensions[row - 1][column - j + 1] = 1
              @dimensions[row + 1][column - j + 1] = 1
            end
          end

          # if within boundary max of image size, right
          if column + j != @columns 
            # right
            @dimensions[row][column + j] = 1
            if row - j != - 1 && j > 1
              # right's top and bottom
              @dimensions[row - 1][column + j - 1] = 1
              @dimensions[row + 1][column + j - 1] = 1
            end            
          end

          if row - j != -1 && column - j != - 1
            # top left
            # @dimensions[row - j + 1][column - j + 1] = 1
          end

          if row - j != -1 && column + j != @columns 
            # top right
            # @dimensions[row - j + 1][column + j - 1] = 1
          end

          

      end
    end
  end
end

image = Image.new(15,15)
image.input_pixel(7,7)
image.update_image
# image.input_pixel(11,2)
# image.update_image
# image.copy_image
# image.output_image
# image.copy_image
puts "\n"
# image.output_copy_image
puts "\n"
image.plot_origin
image.show_pixel_location
image.blur_image(2)
image.output_image
