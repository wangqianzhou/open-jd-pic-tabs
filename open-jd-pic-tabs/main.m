//
//  main.m
//  open-jd-pic-tabs
//
//  Created by 王乾舟 on 02/09/2017.
//  Copyright © 2017 王乾舟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTMLParser.h"
#import "NSStringAdditions.h"

const int OPEN_TABS_COUNT = 15;

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSURL* ss = [NSURL URLWithString:@"http://jandan.net/pic"];
        NSError* error = nil;
        HTMLParser* parser = [[HTMLParser alloc] initWithContentsOfURL:ss error:&error];

        do
        {
            if (error != nil && parser == nil)
            {
                NSLog(@"GET SRC ERROR:%@", error);
                break;
            }
            
            HTMLNode* body = parser.body;
            HTMLNode* currentPageNodes = [body findChildOfClass:@"current-comment-page"];
            
            NSString* content = [currentPageNodes contents];
            if ([content length] <= 2)
            {
                NSLog(@"GET Current Page ERROR:%@", error);
                break;
            }
            
            NSInteger pageNumber = [[content substringWithRange:NSMakeRange(1, content.length-1)] integerValue];
            if (pageNumber == 0)
            {
                NSLog(@"Extract Current Page Number ERROR:%@", error);
                break;
            }
            
            NSLog(@"Current Page Number: %zd", pageNumber);
            
            /* http://jandan.net/pic/MjAyMDA3MDktMjAy#comments */
            //20200709-202
            NSDateFormatter* dateFormatter = [NSDateFormatter new];
            [dateFormatter setDateFormat:@"YYYYMMdd"];
            
            NSDate* now = [NSDate date];
            NSString* dateDes = [dateFormatter stringFromDate:now];
            
            for (int i=0; i<OPEN_TABS_COUNT; i++)
            {
                NSString* md5Compent = [[NSString stringWithFormat:@"%@-%zd", dateDes, pageNumber-i] base64];
                NSString* url = [NSString stringWithFormat:@"http://jandan.net/pic/%@#comments", md5Compent];
                
                NSString* excuteCmd = [NSString stringWithFormat:@"open %@", url];
                system([excuteCmd UTF8String]);
            }
            

            
        } while (0);
    }
    return 0;
}
