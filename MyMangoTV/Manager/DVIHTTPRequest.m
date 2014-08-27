//
//  DVIHTTPRequest.m
//  MangoNetwork
//
//  Created by apple on 14-8-26.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "DVIHTTPRequest.h"
#import "NSDictionary+URL.h"

@interface DVIHTTPRequest () <NSURLConnectionDataDelegate, NSURLConnectionDelegate>
{
    NSURLConnection *_connection;
    
    NSMutableData *_data;
}
@end

@implementation DVIHTTPRequest

- (instancetype)initWithURL:(NSString *)path
{
    if (self = [super init]) {
        _path = [path copy];
    }
    
    return self;
}

//创建Get请求
- (NSMutableURLRequest *)createGetRequest
{
    NSString *str = _path;
    if (_paramter) {
        str = [NSString stringWithFormat:@"%@?%@", str, [_paramter URLString]];
        
    }
    
    NSURL *url = [NSURL URLWithString:str];
    return [NSMutableURLRequest requestWithURL:url];
}

//创建Post请求
- (NSMutableURLRequest *)createPostRequest
{
    NSURL *url = [NSURL URLWithString:_path];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:_method];
    
    if (_paramter) {
        NSString *str = [_paramter URLString];
        [request setHTTPBody:[str dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    return request;
}

//创建HTTP请求
- (NSURLRequest *)createRequest
{
    NSMutableURLRequest *request = nil;
    if (_method == nil || [[_method uppercaseString] isEqualToString:@"GET"]) {
        request = [self createGetRequest];
    }
    else {
        request = [self createPostRequest];
    }
    
    if (_headerFields) {
        request.allHTTPHeaderFields = _headerFields;
    }
    
    return request;
}

//有瑕疵
- (void)start
{
    //给nil对象发送任何消息都不会有反应
    [self cancel];
    
    NSURLRequest *request = [self createRequest];

    //每一个NSURLConnection对象一定需要一个delegate对象来接收网络数据
    //但是，每个connection的delegate方法，都是一样
    _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [_connection start];
}

- (void)cancel
{
    [_connection cancel];
}

#pragma mark - NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (_errorHandler) {
        _errorHandler(self, error);
    }
}

//多个connection对象可能共用同一个方法
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if (httpResponse.statusCode == 200) {
        _data = [NSMutableData data];
    }
    else {
        NSError *error = [NSError errorWithDomain:@"Resource not found" code:404 userInfo:nil];
        _errorHandler(self, error);
    }
}

//分次接收数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //所有数据接收完成
    if (_dataHandler) {
        _dataHandler(self, _data);
    }
}
@end

