//
//  ViewController.m
//  NetworkManagerFinal
//
//  Created by Bhavesh Sarwar on 7/11/17.
//  Copyright © 2017 Pathik Botadra. All rights reserved.
//

#import "ViewController.h"
#import "GenerateRequest.h"
#import "ECStrategy.h"
@interface ViewController ()<RequestHandler>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *url =  @"http://vps2.inspeero.com/gcapi/api/Update_contact.php";
    
    NSDictionary *parameters =@{
                                @"uid":@"17",
                                @"contacts": @[
                                        @{
                                            @"name": @"Raj Trisdcsdcvasdcasdcsdcasdcedi",
                                            @"mobile_alternate": @"1234sacasdcsdc567890",
                                            @"email": @"smalgoankar@inspeero.com",
                                            @"company": @"Raj Pvtasdcasdc Ltd",
                                            @"location": @"Mumbasadcasdci",
                                            @"designation": @"Mascdasdnager",
                                            @"notes": @"Hello sadcasdcnotes!",
                                            @"mobile": @"123098sdcsadcs7654"
                                            }
                                        ]
                                };
    
    NSDictionary *headerParameters = @{
                                       @"token":@"ajnskjnkja"
                                       };
    
    
    id<GatewayRequest> request = [[GenerateRequest alloc] generateRequestWith:url
                                                                   parameters:parameters
                                                             headerParameters:nil
                                                                  forDelegate:self
                                                                       ofType:POST
                                                                isJSONRequest:YES];
    
    
    
    [[ECStrategy sharedInstance] requestForAPI:request];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)requestFailed:(NSDictionary *)failureResult{
    NSLog(@"response failed");
}
-(void)responseReceived:(NSDictionary *)result{
    
    NSLog(@"response received: %@",result);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
