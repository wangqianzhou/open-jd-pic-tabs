//
//  NSStringAdditions.m
//  open-jd-pic-tabs
//
//  Created by wangqianzhou on 2020/7/9.
//  Copyright © 2020 王乾舟. All rights reserved.
//

#import "NSStringAdditions.h"
#import <CommonCrypto/CommonDigest.h> // Need to import for CC_MD5 access

@implementation NSString (MyAdditions)
- (NSString *)md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (int)strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
        @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
        result[0], result[1], result[2], result[3],
        result[4], result[5], result[6], result[7],
        result[8], result[9], result[10], result[11],
        result[12], result[13], result[14], result[15]
        ];
}

-(NSString *)md5_16

{
   const char *cStr = [self UTF8String];
   unsigned char result[CC_MD5_DIGEST_LENGTH];
   CC_MD5( cStr, (int)strlen(cStr), result ); // This is the md5 call
   return [NSString stringWithFormat:
       @"%02x%02x%02x%02x%02x%02x%02x%02x",
       result[4], result[5], result[6], result[7],
       result[8], result[9], result[10], result[11]
       ];
}

-(NSString *)base64
{
    NSData *dataToEncode = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encodedData = [dataToEncode base64EncodedDataWithOptions:0];
    NSString *encodedString = [[NSString alloc] initWithData:encodedData encoding:NSUTF8StringEncoding];
    
    return encodedString;
}
@end
