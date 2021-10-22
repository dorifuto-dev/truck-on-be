class Weather
  attr_reader :temp, :conditions

  def initialize(data)
    @temp = data[:temp]
    @conditions = data[:weather].first[:description]
  end
end
