//
//  SubScene.h
//  GameFeatSample_Cocos2d-x_v3.2
//
//  Created by kkyouhei on 2014/10/31.
//
//

#ifndef __GameFeatSample_Cocos2d_x_v3_2__SubScene__
#define __GameFeatSample_Cocos2d_x_v3_2__SubScene__

#include "cocos2d.h"

class SubScene : public cocos2d::Layer
{
protected:
    void backMain(Ref* pSender);
    
    enum {
        tag_back = 1
    };
    
public:
    virtual bool init();
    static cocos2d::Scene* scene();
    CREATE_FUNC(SubScene);
};


#endif /* defined(__GameFeatSample_Cocos2d_x_v3_2__SubScene__) */
