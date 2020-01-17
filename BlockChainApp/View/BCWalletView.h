//
//  BCWalletView.h
//  BlockChainApp
//
//  Created by Miroslav Djukic on 10/20/17.
//  Copyright © 2017 Miroslav Djukic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCWalletData.h"
@interface BCWalletView : UIView

@property (nonatomic, weak) id                                    delegate;

-(void)initWalletData;
-(void)showPrivateKeyLabel;
@end

@protocol WalletViewDelegate

@required
-(void) authanticateForWallet;

@end
