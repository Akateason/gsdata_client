//
//  LoginViewController.m
//  XtDemo
//
//  Created by teason on 16/5/6.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewCtrller.h"
#import "XTHudManager.h"
#import "User.h"
#import "YYModel.h"
#import "LoginHandler.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tf_name;
@property (weak, nonatomic) IBOutlet UITextField *tf_pass;
@property (weak, nonatomic) IBOutlet UIButton *btLogin;
@property (weak, nonatomic) IBOutlet UIButton *btRegister;

@end

@implementation LoginViewController


#pragma mark - Action

- (IBAction)btLoginOnClick:(id)sender
{
    if (!_tf_name.text.length || !_tf_pass.text.length) {
        [XTHudManager showWordHudWithTitle:@"未填写完整!"] ;
        return ;
    }
    // login .
    [ServerRequest loginName:_tf_name.text
                    password:_tf_pass.text
                     success:^(id json) {
                         
                         ResultParsered *result = [[ResultParsered alloc] initWithDic:json] ;
                         if ([result.returnCode integerValue] == 1001) {
                             [XTHudManager showWordHudWithTitle:@"登录成功!"] ;                             
                             User *user = [User yy_modelWithJSON:result.returnData] ;
                             [LoginHandler loginCachedInUserDefaults:user] ;
                             [self dismissViewControllerAnimated:YES completion:^{}] ;
                         }
                         else
                         {
                             [XTHudManager showWordHudWithTitle:result.returnMsg] ;
                         }
                         
                         
                     } fail:^{
                         [XTHudManager showWordHudWithTitle:@"网络不好!"] ;
                     }] ;
}

- (IBAction)btRegisterOnClick:(id)sender
{
    [self performSegueWithIdentifier:@"login2register" sender:nil] ;
}

#pragma mark - Life 

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tf_name.layer.cornerRadius = 5. ;
    _tf_pass.layer.cornerRadius = 5. ;
    _btRegister.layer.cornerRadius = 5. ;
    _btLogin.layer.cornerRadius = 5. ;
    _tf_name.layer.borderWidth = 1. ;
    _tf_name.layer.borderColor = [UIColor xt_mainColor].CGColor ;
    _tf_pass.layer.borderWidth = 1. ;
    _tf_pass.layer.borderColor = [UIColor xt_mainColor].CGColor ;
    _btRegister.layer.borderWidth = 1. ;
    _btRegister.layer.borderColor = [UIColor xt_mainColor].CGColor ;

    self.navigationController.navigationBarHidden = YES ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"login2register"])
    {
        RegisterViewCtrller *registerCtrller = [segue destinationViewController] ;
        registerCtrller.name = self.tf_name.text ;
        registerCtrller.pass = self.tf_pass.text ;
    }
}


@end
