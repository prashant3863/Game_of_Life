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
  
  def live_neighbours_around_cell(cell)
    live_neighbours = []
    #North
    if cell.y > 0
      candidate = self.cell_grid[cell.y - 1][cell.x]
      live_neighbours << candidate if candidate.alive?
    end    
    #Nort-East
    if cell.y > 0 && cell.x < (col-1)
      candidate = self.cell_grid[cell.y - 1][cell.x + 1]
      live_neighbours << candidate if candidate.alive?
    end
    
    
    
