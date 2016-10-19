//
//  YDAStringGrepperImpl.h
//  YDAStringGrepper
//
//  Created by Yuto on 2016/10/20.
//  Copyright © 2016年 Yuto. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YDAStringGrepper;
@class YDAStringGrepperLineObject;

@protocol YDAStringGrepperDelegate <NSObject>

- (void)grepper:(YDAStringGrepper *)grepper onGrepComplete:(NSArray <YDAStringGrepperLineObject *>*)lineList error:(NSError *)error;

@end

@interface YDAStringGrepper : NSObject

@property (weak, nonatomic) id<YDAStringGrepperDelegate> delegate;

@property (strong, nonatomic) NSString *baseString;

- (void)startGrep:(NSString *)expressionPattern;

- (void)startGrep:(NSString *)expressionPattern options:(NSRegularExpressionOptions)options;

@end
