//
//  ECStrategy.m
//  ECMCRemoteProject
//
//  Created by Inspeero Technologies on 18/05/15.
//  Copyright (c) 2015 Inspeero Technologies. All rights reserved.
//

#import "ECStrategy.h"
#import "ECNetworkFactory.h"
#import "ECRequestMapper.h"

@implementation ECStrategy

+ (ECStrategy*)sharedInstance {
    static ECStrategy *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (void)requestForAPI:(id<GatewayRequest>)requestObj {
    //id <GatewayRequest> request = [ECRequestFactory requestForAPI:RT_INITIAL_SETUP_GET_PAGE parameters:params withStrategy:STRAT_DEFAULT forDelegate:delegate];
    requestObj.requestStrategy = STRAT_DEFAULT;
    //TODO: Remove Special Handling
    if (requestObj.requestIdentifier != RT_PLAYER_SEEK_TYPE || requestObj.requestIdentifier != RT_PLAYER_GET_PROPERTIES_TYPE) {
//        NSMutableDictionary *requestsInQueueCopy = [[ECRequestMapper sharedInstance] requestsInQueue];
        NSArray *keysArray = nil;
        @try {
            keysArray = [[[ECRequestMapper sharedInstance] requestsInQueue] allKeys];
        } @catch (NSException *exception) {
//            NSLog(@"\n\n Exception occured : %@",exception);
//            NSLog(@"\n Request count : %lu ",(unsigned long)requestsInQueueCopy.count);
//            NSLog(@"\n All Requests  : %@ ",requestsInQueueCopy);
        }
        if ([keysArray containsObject:[NSString stringWithFormat:@"%ld",(long)requestObj.requestIdentifier]]) {
            long long newReqId = [self getUniqueIdFor:[NSString stringWithFormat:@"%ld",(long)requestObj.requestIdentifier]];
            NSMutableString* tempStr = [NSMutableString stringWithString:requestObj.requestString];
            [tempStr replaceOccurrencesOfString:[NSString stringWithFormat:@"%ld",(long)requestObj.requestIdentifier]
                                                            withString:[NSString stringWithFormat:@"%lld",newReqId]
                                                            options:NSCaseInsensitiveSearch
                                                        range:((NSRange){0, [requestObj.requestString length]})];
            requestObj.requestString = tempStr ;
            requestObj.requestIdentifier = newReqId;
        }
        
//        [[ECRequestMapper sharedInstance] setRequestDictionaryForID:requestObj.requestIdentifier forRequest:requestObj];
    }
    [requestObj sendRequest];
}

- (id<GatewayRequest>)requestForAPIDontSend:(id<GatewayRequest>)requestObj {
    //id <GatewayRequest> request = [ECRequestFactory requestForAPI:RT_INITIAL_SETUP_GET_PAGE parameters:params withStrategy:STRAT_DEFAULT forDelegate:delegate];
    requestObj.requestStrategy = STRAT_DEFAULT;
    //TODO: Remove Special Handling
    if (requestObj.requestIdentifier != RT_PLAYER_SEEK_TYPE  || requestObj.requestIdentifier != RT_PLAYER_GET_PROPERTIES_TYPE) {
        @try {
//            NSMutableDictionary *requestsInQueueCopy = [[ECRequestMapper sharedInstance] requestsInQueue];
            NSArray *keysArray = nil;
            @try {
                keysArray = [[[ECRequestMapper sharedInstance] requestsInQueue] allKeys];
            } @catch (NSException *exception) {
//                NSLog(@"\n\n Exception occured : %@",exception);
//                NSLog(@"\n Request count : %lu ",(unsigned long)requestsInQueueCopy.count);
//                NSLog(@"\n All Requests  : %@ ",requestsInQueueCopy);
            }
            if ([keysArray containsObject:[NSString stringWithFormat:@"%ld",(long)requestObj.requestIdentifier]]) {
                long long newReqId = [self getUniqueIdFor:[NSString stringWithFormat:@"%ld",(long)requestObj.requestIdentifier]];
                NSMutableString* tempStr = [NSMutableString stringWithString:requestObj.requestString];
                [tempStr replaceOccurrencesOfString:[NSString stringWithFormat:@"%ld",(long)requestObj.requestIdentifier]
                                         withString:[NSString stringWithFormat:@"%lld",newReqId]
                                            options:NSCaseInsensitiveSearch
                                              range:((NSRange){0, [requestObj.requestString length]})];
                requestObj.requestString = tempStr ;
                requestObj.requestIdentifier = newReqId;
                //            NSLog(@"requestIdenfier %d",newReqId);
            }
            [[ECRequestMapper sharedInstance] setRequestDictionaryForID:requestObj.requestIdentifier forRequest:requestObj];
        }
        @catch (NSException *exception) {
            NSLog(@"\n\n Request identifier : %@",[NSString stringWithFormat:@"%ld",(long)requestObj.requestIdentifier]);
            NSLog(@"\n\n All Keys : \n%@\n\n\n",[[[ECRequestMapper sharedInstance] requestsInQueue] allKeys]);
        }
    }
    return requestObj;
}

- (long long)getUniqueIdFor:(NSString*)reqId {
//    NSLog(@"\n ReqId (%@) isKindOfClass: %@", reqId, [reqId class]);
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",reqId];
//    NSMutableDictionary *requestsInQueueCopy = [[ECRequestMapper sharedInstance] requestsInQueue];
    NSArray *keysArray = nil;
    @try {
        keysArray = [[[ECRequestMapper sharedInstance] requestsInQueue] allKeys];
    } @catch (NSException *exception) {
//        NSLog(@"\n\n Exception occured : %@",exception);
//        NSLog(@"\n Request count : %lu ",(unsigned long)requestsInQueueCopy.count);
//        NSLog(@"\n All Requests  : %@ ",requestsInQueueCopy);
    }
    NSArray* resultArr = [keysArray filteredArrayUsingPredicate:predicate];
    if (resultArr.count == 1) {
        //its 1st 4 digits number
        NSMutableString* newStr = [NSMutableString stringWithFormat:@"%d",[reqId intValue]];
        [newStr appendString:@"000000"];
        return [newStr longLongValue];
    }else {
        long long max = [[resultArr valueForKeyPath:@"@max.longLongValue"] longLongValue];
        return (max+1);
    }
}

@end
