//
//  ECNetworkFactory.h
//  ECMCRemoteProject
//
//  Created by Inspeero Technologies on 16/04/15.
//  Copyright (c) 2015 Inspeero Technologies. All rights reserved.
//

@import Foundation;
#import "ECRequestFactory.h"
#import "ECBaseRequest.h"

enum : NSUInteger {
    CONNECTION_TYPE_HTTP        = 0,
    CONNECTION_TYPE_BLUETOOTH   = 1
}ECConnectionType;

@protocol NetworkProtocol <NSObject>
- (void)sendRequestOnClient:(ECBaseRequest*)ECRequest;
@end

@interface ECNetworkFactory : NSObject {
    @private
    NSUInteger currentConnectionType;
}

+ (ECNetworkFactory*)sharedInstance;
- (id<NetworkProtocol>) getClient;
- (void) setConnectionType;
@end
