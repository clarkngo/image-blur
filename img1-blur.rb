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

    def input_pixel(input_row, input_column)
        @input_row = input_row - 1
        @input_column = input_column - 1
    end

    def change_image
        @dimensions[@input_row][@input_column] = 1
    end

    def output_image
       for i in 0..@rows - 1
         puts "#{@dimensions[i]}"
       end
    end

end

image = Image.new(5,5)
image.input_pixel(2,3)
image.change_image
image.output_image

