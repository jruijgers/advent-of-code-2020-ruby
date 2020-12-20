module Day17
  class ConwayHyperPowerGrid
    def self.parse(lines)
      grid = {}

      y = 0
      x = 0
      lines.each do |line|
        x = 0
        line.split("").each do |c|
          grid[[x, y, 0, 0]] = true if c == "#"
          x += 1
        end
        y += 1
      end

      new(grid, x - 1, y - 1)
    end

    def initialize(grid, x, y)
      @grid = grid
      @min_x = 0
      @max_x = x
      @min_y = 0
      @max_y = y
      @min_z = 0
      @max_z = 0
      @min_w = 0
      @max_w = 0
    end

    def power_up
      (1..6).each do |_cycle|
        new_grid = {}

        ((@min_x - 1)..(@max_x + 1)).each do |x|
          ((@min_y - 1)..(@max_y + 1)).each do |y|
            ((@min_z - 1)..(@max_z + 1)).each do |z|
              ((@min_w - 1)..(@max_w + 1)).each do |w|
                cell_status = @grid[[x, y, z, w]]
                active_cells = active_cells_around(x, y, z, w)

                if cell_status && (active_cells == 2 || active_cells == 3)
                  new_grid[[x, y, z, w]] = true
                elsif !cell_status && active_cells == 3
                  new_grid[[x, y, z, w]] = true
                end
              end
            end
          end
        end

        @grid = new_grid
        @min_x -= 1
        @max_x += 1
        @min_y -= 1
        @max_y += 1
        @min_z -= 1
        @max_z += 1
        @min_w -= 1
        @max_w += 1
      end
    end

    def active_cells
      active_cells = 0

      (@min_z..@max_z).each do |z|
        (@min_y..@max_y).each do |y|
          (@min_x..@max_x).each do |x|
            (@min_w..@max_w).each do |w|
              active_cells += 1 if @grid[[x, y, z, w]]
            end
          end
        end
      end
      active_cells
    end

    private

    def active_cells_around(x, y, z, w)
      active_cells = 0

      ((x - 1)..(x + 1)).each do |x2|
        ((y - 1)..(y + 1)).each do |y2|
          ((z - 1)..(z + 1)).each do |z2|
            ((w - 1)..(w + 1)).each do |w2|
              next if x == x2 && y == y2 && z == z2 && w == w2

              active_cells += 1 if @grid[[x2, y2, z2, w2]]
            end
          end
        end
      end

      active_cells
    end
  end
end
