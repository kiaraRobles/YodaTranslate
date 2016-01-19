//
//  YTTranslation.m
//  YodaTranslate
//
//  Created by Kiara Robles on 1/16/16.
//  Copyright © 2016 kiaraRobles. All rights reserved.
//

#import "YTTranslations.h"
#import "YTConstants.h"

@interface YTTranslations ()

@property (nonatomic, strong) YTTranslations *translations;

@end

@implementation YTTranslations

#pragma mark - Initialization Method

- (instancetype)initWithType:(NSString *)type
{
    self = [super init];
    if (self) {
        _type = type;
        [self checkType];
    }
    return self;
}

#pragma mark - Helper Method

- (void)checkType
{
    if (![self.type isEqualToString: kTranslationTypeYoda] && ![self.type isEqualToString: kTranslationTypeLeet])
    {
        NSLog(@"Translations: Type not specified in ytconstants.h.\nObjects properties set to nil.");
        self.type = nil;
        self.messages = nil;
    }
}


@end
