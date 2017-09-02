//
//  main.m
//  open-jd-pic-tabs
//
//  Created by 王乾舟 on 02/09/2017.
//  Copyright © 2017 王乾舟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTMLParser.h"

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
            
            NSInteger pageNuber = [[content substringWithRange:NSMakeRange(1, content.length-1)] integerValue];
            if (pageNuber == 0)
            {
                NSLog(@"Extract Current Page Number ERROR:%@", error);
                break;
            }
            
            NSLog(@"Current Page Number: %zd", pageNuber);
            
            for (int i=0; i<OPEN_TABS_COUNT; i++)
            {
                NSString* url = [NSString stringWithFormat:@"http://jandan.net/pic/page-%zd#comments", pageNuber-i];
                
                NSString* excuteCmd = [NSString stringWithFormat:@"open %@", url];
                system([excuteCmd UTF8String]);
            }
            

            
        } while (0);
    }
    return 0;
}
