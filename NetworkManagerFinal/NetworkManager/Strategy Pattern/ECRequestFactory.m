//
//  ECRequestFactory.m
//  ECMCRemoteProject
//
//  Created by Inspeero Technologies on 16/04/15.
//  Copyright (c) 2015 Inspeero Technologies. All rights reserved.
//

#import "ECRequestFactory.h"
#import "ECBaseRequest.h"
//#import "ECInitialSetupRequest.h"

@implementation ECRequestFactory

+ (ECRequestFactory*)sharedInstance {
    static ECRequestFactory *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}
/*
+ (id<GatewayRequest>)requestForAPI:(NSInteger)reqType parameters:(NSDictionary *)params withStrategy:(NSInteger)strategyType forDelegate:(id)delegate {
    switch (reqType) {
        case RT_INITIAL_SETUP_GET_PAGE:
            return [[ECInitialSetupRequest alloc] initWithGetPage:params withStrategy:strategyType forDelegate:delegate];
            break;
            
        default:
            break;
    }
}
*/
@end
