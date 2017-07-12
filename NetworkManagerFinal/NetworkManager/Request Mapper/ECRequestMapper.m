//
//  ECRequestMapper.m
//  ECMCRemoteProject
//
//  Created by Inspeero Technologies on 07/04/15.
//  Copyright (c) 2015 Inspeero Technologies. All rights reserved.
//

#import "ECRequestMapper.h"
#import "ECBaseRequest.h"

@interface ECRequestMapper() {
    dispatch_queue_t _requestMapperQueue;
}

@end

@implementation ECRequestMapper
@synthesize requestsInQueue;

+ (ECRequestMapper*)sharedInstance {
    static ECRequestMapper *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (void) setRequestDictionaryForID:(long long)reqId forRequest:(id)requestObj {
    if (!requestsInQueue) {
        requestsInQueue         = [[NSMutableDictionary alloc] init];
        _requestMapperQueue = dispatch_queue_create("com.ecm.requestMapperQueue", DISPATCH_QUEUE_SERIAL);
    }
    NSString *requestKey = [NSString stringWithFormat:@"%lld",reqId];
//    NSLog(@"\n setRequestDictionaryForID ERROR :::: requestKey:%@", requestKey);
    
    if ([requestKey isKindOfClass:[NSNull class]] || [requestObj isKindOfClass:[NSNull class]]) {
//        CLSNSLog(@"\n CRASH ERROR :::: \n requestKey:%@ \n requestObj :%@ ", requestKey,requestObj);
    }
    [requestsInQueue setValue:requestObj forKey:requestKey];
}

- (void) removeRequestInQueueWithDelegate:(id)deleg {
    if (requestsInQueue) {
        NSMutableArray* deleteRequests = [[NSMutableArray alloc] init];
        for (NSString* reqIdStr in requestsInQueue.allKeys) {
            id<GatewayRequest> reqObj = [requestsInQueue valueForKey:reqIdStr];
            if (reqObj.delegate == deleg) {
                [deleteRequests addObject:reqIdStr];
            }
        }
        for (NSString* deleteReqId in deleteRequests) {
            NSLog(@"Request Deleted %@",deleteReqId);
            [self removeObjectFromMapper:deleteReqId];
        }
    }
}

- (void) removeRequestInQueueForId:(NSString*)key {
    [requestsInQueue removeObjectForKey:key];
}

- (void) removeObjectFromMapper:(NSString*)key {
    dispatch_async(_requestMapperQueue, ^{
        [requestsInQueue removeObjectForKey:key];
    });
}

@end
