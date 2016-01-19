//
//  YTTranslator.h
//  YodaTranslate
//
//  Created by Kiara Robles on 1/17/16.
//  Copyright © 2016 kiaraRobles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTTranslator : NSObject

+ (void)translateStringWithString:(NSString *)inputString translationType:(NSString *)translationType andReturnTranslatedString:(void (^)(NSString *))translatedString;

@end
