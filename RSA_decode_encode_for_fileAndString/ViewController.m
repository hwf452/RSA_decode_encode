//
//  ViewController.m
//  RSA_decode_encode_for_fileAndString
//
//  Created by skyinno on 16/8/24.
//  Copyright © 2016年 skyinno. All rights reserved.
//

#import "ViewController.h"
#define DocumentsDir [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define OpenSSLRSAKeyDir [DocumentsDir stringByAppendingPathComponent:@".openssl_rsa"]
#define OpenSSLRSAPublicKeyFile [OpenSSLRSAKeyDir stringByAppendingPathComponent:@"bb.publicKey.pem"]
#define OpenSSLRSAPrivateKeyFile [OpenSSLRSAKeyDir stringByAppendingPathComponent:@"bb.privateKey.pem"]

#define kRSAPublicKey @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDjzcWpTrtuPJX8pkgWAx1z9/3Yb2ddC9ix4wMImTZ4vQO5xaiYf2bKkCbpIRscQS1y1jy6LlWMyynh1ocVmJgVj7SFCnvPHRYNR/6cip0vpdC5FEzjIBLmtdHGsJWuUFwB27XGtFMc5AaWm0+5tfIsenJnrbq4Vi0w+1vtvcpnYQIDAQAB"

#define kRSAPrivateKey @"MIICWwIBAAKBgQDjzcWpTrtuPJX8pkgWAx1z9/3Yb2ddC9ix4wMImTZ4vQO5xaiYf2bKkCbpIRscQS1y1jy6LlWMyynh1ocVmJgVj7SFCnvPHRYNR/6cip0vpdC5FEzjIBLmtdHGsJWuUFwB27XGtFMc5AaWm0+5tfIsenJnrbq4Vi0w+1vtvcpnYQIDAQABAoGAbzWze1X+VnCpYC/lHSnkJQs6F4E7Wsc/wIfsoTP6zbKosPZ3ugroKZd6B3GsBH0lLNy9xL598T/1cFUEmVxnUaNT/t26X9t14EqgnGiGL8dC+ZBdl4DjOcjHi1HAnfEWKOhoFydph+6ndLaiSKkZlLeb6YXoKzarToEqYQFYPeECQQD8YssODW4lv/76PvmRhImq8GLEHryzYTXwS/Fz1Cd3VVDepcVRJ4uUy5q7Ig3Z+njlCUldipEx2eON7Dx0KtvNAkEA5xDdYwxpZqvRZGroj52hgOlTAYASDIa3kqN8WKZS9+k+8lUgOqk+ko9XPHGX/Qs6A+wcI2XuFaFnWTvC7NPt5QJAL3fNRPlVrBfuNta9TZcl5VaM3OIDD6HK6UT/Ro+yVIlhSl7XO6o6YGPi2CtRe5vWPQ2AFO3I3R1j5P93Z0ngSQJAOPq2rTMlVrUt+IZIfQnRBroCxw7u5HngEOARzMaPFSVGaXnGbdDIZlnEmFomsbawAsGZmr0K/fiERMPw6HfGZQJAOYCL+CyrtXweL+1pUL5CGrX51+cXUpUc2xzoGZvtsvcDgBjAuMlpCn3+dsXUlDvfeAuKDmmREbFXFOUBJjxRkw=="

#import "NSString+Base64.h"
#import "NSData+Base64.h"


#import "BBRSACryptor.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnCreateKeyClick:(UIButton *)sender {
    
    BBRSACryptor *rsaCryptor = [[BBRSACryptor alloc] init];
    
    [rsaCryptor generateRSAKeyPairWithKeySize:1024];
    
    //公钥 [rsaCryptor PEMFormatPublicKey]
    //私钥 [rsaCryptor PEMFormatPrivateKey]
    
    
    
    NSLog(@"私钥:%@",[rsaCryptor PEMFormatPrivateKey]);
    NSLog(@"公钥:%@",[rsaCryptor PEMFormatPublicKey]);
    
    
    CreateKeyViewController *create=[[CreateKeyViewController alloc] initWithNibName:@"CreateKeyViewController" bundle:nil];
    
    create.publicKey=[rsaCryptor PEMFormatPublicKey];
    create.privateKey=[rsaCryptor PEMFormatPrivateKey];
    
    [self presentViewController:create animated:YES completion:^{
        
    }];
}

- (IBAction)inputPublic:(UIButton *)sender {
    
    BBRSACryptor *rsaCryptor = [[BBRSACryptor alloc] init];
    BOOL importSuccess = [rsaCryptor importRSAPublicKeyBase64:kRSAPublicKey];
    NSLog(@"imporRsapublicSuccess:%zi",importSuccess);
    [[iToast makeText:@"文本公钥导入成功"] show];
    
    

}

- (IBAction)inputFilePublic:(UIButton *)sender {
    BBRSACryptor *rsaCryptor = [[BBRSACryptor alloc] init];
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:OpenSSLRSAPublicKeyFile]){
        NSString *rsaPath=[[NSBundle mainBundle] pathForResource:@"app_public_key" ofType:@"pem"];
        BOOL success = [fm copyItemAtPath:rsaPath toPath:OpenSSLRSAPublicKeyFile error:nil];
        if (success) {
            NSLog(@"文件复制成功");
            [[iToast makeText:@"文件公钥导入成功"] show];
        }
    }else{
        [[iToast makeText:@"文件公钥已存在"] show];

    }

}

