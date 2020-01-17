//
//  BCSettingsView.h
//  BlockChainApp
//
//  Created by Miroslav Djukic on 10/20/17.
//  Copyright © 2017 Miroslav Djukic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCSettingsView : UIView <UITextFieldDelegate>
@property (nonatomic, weak) id                     delegate;

@end
@protocol SettingsViewDelegate
-(void)pinChanged;
@end
