//
//  YTTranslationViewController.m
//  YodaTranslate
//
//  Created by Kiara Robles on 1/16/16.
//  Copyright © 2016 kiaraRobles. All rights reserved.
//

#import "YTTranslationViewController.h"
#import "YTTranslationsDataStore.h"
#import "YTTranslator.h"
#import "PTSMessagingCell.h"

@interface YTTranslationViewController ()

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, assign) CGFloat keyboardHeight;
@property (nonatomic, assign) CGFloat keyboardAnimationDuration;
@property (nonatomic, strong) YTTranslationsDataStore *dataStore;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *textfieldBottomSpaceConstraint;
@property (nonatomic, weak) IBOutlet UITableView *tableview;
@property (nonatomic, strong) IBOutlet UITextField *textfield;

@end

@implementation YTTranslationViewController

static CGFloat standardSpacing = 8.0f;

# pragma mark - View Life Cycle & Memmory Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTextfield];
    [self setupBackButton];
    [self registerKeyboardNotifications];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.textfield.delegate = self;

    self.dataStore = [YTTranslationsDataStore sharedTranslationsDataStore];
    [self setupTitle];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    [self deregisterKeyboardNotifications];
}

- (void)dealloc
{
    [self deregisterKeyboardNotifications];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

# pragma mark - Setup Methods

- (void)setupKeyboard:(NSNotification *)notification
{
    if (!self.keyboardHeight || !self.keyboardAnimationDuration)
    {
        NSDictionary *userInfo = notification.userInfo;
        NSValue *keyboardValue = ([userInfo valueForKey:UIKeyboardFrameEndUserInfoKey]);
        CGRect keyboardFrame = keyboardValue.CGRectValue;
        self.keyboardHeight = keyboardFrame.size.height;
        
        NSNumber *keyboardAnimationDurationNumber = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
        self.keyboardAnimationDuration = [keyboardAnimationDurationNumber floatValue];
    }
}

- (void)registerKeyboardNotifications
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)deregisterKeyboardNotifications
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [center removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [center removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
}

- (void)setupTextfield
{
    [self.textfield setReturnKeyType:UIReturnKeyDone];
}

- (void)setupTitle
{
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = self.dataStore.translations.type;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0];
    [titleLabel sizeToFit];
    
    self.navigationItem.titleView = titleLabel;
}

-(void)setupBackButton
{
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backButtonImage = [UIImage imageNamed:@"backButton"];
    [backButton setImage:backButtonImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popBackAction)forControlEvents:UIControlEventTouchUpInside];
    [backButton setFrame:CGRectMake(0, 0, backButtonImage.size.width, backButtonImage.size.height)];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = barButton;
}

# pragma mark - Action Methods

-(void)popBackAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

# pragma mark - Tableview Methods

- (void)translateString:(NSString *)inputString
{
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    self.navigationItem.titleView = self.activityIndicator;
    self.activityIndicator.color = [UIColor blackColor];
    [self.activityIndicator startAnimating];
    
    [YTTranslator translateStringWithString:inputString translationType:self.dataStore.translations.type andReturnTranslatedString:^(NSString * translatedString) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            [self.activityIndicator stopAnimating];
            [self setupTitle];
            
            if ([translatedString isEqualToString:@""]) {
                NSString *alertAPIError = @"Sorry, an API error has occurred.";
                [self.dataStore.translations.messages addObject:alertAPIError];
                [self.tableview reloadData];
            }
            else {
                [self.dataStore.translations.messages addObject:translatedString];
                [self.tableview reloadData];
            }
        }];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataStore.translations.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"messagingCell";
    PTSMessagingCell *cell = (PTSMessagingCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[PTSMessagingCell alloc] initMessagingCellWithReuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.row % 2 == 0) {
        cell.sent = YES;
    }
    else {
        cell.sent = NO;
    }
    
    cell.messageLabel.text = [self.dataStore.translations.messages objectAtIndex:indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize messageSize = [PTSMessagingCell messageSize:[self.dataStore.translations.messages objectAtIndex:indexPath.row]];
    CGFloat messageSizeFloat = messageSize.height + 2 * [PTSMessagingCell textMarginVertical] + standardSpacing;
    
    return messageSizeFloat;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionHeaderView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, tableView.frame.size.width, standardSpacing)];
    
    return sectionHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return standardSpacing;
}

# pragma mark - Keyboard Methods

-(void)keyboardWillShow:(NSNotification *)notification
{
    [self setupKeyboard:notification];
    
    [UIView animateWithDuration:self.keyboardAnimationDuration animations:^{
        self.textfieldBottomSpaceConstraint.constant += self.keyboardHeight;
        [self.view layoutIfNeeded];
    }];
    
    [self.tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataStore.translations.messages.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:self.keyboardAnimationDuration animations:^{
        self.textfieldBottomSpaceConstraint.constant -= self.keyboardHeight;
        [self.view layoutIfNeeded];
    }];
}

-(void)hideKeyboardOnTap
{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textfield
{
    if (![self.textfield.text isEqualToString:@""])
    {
        [self.dataStore.translations.messages addObject:textfield.text];
        [self translateString:textfield.text];
        [self.tableview reloadData];
        
        self.textfield.text = @"";
    }
    
    [textfield resignFirstResponder];
    return YES;
}

@end
