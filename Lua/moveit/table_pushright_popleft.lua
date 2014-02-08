--depend on some stric array we can only use pushleft & pushright,but mostly we can usse the talbe[1] to get the value
function List.pushleft(list,value)
    local first = list.first -1
    list.first = first
    list.[first] = value
end

function List.pushright(list,value)
    local last = list.first +1
    list.last = first
    list.[last] = value
end

function List.popleft(list)
    local first = list.first
    if first > list.last then error("list is empty") end 
    local value = list[first]
    list[first] = nil
    list.first = first + 1
    return value
end

function List.popright(list)
    local last = list.last
    if first > last then error("list is empty") end 
    local value = list[last]
    list[last] = nil
    list.last = last - 1
    return value
end

