module Visitable
  def accept(visitor)
    visitor.visit(self)
  end
end

class Product
  include Visitable

  attr_reader :name, :price
  def initialize(name:, price:)
    @name = name
    @price = price
  end
end

class Order
  include Visitable

  def initialize
    @products = []
  end

  def add_product(product)
    @products << product
  end

  def accept(visitor)
    @products.each do |product|
      product.accept(visitor)
    end
  end
end

class Visitor
  def visit(subject)
    raise NotImpelementedError.new
  end
end

class ProductsPrinterVisitor < Visitor
  def visit(subject)
    puts "Product: #{subject.name} - $#{subject.price}"
  end
end

class HalfPriceSimulatorVisitor < Visitor
  def visit(subject)
    puts "Product: #{subject.name} - after 50% discount: $#{subject.price / 2.0}"
  end
end


class TaxCalculatorVisitor < Visitor
  def visit(subject)
    tax = subject.price * 0.2 # Налог в размере 20% от цены продукта
    puts "Tax for Product: #{subject.name} - $#{tax}"
  end
end

product1 = Product.new(name: 'Table', price: 1000)
product2 = Product.new(name: 'Fork', price: 5)

order = Order.new
order.add_product(product1)
order.add_product(product2)

order.accept(ProductsPrinterVisitor.new)
order.accept(HalfPriceSimulatorVisitor.new)
order.accept(TaxCalculatorVisitor.new)