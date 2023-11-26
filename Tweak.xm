/*
AutoFolderClose a tweak that auto-closes folders for iOS 13+
Copyright 2020 J.K. Hayslip @(iKilledAppl3) and iKilledAppl3 LLC. All rights reserved.
*/


@import UIKit;

@interface SBHIconManager : NSObject
-(void)closeFolderAnimated:(BOOL)arg1 withCompletion:(id)arg2;
@end

@interface SBFolderController : NSObject 
-(BOOL)isOpen;
@end

@interface SpringBoard : UIApplication
+(id)sharedApplication;
-(void)_simulateHomeButtonPress;
@end

@interface SBIconController : UIViewController
@property (nonatomic,readonly) SBFolderController *currentFolderController;
@property (nonatomic,readonly) SBFolderController *openFolderController;
@property (nonatomic,readonly) SBHIconManager *iconManager; 
+(id)sharedInstance;
-(SBFolderController *)_openFolderController;
-(void)iconManager:(id)arg1 launchIconForIconView:(id)arg2;
-(void)iconManager:(SBHIconManager *)arg1 willCloseFolderController:(SBFolderController *)arg2;
@end
static SBIconController *iconController = nil;


%hook SBUIController
-(void)activateApplication:(id)arg1 fromIcon:(id)arg2 location:(long long)arg3 activationSettings:(id)arg4 actions:(id)arg5 {
  // calling SBIconController into memory using it's sharedInstance!
  iconController = [%c(SBIconController) sharedInstance];
    if ([[iconController _openFolderController] isOpen]) {
     %orig;
     [iconController.iconManager closeFolderAnimated:YES withCompletion:nil];
  }

  else {
    %orig;
  }
      

}
%end