//
//  ViewController.h
//  BlockChainApp
//
//  Created by Miroslav Djukic on 10/20/17.
//  Copyright © 2017 Miroslav Djukic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCLoginView.h"
@interface BCLoginViewController : UIViewController <LoginViewDelegate>

@property (nonatomic, assign) BOOL                 notMainLogin;
@property (nonatomic, weak) id                     delegate;

@end

@protocol LoginViewControllerDelegate

@required
-(void) loginDidFinishSuccessfully:(BOOL)success;

@end

