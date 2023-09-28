module Shape
  def move(x, y)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def accept(visitor)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end


class Dot 
  include Shape

    def move(x, y)
        [x, y] 
    end

    def accept(visitor)
        visitor.visit_dot(self)
    end
end


class Circle 
  include Shape

    def move(x, y)
        [x, y] 
    end

  def accept(visitor)
    visitor.visit_circle(self)
  end
end


class Rectangle 
  include Shape

    def move(x, y)
        [x, y] 
    end
    
    def accept(visitor)
        visitor.visit_rectangle(self)
    end
end


class CompoundShape 
  include Shape

    def move(x, y)
        [x, y] 
    end

  def accept(visitor)
    visitor.visit_compound_shape(self)
  end
end


module Visitor
  def visit_dot(dot)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def visit_circle(circle)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def visit_rectangle(rectangle)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def visit_compound_shape(compound_shape)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end


class XMLExportVisitor include Visitor
  def visit_dot(dot)
    puts "Exporting Dot with id: #{dot.object_id} and coordinates: #{dot.move(1, 2)}"
  end

  def visit_circle(circle)
    puts "Exporting Circle with id: #{circle.object_id} and coordinates: #{circle.move(3, 4)}"
  end

  def visit_rectangle(rectangle)
    puts "Exporting Rectangle with id: #{rectangle.object_id} and coordinates: #{rectangle.move(5, 6)}"
  end

  def visit_compound_shape(compound_shape)
    puts "Exporting CompoundShape with id: #{compound_shape.object_id} and coordinates: #{compound_shape.move(7, 8)}"
  end
end


class App
  def initialize
    @all_shapes = []
  end

  def add_shape(shape)
    @all_shapes << shape
  end

  def export
    export_visitor = XMLExportVisitor.new

    @all_shapes.each do |shape|
      shape.accept(export_visitor)
    end
  end
end


app = App.new
app.add_shape(Dot.new)
app.add_shape(Circle.new)
app.add_shape(Rectangle.new)
app.add_shape(CompoundShape.new)

app.export