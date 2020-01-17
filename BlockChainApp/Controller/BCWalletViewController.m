//
//  BCWalletViewController.m
//  BlockChainApp
//
//  Created by Miroslav Djukic on 10/20/17.
//  Copyright © 2017 Miroslav Djukic. All rights reserved.
//

#import "BCWalletViewController.h"
#import "BCWalletData.h"

@interface BCWalletViewController ()

@end

@implementation BCWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ((BCWalletView*)self.view).delegate = self;
    [(BCWalletView*)self.view initWalletData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender{
    
    
}

//wallet view delegate
-(void)authanticateForWallet{
    BCLoginViewController *loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    loginViewController.notMainLogin = YES;
    loginViewController.delegate = self;
    [self.navigationController pushViewController:loginViewController animated:YES ];
    
}

// login view delegate
-(void)loginDidFinishSuccessfully:(BOOL)success{
    if(success){
        [(BCWalletView*) self.view showPrivateKeyLabel];
    }

}
@end
