//
//  ECJSONRPCNetworkClient.h
//  ECMCRemoteProject
//
//  Created by Inspeero Technologies on 16/04/15.
//  Copyright (c) 2015 Inspeero Technologies. All rights reserved.
//

//#import <AFNetworking/AFNetworking.h>

#import "AFNetworking.h"
#import "ECNetworkFactory.h"

@interface ECJSONRPCNetworkClient : NSObject <NetworkProtocol>

+ (ECJSONRPCNetworkClient*)sharedInstance;

@end
