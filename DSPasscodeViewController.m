//
//  PasscodeViewController.m
//  Passcode App
//
//  Created by StandardUser on 14/05/13.
//  Copyright (c) 2013 StandardUser. All rights reserved.
//

#import "DSPasscodeViewController.h"

@interface DSPasscodeViewController ()

@end

@implementation DSPasscodeViewController


@synthesize manager,formatingDict,passcodeLabel,passcodeTextfield,backgroundImage,delegate,ispasscodeCheck;

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
    [self registerForTextFieldNotifications];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [self deregisterForTextFieldNotifications];
}


-(void)registerForTextFieldNotifications {
	
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
	
	[notificationCenter addObserver:self selector:@selector(keyboardWillShow:) name: UIKeyboardDidShowNotification object:nil];
	[notificationCenter addObserver:self selector:@selector(keyboardWillHide:) name: UIKeyboardDidHideNotification object:nil];
	
}

-(void)deregisterForTextFieldNotifications
{
     NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [notificationCenter removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

-(void)keyboardWillShow: (id) notification
{
    
    [self performSelector:@selector(addCustomClearBtn) withObject:nil afterDelay:.5];
    
}

-(void)addCustomClearBtn
{
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    doneButton.frame = CGRectMake(214, 163, 106, 53);
    //[doneButton setBackgroundColor:[UIColor clearColor]];
    // doneButton.titleLabel.text = @"Done";
    //[doneButton setTag:989];
    doneButton.showsTouchWhenHighlighted=YES;
    [doneButton setImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
    [ doneButton addTarget:self action:@selector(clearBtnClikd) forControlEvents:UIControlEventTouchUpInside];
    
    UIWindow *tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    UIView *keyboard;
    for (int i = 0; i < [tempWindow.subviews count]; i++) {
        keyboard = [tempWindow.subviews objectAtIndex:i];
        if ([[keyboard description] hasPrefix:@"<UIPeripheralHostView"] == YES) {
            [keyboard addSubview:doneButton];
        }
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if([formatingDict objectForKey:@"title"])
    {
        self.passcodeLabel.text=[formatingDict objectForKey:@"title"];
    }
    
    if([formatingDict objectForKey:@"color"])
    {
        self.passcodeLabel.textColor=[formatingDict objectForKey:@"color"];
    }
    
    if([formatingDict objectForKey:@"image"])
    {
        self.backgroundImage.image=[formatingDict objectForKey:@"image"];
    }
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        [self.passcodeTextfield becomeFirstResponder];
    }
    isConfirm=NO;
    if (ispasscodeCheck) {
        self.passcodeTextfield.keyboardAppearance=UIKeyboardAppearanceAlert;
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeBtnClikd:(id)sender
{
    if(!ispasscodeCheck)
    { [self dismissViewControllerAnimated:YES completion:nil];
    if([delegate respondsToSelector:@selector(userCancelledPasscodeLock)])
    {
        [delegate userCancelledPasscodeLock];
    }
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Passcode" message:@"Enter a vaild passcode" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        
    }
}

- (IBAction)textFieldValueChanged:(UITextField *)sender
{
    if([sender.text length]==1)
    {
        UITextField *textField=(UITextField *)[self.passcodeAnimatingView viewWithTag:1];
        textField.text=@"@";
    }
    else if([sender.text length]==2){
        UITextField *textField=(UITextField *)[self.passcodeAnimatingView viewWithTag:2];
        textField.text=@"@";
    }
    else if([sender.text length]==3){
        UITextField *textField=(UITextField *)[self.passcodeAnimatingView viewWithTag:3];
        textField.text=@"@";
    }
    else if([sender.text length]==4){
        UITextField *textField=(UITextField *)[self.passcodeAnimatingView viewWithTag:4];
        textField.text=@"@";
        
        if([DSPasscodeManager isPasscodeProtected])
        {
            [self checkPasscode];
        }
        else
        {
            if(isConfirm)
                [self matchPasscode];
            else 
            {   [self animatePasscodeView];
                [self performSelector:@selector(confirmPasscode) withObject:nil afterDelay:0.3];
            }
        }
    }


}

-(void)checkPasscode
{
    if([passcodeTextfield.text isEqualToString:[[NSUserDefaults standardUserDefaults]objectForKey:kPasscode]])
    {
        if(!self.ispasscodeCheck)
        {
            [DSPasscodeManager removePasscode];
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];

        if([delegate respondsToSelector:@selector(passcodeMatchSuccessful)])
        {
            [delegate passcodeMatchSuccessful];
        }
    }
    else
    {
        self.passcodeTextfield.text=@"";
        UITextField *textField1=(UITextField *)[self.passcodeAnimatingView viewWithTag:1];
        textField1.text=@"";
        UITextField *textField2=(UITextField *)[self.passcodeAnimatingView viewWithTag:2];
        textField2.text=@"";
        UITextField *textField3=(UITextField *)[self.passcodeAnimatingView viewWithTag:3];
        textField3.text=@"";
        UITextField *textField4=(UITextField *)[self.passcodeAnimatingView viewWithTag:4];
        textField4.text=@"";
        
    if([delegate respondsToSelector:@selector(passcodeMatchUnsuccessful)])
        {
            [delegate passcodeMatchUnsuccessful];
        }
        
    }
}
-(void)animatePasscodeView
{
    CGRect frame=self.passcodeAnimatingView.frame;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        frame.origin.x=-320;
    }
    else
    {
        frame.size.width=0;
    }
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelay:0];
    self.passcodeAnimatingView.frame=frame;
    [UIView commitAnimations];
    
}
-(void)confirmPasscode
{
    
    CGRect frame=self.passcodeAnimatingView.frame;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {   
        frame.origin.x=0;
    }
    else{
        frame.size.width=360;
    }
    
    self.passcodeAnimatingView.frame=frame;
    
    passcode=self.passcodeTextfield.text;
    self.passcodeTextfield.text=@"";
    self.passcodeLabel.text=@"Confirm Passcode";
    isConfirm=YES;
    
    UITextField *textField1=(UITextField *)[self.passcodeAnimatingView viewWithTag:1];
    textField1.text=@"";
    UITextField *textField2=(UITextField *)[self.passcodeAnimatingView viewWithTag:2];
    textField2.text=@"";
    UITextField *textField3=(UITextField *)[self.passcodeAnimatingView viewWithTag:3];
    textField3.text=@"";
    UITextField *textField4=(UITextField *)[self.passcodeAnimatingView viewWithTag:4];
    textField4.text=@"";
    
}
-(void)matchPasscode
{
    isConfirm=NO;
    
    if([passcode isEqualToString:self.passcodeTextfield.text])
    {
        [[NSUserDefaults standardUserDefaults]setObject:passcode forKey:kPasscode];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self dismissViewControllerAnimated:YES completion:nil];
       
        if([delegate respondsToSelector:@selector(passcodeSaved)])
        {
            [delegate passcodeSaved];
        }
        
    }
    else
    {
        [self confirmPasscode];
        isConfirm=NO;
        self.passcodeLabel.text=@"Enter Passcode";
        
        if([delegate respondsToSelector:@selector(confirmPasswordMisMatch)])
        {
            [delegate confirmPasswordMisMatch];
        }
    }
}

//iPad Keyboard
-(IBAction)numberKeyPressed:(UIButton *)sender
{
    NSUInteger length1= [self.passcodeTextfield.text length];
    if( length1<4)
    {
        
        NSString *passStr;
        
        switch (sender.tag)
        {
            case 1:
                passStr=[self.passcodeTextfield.text stringByAppendingString:@"1"];
                self.passcodeTextfield.text=passStr;
                [self textFieldValueChanged:self.passcodeTextfield];
                break;
            case 2:
                passStr=[self.passcodeTextfield.text stringByAppendingString:@"2"];
                self.passcodeTextfield.text=passStr;
                 [self textFieldValueChanged:self.passcodeTextfield];
                break;
            case 3:
                passStr=[self.passcodeTextfield.text stringByAppendingString:@"3"];
                self.passcodeTextfield.text=passStr;
                 [self textFieldValueChanged:self.passcodeTextfield];
                break;
            case 4:
                passStr=[self.passcodeTextfield.text stringByAppendingString:@"4"];
                self.passcodeTextfield.text=passStr;
                 [self textFieldValueChanged:self.passcodeTextfield];
                break;
            case 5:
                passStr=[self.passcodeTextfield.text stringByAppendingString:@"5"];
                self.passcodeTextfield.text=passStr;
                [self textFieldValueChanged:self.passcodeTextfield];
                break;
            case 6:
                passStr=[self.passcodeTextfield.text stringByAppendingString:@"6"];
                self.passcodeTextfield.text=passStr;
                [self textFieldValueChanged:self.passcodeTextfield];
                break;
            case 7:
                passStr=[self.passcodeTextfield.text stringByAppendingString:@"7"];
                self.passcodeTextfield.text=passStr;
                 [self textFieldValueChanged:self.passcodeTextfield];
                break;
            case 8:
                passStr=[self.passcodeTextfield.text stringByAppendingString:@"8"];
                self.passcodeTextfield.text=passStr;
                 [self textFieldValueChanged:self.passcodeTextfield];
                break;
            case 9:
                passStr=[self.passcodeTextfield.text stringByAppendingString:@"9"];
                self.passcodeTextfield.text=passStr;
                 [self textFieldValueChanged:self.passcodeTextfield];
                break;
            case 10:
                passStr=[self.passcodeTextfield.text stringByAppendingString: @"0"];
                self.passcodeTextfield.text=passStr;
                 [self textFieldValueChanged:self.passcodeTextfield];
                break;
            case 11:
               // [settingView dismisPopOverViewController];
                break;
            case 12:
                [ self clearBtnClikd];
                break;
            default:
                break;
        }
        
             
}
}

-(void)clearBtnClikd
{
    NSInteger nlength=[self.passcodeTextfield.text length];
    UITextField *textField=(UITextField *)[self.passcodeAnimatingView viewWithTag:nlength];

    switch (nlength) {
        case 1:
            textField.text=@"";
            self.passcodeTextfield.text=@"";
            break;
        case 2:
            textField.text=@"";
            self.passcodeTextfield.text=[self.passcodeTextfield.text substringWithRange:NSMakeRange(0, 1)];
            break;
        case 3:
            textField.text=@"";
            self.passcodeTextfield.text=[self.passcodeTextfield.text substringWithRange:NSMakeRange(0, 2)];
            break;
        default:
            break;
    }

}
@end
