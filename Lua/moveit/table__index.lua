--create a namespace
Window = {}
--create the prototype with default values
Window.prototype = {x=0,y=0,width=1000,height=100, }
Window.mt = {}
function Window.new(o)
    setmetatable(o,Window.mt)
    return o
end
Window.mt.__index = function (table,key)
    return Window.prototype[key]
end

w = Window.new{x=10,y=20}
print(w.width)
