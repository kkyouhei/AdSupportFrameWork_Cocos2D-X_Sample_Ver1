//
//  NativeBridge.m
//
//  Created by 中村 慎司 on 2013/09/04.
//
//

#import "NativeBridge.h"
#include "AppController.h"

#import <AdSupportFramework/AdView.h>
#import <AdSupportFramework/AdController.h>

/**
 * オファーウォール型表示
 */
void NativeBridge::showAd()
{
    AppController *appController = (AppController*)[[UIApplication sharedApplication] delegate];
    [AdController showAd:(UIViewController *)appController.viewController site_id:GF_SITE_ID];
    NSLog(@"showAd");
}

/**
 * アイコン型表示
 */
void NativeBridge::showIcon()
{
    AppController *appController = (AppController*)[[UIApplication sharedApplication] delegate];
    [appController showIcon];
    NSLog(@"showIcon");
}

/**
 * アイコン型非表示
 */
void NativeBridge::hideIcon()
{
    AppController *appController = (AppController*)[[UIApplication sharedApplication] delegate];
    [appController hideIcon];
    NSLog(@"hideIcon");
}