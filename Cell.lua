local Cell = {}
Cell.__index = Cell

function Cell:new(x, y, width, height, alive)
  local ce = {}
  setmetatable(ce, Cell)
  ce.x = x
  ce.y = y
  ce.width = width
  ce.height = height
  ce.alive = alive
  ce.live_neighbor_count = 2
  ce.highlight = false
  return ce
end

function Cell:update()
  -- Rules
  -- 1. Living will Die if < 2 Live Neighbors
  -- 2. Living will keep Living if 2 or 3 Live Neighbors
  -- 3. Living will Die if > 3 Live Neighbors
  -- 4. Dead will Live if 3 Live Neighbors

  if self.alive then
    -- Rule 1 & 3
    if self.live_neighbor_count < 2 or self.live_neighbor_count > 3 then
      self.alive = false
    end
    -- Rule 2 - Do Nothing
  elseif not self.alive then
    -- Rule 4
    if self.live_neighbor_count == 3 then
      self.alive = true
    end
  end
end

function Cell:draw()
  if not self.alive then
    love.graphics.setColor(0, 0, 0)
  elseif self.alive then
    love.graphics.setColor(255, 255, 255)
  end
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
  if self.highlight then
    love.graphics.setColor(230, 126, 34, 175)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
  end
end

return Cell
