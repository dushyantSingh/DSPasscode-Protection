//
//  ViewController.m
//  Passcode App
//
//  Created by StandardUser on 14/05/13.
//  Copyright (c) 2013 StandardUser. All rights reserved.
//

#import "ViewController.h"
#import "DSPasscodeManager.h"
#import "SettingViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)switchChanged:(id)sender
{
//    NSString *string=@"time";
//    NSString *srt1=[string capitalizedString];
//    NSLog(@"RAFDFS %@",srt1);
}

-(void)onForeGround
{
     [[DSPasscodeManager sharedManager]setDelegate:self];
     [[DSPasscodeManager sharedManager]lockApp];
}
-(void)userCancelledPasscodeLock
{
    NSLog(@"UserCancelled");
}

- (IBAction)pushView:(id)sender
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        SettingViewController *cont=[[SettingViewController alloc]initWithNibName:@"SettingViewController_iPhone" bundle:nil];
    [self.navigationController pushViewController:cont animated:YES];
    }
    else
    {
        SettingViewController *cont=[[SettingViewController alloc]initWithNibName:@"SettingViewController_iPad" bundle:nil];
        [self.navigationController pushViewController:cont animated:YES];
    }
}
@end
