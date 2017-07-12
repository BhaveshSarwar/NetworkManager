//
//  ECStrategy.h
//  ECMCRemoteProject
//
//  Created by Inspeero Technologies on 18/05/15.
//  Copyright (c) 2015 Inspeero Technologies. All rights reserved.
//


@import Foundation;
#import "ECRequestFactory.h"


typedef enum : NSUInteger {
    STRAT_DEFAULT,
} STARTEGY_TYPE;

@interface ECStrategy : NSObject

+ (ECStrategy*)sharedInstance;
- (void)requestForAPI:(id<GatewayRequest>)requestObj;
- (id<GatewayRequest>)requestForAPIDontSend:(id<GatewayRequest>)requestObj;

@end
