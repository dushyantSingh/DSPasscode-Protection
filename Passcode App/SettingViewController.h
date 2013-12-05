//
//  SettingViewController.h
//  Passcode App
//
//  Created by StandardUser on 15/05/13.
//  Copyright (c) 2013 StandardUser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSPasscodeManager.h"
@interface SettingViewController : UIViewController<DSPasscodeDelegate>

@property (weak, nonatomic) IBOutlet UISwitch *passSwitch;
- (IBAction)passSwitchChange:(id)sender;
- (IBAction)backBtnClikd:(id)sender;
@end
