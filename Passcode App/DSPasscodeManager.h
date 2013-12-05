//
//  PasscodeManager.h
//  Passcode App
//
//  Created by StandardUser on 14/05/13.
//  Copyright (c) 2013 StandardUser. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DSPasscodeDelegate  <NSObject>

@optional
-(void)userCancelledPasscodeLock;
-(void)passcodeMatchSuccessful;
-(void)passcodeMatchUnsuccessful;
-(void)passcodeSaved;
-(void)confirmPasswordMisMatch;
@end

#define kPasscode @"DSPasscodeLockKey"

@interface DSPasscodeManager : UIViewController
{
    id<DSPasscodeDelegate> delegate;
    
}

@property(nonatomic, retain)id<DSPasscodeDelegate> delegate;
@property(nonatomic, retain) NSMutableDictionary *attributeDict;

+(DSPasscodeManager*)sharedManager;

//check app is passcode protected or not
+(BOOL)isPasscodeProtected;


//Removing existing passcode 
+(void)removePasscode;

//Set background Image for Passcode View
-(void)setBackgroundImage:(UIImage *)image;

//Set Passcode Lock by calling this method. If there is an existing passcode , calling this method will disengage the passcode lock 
-(void)setPasscodeLock;

//Set App lock by this method
-(void)lockApp;

@end
