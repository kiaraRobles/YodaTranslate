//
//  YTTranslations.h
//  YodaTranslate
//
//  Created by Kiara Robles on 1/16/16.
//  Copyright © 2016 kiaraRobles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTTranslations : NSObject

@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) NSMutableArray *messages;

- (instancetype)initWithType:(NSString *)type;

@end
