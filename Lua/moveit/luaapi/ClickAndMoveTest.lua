
require("config")
require("framework.init")
require("framework.shortcodes")
require("framework.cc.init")

local size = CCDirector:sharedDirector():getWinSize()
local layer = nil
local kTagSprite = 1

local MyApp = class("MyApp", cc.mvc.AppBase)
function MyApp:ctor()
    MyApp.super.ctor(self)
end

local function initWithLayer()
    local sprite = CCSprite:create("Hello.png")

    local bgLayer = CCLayerColor:create(ccc4(0,255,0,255))
    layer:addChild(bgLayer,-1)

    layer:addChild(sprite,0,kTagSprite)
    sprite:setPosition(CCPointMake(20,150))

   -- sprite:runAction(CCJumpTo:create(4,CCPointMake(300,48),400,10)) -- time ,position, jumpheight,jumptimes

    bgLayer:runAction(CCRepeatForever:create(CCSequence:createWithTwoActions(CCFadeIn:create(1),CCFadeOut:create(1))))
    local function onTouchEnded(x,y)
        local s = layer:getChildByTag(kTagSprite)
        s:stopAllActions()
        s:runAction(CCMoveTo:create(1,CCPointMake(x,y)))
        local posX,posY = s:getPosition()
        print("posX&posY:",posX,posY)
        print("X&Y:",x,y)
        local o = x - posX
        local a = y - posY
        local at = math.atan(0 / a) /math.pi * 180.0

        print("o&a&at:",o,a,at)
        print("math.abs(at)",math.abs(at))
        if a < 0 then 
            if o < 0 then 
                at = 180 + math.abs(at) 
            else
                at = 180 - math.abs(at)
            end
        end
        print("o&a&at:",o,a,at)
        s:runAction(CCRotateTo:create(1,at))
        --s:runAction(CCRepeatForever:create(CCSequence:createWithTwoActions(CCFadeIn:create(1),CCFadeOut:create(1))))
    end
    local function onTouch(eventType,x,y)
        if eventType == "began" then 
            return true
        elseif eventType == "ended" then 
            return onTouchEnded(x,y)
        end
    end

    layer:setTouchEnabled(true)
    layer:registerScriptTouchHandler(onTouch)
    return layer
end



function MyApp:run()
    CCFileUtils:sharedFileUtils():addSearchPath("res/")
    --    local scene = CCScene:create()
    --    scene:addChild(CreateTestMenu())
    --   CCDirector:sharedDirector():runWithScene(scene)
    --  self:enterScene("MainScene")
    local scene = CCScene:create()
    layer = CCLayer:create()
    initWithLayer()
    scene:addChild(layer)
    CCDirector:sharedDirector():runWithScene(scene)

end

return MyApp
