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
  
  def initialize(rows=5, cols=5)
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
    #East
    if cell.x < (cols - 1)
      candidate = self.cell_grid[cell.y][cell.x + 1]
      live_neighbours << candidate if candidate.alive?
    end
    #South-East
    if cell.x < (cols-1) && cell.y < (rows - 1)
      candidate = self.cell_grid[cell.y+1][cell.x+1]
      live_neighbours << candidate if candidate.alive?
    end
    #South-West
    if cell.y < (rows - 1) && cell.x > 0
      candidate = self.cell_grid[cell.y + 1][cell.x - 1]
      live_neighbours << candidate if candidate.alive?
    end
    #West
    if cell.x > 0
      candidate = self.cell_grid[cell.y][cell.x - 1]
      live_neighbours << candidate if candidate.alive?
    end
    #North-West
    if cell.x > 0 && cell.y > 0
      candidate = self.cell_grid[cell.y - 1][cell.x - 1]
      live_neighbours << candidate if candidate.alive?
    end
    
    live_neighbours
  end
  
  def live_cells
    cells.select{|cell| cell.alive}
  end
  
  def populate
  #need to take input from user to initialze the first gen
  end
  
end

class Game
  attr_accessor :world, :seeds
  def initialize(worls=World.new, seeds=[0])
    @world = world
    seeds.each do |seed|
      @world.cell_grid[seed[0]][seed[1]].alive = true
    end
  end  
  
  def generation
  # all game conditions comes here
    next_round_live_cells = []
    next_round_dead_cells = []
    
    @world.cells.each do |cell|
      neighbour_count = self.world.live_neighbours_around_cell(cell).count
      
      #Rule1
      if cell.alive? && neighbour_count < 2
        next_round_dead_cells << cell
      end
      
      #Rule2
      if cell.alive? && ([2,3].include?neighbour_count)
        next_round_live_cells << cell
      end
      
      #Rule3
      if cell.alive? && neighbur_count>3
        next_round_dead_cells << cell
      end
      
      #Rule4
      if cell.dead? && neighbour_count == 3
        next_round_live_cells << cell
      end
    end
    
    next_round_live_cells.each do |cell|
      cell.revive!
    end
    next_round_dead_cells.each do |cell|
      cell.die!
    end  
  end    
   
end    
    
