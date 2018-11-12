require 'minitest/autorun'
class Point
    def initialize (x,y)
      @x = x
      @y = y
    end
    def get_x
      @x
    end
    def get_y
      @y
    end
end
class Rectangle
  def initialize (p1, p2)
    @point_a = p1
    @point_b = p2
  end

    def area
      x = @point_a.get_x - @point_b.get_x
      y = @point_a.get_y - @point_b.get_y
      (x * y).abs
    end
end
class Triangle
  def initialize (p1, p2, p3)
    @point_a = p1
    @point_b = p2
    @point_c = p3
  end

    def area
      p0 = @point_c
      area2 = 0
      [@point_a, @point_b, @point_c].each { |p|
         area2 += p0[0]*p[1] - p[0]*p0[1]
         p0 = p
      }
      (area2 / 2.0).abs
    end
end

class Circle
  def initialize (p1, r)
    @point_a = p1
    @radius = r
  end

    def area
      3.14 * @radius.abs2
    end
end

class Scene
  def initialize (array)
    @shapes = array
  end

    def shape_count
      @shapes.count
    end
    def total_area
      area = 0
      @shapes.each do |shape|
        area += shape.area
      end
      return area
    end
    def add_shape (add)
      @shapes.push(add)
    end
    def remove_shape (remove)
      @shapes.each do |shape|
        if remove equal? shape
          @shapes.delete(shape)
          return
        end
      end
    end
end

#### Minitest/spec

describe Point do
  it 'can be initialized' do
    @a_point = Point.new(1, 2)

    @a_point.get_x.must_equal 1
    @a_point.get_y.must_equal 2
  end
end


describe Rectangle do
  it "can be initialized" do
    shape = Rectangle.new(Point.new(1,2), Point.new(3,4))
    shape.must_be_instance_of Rectangle
  end

  it 'can track area' do
    shape = Rectangle.new(Point.new(1,1), Point.new(3,3))
    shape.area.must_equal 4
  end
end

describe Triangle do
  it "can be initialized" do
    shape = Triangle.new(Point.new(1,1), Point.new(3,1), Point.new(2,3))
    shape.must_be_instance_of Triangle
  end

  it 'can track area' do
    shape = Triangle.new(Point.new(1,1), Point.new(3,1), Point.new (2,3))
    shape.area.must_equal 2
  end
end

describe Circle do
  it "can be initialized" do
    shape = Circle.new(Point.new(2,2), 1)
    shape.must_be_instance_of Circle
  end

  it 'can track area' do
    shape = Circle.new(Point.new(2,2), 1)
    shape.area.must_equal 1
  end
end

describe Scene do
  it "can be initialized" do
    scene = [Circle.new(Point.new(2,2), 1), Triangle.new(Point.new(1,1), Point.new(3,1), Point.new(2,3))]
    scene.must_be_instance_of Scene
  end

  it 'can track count' do
    scene = [Circle.new(Point.new(2,2), 1), Triangle.new(Point.new(1,1), Point.new(3,1), Point.new(2,3))]
    scene.shape_count.must_equal 2
  end
  it 'can track area' do
    scene = [Circle.new(Point.new(2,2), 1), Triangle.new(Point.new(1,1), Point.new(3,1), Point.new(2,3))]
    scene.total_area.must_equal 3
  end
end
