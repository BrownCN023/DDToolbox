//
//  DDSimplePopViewController.m
//  DDModalDemo
//
//  Created by TongAn001 on 2018/6/1.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDSimplePopMenuViewController.h"

#define DDSimplePopItemHeight 50.0f

@interface DDSimplePopMenuViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIImageView * bubbleImgView;
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSArray * items;
@property (nonatomic,copy) NSString * titleKeyPath;
@property (nonatomic,copy) NSString * iconKeyPath;
@property (nonatomic,assign) DDSimplePopPosition position;
@property (nonatomic,copy) void (^clickItemBlock)(NSInteger itemIndex,id itemObj);

@end

@implementation DDSimplePopMenuViewController

+ (DDSimplePopMenuViewController *)showPop:(NSArray *)items titleKeyPath:(NSString *)titleKeyPath iconKeyPath:(NSString *)iconKeyPath position:(DDSimplePopPosition)position onClickItemBlock:(void (^)(NSInteger itemIndex,id itemObj))clickItemBlock{
    DDSimplePopMenuViewController * vctl = [[[self class] alloc] init];
    vctl.items = items;
    vctl.titleKeyPath = titleKeyPath;
    vctl.iconKeyPath = iconKeyPath;
    vctl.position = position;
    vctl.clickItemBlock = clickItemBlock;
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
- (CGSize)cornerSize{
    return CGSizeZero;
}
- (CGFloat)topHeight{
    return 0.0f;
}
- (CGFloat)contentHeight{
    
    CGFloat maxHeight = DDModal_ScreenHeight- self.popViewOffsetY -60;
    CGFloat targetHeight = self.items.count*DDSimplePopItemHeight + 6;
    if(targetHeight > maxHeight){
        targetHeight = maxHeight;
        self.tableView.scrollEnabled = YES;
    }
    return targetHeight;
}
- (CGFloat)bottomHeight{
    return 0.0f;
}
- (CGFloat)popMarginRight{
    if(self.position == DDSimplePopPositionRightTop || self.position == DDSimplePopPositionRightBottom){
        return self.popViewOffsetX;
    }
    return DDModal_ScreenWidth-self.popMarginLeft-self.popViewWidth;
}
- (CGFloat)popMarginLeft{
    if(self.position == DDSimplePopPositionLeftTop || self.position == DDSimplePopPositionLeftBottom){
        return self.popViewOffsetX;
    }
    return DDModal_ScreenWidth-self.popMarginRight-self.popViewWidth;
}
- (CGFloat)popMarginBottom{
    if(self.position == DDSimplePopPositionLeftTop || self.position == DDSimplePopPositionRightTop){
        return DDModal_ScreenHeight-self.contentHeight-self.popViewOffsetY;
    }else{
        return self.popViewOffsetY;
    }
}

- (CGFloat)popViewWidth{
    return 160;
}
- (CGFloat)popViewOffsetX{
    return 10.0f;
}
- (CGFloat)popViewOffsetY{
    return 64.0f;
}

#pragma mark - Setup
- (void)setupData{
    [super setupData];
}
- (void)setupSubviews{
    [super setupSubviews];
    self.popView.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.bubbleImgView];
    [self.contentView addSubview:self.tableView];
    self.tableView.scrollEnabled = NO;

    [self.tableView modalLayerCorners:UIRectCornerAllCorners cornerRect:CGRectMake(0, 0, self.popViewWidth, self.contentHeight-6) cornerSize:CGSizeMake(7, 7)];
}
- (void)setupLayout{
    [super setupLayout];
    [self.bubbleImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(0);
    }];
    CGFloat tableMarginTop = 0;
    CGFloat tableMarginBottom = 6;
    if(self.position == DDSimplePopPositionLeftTop || self.position == DDSimplePopPositionRightTop){
        tableMarginTop = 6;
        tableMarginBottom = 0;
    }
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-tableMarginBottom);
        make.top.mas_equalTo(tableMarginTop);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
}

#pragma mark - UITableViewDelegate/UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return DDSimplePopItemHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"UITableViewCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
    }
    id item = self.items[indexPath.row];
    NSString * text = DDModal_StringIsEmpty(self.titleKeyPath)?item:[item valueForKeyPath:self.titleKeyPath];
    cell.textLabel.text = text;
    
    if(!DDModal_StringIsEmpty(self.iconKeyPath)){
        cell.imageView.image = [UIImage imageNamed:[item valueForKey:self.iconKeyPath]];
    }else{
        cell.imageView.image = nil;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id item = self.items[indexPath.row];
    [self dismiss:^{
        if(self.clickItemBlock){
            self.clickItemBlock(indexPath.row, item);
        }
    }];
}

#pragma mark - Setter/Getter
- (UIImageView *)bubbleImgView{
    if(!_bubbleImgView){
        UIImageView * v = [[UIImageView alloc] init];
//        v.backgroundColor = [UIColor orangeColor];
        UIImage * image = nil;
        UIEdgeInsets insets = UIEdgeInsetsZero;
        if(self.position == DDSimplePopPositionLeftTop){
            image = [UIImage imageNamed:@"DDModal.bundle/bubble-top.png"];
            insets = UIEdgeInsetsMake(30, 30, 25, 10);
        }else if (self.position == DDSimplePopPositionRightTop){
            image = [UIImage imageNamed:@"DDModal.bundle/bubble-top.png"];
            insets = UIEdgeInsetsMake(30, 10, 25, 30);
        }else if (self.position == DDSimplePopPositionLeftBottom){
            image = [UIImage imageNamed:@"DDModal.bundle/bubble-bottom.png"];
            insets = UIEdgeInsetsMake(25, 30, 30, 10);
        }else if (self.position == DDSimplePopPositionRightBottom){
            image = [UIImage imageNamed:@"DDModal.bundle/bubble-bottom.png"];
            insets = UIEdgeInsetsMake(25, 10, 30, 30);
        }
        v.image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
        
        _bubbleImgView = v;
    }
    return _bubbleImgView;
}

- (UITableView *)tableView{
    if(!_tableView){
        UITableView * v = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        v.delegate = self;
        v.dataSource = self;
//        v.backgroundColor = [UIColor orangeColor];
        v.estimatedRowHeight = 0;
        v.estimatedSectionFooterHeight = 0;
        v.estimatedSectionHeaderHeight = 0;
//        v.separatorStyle = UITableViewCellSeparatorStyleNone;
        v.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
//        v.separatorColor = DDModal_COLOR_Hex(0xF1F1F1);
        v.backgroundColor = [UIColor clearColor];
        _tableView = v;
    }
    return _tableView;
}

@end
