//
//  GenerateRequest.h
//  InspeeroNetworkManager
//
//  Created by Bhavesh Sarwar on 7/11/17.
//  Copyright © 2017 Pathik Botadra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECBaseRequest.h"
#import <UIKit/UIKit.h>


@protocol RequestHandler <NSObject>
@required
- (void)requestFailed:(NSError *)error;
@optional
- (void)responseReceived:(NSDictionary*)result;
//- (void)initialSetupActionCompleted:(BOOL)response;
//- (void)initialSetupYesNoSelectionCompleted;
@end

@interface GenerateRequest : ECBaseRequest <GatewayRequest>
- (instancetype) generateRequestWith:(NSString * )url
                          parameters:(NSDictionary*)parameters
                    headerParameters:(NSDictionary *)headerParameters
                         forDelegate:(id)deleg
                              ofType:(NSInteger)requestType
                       isJSONRequest:(bool)isJSONRequest;
@end
