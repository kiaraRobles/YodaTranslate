//
//  YTTranslationsDataStore.h
//  YodaTranslate
//
//  Created by Kiara Robles on 1/16/16.
//  Copyright © 2016 kiaraRobles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YTTranslations.h"

@interface YTTranslationsDataStore : NSObject

@property (nonatomic, strong) YTTranslations *translations;

+ (instancetype)sharedTranslationsDataStore;

- (void)generateInitalDataWithTranslation:(YTTranslations *)translations;

@end
