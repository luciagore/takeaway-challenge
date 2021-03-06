class Menu

  attr_reader :dishes
  def initialize(dishes)
    @dishes = dishes
  end

  def print_menu
    @dishes.map do |title, price|
      "%s £%.2f" % [title.to_s.capitalize, price]
    end.join(", ")
  end

  def available?(dish)
    !!dishes[dish]
  end

  def price(dish)
    dishes[dish]
  end
end
