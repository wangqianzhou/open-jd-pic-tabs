//
//  NSStringAdditions.h
//  open-jd-pic-tabs
//
//  Created by wangqianzhou on 2020/7/9.
//  Copyright © 2020 王乾舟. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Additions)
- (NSString *)md5;
-(NSString *)md5_16;

-(NSString *)base64;
@end

NS_ASSUME_NONNULL_END
