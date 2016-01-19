//
//  YTTranslator.m
//  YodaTranslate
//
//  Created by Kiara Robles on 1/17/16.
//  Copyright © 2016 kiaraRobles. All rights reserved.
//

#import "YTTranslator.h"
#import "YTConstants.h"
#import <UNIRest/UNIRest.h>

@interface YTTranslator ()

+ (UNIHTTPRequest *)sendAPIRequestWithInput:(NSString *)input translationType:(NSString *)translationType;

@end

@implementation YTTranslator

+ (void)translateStringWithString:(NSString *)inputString translationType:(NSString *)translationType andReturnTranslatedString:(void (^)(NSString *))translatedString
{
    UNIHTTPRequest *request = [self sendAPIRequestWithInput:inputString translationType:translationType];
    [request asStringAsync:^(UNIHTTPStringResponse *stringResponse, NSError *error) {
        if (!error)
        {
            NSInteger code = stringResponse.code;
            if (code != 200) {
                NSLog(@"Request Failed Code: %lu", code);
                translatedString(nil);
            }
            else {
                translatedString([NSString stringWithFormat:@"%@", stringResponse.body]);
            }
        }
        else
        {
            NSLog(@"Request Failed Error: %@", error);
            translatedString(nil);
        }
    }];
}

+ (UNIHTTPRequest *)sendAPIRequestWithInput:(NSString *)input translationType:(NSString *)translationType
{
    NSString *URLStringPrefix = [self returnURLPrefixFromTranalationType:translationType];
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *URLString = [NSString stringWithFormat:URLStringPrefix,
                           [input stringByAddingPercentEncodingWithAllowedCharacters:set]];
    
    return [UNIRest get:^(UNISimpleRequest *request) {
        [request setUrl:URLString];
        [request setHeaders:kMashapeHeader];
    }];
}

+ (NSString *)returnURLPrefixFromTranalationType:(NSString *)translationType{
    
    NSString *URLStringPrefix;
    
    if ([translationType isEqualToString: kTranslationTypeYoda]) {
        URLStringPrefix = kURLStringPrefixYoda;
    }
    else if ([translationType isEqualToString: kTranslationTypeLeet]) {
        URLStringPrefix = kURLStringPrefixLeet;
    }
    
    return URLStringPrefix;
}

@end
