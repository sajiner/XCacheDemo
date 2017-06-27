//
//  ViewController.m
//  XDemo
//
//  Created by 张鑫 on 2017/6/27.
//  Copyright © 2017年 张鑫. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSCacheDelegate>

@property (nonatomic, strong) NSCache *cache;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    for (int i = 0; i < 20; i++) {
        NSString *str = [NSString stringWithFormat:@"hello -- %d", i];
        
        NSLog(@"设置===%@", str);
        [self.cache setObject:str forKey:@(i)];
    }
    
    for (int i = 0; i < 20; i++) {
        NSLog(@"%@", [self.cache objectForKey:@(i)]);
    }
    
}

#pragma mark - NSCacheDelegate
/*
 当缓存中的对象被清除的时候，会自动调用
 满10个后，会先清理再添加
 2017-06-27 14:03:59.529 XDemo[1162:28917] 将要清理：hello -- 0
 2017-06-27 14:03:59.529 XDemo[1162:28917] 设置===hello -- 11
 2017-06-27 14:03:59.529 XDemo[1162:28917] 将要清理：hello -- 1
 2017-06-27 14:03:59.529 XDemo[1162:28917] 设置===hello -- 12

 */
- (void)cache:(NSCache *)cache willEvictObject:(id)obj {
    // 会影响清理速度，所以，平时开发的时候不建议重写此代理方法；仅供调试时使用
    [NSThread sleepForTimeInterval:1];
    NSLog(@"将要清理：%@", obj);
}

- (NSCache *)cache {
    if (!_cache) {
        _cache = [[NSCache alloc] init];
        // 设置数量限制
        _cache.countLimit = 10;
        _cache.delegate = self;
    }
    return _cache;
}

@end
