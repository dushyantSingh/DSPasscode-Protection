DSPasscode-Protection
=====================

DSPasscode Protection is a Apple Style passcode protection , which could easily be used in your app by calling few methods





DSPasscode Protection is a Apple Style passcode protection , which could easily be used in your app by calling few methods

Using DSPasscode Protection


1. Create a sharedManager in Appdelegate .   
         [DSPasscodeManager sharedManager];

2. When user want to set Passcode , call this method from DSPasscodeManager class
    		[[DSPasscodeManager sharedManager]setPasscodeLock];
  with passing the Delegate 
             [DSPasscodeManager sharedManager].delegate=self;

3. When user want to lock app , call this method from DSPasscodeManager class
           [[DSPasscodeManager sharedManager]setDelegate:self];
     [[DSPasscodeManager sharedManager]lockApp];

4. You can also set the background for lock screen by using this method
    [[DSPasscodeManager sharedManager]setBackgroundImage:(UIImage*)];

5. You can check whether app is passcode protected
     [DSPasscodeManager isPasscodeProtected];
   It returns BOOL value.

6. You can remove Passcode by calling 
    [DSPasscodeManager removePasscode];

7. Show appropriate alerts on these methods
-(void)userCancelledPasscodeLock            --When user cancels setting pass lock
-(void)passcodeMatchSuccessful                       --   When user unlocks the app and passcode matches
-(void)passcodeMatchUnsuccessful            --When user unlocks the app and passcode does not match
-(void)passcodeSaved							        --When user saves new passcode 
-(void)confirmPasscodeMismatch              --When user saves new password and confirm password do not match with earlier given password
