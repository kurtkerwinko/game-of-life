local conf = require "conf"
local Cell = require "Cell"
local cell_array
local max_rows
local max_columns
local padding
local cell_width = 10
local cell_height = 10
local is_running = true
local previous_highlight = nil

function love.load()
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
        for col = 0, max_columns - 1 do
          -- Count live neighbors
          local live_neighbors = 0
          local min_ncol = col == 0 and 0 or -1
          local max_ncol = col == max_columns - 1 and 0 or 1
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

      for c = 0, #cell_array do
        cell_array[c]:update()
      end
    end
  end
end

function love.draw()
  love.graphics.setBackgroundColor(52, 152, 219)
  for c = 0, #cell_array do
    cell_array[c]:draw()
  end
end

function love.keypressed(key, unicode)
  if key == 'r' then -- Reset
    generate_cells()
  elseif key == 'd' then -- Kill all cells
    for c = 0, #cell_array do
      cell_array[c].alive = false
    end
  elseif key == 'space' then
    is_running = not is_running
  elseif key == 'p' then
    if love.window.getFullscreen() then
      love.window.setFullscreen(false)
      love.window.setMode(800, 800, {resizable=true})
      generate_cells()
    else
      love.window.setFullscreen(true)
    end
  end
end

function love.mousemoved(x, y, dx, dy)
  highlight_cell(x, y)
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

function love.resize(w, h)
  generate_cells()
end

function generate_cells()
  padding = 15 + math.max(math.floor(((love.graphics.getHeight() % 20) / 2)), math.floor(((love.graphics.getWidth() % 20) / 2)))
  max_rows = math.floor((love.graphics.getHeight() - padding * 2) / cell_height)
  max_columns = math.floor((love.graphics.getWidth() - padding * 2) / cell_width)

  cell_array = {}
  for row = 0, max_rows - 1 do
    for col = 0, max_columns - 1 do
      local clive = false
      if math.random(0, 1) == 1 then
        clive = true
      end
      cell_array[row*max_columns + col] = Cell:new(col * cell_width + padding, row * cell_height + padding, cell_width, cell_height, clive)
    end
  end
end

function highlight_cell(x, y)
  if previous_highlight then
    previous_highlight.highlight = false
  end
  local hovered_cell = get_hovered_cell(x, y)
  if hovered_cell then
    previous_highlight = hovered_cell
    hovered_cell.highlight = true
  end
end

function cell_clicked(x, y, alive)
  local clicked_cell = get_hovered_cell(x, y)
  if clicked_cell then
    clicked_cell.alive = alive
  end
end

function get_hovered_cell(x, y)
  local row_num = math.floor((y - padding) / cell_height)
  local col_num = math.floor((x - padding) / cell_width)
  local hovered_cell = cell_array[row_num*max_columns + col_num]
  if hovered_cell and within_bounds(row_num, col_num) then
    return hovered_cell
  end
end

function within_bounds(r, c)
  return r >= 0 and r < max_rows and c >= 0 and c < max_columns
end
