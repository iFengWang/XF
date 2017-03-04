
#面向AOP编程

##起源

1. 先来上段代码：

```
	@interface LiveChatWebSocket () {
    dispatch_source_t _keepAliveTimer;
    NSInteger _reConnectNum;
    NSMutableDictionary *_messageDic;
    CGFloat screenWidth;
    NSInteger _pingCount;
    NSInteger _pongCount;
    NSInteger _currentPid;
    NSTimer *_sendLostPidsTimer;
    BOOL isWss;
}
@property (nonatomic) NSTimer *timer;
@property (nonatomic, assign) BOOL isConnnected;
@end

@implementation LiveChatWebSocket

- (id)init {
    self = [super init];
    
    if (self) {
        _reConnectNum = 0;
        isWss = NO;
    }
    
    return self;
}
```

上面这段代码说明了一种`新的`编程思想[^1]<gf_w@qq.com>`<gf_w@qq.com>`

---

[百度](http://www.baidu.com)

![image](http://img.jiankang.com/temp/2017/03/02/14884467228547.png "卧龙")

##演进
* 好好学习
* 天天向上
	* 向着太阳的方向
	* 永远别回头

1. **跟着优秀的人学**
2. *远离损友*
 
##未来
> 未来就在我们眼前，就看你怎么把握，古人云狼走千里吃肉，那么你认为自己是狼吗？未来就在我们眼前，就看你怎么把握，古人云狼走千里吃肉，那么你认为自己是狼吗？未来就在我们眼前，就看你怎么把握，古人云狼走千里吃肉，那么你认为自己是狼吗？未来就在我们眼前，就看你怎么把握，古人云狼走千里吃肉，那么你认为自己是狼吗？未来就在我们眼前，就看你怎么把握，古人云狼走千里吃肉，那么你认为自己是狼吗？未来就在我们眼前，就看你怎么把握，古人云狼走千里吃肉，那么你认为自己是狼吗？
