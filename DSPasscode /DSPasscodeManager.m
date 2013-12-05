//
//  PasscodeManager.m
//  Passcode App
//
//  Created by StandardUser on 14/05/13.
//  Copyright (c) 2013 StandardUser. All rights reserved.
//

#import "DSPasscodeManager.h"
#import "DSPasscodeViewController.h"

@interface DSPasscodeManager ()

@end

@implementation DSPasscodeManager

@synthesize delegate,attributeDict;

+(DSPasscodeManager *)sharedManager
{
    static DSPasscodeManager *manager=nil;
    
    if(!manager)
    {
        static dispatch_once_t pred;
  
    dispatch_once(&pred, ^{
            manager=[[DSPasscodeManager alloc]init];
            manager.attributeDict=[[NSMutableDictionary alloc]init];
    });
    }
    
    return manager;
}
+(BOOL)isPasscodeProtected
{
    if([[NSUserDefaults standardUserDefaults]objectForKey:kPasscode])
    {
        return YES;
    }
    else
        return NO;
}

+(void)removePasscode
{
    if([[NSUserDefaults standardUserDefaults]objectForKey:kPasscode])
    {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:kPasscode];
    }
}
//
-(void)setBackgroundImage:(UIImage *)image
{
    if (image) {
        [attributeDict setObject:image forKey:@"image"];
    }
    
        
}
-(void)setTitleString:(NSString *)title withTextColor:(UIColor *)color
{
    if(title)
    {
         [attributeDict setObject:title forKey:@"title"];
    }
    
    if(color)
    {
         [attributeDict setObject:color forKey:@"color"];
    }
}
-(void)setPasscodeLock
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        DSPasscodeViewController *controller=[[DSPasscodeViewController alloc]initWithNibName:@"DSPasscodeViewController_iPhone" bundle:nil];
        controller.delegate=delegate;
        controller.formatingDict=attributeDict;
        UIViewController *temp=(UIViewController *)delegate;
        [temp presentViewController:controller animated:YES completion:nil];
    }
    else
    {
        DSPasscodeViewController *controller=[[DSPasscodeViewController alloc]initWithNibName:@"DSPasscodeViewController_iPad" bundle:nil];
        controller.delegate=delegate;
        controller.formatingDict=attributeDict;
        UIViewController *temp=(UIViewController *)delegate;
        [temp presentViewController:controller animated:YES completion:nil];
    }
}

-(void)lockApp
{
   if([DSPasscodeManager isPasscodeProtected])
   {  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        DSPasscodeViewController *controller=[[DSPasscodeViewController alloc]initWithNibName:@"DSPasscodeViewController_iPhone" bundle:nil];
        controller.delegate=delegate;
        controller.ispasscodeCheck=YES;
        controller.formatingDict=attributeDict;
        UIViewController *temp=(UIViewController *)delegate;
        [temp presentViewController:controller animated:YES completion:nil];
    }
    else
    {
        DSPasscodeViewController *controller=[[DSPasscodeViewController alloc]initWithNibName:@"DSPasscodeViewController_iPad" bundle:nil];
        controller.delegate=delegate;
        controller.ispasscodeCheck=YES;
        controller.formatingDict=attributeDict;
        UIViewController *temp=(UIViewController *)delegate;
        [temp presentViewController:controller animated:YES completion:nil];
    }
   }
   
}
-(void)userCancelled
{
    if([delegate respondsToSelector:@selector(userCancelledPasscodeLock)])
    {
        [delegate userCancelledPasscodeLock];
    }

}
@end
