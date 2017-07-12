//
//  ECBaseRequest.m
//  ECMCRemoteProject
//
//  Created by Inspeero Technologies on 16/04/15.
//  Copyright (c) 2015 Inspeero Technologies. All rights reserved.
//

#import "ECBaseRequest.h"
#import "ECNetworkFactory.h"
#import "ECJSONRPCNetworkClient.h"

@implementation ECBaseRequest
@synthesize requestString, requestIdentifier, requestStrategy, delegate,requestParameters ,requestType;;

- (void)sendRequest {
    __block id<NetworkProtocol> client = [[ECNetworkFactory sharedInstance] getClient];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [client sendRequestOnClient:self];
    });
}
@end
