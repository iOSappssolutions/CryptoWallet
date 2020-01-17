//
//  ViewController.m
//  BlockChainApp
//
//  Created by Miroslav Djukic on 10/20/17.
//  Copyright © 2017 Miroslav Djukic. All rights reserved.
//

#import "BCLoginViewController.h"
#import "BCWalletViewController.h"
@interface BCLoginViewController ()
    @property (nonatomic, weak) BCLoginView            *loginView;
@end

@implementation BCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadLoginView];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)loadLoginView{
    BCLoginView *loginView = [[BCLoginView alloc]init];
    loginView.delegate = self;
    if(_notMainLogin){
        loginView.notMainLogin = YES;
    }
    _loginView = loginView;
    [self.view addSubview:_loginView];
    [self setConstraints];
    [self.view layoutIfNeeded];

}

-(void)setConstraints{
    _loginView.translatesAutoresizingMaskIntoConstraints = NO;
    [_loginView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [_loginView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [_loginView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    [_loginView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// login view delegate
-(void)loginDidFinishSuccessfully:(BOOL)success{
    if(_notMainLogin){
        if(success){
            [_delegate loginDidFinishSuccessfully:YES];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }else{
        BCWalletViewController *walletViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WalletViewControllerNav"];
        [self presentViewController:walletViewController animated:YES completion:nil];
    }
}

@end
