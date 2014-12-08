//
//  SubScene.cpp
//  GameFeatSample_Cocos2d-x_v3.2
//
//  Created by kkyouhei on 2014/10/31.
//
//

#include "SubScene.h"
#include "MainScene.h"
#include "NativeBridge.h"

using namespace cocos2d;
using namespace std;

Scene* SubScene::scene()
{
    Scene* scene = Scene::create();
    SubScene* layer = SubScene::create();
    scene->addChild(layer);
    
    return scene;
}

bool SubScene::init()
{
    if (!CCLayer::init())
    {
        return false;
    }
    
    Size size = Director::getInstance()->getWinSize();
    
    //backボタン
    MenuItemImage* backButton = MenuItemImage::create("backButton1.png", "backButton2.png", CC_CALLBACK_1(SubScene::backMain, this));
    backButton->setPosition(Point(size.width/2, size.height/9));
    backButton->setTag(tag_back);
    
    Menu* menu = Menu::create(backButton, NULL);
    menu->setPosition(Point::ZERO);
    this->addChild(menu);
    
    NativeBridge::showAllGameFeat();
    
    return true;
}

//メイン画面へ戻る
void SubScene::backMain(Ref* pSender)
{
    int tag = ((MenuItem *)(pSender))->getTag();
    
    if (tag == tag_back)
    {
        //全画面型GameFeat削除
        NativeBridge::hideAllGameFeat();
        
        Scene* scene = MainScene::createScene();
        Director::getInstance()->replaceScene(scene);
    }
}
