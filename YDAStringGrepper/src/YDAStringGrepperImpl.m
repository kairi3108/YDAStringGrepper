//
//  YDAStringGrepperImpl.m
//  YDAStringGrepper
//
//  Created by Yuto on 2016/10/20.
//  Copyright © 2016年 Yuto. All rights reserved.
//

#import "YDAStringGrepperImpl.h"
#import "YDAStringGrepperLineObject.h"

@interface YDAStringGrepper ()

@property (strong, nonatomic) NSOperationQueue *grepQueue;

@end

@implementation YDAStringGrepper

- (void)dealloc {
    _delegate = nil;
    _baseString = nil;
}

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

- (void)startGrep:(NSString *)expressionPattern {
    [self startGrep:expressionPattern options:0];
}

- (void)startGrep:(NSString *)expressionPattern options:(NSRegularExpressionOptions)options {
    
    __weak YDAStringGrepper *weakSelf = self;
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // grep
        NSMutableArray <YDAStringGrepperLineObject *> *ret = [NSMutableArray array];
        NSError *error = nil;
        NSRegularExpression *regexp = [NSRegularExpression regularExpressionWithPattern:expressionPattern options:options error:&error];
        if (error == nil) {
            NSArray *arr = [regexp matchesInString:weakSelf.baseString options:0 range:NSMakeRange(0, weakSelf.baseString.length)];
            for (NSTextCheckingResult *match in arr) {
                if (match.range.location == NSNotFound) {
                    continue;
                }
                YDAStringGrepperLineObject *obj = [[YDAStringGrepperLineObject alloc] init];
                obj.textResult = [match copy];
                [ret addObject:obj];
            }
        }
        if (weakSelf.delegate) {
            if ([weakSelf.delegate respondsToSelector:@selector(grepper:onGrepComplete:error:)]) {
                [weakSelf.delegate grepper:weakSelf onGrepComplete:ret error:error];
            }
        }
    });
}

@end
