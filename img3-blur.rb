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
      @dimensions[@input_row][@input_column] = 6
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

  def blur_image(size)
    # start at left
    row = @input_row 
    column = @input_column 

    f1 = :+
    f2 = :+
    count = 0
    min_col = column - size
    max_col = column + size
    max_row = row + size
    min_row = row - size
    column = @input_column - size

    diamond_loop = size * 4
    for j in 1..size do
      for i in 1..diamond_loop   do

        if row == max_row
          f1 = :-
        elsif row == min_row
          f1 = :+
        end

        if column == max_col
          f2 = :-
        elsif column == min_col
          f2 = :+
        end   

        @dimensions[row][column] = 1
        row = row.public_send(f1, 1) 
        column = column.public_send(f2, 1)
        count = count + 1
      end
      puts row
      puts column
      column = column + 1
      max_row = max_row - 1
      min_row = min_row - 1
      min_col = min_col - 1
      max_col = max_col - 1      
      diamond_loop = diamond_loop - 4
    end       
    puts row
    puts column
  end
end

image = Image.new(7,7)
image.input_pixel(3,4)
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
