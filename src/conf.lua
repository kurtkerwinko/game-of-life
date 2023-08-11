local conf = {}

function love.conf(t)
  t.version = "0.10.2"
  t.window.title = "Game of Life"
  t.window.borderless = false
  t.window.resizable = true
  t.window.minwidth = 800
  t.window.minheight = 800
  t.window.width = t.window.minwidth
  t.window.height = t.window.minheight

  conf.t = t
end

return conf
