//
//  ViewController.h
//  RSA_decode_encode_for_fileAndString
//
//  Created by skyinno on 16/8/24.
//  Copyright © 2016年 skyinno. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CreateKeyViewController.h"
#import "iToast.h"

@interface ViewController : UIViewController

- (IBAction)btnCreateKeyClick:(UIButton *)sender;

- (IBAction)inputPublic:(UIButton *)sender;


- (IBAction)inputFilePublic:(UIButton *)sender;

- (IBAction)inputprivate:(UIButton *)sender;



- (IBAction)inputFilePrivate:(UIButton *)sender;


- (IBAction)publicEncode:(UIButton *)sender;


- (IBAction)publicDecode:(UIButton *)sender;


- (IBAction)privateEncode:(UIButton *)sender;

- (IBAction)privateDecode:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UITextField *tf_encodeordecode;


@property (weak, nonatomic) IBOutlet UILabel *lb_result;





@end

