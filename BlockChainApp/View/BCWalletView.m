//
//  BCWalletView.m
//  BlockChainApp
//
//  Created by Miroslav Djukic on 10/20/17.
//  Copyright © 2017 Miroslav Djukic. All rights reserved.
//

#import "BCWalletView.h"
@interface BCWalletView()
    @property (strong, nonatomic) IBOutlet UILabel            *pubAddressLabel;
    @property (strong, nonatomic) IBOutlet UILabel            *privateKeyLabel;
    @property (nonatomic, strong) BCWalletData                     *walletData;
    @property (nonatomic, assign) BOOL                            walletExists;
    @property (strong, nonatomic) IBOutlet UIButton        *createWalletButton;
    @property (strong, nonatomic) IBOutlet UIButton     *previousAddressButton;
    @property (strong, nonatomic) IBOutlet UIButton         *nextAddressButton;
    @property (strong, nonatomic) IBOutlet UIButton      *showPrivateKeyButton;
@end
@implementation BCWalletView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)initWalletData{
    _walletData = [[BCWalletData alloc]init];
    if([_walletData ifKeyExists]){
        NSString* address = [_walletData getFirstAddress];
        [self setPubAddressLabelText:address];
        _walletExists = YES;
    }else{
        _walletExists = NO;
        [self disableAddressUIControlls];
    }
}
- (IBAction)createNewWallet:(id)sender {
    [_walletData createNewWallet];
    NSString* address = [_walletData getFirstAddress];
    [self setPubAddressLabelText:address];
    [self setPrivateKeyLabelText:@""];
    _walletExists = YES;
    [self enableAddressUIControlls];
}

- (IBAction)getPreviousPublicAddress:(id)sender {
    NSString* address = [_walletData getPreviousAddress];
    [self setPubAddressLabelText:address];
    [self setPrivateKeyLabelText:@""];
}

- (IBAction)getNextPublicAddress:(id)sender {
    NSString* address = [_walletData getNextAddress];
    [self setPubAddressLabelText:address];
    [self setPrivateKeyLabelText:@""];
}
- (IBAction)showPrivateKey:(id)sender {
    if((_privateKeyLabel.text == nil || [_privateKeyLabel.text isEqualToString: @""])){
        [_delegate authanticateForWallet];
    }
}
-(void)showPrivateKeyLabel{
    NSString* privateKey = [_walletData getPrivateKey];
    [self setPrivateKeyLabelText:privateKey];
}
-(void)setPubAddressLabelText:(NSString *)text{
    _pubAddressLabel.text = text;
}

-(void)setPrivateKeyLabelText:(NSString *)text{
    _privateKeyLabel.text = text;
}

-(void)disableAddressUIControlls{
    _createWalletButton.userInteractionEnabled = YES;
    _nextAddressButton.userInteractionEnabled = NO;
    _previousAddressButton.userInteractionEnabled = NO;
    _showPrivateKeyButton.userInteractionEnabled = NO;
    _nextAddressButton.alpha = 0.3;
    _previousAddressButton.alpha  = 0.3;
    _showPrivateKeyButton.alpha  = 0.3;
    
}

-(void)enableAddressUIControlls{
    _createWalletButton.userInteractionEnabled = YES;
    _nextAddressButton.userInteractionEnabled = YES;
    _previousAddressButton.userInteractionEnabled = YES;
    _showPrivateKeyButton.userInteractionEnabled = YES;
    _nextAddressButton.alpha = 1;
    _previousAddressButton.alpha  = 1;
    _showPrivateKeyButton.alpha  = 1;
    
}

@end