- (IBAction)inputprivate:(UIButton *)sender {
    
    BBRSACryptor *rsaCryptor = [[BBRSACryptor alloc] init];
    BOOL importSuccess = [rsaCryptor importRSAPrivateKeyBase64:kRSAPrivateKey];
    NSLog(@"imporRsaprivateSuccess:%zi",importSuccess);
    [[iToast makeText:@"文本私钥导入成功"] show];
    
    
}
- (IBAction)inputFilePrivate:(UIButton *)sender {
    BBRSACryptor *rsaCryptor = [[BBRSACryptor alloc] init];
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:OpenSSLRSAPrivateKeyFile]){
        NSString *rsaPath=[[NSBundle mainBundle] pathForResource:@"app_private_key" ofType:@"pem"];
        BOOL success = [fm copyItemAtPath:rsaPath toPath:OpenSSLRSAPrivateKeyFile error:nil];
        if (success) {
            NSLog(@"私钥文件复制成功");
            [[iToast makeText:@"文件私钥导入成功"] show];
        }
    }else{
        [[iToast makeText:@"文件私钥已存在"] show];
        
    }
}

- (IBAction)publicEncode:(UIButton *)sender {
    BBRSACryptor *rsaCryptor = [[BBRSACryptor alloc] init];
    BOOL importSuccess = [rsaCryptor importRSAPublicKeyBase64:kRSAPublicKey];
    NSLog(@"imporRsapublicSuccess:%zi",importSuccess);
    if (self.tf_encodeordecode.text.length>0) {
        NSData *cipherData = [rsaCryptor encryptWithPublicKeyUsingPadding:RSA_PKCS1_PADDING plainData:[self.tf_encodeordecode.text dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSString *str = [cipherData base64EncodedString];
        NSLog(@"data:%@",cipherData);
        NSLog(@"str:%@",str);
        _lb_result.text=str;
        self.tf_encodeordecode.text=str;
        
    }else{
        [[iToast makeText:@"请输入要加密的文本"] show];
    }
    
    
}

- (IBAction)publicDecode:(UIButton *)sender {
    
    
    
    BBRSACryptor *rsaCryptor = [[BBRSACryptor alloc] init];
    BOOL importSuccess = [rsaCryptor importRSAPublicKeyBase64:kRSAPublicKey];
    NSLog(@"imporRsapublicSuccess:%zi",importSuccess);
    if (self.tf_encodeordecode.text.length>0) {
        NSData *cipherData = [self.tf_encodeordecode.text base64DecodedData];
        NSData *plainData = [rsaCryptor decryptWithPublicKeyUsingPadding:RSA_PADDING_TYPE_PKCS1 cipherData:cipherData];
        NSString *plainText = [[NSString alloc]initWithData:plainData encoding:NSUTF8StringEncoding];
        NSString *str1 = [NSString stringWithFormat:@"解密可得: \n%@", plainText];
        NSLog(@"%@",str1);
        _lb_result.text=str1;
    }else{
        [[iToast makeText:@"请输入要解密的文本"] show];
    }
}

- (IBAction)privateEncode:(UIButton *)sender {
    BBRSACryptor *rsaCryptor = [[BBRSACryptor alloc] init];
    BOOL importSuccess = [rsaCryptor importRSAPrivateKeyBase64:kRSAPrivateKey];
    NSLog(@"imporRsaprivateSuccess:%zi",importSuccess);
    
    if (self.tf_encodeordecode.text.length>0) {
        NSData *cipherData = [rsaCryptor encryptWithPrivateKeyUsingPadding:RSA_PKCS1_PADDING plainData:[self.tf_encodeordecode.text dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSString *str = [cipherData base64EncodedString];
        NSLog(@"data:%@",cipherData);
        NSLog(@"str:%@",str);
        _lb_result.text=str;
        self.tf_encodeordecode.text=str;
    }else{
        [[iToast makeText:@"请输入要加密的文本"] show];
    }
}

- (IBAction)privateDecode:(UIButton *)sender {
    
    
    
    
    BBRSACryptor *rsaCryptor = [[BBRSACryptor alloc] init];
    BOOL importSuccess = [rsaCryptor importRSAPrivateKeyBase64:kRSAPrivateKey];
    NSLog(@"imporRsaprivateSuccess:%zi",importSuccess);
    if (self.tf_encodeordecode.text.length>0) {
        NSData *cipherData = [self.tf_encodeordecode.text base64DecodedData];
        NSData *plainData = [rsaCryptor decryptWithPrivateKeyUsingPadding:RSA_PADDING_TYPE_PKCS1 cipherData:cipherData];
        NSString *plainText = [[NSString alloc]initWithData:plainData encoding:NSUTF8StringEncoding];
        NSString *str1 = [NSString stringWithFormat:@"解密可得: \n%@", plainText];
        NSLog(@"%@",str1);
        _lb_result.text=str1;
    }else{
        [[iToast makeText:@"请输入要解密的文本"] show];
    }
}

//关闭键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



@end
