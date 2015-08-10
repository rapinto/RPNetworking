//
//  RPRequestOperation.m
//
//
//  Created by Raphaël Pinto on 07/08/2015.
//
// The MIT License (MIT)
// Copyright (c) 2015 Raphael Pinto.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.



#import "RPRequestOperation.h"



@implementation RPRequestOperation



#pragma mark -
#pragma mark Operation Steps Methods



- (void)start
{
    self.startTime = CFAbsoluteTimeGetCurrent();
    
    [super start];
}


- (void)setCompletionBlockWithSuccess:(void (^)(AFHTTPRequestOperation *, id))success
                              failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    
    __weak __typeof(self)weakSelf = self;
    
    [super setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        weakSelf.totalTime = CFAbsoluteTimeGetCurrent() - weakSelf.startTime;
        
        if (success)
        {
            success(operation, operation.responseObject);
        }
    }
                                 failure:^(AFHTTPRequestOperation *operation, NSError* error)
     {
         weakSelf.totalTime = CFAbsoluteTimeGetCurrent() - weakSelf.startTime;
         
         if (failure)
         {
             failure(operation, error);
         }
     }];
}



@end