//
//  bridgeManager.h
//  project
//
//  Created by liufei on 2017/2/6.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <React/RCTRootView.h>
#import "SingleDefine.h"


@interface BridgeManager : NSObject

SINGLETON_INTERFACE(BridgeManager, sharedManager);

@property (nonatomic, strong) RCTBridge *bridge;

@end
