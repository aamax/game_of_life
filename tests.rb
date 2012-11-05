require './gol.rb'
require 'pry'

describe Point do
  before :each do
    @p = Point.new(5, 5)
  end
end

describe Cell do
  before :each do
    @world = World.new  
    @cell = Cell.new(5,5, @world)    
  end
  
  it "should have no neighbors if it isn't touching any cells" do
    @cell.neighbors.should == []
  end
  
  it "should detect a neighbor at the NW" do
    neighbor = Cell.new(4,4, @world)
    @cell.neighbors.should == [neighbor]
  end
  
  it "should detect a neighbor at the N" do
    neighbor = Cell.new(5,4, @world)
    @cell.neighbors.should == [neighbor]
  end
  
  it "should detect a neighbor at the NE" do
    neighbor = Cell.new(6,4, @world)
    @cell.neighbors.should == [neighbor]
  end
  
  it "should detect a neighbor at the E" do
    neighbor = Cell.new(6,6, @world)
    @cell.neighbors.should == [neighbor]
  end
  
  it "should detect a neighbor at the SE" do
    neighbor = Cell.new(6,6, @world)
    @cell.neighbors.should == [neighbor]
  end
  
  it "should detect a neighbor at the S" do
    neighbor = Cell.new(5,6, @world)
    @cell.neighbors.should == [neighbor]
  end
  
  it "should detect a neighbor at the SW" do
    neighbor = Cell.new(4,6, @world)
    @cell.neighbors.should == [neighbor]
  end
  
  it "should detect a neighbor at the W" do
    neighbor = Cell.new(5,4, @world)
    @cell.neighbors.should == [neighbor]
  end

  it "should not detect a neighbor if it's not touching" do
    neighbor = Cell.new(5,7, @world)
    @cell.neighbors.should == []
  end
  
  context "empty cell" do
    before :each do
      @empties = @cell.empty_neighbors
    end
    
    it "should return empty cell at NW" do
      found = false
      @empties.each do |pt|
        if (pt.x == @cell.location.x - 1) && (pt.y == @cell.location.y - 1)
          found = true
          break
        end
      end
      found.should == true
    end
  
    it "should return empty cell at N" do
      found = false
      @empties.each do |pt|
        if (pt.x == @cell.location.x) && (pt.y == @cell.location.y - 1)
          found = true
          break
        end
      end
      found.should == true
    end
      
    it "should return empty cell at W" do
      found = false
      @empties.each do |pt|
        if (pt.x == @cell.location.x - 1) && (pt.y == @cell.location.y)
          found = true
          break
        end
      end
      found.should == true
    end
      
    it "should return empty cell at SW" do
      found = false
      @empties.each do |pt|
        if (pt.x == @cell.location.x - 1) && (pt.y == @cell.location.y - 1)
          found = true
          break
        end
      end
      found.should == true
    end
      
    it "should return empty cell at E" do
      found = false
      @empties.each do |pt|
        if (pt.x == @cell.location.x + 1) && (pt.y == @cell.location.y)
          found = true
          break
        end
      end
      found.should == true
    end
      
    it "should return empty cell at NE" do
      found = false
      @empties.each do |pt|
        if (pt.x == @cell.location.x + 1) && (pt.y == @cell.location.y - 1)
          found = true
          break
        end
      end
      found.should == true
    end
      
    it "should return empty cell at S" do
      found = false
      
      @empties.each do |pt|
        if (pt.x == @cell.location.x) && (pt.y == @cell.location.y + 1)
          found = true
          break
        end
      end
      found.should == true
    end
      
    it "should return empty cell at SE" do
      found = false
      @empties.each do |pt|
        if (pt.x == @cell.location.x + 1) && (pt.y == @cell.location.y + 1)
          found = true
          break
        end
      end
      found.should == true
    end
      
    it "should return all empty cells for single cell" do
      @cell.empty_neighbors.count.should == 8  
    end
  end
end

describe World do
  before :each do
    @world = World.new  
    @cell = Cell.new(5,5, @world)    
  end

  context "on a tick" do
    it "should mark cells with no neighbors to die" do
      @world.tick
      @cell.status.should == -1
    end
    
    it "should mark cells with 1 neighbor to die" do
      neighbor = Cell.new(4,5,@world)
      @world.tick
      @cell.status.should == -1
      neighbor.status.should == -1
    end
    
    it "should mark cells with 2 neighbors to live" do
      neighbor = Cell.new(4,4,@world)
      neighbor2 = Cell.new(4,6,@world)
      @cell.neighbors.count.should == 2
      @world.tick
      @cell.status.should == 0
    end

    it "should mark cells with  neighbors to live" do
      neighbor = Cell.new(4,4,@world)
      neighbor2 = Cell.new(4,6,@world)
      neighbor3 = Cell.new(6,6,@world)
      @cell.neighbors.count.should == 3
      @world.tick
      @cell.status.should == 0
    end
    
    it "should mark cells with 4 neighbors to die" do
      neighbor = Cell.new(4,4,@world)
      neighbor2 = Cell.new(4,6,@world)
      neighbor3 = Cell.new(6,6,@world)
      neighbor4 = Cell.new(6,4,@world)
      @cell.neighbors.count.should == 4
      @world.tick
      @cell.status.should == -1
    end
    
    it "should create new cell if an empty cell has 3 neighbors" do
      neighbor2 = Cell.new(4,6,@world)
      neighbor3 = Cell.new(6,6,@world)
      @world.tick
      
      new_cell = @world.cell_at(5,6)
      new_cell.should_not be nil
      new_cell.status.should == 1
    end
    
  end

  context "live_neighbors" do
    it "should return cell for NW cell check" do
      c2 = Cell.new(4,6, @world)
      c2 = Cell.new(6,6, @world)
      set = @world.live_neighbors(Point.new(4,4))
      set.count.should == 1
      set[0].location.x.should == 5
      set[0].location.y.should == 5
    end

    it "should return cell for N cell check" do
      set = @world.live_neighbors(Point.new(5,4))
      set.count.should == 1
      set[0].location.x.should == 5
      set[0].location.y.should == 5
    end
    
    it "should return cell for NE cell check" do
      set = @world.live_neighbors(Point.new(6,4))
      set.count.should == 1
      set[0].location.x.should == 5
      set[0].location.y.should == 5
    end

    it "should return cell for W cell check" do
      set = @world.live_neighbors(Point.new(4,5))
      set.count.should == 1
      set[0].location.x.should == 5
      set[0].location.y.should == 5
    end
    
    it "should return cell for SW cell check" do
      set = @world.live_neighbors(Point.new(4,6))
      set.count.should == 1
      set[0].location.x.should == 5
      set[0].location.y.should == 5
    end

    it "should return cell for S cell check" do
      set = @world.live_neighbors(Point.new(5,6))
      set.count.should == 1
      set[0].location.x.should == 5
      set[0].location.y.should == 5
    end
    
    it "should return cell for SE cell check" do
      set = @world.live_neighbors(Point.new(6,6))
      set.count.should == 1
      set[0].location.x.should == 5
      set[0].location.y.should == 5
    end

    it "should return cell for E cell check" do
      set = @world.live_neighbors(Point.new(6,5))
      set.count.should == 1
      set[0].location.x.should == 5
      set[0].location.y.should == 5
    end
    
  end
end