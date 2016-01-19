//
//  YTTranslatorSpec.m
//  YodaTranslate
//
//  Created by Kiara Robles on 1/17/16.
//  Copyright 2016 kiaraRobles. All rights reserved.
//

#import "YTTranslator.h"
#import "YTConstants.h"
#import <Foundation/Foundation.h>
#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#define EXP_SHORTHAND

SpecBegin(YTTranslator)

describe(@"YTTranslator", ^{
    __block YTTranslator *translator;
    
    beforeAll(^{
        translator = [[YTTranslator alloc] init];
    });
    
    describe(@"newInstance", ^{
        it(@"should exist", ^{
            expect(translator).notTo.equal(nil);
        });
     });

    afterEach(^{
        translator = nil;
    });
});

SpecEnd
