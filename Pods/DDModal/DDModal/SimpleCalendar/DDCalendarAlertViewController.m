//
//  DDCalendarAlertViewController.m
//  DDModalDemo
//
//  Created by TongAn001 on 2018/6/20.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "DDCalendarAlertViewController.h"
#import "DDCalendarAlertItemCell.h"
#import "DDSimpleDateAlertHeaderView.h"
#import "DDSimpleDateAlertWeekView.h"

@interface DDCalendarAlertViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    CGFloat selfContentWidth;
}

@property (nonatomic,strong) UIButton * todayButton;
@property (nonatomic,strong) UIButton * submitButton;
@property (nonatomic,strong) DDSimpleDateAlertWeekView * weekView;
@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,assign) CGSize itemSize;
@property (nonatomic,strong) DDCalendarManager * calendarManager;

@property (nonatomic,strong) NSIndexPath * currentSelectedIndexPath;
@property (nonatomic,strong) DDDateItem * currentSelectedDateItem;

@end

@implementation DDCalendarAlertViewController

- (void)dealloc{
    if(self.currentSelectedDateItem){
        self.currentSelectedDateItem.selected = NO;
    }
}

- (instancetype)initWithCalendarManager:(DDCalendarManager *)calendarManager{
    if(self = [super init]){
        self.calendarManager = calendarManager;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self changeSubmitButton:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self scrollToToday:NO];
}

- (UICollectionViewLayout *)collectionViewLayout{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    return layout;
}

- (CGFloat)contentHeight{
    return 400;
}

- (CGFloat)bottomHeight{return 0.0f;}

- (DDModalPopAnimation)showPopAnimation{
    return DDModalPopAnimationBottom;
}
- (DDModalPopAnimation)hidePopAnimation{
    return DDModalPopAnimationBottom;
}

#pragma mark - Setup
- (void)setupData{
    [super setupData];
    
    selfContentWidth = DDModal_ScreenWidth-self.popMarginLeft-self.popMarginRight;
    CGFloat itemWidth = (selfContentWidth-10)/7.0f;
    self.itemSize = CGSizeMake(itemWidth, itemWidth);
    if(!self.calendarManager){
        self.calendarManager = [[DDCalendarManager alloc] init];
        [self.calendarManager prepare];
    }
}
- (void)setupSubviews{
    [super setupSubviews];
    
    [self.topView addSubview:self.todayButton];
    [self.topView addSubview:self.submitButton];
    
    [self.contentView addSubview:self.weekView];
    [self.contentView addSubview:self.collectionView];
    
    [self.collectionView registerClass:[DDCalendarAlertItemCell class] forCellWithReuseIdentifier:@"DDCalendarAlertItemCell"];
    
    [self.collectionView registerClass:[DDSimpleDateAlertHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"DDSimpleDateAlertHeaderView"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableView"];
    
}
- (void)setupLayout{
    [super setupLayout];
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.centerY.equalTo(self.topView);
    }];
    
    [self.todayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView).offset(15);
        make.right.equalTo(self.submitButton.mas_left).offset(-15);
        make.height.mas_equalTo(40);
        make.centerY.equalTo(self.topView);
    }];
    
    [self.weekView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(35);
    }];
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.weekView.mas_bottom);
        make.left.right.bottom.equalTo(self.contentView);
    }];
}

- (void)scrollToToday:(BOOL)animated{
    NSInteger targetSection = self.calendarManager.currentMonthIndex-2;
    DDDateSection * monthItem = self.calendarManager.monthItems[targetSection];
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:monthItem.dayItems.count-1 inSection:targetSection] atScrollPosition:UICollectionViewScrollPositionTop animated:animated];
}

- (void)changeSubmitButton:(BOOL)enabled{
    if(enabled){
        self.submitButton.tintColor = [DDModalThemeConfig sharedConfig].titleColor;
    }else{
        self.submitButton.tintColor = DDModal_COLOR_RGB(100, 100, 100);
    }
    self.submitButton.userInteractionEnabled = enabled;
}

- (void)clickTodayButton:(UIButton *)sender{
    [self scrollToToday:YES];
}

