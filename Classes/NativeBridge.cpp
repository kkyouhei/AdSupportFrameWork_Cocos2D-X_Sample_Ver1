//
//  NativeBridge.cpp
//
//  Created by 中村 慎司 on 2013/09/04.
//
//

#include "NativeBridge.h"
#include <android/log.h>
#include <jni.h>
#include "platform/android/jni/JniHelper.h"

#define CLASS_NAME "org/cocos2dx/cpp/AppActivity"

using namespace std;
using namespace cocos2d;

/**
 * オファーウォール型広告表示
 */
void NativeBridge::showAd()
{
    JniMethodInfo t;
    
    if (JniHelper::getStaticMethodInfo(t, CLASS_NAME, "showAdJNI", "()V"))
    {
        t.env->CallStaticVoidMethod(t.classID, t.methodID);
    }
}

/**
 * アイコン型広告表示
 */
void NativeBridge::showIcon()
{
    JniMethodInfo t;
    
    if (JniHelper::getStaticMethodInfo(t, CLASS_NAME, "showIconJNI", "()V"))
    {
        t.env->CallStaticVoidMethod(t.classID, t.methodID);
    }
}

/**
 * アイコン型広告非表示
 */
void NativeBridge::hideIcon()
{
    JniMethodInfo t;
    
    if (JniHelper::getStaticMethodInfo(t, CLASS_NAME, "hideIconJNI", "()V"))
    {
        t.env->CallStaticVoidMethod(t.classID, t.methodID);
    }
}