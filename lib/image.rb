class Image
  attr_accessor :data

  def initialize(data)
    @data = data
  end

  def blur
    return Image.new(@data)
end