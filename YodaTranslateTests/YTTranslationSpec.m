//
//  YTTranslationSpec.m
//  YodaTranslate
//
//  Created by Kiara Robles on 1/17/16.
//  Copyright 2016 kiaraRobles. All rights reserved.
//

#import "YTTranslations.h"
#import "YTConstants.h"
#import <Foundation/Foundation.h>
#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#define EXP_SHORTHAND

SpecBegin(YTTranslations)

describe(@"YTTranslations", ^{
    
    __block YTTranslations *yodaTypeTranslations;
    __block YTTranslations *leetTypeTranslations;
    __block YTTranslations *notValidTypeTranslations;
    
    beforeEach(^{
        yodaTypeTranslations = [[YTTranslations alloc] initWithType:kTranslationTypeYoda];
        leetTypeTranslations = [[YTTranslations alloc] initWithType:kTranslationTypeLeet];
        notValidTypeTranslations = [[YTTranslations alloc] initWithType:@"Text To Speech"];
    });
    
    describe(@"when creating a new instance", ^{
        
        describe(@"validTypes", ^{
            it(@"should return translation is of yoda type", ^{
                expect(yodaTypeTranslations.type).to.equal(kTranslationTypeYoda);
            });
            it(@"should return translation is of leet type", ^{
                expect(leetTypeTranslations.type).to.equal(kTranslationTypeLeet);
            });
            it(@"should return translation type as nil", ^{
                expect(notValidTypeTranslations.type).to.equal(nil);
            });
        });
    });
});

SpecEnd
