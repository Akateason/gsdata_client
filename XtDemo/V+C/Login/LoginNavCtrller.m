//
//  LoginNavCtrller.m
//  XtDemo
//
//  Created by teason on 16/5/6.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "LoginNavCtrller.h"

@interface LoginNavCtrller ()

@end

@implementation LoginNavCtrller

+ (void)modalToLoginNavCtrllerWithOrignalCtrller:(UIViewController *)ctrllerOrigin
{
    LoginNavCtrller *navCtrller = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginNavCtrller"] ;
    
    [ctrllerOrigin presentViewController:navCtrller
                                animated:YES
                              completion:^{
        
    }] ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
