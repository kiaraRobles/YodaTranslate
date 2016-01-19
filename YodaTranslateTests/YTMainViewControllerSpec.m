//
//  YTMainViewControllerSpec.m
//  YodaTranslate
//
//  Created by Kiara Robles on 1/18/16.
//  Copyright 2016 kiaraRobles. All rights reserved.
//

#import "YTMainViewController_Private.h"
#import "YTTranslationViewController.h"
#import <Foundation/Foundation.h>
#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <KIF/KIF.h>
#define EXP_SHORTHAND

SpecBegin(YTMainViewController)

describe(@"YTMainViewController", ^{
    
    __block YTMainViewController *mainVC;
    __block UINavigationController *navController;
    
    beforeAll(^{
        UIWindow *window = [[UIApplication sharedApplication].delegate window];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        navController = [storyboard instantiateInitialViewController];
        
        [window setRootViewController:navController];
        [window makeKeyAndVisible];
        
        mainVC = (YTMainViewController *)navController.visibleViewController;
    });
    
    it(@"viewController setup hasn't been modified from starter code", ^{
        expect([mainVC isMemberOfClass:[YTMainViewController class]]).to.beTruthy();
    });
    
    describe(@"yodaButton", ^{
        __block UIButton *yodaButton;
        
        it(@"can be accessed via accessibilityLabel", ^{
            yodaButton = (UIButton *)[tester waitForViewWithAccessibilityLabel:@"yodaButton"];
            expect(yodaButton).toNot.beNil();
        });
        
        it(@"segues to YTTranslationViewController", ^{
            [tester tapViewWithAccessibilityLabel:@"yodaButton"];
            expect(navController.visibleViewController.class).to.equal([YTTranslationViewController class]);
            [navController popViewControllerAnimated:NO];
        });
    });
    
    describe(@"leetButton", ^{
        __block UIButton *leetButton;
        
        it(@"can be accessed via accessibilityLabel", ^{
            leetButton = (UIButton *)[tester waitForViewWithAccessibilityLabel:@"leetButton"];
            expect(leetButton).toNot.beNil();
        });
        
        it(@"segues to YTTranslationViewController", ^{
            [tester tapViewWithAccessibilityLabel:@"leetButton"];
            expect(navController.visibleViewController.class).to.equal([YTTranslationViewController class]);
            [navController popViewControllerAnimated:NO];
        });
    });
});

SpecEnd
