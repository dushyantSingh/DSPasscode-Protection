//
//  PasscodeViewController.h
//  Passcode App
//
//  Created by StandardUser on 14/05/13.
//  Copyright (c) 2013 StandardUser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSPasscodeManager.h"

@interface DSPasscodeViewController : UIViewController
{
    NSString *passcode;
    BOOL isConfirm;
    BOOL ispasscodeCheck;
}


@property(nonatomic, retain)id<DSPasscodeDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIView *passcodeAnimatingView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *passcodeLabel;
@property (assign, nonatomic) BOOL ispasscodeCheck;

@property(nonatomic , strong)DSPasscodeManager *manager;
@property (weak, nonatomic) IBOutlet UITextField *passcodeTextfield;
@property(nonatomic, strong)NSMutableDictionary *formatingDict;
- (IBAction)closeBtnClikd:(id)sender;
- (IBAction)textFieldValueChanged:(UITextField *)sender;
-(IBAction)numberKeyPressed:(UIButton *)sender;
@end
