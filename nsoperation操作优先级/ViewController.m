//
//  ViewController.m
//  nsoperation操作优先级
//
//  Created by 李凯 on 16/7/30.
//  Copyright © 2016年 kevin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //初始化队列
    self.queue = [[NSOperationQueue alloc]init];
    //设置最大并发数
    self.queue.maxConcurrentOperationCount=2;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self demo3];
}


/**
 *  队列的最大并发数
 */
- (void)demo3
{
//    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    for (int i=0; i<20; i++) {
        
        [self.queue addOperationWithBlock:^{
            [NSThread sleepForTimeInterval:1];
            NSLog(@"%@ %d", [NSThread currentThread], i);
        }];
    }
    
}

/**
 *  队列优先级
 */
- (void)demo2
{
//    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"haha");
//    }];
//    NSOperationQueue *q1 = [[NSOperationQueue alloc]init];
//    [q1 addOperation:op1];
//    q1.qualityOfService = NSQualityOfServiceBackground;
//    
//    
//    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"hehe");
//    }];
//    NSOperationQueue *q2 = [[NSOperationQueue alloc]init];
//    [q2 addOperation:op2];
//    q2.qualityOfService = NSQualityOfServiceUserInteractive;
    
    NSOperationQueue *q1 = [[NSOperationQueue alloc]init];
    q1.qualityOfService = NSQualityOfServiceBackground;
    
    NSOperationQueue *q2 = [[NSOperationQueue alloc]init];
    q2.qualityOfService = NSQualityOfServiceUserInteractive;
    
    for(int i=0; i<10; i++)
    {
        [q1 addOperationWithBlock:^{
            NSLog(@"haha");
        }];
        
        [q2 addOperationWithBlock:^{
            NSLog(@"hehe");
        }];
    }
}

/**
 *  操作优先级
 */
- (void)demo1
{
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"haha");
    }];
    op1.qualityOfService = NSQualityOfServiceUserInteractive;
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"hehe");
    }];
    op2.qualityOfService = NSQualityOfServiceBackground;
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperations:@[op1, op2] waitUntilFinished:false];
}

@end
