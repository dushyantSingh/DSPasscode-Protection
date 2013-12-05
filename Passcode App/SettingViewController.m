//
//  SettingViewController.m
//  Passcode App
//
//  Created by StandardUser on 15/05/13.
//  Copyright (c) 2013 StandardUser. All rights reserved.
//

#import "SettingViewController.h"
#import "DSPasscodeManager.h"
@interface SettingViewController ()

@end

@implementation SettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
   if([DSPasscodeManager isPasscodeProtected])
   {
       self.passSwitch.on=YES;
   }
   else{
       self.passSwitch.on=NO;
   }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)passSwitchChange:(id)sender
{
    [DSPasscodeManager sharedManager].delegate=self;
    
    //[[PasscodeManager sharedManager]setTitleString:@"" withTextColor:[UIColor whiteColor]];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        [[DSPasscodeManager sharedManager]setBackgroundImage:[UIImage imageNamed:@"background.png"]];
        
    }
    else
    {
        [[DSPasscodeManager sharedManager]setBackgroundImage:[UIImage imageNamed:@"background_iPad.png"]];
    }
    [[DSPasscodeManager sharedManager]setPasscodeLock];

}

- (IBAction)backBtnClikd:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)passcodeMatchSuccessful
{
    NSLog(@"Successful");
}
-(void)passcodeMatchUnsuccessful
{
    NSLog(@"Not Match");
}
-(void)passcodeSaved
{
    NSLog(@"New Passcode Saved");
}
-(void)userCancelledPasscodeLock
{
    NSLog(@"User Cancelled");
}
@end
