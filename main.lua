local Cell = require "Cell"
local cell_array
local max_rows
local max_columns
local padding = 20
local cell_width = 20
local cell_height = 20
local is_running = true

function love.load()
  max_rows = (love.graphics.getHeight() - padding * 2) / cell_height
  max_columns = (love.graphics.getWidth() - padding * 2) / cell_width

  -- Generate Cells
  generate_cells()
end

local dnext = 0
function love.update(dt)
  dnext = dnext + dt

  if is_running then
    -- Set FPS to 10
    if dnext >= .1 then
      dnext = 0
      for row = 0, max_rows - 1 do
        for col = 1, max_columns do
          -- Count live neighbors
          local live_neighbors = 0
          local min_ncol = col == 1 and 0 or -1
          local max_ncol = col == max_columns and 0 or 1
          for ncol = min_ncol, max_ncol do
            local rn1 = cell_array[(row-1)*max_columns + col + ncol]
            if rn1 and rn1.alive then
              live_neighbors = live_neighbors + 1
            end

            local r0 = cell_array[row*max_columns + col + ncol]
            if r0 and r0.alive and ncol ~= 0 then
              live_neighbors = live_neighbors + 1
            end

            local rp1 = cell_array[(row+1)*max_columns + col + ncol]
            if rp1 and rp1.alive then
              live_neighbors = live_neighbors + 1
            end
          end
          local current_cell = cell_array[row*max_columns + col]
          current_cell.live_neighbor_count = live_neighbors
        end
      end

      for c = 1, #cell_array do
        cell_array[c]:update()
      end
    end
  end
end

function love.draw()
  love.graphics.setBackgroundColor(52, 152, 219)
  for c = 1, #cell_array do
    cell_array[c]:draw()
  end
end

function love.keypressed(key, unicode)
  if key == 'r' then -- Reset
    generate_cells()
  elseif key == 'd' then -- Kill all cells
    for c = 1, #cell_array do
      cell_array[c].alive = false
    end
  elseif key == 'space' then
    is_running = not is_running
  end
end

function love.mousemoved(x, y, dx, dy)
  if love.mouse.isDown(1) then
    cell_clicked(x, y, true)
  elseif love.mouse.isDown(2) then
    cell_clicked(x, y, false)
  end
end

function love.mousepressed(x, y, button, isTouch)
  if button == 1 then
    cell_clicked(x, y, true)
  elseif button == 2 then
    cell_clicked(x, y, false)
  end
end

function cell_clicked(x, y, alive)
  local row_num = math.floor((y - padding) / cell_height)
  local col_num = math.floor(x / cell_width)
  local clicked_cell = cell_array[row_num*max_columns + col_num]
  if clicked_cell and within_bounds(row_num, col_num) then
    clicked_cell.alive = alive
  end
end

function generate_cells()
  cell_array = {}
  for row = 0, max_rows - 1 do
    for col = 1, max_columns do
      local clive = false
      if math.random(0, 1) == 1 then
        clive = true
      end
      cell_array[row*max_columns + col] = Cell:new(col * cell_width, (row+1) * cell_height, cell_width, cell_height, clive)
    end
  end
end

function within_bounds(r, c)
  return r >= 0 and r < max_rows and c >= 1 and c <= max_columns
end
