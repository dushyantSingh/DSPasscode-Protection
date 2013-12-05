//
//  ViewController.h
//  Passcode App
//
//  Created by StandardUser on 14/05/13.
//  Copyright (c) 2013 StandardUser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSPasscodeManager.h"
@interface ViewController : UIViewController<DSPasscodeDelegate>


- (IBAction)switchChanged:(id)sender;
-(void)userCancelledPasscodeLock;
- (IBAction)pushView:(id)sender;
-(void)onForeGround;
@end
