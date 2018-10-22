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

  def check_pixel
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

  def blur_image
    for i in 0..@pixel_location.length - 1
        puts "#{@pixel_location[i]}"
        row = @pixel_location[i][0]
        column = @pixel_location[i][1]

        if row - 1 != - 1
          @dimensions[row - 1][column] = 1
        end

        if row + 1 != @rows 
          @dimensions[row + 1][column] = 1
        end

        if column - 1 != - 1
          @dimensions[row][column - 1] = 1
        end

        if column + 1 != @columns 
          @dimensions[row][column + 1] = 1
        end
    end
  end
end

image = Image.new(5,5)
image.input_pixel(3,4)
image.update_image
image.input_pixel(1,2)
image.update_image
image.copy_image
image.output_image
image.copy_image
puts "\n"
image.output_copy_image
puts "\n"
image.check_pixel
image.show_pixel_location
image.blur_image
image.output_image