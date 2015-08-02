//
//  ViewController.mm
//  LiteTest
//
//  Created by easycoding on 15/8/2.
//  Copyright (c) 2015年 easycoding. All rights reserved.
//

#import "ViewController.h"
#import <EALayout/EALayout.h>

@interface ViewController ()

@property (nonatomic, strong) SkinParser* skinParser;

@end

@implementation ViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        self.automaticallyAdjustsScrollViewInsets = false;
        
        //通过指定文件名创建一个 SkinParser, 我们这里直接使用了当前类名
        _skinParser = [SkinParser getParserByName:NSStringFromClass([self class])];
        
        //eventTarget 是指定在解析 UIButton 或者说 UIControl 时，
        // addTarget: eventTarget  forState:xxx
        //viewController里只实现通过json里指定的方法就可以了，不需要用代码绑定
        _skinParser.eventTarget = self;
    }
    return self;
}

-(void)loadView
{
    [super loadView];
    
    //从json里读取叫  @"selfView" 的一个节点， 将属性解析到  参数  self.view 中
    //如果参数  self.view 为 nil , 那在selfView里必须指名 class 属性，以便自动创建,并且返回创建的对象。
    //如果 view参数为 nil, 也可以使用 UIView* view = [_skinParser parse:@"aViewName"];
    [_skinParser parse:@"selfView" view:self.view];
    
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    //计算布局
    //在代码里对某个控件设置了属性，会影响布局的,就需要调用 spUpdateLayout
    //如 修改了 UILabel* label;   需要调用 [label.superview spUpdateLayout]
    //可以在修改多个控件属性后，再找到一个统一上层的父view, 调用一次即可
    [self.view spUpdateLayout];
}

#if DEBUG
-(void)freshSkin
{
    
    //当刷新json时，此函数被调用
    //可根据实际情况，自行修改，
    
#if TARGET_IPHONE_SIMULATOR
    
    self.view = [[UIView alloc] init];
    _skinParser = [SkinParser getParserByName:NSStringFromClass([self class])];
    _skinParser.eventTarget = self;
    [self loadView];
    [self viewDidLoad];
    
#else
    //真机上调试界面
    //            var ipfile = NSBundle.mainBundle().resourcePath!.stringByAppendingPathComponent("ip")
    //            var ipstr = NSString(contentsOfFile: ipfile, encoding: NSUTF8StringEncoding, error: nil)
    //            ipstr = ipstr?.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "\n "))
    //            var filepath = ipstr?.stringByAppendingFormat(":8000/%@.json", NSStringFromClass(self.classForCoder).componentsSeparatedByString(".").last!)
    //            var http = CurlHttp.get(filepath as! String, param: nil, cacheSec: 0)
    //            http.start(true, res: { (err, http, data) -> Void in
    //                if CURLE_OK.value == err.value && data != nil {
    //                    self.view = UIView()
    //                    self._skinParser = SkinParser.getParserByData(data)
    //                    self.loadView()
    //                    self.viewDidLoad()
    //                }
    //            })
    
#endif
    
}
#endif

@end
