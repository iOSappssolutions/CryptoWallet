//
//  BCLoginView.h
//  BlockChainApp
//
//  Created by Miroslav Djukic on 10/20/17.
//  Copyright © 2017 Miroslav Djukic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCLoginView : UIView <UITextFieldDelegate>

@property (nonatomic, weak) id                     delegate;
@property (nonatomic, assign) BOOL                 pinExists;
@property (nonatomic, assign) BOOL                 notMainLogin;

@end

@protocol LoginViewDelegate
@required
-(void) loginDidFinishSuccessfully:(BOOL)success;

@end
