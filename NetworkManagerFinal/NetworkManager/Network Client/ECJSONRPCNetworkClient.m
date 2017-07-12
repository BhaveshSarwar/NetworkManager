//
//  ECJSONRPCNetworkClient.m
//  ECMCRemoteProject
//
//  Created by Inspeero Technologies on 16/04/15.
//  Copyright (c) 2015 Inspeero Technologies. All rights reserved.
//

#import "ECJSONRPCNetworkClient.h"
#import "ECRequestMapper.h"
#import "ECBaseRequest.h"

@interface ECJSONRPCNetworkClient (){
    dispatch_queue_t _networkManagerQueue;
}

@property (nonatomic, strong) NSURLSessionConfiguration *sessionConfiguration1;
@property (nonatomic, strong) AFURLSessionManager *manager1;
@property (nonatomic, strong) NSURLSessionConfiguration *sessionConfiguration2;
@property (nonatomic, strong) AFURLSessionManager *manager2;

@end

@implementation ECJSONRPCNetworkClient
@synthesize sessionConfiguration1, manager1, sessionConfiguration2, manager2;

+ (ECJSONRPCNetworkClient*)sharedInstance {
    static ECJSONRPCNetworkClient *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (void)initializeManager {
    //sync manager
    sessionConfiguration1 = [NSURLSessionConfiguration defaultSessionConfiguration];
    manager1 = [[AFURLSessionManager alloc] initWithSessionConfiguration:sessionConfiguration1];
    [manager1 setResponseSerializer:[AFJSONResponseSerializer serializer]];
    _networkManagerQueue = dispatch_queue_create("com.ecm.networkManagerQueue", DISPATCH_QUEUE_CONCURRENT);
    manager1.completionQueue = _networkManagerQueue;
    
    //manager 2 without queue
    sessionConfiguration2 = [NSURLSessionConfiguration defaultSessionConfiguration];
    manager2 = [[AFURLSessionManager alloc] initWithSessionConfiguration:sessionConfiguration2];
    [manager2 setResponseSerializer:[AFJSONResponseSerializer serializer]];
}
- (id<GatewayRequest>)getRequestfor:(NSString *)identifier{
    NSArray *keysArray = nil;
    @try {
        keysArray = [[[ECRequestMapper sharedInstance] requestsInQueue] allKeys];
    } @catch (NSException *exception) {
        //                NSLog(@"\n\n Exception occured : %@",exception);
        //                NSLog(@"\n Request count : %lu ",(unsigned long)requestsInQueueCopy.count);
        //                NSLog(@"\n All Requests  : %@ ",requestsInQueueCopy);
    }
    if ([keysArray containsObject:identifier]) {
        id<GatewayRequest> requestCaller = [[[ECRequestMapper sharedInstance] requestsInQueue] valueForKey:identifier];
        [[ECRequestMapper sharedInstance] removeRequestInQueueForId:identifier];
        return requestCaller;
//        [requestCaller parseResponse:responseObject];
    }
    else {
        //                [((ECAppDelegate*)[[UIApplication sharedApplication] delegate]) hideHUD];
        NSLog(@"Request Not Present %@",identifier);
    }
    return nil;
}

-(void)sendGetRequestforrequest:(id<GatewayRequest>)ECRequest {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    for (NSString *key  in ECRequest.headerParameters.allKeys) {
        [manager.requestSerializer setValue:[ECRequest.headerParameters valueForKey:key] forHTTPHeaderField:key];
    }
    [manager.requestSerializer setTimeoutInterval:15];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSURLSessionDataTask *task =
    
    [manager GET:ECRequest.requestString parameters:ECRequest.requestParameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        id<GatewayRequest> requestCaller = [self getRequestfor:[NSString stringWithFormat:@"%lu",(unsigned long)task.taskIdentifier]];
        if (requestCaller) [requestCaller parseResponse:responseObject];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
//    [manager POST:ECRequest.requestString parameters:ECRequest.requestParameters success:^(NSURLSessionDataTask *task, id responseObject) {
//
//        id<GatewayRequest> requestCaller = [self getRequestfor:[NSString stringWithFormat:@"%lu",(unsigned long)task.taskIdentifier]];
//        if (requestCaller) [requestCaller parseResponse:responseObject];
//
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//
//
//    }];
    
    ECRequest.taskIdentifier = task.taskIdentifier;
    [[ECRequestMapper sharedInstance] setRequestDictionaryForID:ECRequest.taskIdentifier forRequest:ECRequest];
    
}

-(void)sendPOSTRequestforrequest:(id<GatewayRequest>)ECRequest {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    for (NSString *key  in ECRequest.headerParameters.allKeys) {
         [manager.requestSerializer setValue:[ECRequest.headerParameters valueForKey:key] forHTTPHeaderField:key];
    }
    
    [manager.requestSerializer setTimeoutInterval:15];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    if (ECRequest.isJSONRequest == YES) {
         manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    NSURLSessionDataTask *task =  [manager POST:ECRequest.requestString parameters:ECRequest.requestParameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        id<GatewayRequest> requestCaller = [self getRequestfor:[NSString stringWithFormat:@"%lu",(unsigned long)task.taskIdentifier]];
        if (requestCaller) [requestCaller parseResponse:responseObject];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        id<GatewayRequest> requestCaller = [self getRequestfor:[NSString stringWithFormat:@"%lu",(unsigned long)task.taskIdentifier]];
        if (requestCaller) [requestCaller requestFailed:error];
        
    }];
    
    ECRequest.taskIdentifier = task.taskIdentifier;
    [[ECRequestMapper sharedInstance] setRequestDictionaryForID:ECRequest.taskIdentifier forRequest:ECRequest];
    
}


- (void)sendRequestOnClient:(id<GatewayRequest>)ECRequest {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        [self initializeManager];
//    });
//
    
    switch (ECRequest.requestType) {
            
        case GET:
            [self sendGetRequestforrequest:ECRequest];
            break;
            
        case POST:
            [self sendPOSTRequestforrequest:ECRequest];
            break;
            
        default:
            break;
    }
    
    
    
    
    
    
//    NSArray *keysArray = nil;
//    @try {
//        keysArray = [[[ECRequestMapper sharedInstance] requestsInQueue] allKeys];
//    } @catch (NSException *exception) {
//        //                NSLog(@"\n\n Exception occured : %@",exception);
//        //                NSLog(@"\n Request count : %lu ",(unsigned long)requestsInQueueCopy.count);
//        //                NSLog(@"\n All Requests  : %@ ",requestsInQueueCopy);
//    }
//    if ([keysArray containsObject:[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"id"]]]) {
////        id<GatewayRequest> requestCaller = [[[ECRequestMapper sharedInstance] requestsInQueue] valueForKey:[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"id"]]];
////        [[ECRequestMapper sharedInstance] removeRequestInQueueForId:[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"id"]]];
//        [requestCaller parseResponse:responseObject];
//    }
    
    
    
//    task.taskIdentifier = ECRequest.requestIdentifier;
//    NSLog(@"sdajsdasd");
//    tas
//    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        completionHandler (responseObject,nil);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        completionHandler (nil,error);
//    }];
    
    
    
    
    
//    if ([str rangeOfString:@"JsonStub-User-Key.com"].location != NSNotFound) {
//        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//        [request setValue:@"bede620e-3c53-418c-9403-e39dce40f20d" forHTTPHeaderField:@"JsonStub-User-Key"];
//        [request setValue:@"794b09fe-afcb-45e8-b2af-d3759ece147f" forHTTPHeaderField:@"JsonStub-Project-Key"];
//    }
//    /**
//     check if it is a sync api
//     then send on sync manager
//     else on UI manager
//    */
//    NSString* idStr = [NSString stringWithFormat:@"%ld",(long)ECRequest.requestIdentifier];
//
//    if ([idStr rangeOfString:[NSString stringWithFormat:@"%ld",(long)RT_GET_ALL_ALBUMS_TYPE]].location != NSNotFound ||
//        [idStr rangeOfString:[NSString stringWithFormat:@"%ld",(long)RT_GET_ALL_SONGS_TYPE]].location != NSNotFound ||
//        [idStr rangeOfString:[NSString stringWithFormat:@"%ld",(long)RT_GET_ALL_VIDEO_GENRE_TYPE]].location != NSNotFound ||
//        [idStr rangeOfString:[NSString stringWithFormat:@"%ld",(long)RT_GET_ALL_MOVIES_TYPE]].location != NSNotFound ||
//        [idStr rangeOfString:[NSString stringWithFormat:@"%ld",(long)RT_GET_ALL_TV_SHOWS_TYPE ]].location != NSNotFound ||
//        [idStr rangeOfString:[NSString stringWithFormat:@"%ld",(long)RT_GET_ALL_SEASONS_TYPE]].location != NSNotFound ||
//        [idStr rangeOfString:[NSString stringWithFormat:@"%ld",(long)RT_GET_ALL_EPISODES_TYPE]].location != NSNotFound) {
//
//        [[manager1 dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
////            NSMutableDictionary *requestsInQueueCopy = [[ECRequestMapper sharedInstance] requestsInQueue];
//            NSArray *keysArray = nil;
//            @try {
//                keysArray = [[[ECRequestMapper sharedInstance] requestsInQueue] allKeys];
//            } @catch (NSException *exception) {
////                NSLog(@"\n\n Exception occured : %@",exception);
////                NSLog(@"\n Request count : %lu ",(unsigned long)requestsInQueueCopy.count);
////                NSLog(@"\n All Requests  : %@ ",requestsInQueueCopy);
//            }
//            if ([keysArray containsObject:[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"id"]]]) {
//                id<GatewayRequest> requestCaller = [[[ECRequestMapper sharedInstance] requestsInQueue] valueForKey:[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"id"]]];
//                [[ECRequestMapper sharedInstance] removeRequestInQueueForId:[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"id"]]];
//                [requestCaller parseResponse:responseObject];
//            }
//            else {
////                [((ECAppDelegate*)[[UIApplication sharedApplication] delegate]) hideHUD];
//                NSLog(@"Request Not Present %@",[responseObject valueForKey:@"id"]);
//            }
//        }] resume];
//    }
//    else {
//        [[manager2 dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
////            NSMutableDictionary *requestsInQueueCopy = [[ECRequestMapper sharedInstance] requestsInQueue];
//            NSArray *keysArray = nil;
//            @try {
//                keysArray = [[[ECRequestMapper sharedInstance] requestsInQueue] allKeys];
//            } @catch (NSException *exception) {
////                NSLog(@"\n\n Exception occured : %@",exception);
////                NSLog(@"\n Request count : %lu ",(unsigned long)requestsInQueueCopy.count);
////                NSLog(@"\n All Requests  : %@ ",requestsInQueueCopy);
//            }
//            if ([keysArray containsObject:[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"id"]]]) {
//                id<GatewayRequest> requestCaller = [[[ECRequestMapper sharedInstance] requestsInQueue] valueForKey:[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"id"]]];
//                [[ECRequestMapper sharedInstance] removeRequestInQueueForId:[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"id"]]];
//                [requestCaller parseResponse:responseObject];
//            }
//            else {
////                [((ECAppDelegate*)[[UIApplication sharedApplication] delegate]) hideHUD];
//                NSLog(@"Request Not Present %@",[responseObject valueForKey:@"id"]);
//            }
//        }] resume];
//    }
}

- (void) sendRequest:(id<GatewayRequest>)requestObj {
    
}
@end