- (void)clickSubmitButton:(UIButton *)sender{
    [self dismiss:^{
        if(self.onSelectedItemBlock){
            self.onSelectedItemBlock(self.currentSelectedDateItem.year, self.currentSelectedDateItem.month, self.currentSelectedDateItem.day);
        }
    }];
}

#pragma mark  - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.calendarManager.monthItems.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    DDDateSection * monthItem = self.calendarManager.monthItems[section];
    return monthItem.dayItems.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.itemSize;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(selfContentWidth, 35);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(selfContentWidth, 10);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        DDDateSection * monthItem = self.calendarManager.monthItems[indexPath.section];

        DDSimpleDateAlertHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"DDSimpleDateAlertHeaderView" forIndexPath:indexPath];
        [headerView configDataModel:monthItem section:indexPath.section];
        return headerView;
    }else{
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"UICollectionReusableView" forIndexPath:indexPath];
        return footerView;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DDDateSection * monthItem = self.calendarManager.monthItems[indexPath.section];
    DDCalendarAlertItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DDCalendarAlertItemCell" forIndexPath:indexPath];
    [cell configWithDataModel:monthItem.dayItems[indexPath.row] indexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DDDateSection * monthItem = self.calendarManager.monthItems[indexPath.section];
    DDDateItem * dayItem = monthItem.dayItems[indexPath.row];
    
    if(dayItem.year >0){
        if(dayItem.isDisable){
            return;
        }
        if(self.currentSelectedIndexPath != indexPath){
            dayItem.selected = YES;
            self.currentSelectedDateItem.selected = NO;
            self.currentSelectedDateItem = dayItem;
            
            NSArray * indexPaths = nil;
            if(self.currentSelectedIndexPath){
                indexPaths = @[self.currentSelectedIndexPath,indexPath];
            }else{
                indexPaths = @[indexPath];
            }

            [self.collectionView reloadItemsAtIndexPaths:indexPaths];
            self.currentSelectedIndexPath = indexPath;
            [self changeSubmitButton:YES];
        }else{
            self.currentSelectedDateItem.selected = NO;
            [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
            self.currentSelectedIndexPath = nil;
            self.currentSelectedDateItem = nil;
            [self changeSubmitButton:NO];
        }
    }
}

- (DDSimpleDateAlertWeekView *)weekView{
    if(!_weekView){
        DDSimpleDateAlertWeekView * v = [[DDSimpleDateAlertWeekView alloc] init];
        _weekView = v;
    }
    return _weekView;
}

- (UICollectionView *)collectionView{
    if(!_collectionView){
        UICollectionView * v = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewLayout];
        v.backgroundColor = [UIColor whiteColor];//DDModal_COLOR_RGB(230, 230, 230);
        v.delegate = self;
        v.dataSource = self;
        v.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
        _collectionView = v;
    }
    return _collectionView;
}


- (UIButton *)submitButton{
    if(!_submitButton){
        UIButton * v = [UIButton buttonWithType:UIButtonTypeSystem];
        [v setImage:[UIImage imageNamed:@"DDModal.bundle/icon-ok.png"] forState:UIControlStateNormal];
        v.tintColor = [DDModalThemeConfig sharedConfig].titleColor;
        [v addTarget:self action:@selector(clickSubmitButton:) forControlEvents:UIControlEventTouchUpInside];
        _submitButton = v;
    }
    return _submitButton;
}

- (UIButton *)todayButton{
    if(!_todayButton){
        UIButton * v = [UIButton buttonWithType:UIButtonTypeSystem];
        NSString * title = [NSString stringWithFormat:@"%04ld年%02ld月%02ld日",(long)self.calendarManager.todayYear,(long)self.calendarManager.todayMonth,(long)self.calendarManager.todayDay];
        [v setTitle:title forState:UIControlStateNormal];
        v.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        v.tintColor = [DDModalThemeConfig sharedConfig].titleColor;
        v.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [v addTarget:self action:@selector(clickTodayButton:) forControlEvents:UIControlEventTouchUpInside];
        _todayButton = v;
    }
    return _todayButton;
}

@end