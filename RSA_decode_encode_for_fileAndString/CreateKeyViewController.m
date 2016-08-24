//
//  CreateKeyViewController.m
//  RSA_decode_encode_for_fileAndString
//
//  Created by skyinno on 16/8/24.
//  Copyright © 2016年 skyinno. All rights reserved.
//

#import "CreateKeyViewController.h"

@interface CreateKeyViewController ()

@end

@implementation CreateKeyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    self.lbPrivate.text=_privateKey;
    self.lbPublic.text=_publicKey;
    
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

- (IBAction)backClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end
