//
//  MainScene.cpp
//  GameFeatSample_Cocos2d-x_v3.2
//
//  Created by kkyouhei on 2014/10/31.
//
//


#include "MainScene.h"
#include "NativeBridge.h"

using namespace cocos2d;
using namespace std;

Scene* MainScene::createScene()
{
    Scene* scene = Scene::create();
    MainScene* layer = MainScene::create();
    scene->addChild(layer);
    
    return scene;
}

bool MainScene::init()
{
    if (!CCLayer::init())
    {
        return false;
    }
    
    Size size = Director::getInstance()->getWinSize();
    
    //GameFeat起動
    MenuItemImage* gamefeatButton = MenuItemImage::create("GameFeatButton1.png", "GameFeatButton2.png", CC_CALLBACK_1(MainScene::pushMenu, this));
    gamefeatButton->setPosition(Point(size.width/2, size.height*2/3));
    gamefeatButton->setTag(tag_gamefeat);
    
    //アイコン非表示
    MenuItemImage* iconHideButton = MenuItemImage::create("btIconHide.png", "btIconHide.png", CC_CALLBACK_1(MainScene::iconHide,this));
    iconHideButton->setPosition(Point(size.width/2 - 140, size.height/4));
    iconHideButton->setTag(tag_next);
    
    //アイコン表示
    MenuItemImage* iconShowButton = MenuItemImage::create("btIconShow.png", "btIconShow.png", CC_CALLBACK_1(MainScene::iconShow, this));
    iconShowButton->setPosition(Point(size.width/2 + 140, size.height/4));
    iconShowButton->setTag(tag_next);
    
    Menu* menu = Menu::create(gamefeatButton,iconHideButton,iconShowButton,NULL);
    menu->setPosition(Point::ZERO);
    this->addChild(menu);
    
    //アイコン型GameFeat表示
    NativeBridge::showIconGameFeat();
    
    return true;
}

/**
 * メニュー
 */
void MainScene::pushMenu(Ref* pSender)
{
    int tag = ((MenuItem *)(pSender))->getTag();
    
    //オファーウォール型GameFeat表示
    if (tag == tag_gamefeat)
    {
        NativeBridge::showGameFeat();
    }
}

/**
 * アイコン広告表示
 */
void MainScene::iconShow(Ref* pSender)
{
    NativeBridge::showIconGameFeat();
}

/**
 * アイコン広告非表示
 */
void MainScene::iconHide(Ref* pSender)
{
    NativeBridge::hideIconGameFeat();
}
