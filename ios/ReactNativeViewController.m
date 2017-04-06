//
//  BViewController.m
//  project
//
//  Created by liufei on 2017/2/6.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "ReactNativeViewController.h"

#import <React/RCTRootView.h>
#import "BridgeManager.h"
#import "DiffMatchPatch.h"


@interface ReactNativeViewController ()

@end

@implementation ReactNativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
  RCTBridge *bridge = [[RCTBridge alloc]initWithDelegate:self launchOptions:nil];
  RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge moduleName:self.moduleName initialProperties:nil];



  self.view = rootView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
  NSString *path = [self getNewBundle];
  NSURL *jsBundleURL = [NSURL URLWithString:path];
  
  return jsBundleURL;
}


- (NSString *)getNewBundle
{
  
  NSString *commonBundlePath = [[NSBundle mainBundle] pathForResource:@"common" ofType:@"jsbundle"];
  NSString *commonBundleJSCode = [[NSString alloc] initWithContentsOfFile:commonBundlePath encoding:NSUTF8StringEncoding error:nil];
  
  NSString *patch1Path = [[NSBundle mainBundle] pathForResource:self.bridgeName ofType:@"patch"];
  NSString *patch1JSCode = [[NSString alloc] initWithContentsOfFile:patch1Path encoding:NSUTF8StringEncoding error:nil];
  
  
  DiffMatchPatch *diffMatchPatch = [[DiffMatchPatch alloc] init];
  NSArray *convertedPatches = [diffMatchPatch patch_fromText:patch1JSCode error:nil];
  
  NSArray *resultsArray = [diffMatchPatch patch_apply:convertedPatches toString:commonBundleJSCode];
  NSString *resultJSCode = resultsArray[0]; //patch合并后的js
  
  
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *docDir = [paths objectAtIndex:0];
  NSString *newPath = [NSString stringWithFormat:@"%@/%@.jsbundle",docDir,self.bridgeName];
  
  if (resultsArray.count > 1) {
    [resultJSCode writeToFile:newPath atomically:NO encoding:NSUTF8StringEncoding error:nil];
    return newPath;
  }
  else {
    return @"";
  }
  
}



@end
