//
//  ECRequestMapper.h
//  ECMCRemoteProject
//
//  Created by Inspeero Technologies on 07/04/15.
//  Copyright (c) 2015 Inspeero Technologies. All rights reserved.
//

@import Foundation;

@interface ECRequestMapper : NSObject
@property (nonatomic, strong) __block NSMutableDictionary* requestsInQueue;
+ (ECRequestMapper*)sharedInstance;
- (void) setRequestDictionaryForID:(long long)reqId forRequest:(id)requestObj;
- (void) removeRequestInQueueWithDelegate:(id)deleg;
- (void) removeRequestInQueueForId:(NSString*)key;
@end
