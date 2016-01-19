//
//  YTMainViewController.m
//  YodaTranslate
//
//  Created by Kiara Robles on 1/15/16.
//  Copyright © 2016 kiaraRobles. All rights reserved.
//

#import "YTMainViewController.h"
#import "YTTranslationViewController.h"
#import "YTTranslations.h"
#import "YTTranslationsDataStore.h"
#import "YTConstants.h"

@interface YTMainViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintYodaToViewLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintManToViewRight;
@property (weak, nonatomic) IBOutlet UIButton *buttonLeet;
@property (weak, nonatomic) IBOutlet UIButton *buttonYoda;
@property (weak, nonatomic) IBOutlet UILabel *labelOr;

@end

@implementation YTMainViewController

# pragma mark - View Life Cycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.labelOr.hidden = YES;
    self.navigationController.navigationBarHidden = YES;
    
    [self animationIntro];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)animationIntro
{
    [UIView animateWithDuration:0.5f animations:^{
        self.constraintYodaToViewLeft.constant = 8.0;
        self.constraintManToViewRight.constant = 8.0;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.labelOr.hidden = NO;
    }];
}

# pragma mark - Action Methods

- (IBAction)selectedYoda:(id)sender
{
    [self generateDataForTranslationViewControllerWithType:kTranslationTypeYoda];
}

- (IBAction)selectedLeet:(id)sender
{
    [self generateDataForTranslationViewControllerWithType:kTranslationTypeLeet];
}

# pragma mark - Helper Methods

- (void)generateDataForTranslationViewControllerWithType:(NSString *)translationType
{
    YTTranslationsDataStore *dataStore = [YTTranslationsDataStore sharedTranslationsDataStore];
    YTTranslations *traslations = [[YTTranslations alloc] initWithType:translationType];
    [dataStore generateInitalDataWithTranslation:traslations];
    
    [self performSegueWithIdentifier:@"segueTranslationVewController" sender:self];
}

@end
