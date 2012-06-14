//
//  gifFetcher.m
//  gif
//
//  Created by Nick Hughes on 6/14/12.
//  Copyright (c) 2012 GOOD. All rights reserved.
//

#import "gifFetcher.h"

#define WHAT_SHOULD_WE_CALL_ME_URL @"whatshouldwecallme.tumblr.com"

@implementation gifFetcher

+ (NSDictionary *)fetchGif
{
    // generate query string
    NSString *host = @"http://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=";
    NSString *params = [NSString stringWithFormat:@"filetype:gif site:%@", WHAT_SHOULD_WE_CALL_ME_URL];
    NSString *query = [NSString stringWithFormat:@"%@%@", host, params];
    query = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //NSLog(@"%@", query);
    
    // parse response
    NSData *json = [[NSString stringWithContentsOfURL:[NSURL URLWithString:query] encoding:NSUTF8StringEncoding error:nil] dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *results = json ? [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&error] : nil;
    if (error) NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error.localizedDescription);
    
    // assign gif url
    NSDictionary *gif = [[[results objectForKey:@"responseData"] objectForKey:@"results"] objectAtIndex:0];
    //NSLog(@"gif url %@", [gif objectForKey:@"unescapedUrl"]);
    return gif;
}

+ (NSString *)fetchGifUrl
{
    NSDictionary *gif = [self fetchGif];
    return [gif objectForKey:@"unescapedUrl"];
}

@end
