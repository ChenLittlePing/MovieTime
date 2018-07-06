//
//  Base Network request tool.
//
//  Created by cxp on 2018/6/19.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import "Net.h"

@implementation Net

static AFHTTPSessionManager *manager;

-(instancetype)init {
    self = [super init];
    if (self != nil) {
        [self initAFManager];
    }
    return self;
}

// init a singleton manager
-(void) initAFManager {
    if (manager == nil) {
        manager = [AFHTTPSessionManager manager];
        manager.operationQueue.maxConcurrentOperationCount = 5;
        
        // 超时时间
        manager.requestSerializer.timeoutInterval = 30.0f;
        // 设置请求头
        [manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
        
        // 返回格式
        // AFHTTPResponseSerializer           二进制格式
        // AFJSONResponseSerializer           JSON
        // AFXMLParserResponseSerializer      XML,只能返回XMLParser,还需要自己通过代理方法解析
        // AFXMLDocumentResponseSerializer (Mac OS X)
        // AFPropertyListResponseSerializer   PList
        // AFImageResponseSerializer          Image
        // AFCompoundResponseSerializer       组合
        
        manager.responseSerializer = [AFJSONResponseSerializer serializer];//返回格式 JSON
        //设置返回的Content-type
        manager.responseSerializer.acceptableContentTypes=[[NSSet alloc] initWithObjects:@"application/xml", @"text/xml",@"text/html", @"application/json", @"application/x-javascript", @"text/plain",nil];
    }
}

- (void)customerConfig:(id)manager {
    
}

-(NSString *) getBaseUrl {
    return @"";
}

-(void) get:(NSString *)endPoint
            widthParams:(NSDictionary *)params
            result:(NetResult *) result {
    if (manager != nil) {
        [manager GET:[self getUrl: endPoint] parameters:params progress:nil
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 NSLog(@"responseObject-->%@",responseObject);
                 [result parseData: responseObject];
             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 NSLog(@"error-->%@",error);
                 NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
                 result.fail(@"请求失败", [responses statusCode]);
             }];
    }
}

-(void) post:(NSString *)endPoint
        widthParams:(NSDictionary *)params
        result:(NetResult *) result {
    if (manager != nil) {
        [manager POST:[self getUrl: endPoint] parameters:params progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //请求成功返回数据 根据responseSerializer 返回不同的数据格式
            NSLog(@"responseObject-->%@",responseObject);
            [result parseData: responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //请求失败
            NSLog(@"error-->%@",error);
            NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
            result.fail(@"请求失败", [responses statusCode]);
        }];
    }
    
}

-(NSString *) getUrl: (NSString *)endpoint {
    return  [self.getBaseUrl stringByAppendingString: endpoint];
}
@end
