//
//  ECNetworkFactory.m
//  ECMCRemoteProject
//
//  Created by Inspeero Technologies on 16/04/15.
//  Copyright (c) 2015 Inspeero Technologies. All rights reserved.
//

#import "ECNetworkFactory.h"
#import "ECJSONRPCNetworkClient.h"

@implementation ECNetworkFactory

+ (ECNetworkFactory*)sharedInstance {
    static ECNetworkFactory *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setConnectionType) name:@"ECNetworkConnectionTypeChanged" object:nil];
    });
    return sharedMyManager;
}

#pragma mark - notification listener
- (void) setConnectionType {
    //TODO: manage current type based upon notification
    currentConnectionType = CONNECTION_TYPE_HTTP;
}

- (id) getClient {
    switch (currentConnectionType) {
        case CONNECTION_TYPE_HTTP:{
            return [ECJSONRPCNetworkClient sharedInstance];
            break;
        }
        case CONNECTION_TYPE_BLUETOOTH:{
            break;
        }
        default:
            break;
    }
    return [ECJSONRPCNetworkClient sharedInstance];
}

@end
