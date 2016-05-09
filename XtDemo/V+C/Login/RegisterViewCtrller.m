//
//  RegisterViewCtrller.m
//  XtDemo
//
//  Created by teason on 16/5/6.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "RegisterViewCtrller.h"
#import "User.h"
#import "LoginHandler.h"
#import "YYModel.h"

@interface RegisterViewCtrller ()

@property (weak, nonatomic) IBOutlet UITextField *tf_name;
@property (weak, nonatomic) IBOutlet UITextField *tf_pass;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment_jobKind;
@property (weak, nonatomic) IBOutlet UIButton *btRegister;

@end

@implementation RegisterViewCtrller

#pragma mark -

- (IBAction)btRegisterConfirmOnClick:(id)sender
{
    if (!_tf_name.text.length || !_tf_pass.text.length) {
        [XTHudManager showWordHudWithTitle:@"未填写完整!"] ;
        return ;
    }
    
    // register .
    [ServerRequest registerName:_tf_name.text
                       password:_tf_pass.text
                           kind:[self getKindOfJobInSegment]
                        success:^(id json) {
                            
                            ResultParsered *result = [[ResultParsered alloc] initWithDic:json] ;
                            if ([result.returnCode integerValue] == 1001) {
                                [XTHudManager showWordHudWithTitle:@"注册成功!"] ;
                                User *user = [User yy_modelWithJSON:result.returnData] ;
                                [LoginHandler loginCachedInUserDefaults:user] ;
                                [self dismissViewControllerAnimated:YES completion:^{}] ;
                            }
                            else {
                                [XTHudManager showWordHudWithTitle:result.returnMsg] ;
                            }
                            
                        } fail:^{
                            [XTHudManager showWordHudWithTitle:@"网络不好!"] ;
                        }] ;
    
}

#pragma mark -
- (KindOfJob)getKindOfJobInSegment
{
    switch (_segment_jobKind.selectedSegmentIndex) {
        case 0:
        {
            return subaojiang ;
        }
            break;
        case 1:
        {
            return xiaoxuzi ;
        }
            break;
        case 2:
        {
            return admin ;
        }
            break;
        default:
            break;
    }
    
    return 0 ;
}

#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad] ;
    
    [self configureUIs] ;
    
    self.tf_name.text = self.name ;
    self.tf_pass.text = self.pass ;
}

- (void)configureUIs
{
    _tf_name.layer.cornerRadius = 5. ;
    _tf_pass.layer.cornerRadius = 5. ;
    _btRegister.layer.cornerRadius = 5. ;
    _tf_name.layer.borderWidth = 1. ;
    _tf_name.layer.borderColor = [UIColor xt_mainColor].CGColor ;
    _tf_pass.layer.borderWidth = 1. ;
    _tf_pass.layer.borderColor = [UIColor xt_mainColor].CGColor ;
    _btRegister.layer.borderWidth = 1. ;
    _btRegister.layer.borderColor = [UIColor xt_mainColor].CGColor ;
}

@end
