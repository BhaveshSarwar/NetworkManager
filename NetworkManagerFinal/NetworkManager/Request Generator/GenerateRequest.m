//
//  GenerateRequest.m
//  InspeeroNetworkManager
//
//  Created by Bhavesh Sarwar on 7/11/17.
//  Copyright © 2017 Pathik Botadra. All rights reserved.
//

#import "GenerateRequest.h"

@implementation GenerateRequest

@synthesize requestString, requestStrategy, delegate, requestIdentifier ,requestParameters ,requestType ,taskIdentifier , headerParameters ,isJSONRequest;

- (instancetype) generateRequestWith:(NSString * )url
                          parameters:(NSDictionary*)parameters
                    headerParameters:(NSDictionary *)headerParameters
                         forDelegate:(id)deleg
                              ofType:(NSInteger)requestType
                       isJSONRequest:(bool)isJSONRequest{
    
    self.requestString      = url;
    self.delegate           = deleg;
    self.requestIdentifier  = RT_INITIAL_SETUP_GET_PAGE;
    self.requestParameters  = parameters;
    self.requestType        = requestType;
    self.headerParameters   = headerParameters;
    self.isJSONRequest      =  requestType == POST ? isJSONRequest : NO;
    
    
    return self;
}
-(void)parseResponse:(NSDictionary *)responseDictionary{
    
    NSLog(@"Parse response");
    [self.delegate responseReceived:responseDictionary];
    
}
-(void)requestFailed:(NSError *)error{
    [self.delegate requestFailed:error];
}
@end
