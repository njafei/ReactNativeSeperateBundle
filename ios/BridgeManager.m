//
//  bridgeManager.m
//  project
//
//  Created by liufei on 2017/2/6.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "BridgeManager.h"
#import "DiffMatchPatch.h"


@implementation BridgeManager

SINGLETON_IMPLEMENTION(BridgeManager, sharedManager);

- (instancetype)init
{
  if (self = [super init]) {
    _bridge = [[RCTBridge alloc]initWithDelegate:self launchOptions:nil];
  }
  return self;
}

- (void)loadSourceForBridge:(RCTBridge *)bridge
                  withBlock:(RCTSourceLoadBlock)loadCallback
{
//  //business bundle
//  NSURL *jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"buniness" withExtension:@"jsbundle"];
//  NSString *filePath = jsCodeLocation.path;
//  
//  //main bundle
//  NSURL *mainBundleURL = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
//  NSString *mainBundleFilePath = mainBundleURL.path;
//  
//  
//  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//    NSError *error = nil;
//    
//    NSData *businessSource = [NSData dataWithContentsOfFile:filePath
//                                            options:NSDataReadingMappedIfSafe
//                                              error:&error];
//    
//    NSData *mainSource = [NSData dataWithContentsOfFile:mainBundleFilePath
//                                               options:NSDataReadingMappedIfSafe
//                                                 error:&error];
//    
//    NSMutableData *concatData =[[NSMutableData alloc]init];
//    [concatData appendData:(NSData*)mainSource];
//    [concatData appendData:(NSData*)businessSource];
//    
//    loadCallback(nil, concatData,[concatData length]);
//  });
  
  

  
//  [self getNewBundle];
  
//  NSURL *mainBundleURL = [[NSBundle mainBundle] URLForResource:@"new" withExtension:@"jsbundle"];
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *docDir = [paths objectAtIndex:0];
  NSString *newPath = [NSString stringWithFormat:@"%@/new.jsbundle",docDir];
  
//  NSString *mainBundleFilePath = mainBundleURL.path;
  
  NSError *error = nil;
  NSData *mainSource = [NSData dataWithContentsOfFile:newPath
                                              options:NSDataReadingMappedIfSafe
                                                error:&error];
  
  loadCallback(nil, mainSource,[mainSource length]);
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
  NSString *jsBundlePath = @"http://localhost:8081/index.ios.bundle?platform=ios&dev=true";
  NSURL *jsBundleURL = [NSURL URLWithString:jsBundlePath];
  
  
//  NSString *path = [[NSBundle mainBundle] pathForResource:@"all" ofType:@"jsbundle"];
//  NSURL *jsBundleURL = [NSURL URLWithString:path];
  
  return jsBundleURL;
}


- (BOOL)getNewBundle
{
  
  NSString *commonBundlePath = [[NSBundle mainBundle] pathForResource:@"common" ofType:@"jsbundle"];
  NSString *commonBundleJSCode = [[NSString alloc] initWithContentsOfFile:commonBundlePath encoding:NSUTF8StringEncoding error:nil];
  
  NSString *patch1Path = [[NSBundle mainBundle] pathForResource:@"patch1" ofType:@"patch"];
  NSString *patch1JSCode = [[NSString alloc] initWithContentsOfFile:patch1Path encoding:NSUTF8StringEncoding error:nil];
  
  NSString *patch2Path = [[NSBundle mainBundle] pathForResource:@"patch2" ofType:@"patch"];
  NSString *patch2JSCode = [[NSString alloc] initWithContentsOfFile:patch2Path encoding:NSUTF8StringEncoding error:nil];
  
  
  DiffMatchPatch *diffMatchPatch = [[DiffMatchPatch alloc] init];
  NSArray *convertedPatches = [diffMatchPatch patch_fromText:patch1JSCode error:nil];
  NSArray *convertedPatches2 = [diffMatchPatch patch_fromText:patch2JSCode error:nil];
  

  NSArray *resultsArray = [diffMatchPatch patch_apply:convertedPatches toString:commonBundleJSCode];
  NSString *resultJSCode = resultsArray[0]; //patch合并后的js
  
  NSArray *resultsArray2 = [diffMatchPatch patch_apply:convertedPatches2 toString:commonBundleJSCode];
  NSString *resultJSCode2 = resultsArray2[0]; //patch合并后的js

  
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *docDir = [paths objectAtIndex:0];
  NSString *newPath = [NSString stringWithFormat:@"%@/new.jsbundle",docDir];
  if (resultsArray.count > 1) {
    BOOL writeSuccess = [resultJSCode writeToFile:newPath atomically:NO encoding:NSUTF8StringEncoding error:nil];
    return writeSuccess;
  }
  else {
    return NO;
  }

}

@end
