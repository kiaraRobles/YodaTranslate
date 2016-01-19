//
//  YTTranslationsDataStore.m
//  YodaTranslate
//
//  Created by Kiara Robles on 1/16/16.
//  Copyright © 2016 kiaraRobles. All rights reserved.
//

#import "YTTranslationsDataStore.h"
#import "YTConstants.h"

@implementation YTTranslationsDataStore

#pragma mark - Singleton Method

+ (instancetype)sharedTranslationsDataStore
{
    static YTTranslationsDataStore *_sharedTranslationsDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedTranslationsDataStore = [[YTTranslationsDataStore alloc] init];
    });
    
    return _sharedTranslationsDataStore;
}

#pragma mark - Initialization Method

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.translations  = [[YTTranslations alloc] init];
    }
    return self;
}

#pragma mark - Message Data Method

- (void)generateInitalDataWithTranslation:(YTTranslations *)translations
{
    self.translations.type = translations.type;
    
    if ([translations.type isEqualToString: kTranslationTypeYoda])
    {
        NSString *userExampleMessage = @"Hey Yoda, how are you?";
        NSString *yodaExampleResponce = @"Hey you, how are hmm?";
        
        self.translations.messages = [@[userExampleMessage, yodaExampleResponce] mutableCopy];
    }
    else if ([translations.type isEqualToString: kTranslationTypeLeet])
    {
        NSString *userExampleMessage = @"How do you speak leet?";
        NSString *leetExampleResponce = @"ju57 mIX Up 5OM3 a5CIi chaRaC73r2.";
        
        self.translations.messages = [@[userExampleMessage, leetExampleResponce] mutableCopy];
    }
}

@end
