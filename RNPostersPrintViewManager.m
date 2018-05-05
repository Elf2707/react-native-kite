//
//  PostersPrintView.m
//  Ocus
//
//  Created by Elf on 03.02.2018.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNPostersPrintViewManager.h"
#import "Ocus-Swift.h"

@implementation RNPostersPrintViewManager

RCT_EXPORT_MODULE()

RCT_EXPORT_VIEW_PROPERTY(onDidFinish, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(assets, NSArray<NSString *>)

- (UIView *)view {
  return [RNPostersPrintView new];
}
@end
