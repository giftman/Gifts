--original one :can't access other packages
local P = {} 
if _REQUIREDNAME == nil then 
    complex = P
else
    _G[_REQUIREDNAME] = P
end
setfenv(1,P)
--solve 1,extends tables --not fast
local P = {}
setmetatable(P,{__index = _G})
setfenv(1,P)
--solve 2,a local _G --better
local P = {}
pack = P
local _G = _G
setfenv(1,P)

--solve 3 usually solve : fast,usually we see this mathod in many language,Import part of the package,but it need to declare...why so limit.
local P = {}
pack = P
--Import Section:
--declare everything this package needs from outside
local sqrt = math.sqrt
local io = io
--no more external access after this point
setfenn(1,P)
