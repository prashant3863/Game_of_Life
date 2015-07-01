class Cell
  attr_accessor :alive, :x, :y
  
  def initialize(x=0 y=0)
    @x = x
    @y = y
    @alive = false
  end
  
  def alive?
    alive
  end
  
  def dead?
    !alive
  end
  
  def die!
    @alive = false
  end
  
  def revive!
    @alive = true
  end
end

class World
  attr_accessor :rows, :cols, :cell_grid, :cells
  
  def initialize(rows=3, cols=3)
    @rows = rows
    @cols = cols
    @cells = []
    
    @cell_grid = Array.new(rows) do |row|
      Array.new(cols) do |col|
        cell = Cell.new(col, row)
        cells << cell
        cell
      end
    end
  end
  
      
