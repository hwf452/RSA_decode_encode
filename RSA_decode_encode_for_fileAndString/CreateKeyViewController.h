//
//  CreateKeyViewController.h
//  RSA_decode_encode_for_fileAndString
//
//  Created by skyinno on 16/8/24.
//  Copyright © 2016年 skyinno. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateKeyViewController : UIViewController

- (IBAction)backClick:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UILabel *lbPrivate;


@property (weak, nonatomic) IBOutlet UILabel *lbPublic;

@property (copy, nonatomic)  NSString *publicKey;

@property (copy, nonatomic)  NSString *privateKey;







@end
