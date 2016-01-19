//
//  YTTranslationViewControllerSpec.m
//  YodaTranslate
//
//  Created by Kiara Robles on 1/18/16.
//  Copyright 2016 kiaraRobles. All rights reserved.
//

#import "YTTranslationViewController.h"
#import "YTConstants.h"
#import "YTMainViewController_Private.h"
#import <Foundation/Foundation.h>
#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <KIF/KIF.h>
#define EXP_SHORTHAND

SpecBegin(YTTranslationViewController)

describe(@"YTTranslationViewController", ^{
    
    __block YTMainViewController *mainVC;
    __block YTTranslationViewController *translationVC;
    __block UINavigationController *navController;
    
    beforeAll(^{
        UIWindow *window = [[UIApplication sharedApplication].delegate window];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        navController = [storyboard instantiateInitialViewController];
        
        [window setRootViewController:navController];
        [window makeKeyAndVisible];
        
        mainVC = (YTMainViewController *)navController.visibleViewController;
        [mainVC generateDataForTranslationViewControllerWithType:kTranslationTypeYoda];
        translationVC = (YTTranslationViewController *)navController.visibleViewController;
    });
    
    it(@"viewController setup hasn't been modified from starter code", ^{
        expect([translationVC isMemberOfClass:[YTMainViewController class]]).to.beTruthy();
    });
    
    describe(@"backButton", ^{
        __block UIBarButtonItem *backButton;
        
        it(@"can be accessed via accessibilityLabel", ^{
            backButton = (UIBarButtonItem *)[tester waitForViewWithAccessibilityLabel:@"backButton"];
            expect(backButton).toNot.beNil();
        });
        
        it(@"segues to YTMainViewController", ^{
            [tester tapViewWithAccessibilityLabel:@"backButton"];
            expect(navController.visibleViewController.class).to.equal([YTMainViewController class]);
            [navController popViewControllerAnimated:NO];
        });
    });
});

SpecEnd
