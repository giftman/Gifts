local BUFSIZE = 2^13
--local f = io.input(arg[1])
local f = io.input("AndroidManifest.xml")
local cc,lc,wc = 0,0,0

while true do 
    local lines,rest = f:read(BUFSIZE,"*line")
    print(lines)
    if not lines then break end
    if rest then lines = lines .. rest ..'\n' end
    cc = cc + string.len(lines)
    --count words in chunk
    local _,t = string.gsub(lines,"%S+","")
    wc = wc + t
    --count newlines in the chunk
    _,t = string.gsub(lines,"\n","\n")
    lc = lc +t
end
print(lc,wc,cc)
