//
//  MainScene.h
//  AdSupportFw_Cocos2d-x_v3.2
//
//  Created by kkyouhei on 2014/10/31.
//
//

#ifndef __GameFeatSample_Cocos2d_x_v3_2__MainScene__
#define __GameFeatSample_Cocos2d_x_v3_2__MainScene__

#include "cocos2d.h"

class MainScene : public cocos2d::Layer
{
protected:
    void pushMenu(Ref* pSender);
    void iconHide(Ref* pSender);
    void iconShow(Ref* pSender);
    
    enum {
        tag_name = 1,
        tag_next
    };
    
public:
    virtual bool init();
    static cocos2d::Scene* createScene();
    CREATE_FUNC(MainScene);
};

#endif /* defined(__GameFeatSample_Cocos2d_x_v3_2__MainScene__) */
