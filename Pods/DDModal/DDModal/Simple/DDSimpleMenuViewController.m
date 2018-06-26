//
//  DDSimpleMenuViewController.m
//  DDModalDemo
//
//  Created by TongAn001 on 2018/6/2.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDSimpleMenuViewController.h"

@interface DDSimpleMenuViewController ()

@property (nonatomic,strong) UIView * alertView;

@property (nonatomic,strong) NSArray * items;
@property (nonatomic,strong) NSArray * itemsWidthArray;
@property (nonatomic,assign) CGFloat itemTotalWidth;
@property (nonatomic,assign) CGRect originFrame;
@property (nonatomic,assign) DDMenuShowDirection showDirection;

@property (nonatomic,copy) void (^onClickItemBlock)(NSInteger itemIndex);
@property (nonatomic,strong) UIImageView * itemBgView;

@end

@implementation DDSimpleMenuViewController

+ (DDSimpleMenuViewController *)showWithItems:(NSArray *)items
                                  originFrame:(CGRect)originFrame
                                showDirection:(DDMenuShowDirection)showDirection
                             onClickItemBlock:(void (^)(NSInteger itemIndex))clickItemBlock{
    DDSimpleMenuViewController * vctl = [[[self class] alloc] init];
    vctl.items = items;
    vctl.originFrame = originFrame;
    vctl.showDirection = showDirection;
    vctl.onClickItemBlock = clickItemBlock;
    [vctl show:nil];
    return vctl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)popHeight{
    return 40.0f;
}

- (CGFloat)popMarginRight{
    if(self.showDirection == DDMenuShowDirectionLeft){
        return DDModal_ScreenWidth-self.originFrame.origin.x;
    }else{
        return DDModal_ScreenWidth-CGRectGetMaxX(self.originFrame)-self.popWidth;
    }
}

- (CGFloat)popMarginLeft{
    return DDModal_ScreenWidth-self.popMarginRight-self.popWidth;
}

- (CGFloat)popWidth{
    return self.itemTotalWidth+15;
}

- (CGSize)cornerSize{
    return CGSizeMake(5, 5);
}

#pragma mark - Setup
- (void)setupData{
    [super setupData];
}

- (void)setupSubviews{
    [super setupSubviews];
    [self.view addSubview:self.alertView];
    [self.alertView addSubview:self.itemBgView];
}

- (void)setupLayout{
    CGFloat itemBgViewMarginRight = self.popWidth;
    if(self.showDirection == DDMenuShowDirectionRight){
        itemBgViewMarginRight = -self.popWidth;
    }
    [self.itemBgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.alertView);
        make.right.mas_equalTo(itemBgViewMarginRight);
        make.width.mas_equalTo(self.popWidth);
    }];
    [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-self.popMarginRight);
        make.height.mas_equalTo(self.popHeight);
        make.top.mas_equalTo(self.originFrame.origin.y);
        make.width.mas_equalTo(self.popWidth);
    }];
}

- (void)subviewShowAnimation{
    [self.itemBgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
    }];
}

- (void)subviewHideAnimation{
    CGFloat itemBgViewMarginRight = self.popWidth;
    if(self.showDirection == DDMenuShowDirectionRight){
        itemBgViewMarginRight = -self.popWidth;
    }
    [self.itemBgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(itemBgViewMarginRight);
    }];
}

- (void)clickItemButton:(UIButton *)sender{
    [self dismiss:^{
        if(self.onClickItemBlock){
            self.onClickItemBlock(sender.tag);
        }
    }];
}

- (CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize{
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:15]};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

#pragma mark - Setter/Getter
- (void)setItems:(NSArray *)items{
    _items = items;
    
    NSMutableArray * itemsWidthArray = [NSMutableArray new];
    for(NSString * item in items){
        CGSize itemSize = [self sizeWithText:item maxSize:CGSizeMake(280, self.popHeight)];
        CGFloat itemWidth = itemSize.width+20;
        if(itemWidth < 45.0f){
            itemWidth = 45.0f;
        }
        [itemsWidthArray addObject:@(itemWidth)];
        self.itemTotalWidth += itemWidth;
    }
    self.itemsWidthArray = itemsWidthArray;
}

- (UIImageView *)itemBgView{
    if(!_itemBgView){
        UIImageView * v = [[UIImageView alloc] init];
        v.userInteractionEnabled = YES;
        
        UIImage * image = nil;
        UIEdgeInsets insets;
        CGFloat beginMarginleft = 5;
        if(self.showDirection == DDMenuShowDirectionLeft){
            image = [UIImage imageNamed:@"DDModal.bundle/icon-bubble-left.png"];
            insets = UIEdgeInsetsMake(20, 10, 10, 35);
        }else{
            image = [UIImage imageNamed:@"DDModal.bundle/icon-bubble-right.png"];
            insets = UIEdgeInsetsMake(20, 30, 10, 10);
            beginMarginleft = 10;
        }
        v.image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
        
        NSInteger index = 0;
        NSInteger itemCount = self.items.count;
        CGFloat itemHeight = self.popHeight;
        CGFloat interval = 0.5;
        
        for(NSString * item in self.items){
            NSNumber * itemWidth = self.itemsWidthArray[index];
            
            UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.tag = index;
            button.frame = CGRectMake(beginMarginleft, 0, itemWidth.floatValue, itemHeight);
            [button setTitle:item forState:UIControlStateNormal];
            button.tintColor = [UIColor whiteColor];
            [button addTarget:self action:@selector(clickItemButton:) forControlEvents:UIControlEventTouchUpInside];
            [v addSubview:button];
            
            beginMarginleft = CGRectGetMaxX(button.frame)+interval;
            
            index ++;
            if(index < itemCount){
                UIView * sepView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(button.frame), 2.5, 0.5, itemHeight-5)];
                sepView.backgroundColor = DDModal_COLOR_RGB(220, 220, 220);
                [v addSubview:sepView];
            }
        }
        
        _itemBgView = v;
    }
    return _itemBgView;
}

#pragma mark - Setting/Getting
- (UIView *)alertView{
    if(!_alertView){
        UIView * v = [[UIView alloc] init];
        v.clipsToBounds = YES;
        _alertView = v;
    }
    return _alertView;
}

@end
