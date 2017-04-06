//
//  BViewController.h
//  project
//
//  Created by liufei on 2017/2/6.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <React/RCTRootView.h>

@interface ReactNativeViewController : UIViewController

@property (nonatomic, copy) NSString *moduleName;
@property (nonatomic, copy) NSString *bridgeName;

@end
