
require("config")
require("framework.init")
require("framework.shortcodes")
require("framework.cc.init")
--require("app.scenes.SceneTest")
local MyApp = class("MyApp", cc.mvc.AppBase)
function MyApp:ctor()
    MyApp.super.ctor(self)
end

function MyApp:run()
    CCFileUtils:sharedFileUtils():addSearchPath("res/")
    --    local scene = CCScene:create()
    --    scene:addChild(CreateTestMenu())
    --   CCDirector:sharedDirector():runWithScene(scene)
    --  self:enterScene("MainScene")
    local scene = CCScene:create()
    scene:addChild(SceneTestLayer1())
    CCDirector:sharedDirector():runWithScene(scene)


end

SceneTestLayer1 = function()
    local ret = CCLayer:create()
    local function onPushScene(tag,pSender)
        local scene = CCScene:create()
        local layer = SceneTestLayer2()
        scene:addChild(layer,0)
        CCDirector:sharedDirector():pushScene(scene)
    end

    local function onPushSceneTran(tag, pSender)
        local scene = CCScene:create()
        local  layer = SceneTestLayer2()
        scene:addChild(layer, 0)
        CCDirector:sharedDirector():pushScene( CCTransitionSlideInT:create(1, scene) )
    end

    local function onReplaceScene(tag, pSender)
        local scene = CCScene:create()
        local  layer = SceneTestLayer2()
        scene:addChild(layer, 0)
        CCDirector:sharedDirector():replaceScene( scene )
    end

    local function item0Clicked(tag, pSender)
        local newScene = CCScene:create()
        newScene:addChild(SceneTestLayer2())
        CCDirector:sharedDirector():replaceScene(CCTransitionFade:create(0.5, newScene, ccc3(0,255,255)))
    end
    local function onQuit(tag, pSender)
    end
    local item1 = CCMenuItemFont:create("Test pushScene")
    item1:registerScriptTapHandler(onPushScene)
    local item4 = CCMenuItemFont:create("Test replaceScene")
    item4:registerScriptTapHandler(onReplaceScene)
    local item5 = CCMenuItemFont:create("Test FadeToLayer2UseReplaceScene")
    item5:registerScriptTapHandler(item0Clicked)
    local item2 = CCMenuItemFont:create("Test pushScene w/transition")
    item2:registerScriptTapHandler(onPushSceneTran)
    local item3 = CCMenuItemFont:create("Quit")
    item3:registerScriptTapHandler(onQuit)

    local arr = CCArray:create()
    arr:addObject(item1)
    arr:addObject(item4)
    arr:addObject(item5)
    arr:addObject(item2)
    arr:addObject(item3)
    local menu = CCMenu:createWithArray(arr)
    menu:alignItemsVertically()
    ret:addChild(menu)
    
    return ret
end


SceneTestLayer2 = function()
    local ret = CCLayerColor:create(ccc4(0,0,255,255))
    local m_timeCounter = 0

    local function onGoBack(tag, pSender)
        CCDirector:sharedDirector():popScene()
    end

    local function onReplaceScene(tag, pSender)
        local scene = CCScene:create()
        local  layer = SceneTestLayer1()
        scene:addChild(layer, 0)
        CCDirector:sharedDirector():replaceScene( scene )
    end


    local function onReplaceSceneTran(tag, pSender)
        local scene = CCScene:create()
        local  layer = SceneTestLayer1()
        scene:addChild(layer, 0)
        CCDirector:sharedDirector():replaceScene( CCTransitionFlipX:create(2, scene) )
    end
--**popScene When use pushscene it will back to the before scene
    local function item1Clicked(tag, pSender)
        CCDirector:sharedDirector():popScene()
    end

--**popToRootScene will back to the root scene
    local function item2Clicked(tag, pSender)
        CCDirector:sharedDirector():popToRootScene()
    end

    local  item1 = CCMenuItemFont:create( "replaceScene")
    item1:registerScriptTapHandler(onReplaceScene)
    local  item2 = CCMenuItemFont:create( "replaceScene w/transition")
    item2:registerScriptTapHandler(onReplaceSceneTran)
    local  item3 = CCMenuItemFont:create( "Go Back")
    item3:registerScriptTapHandler(onGoBack)
    local arr = CCArray:create()
    arr:addObject(item1)
    arr:addObject(item2)
    arr:addObject(item3)
    local  menu = CCMenu:createWithArray(arr)
    menu:alignItemsVertically()

    ret:addChild( menu )


    return ret
end


    return MyApp
