//
//  ViewController2.m
//  DDTooboxDemo
//
//  Created by TongAn001 on 2018/6/20.
//  Copyright © 2018年 abiang. All rights reserved.
//

#import "ViewController2.h"
#import "DDLoopCollectionView.h"
#import "CollectionViewCell2.h"
#import "DDXib.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CircleArcViewLayout.h"
#import "TestCircleView.h"
#import "ViewController3.h"
#import "TestWebTableViewController.h"
#import "DDCircleRecordView.h"

@interface ViewController2 ()<UICollectionViewDelegate,UICollectionViewDataSource,DDLoopCollectionViewDelegate,DDCircleProgressDelegate>

@property (strong, nonatomic) DDLoopCollectionView *collectionView;
@property (nonatomic,strong) NSArray * dataArray;
@property (weak, nonatomic) IBOutlet TestCircleView *circleView;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel2;
@property (weak, nonatomic) IBOutlet TestCircleView *circleView2;
@property (weak, nonatomic) IBOutlet DDCircleProgressView *circle3;
@property (weak, nonatomic) IBOutlet DDCircleRecordView *recordView;

@end

@implementation ViewController2

- (void)circleView:(DDCircleProgressView *)circleView progress:(CGFloat)progress{
    if(circleView == self.circleView){
        self.progressLabel.text = [NSString stringWithFormat:@"%0.2f%%",progress*100];
    }
    if (circleView == self.circleView2) {
        self.progressLabel2.text = [NSString stringWithFormat:@"%0.2f%%",progress*100];
    }
}

- (IBAction)clickWebTableButton:(id)sender {
    TestWebTableViewController * vctl = [[TestWebTableViewController alloc] init];
    [self.navigationController pushViewController:vctl animated:YES];
}

- (IBAction)valueChanged:(UISlider *)sender {
    self.circleView.progress = sender.value;
    self.circleView2.progress = sender.value;
}

- (IBAction)clickPushButton:(id)sender {
    ViewController3 * vctl = [ViewController3 instanceFromXib];
    [self.navigationController pushViewController:vctl animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.recordView.layer.cornerRadius = MIN(CGRectGetWidth(self.recordView.bounds),CGRectGetHeight(self.recordView.bounds))/2.0f;
    
    self.circleView.progressDelegate = self;
    self.circleView.progress = 0.35;
    self.circleView.type = DDCircleTypeGradient;
    self.circleView.gradientImage = [UIImage imageNamed:@"DDCircleProgressView.bundle/gradient-1.png"];
    
    self.circleView2.progressDelegate = self;
    self.circleView2.progress = 0.35;
    self.circleView2.type = DDCircleTypeGradient;
    
  
    
    self.dataArray = @[
                       @{@"title":@"0",@"img":@"https://desk-fd.zol-img.com.cn/t_s208x130c5/g5/M00/02/06/ChMkJlqYtyuIdpwcAAlWoF1ayFAAAlEMgE-F00ACVa4671.jpg"},
                       @{@"title":@"1",@"img":@"https://desk-fd.zol-img.com.cn/t_s208x130c5/g5/M00/01/0C/ChMkJlqWkrmIIMhYAAH3y4udmhwAAlBwADV9cIAAffj083.jpg"},
                       @{@"title":@"2",@"img":@"https://desk-fd.zol-img.com.cn/t_s208x130c5/g5/M00/00/05/ChMkJlmetaGIYe6IAAoKY5R3HCMAAf8XgPeEFQACgp7260.jpg"},
                       @{@"title":@"3",@"img":@"https://desk-fd.zol-img.com.cn/t_s208x130c5/g5/M00/03/0C/ChMkJlg-zauINOHdAA1v4L395qUAAYL8QJDTGgADW_4593.jpg"},
                       ];
    
    [self.view addSubview:self.collectionView];
    self.collectionView.frame = CGRectMake(0, 200, CGRectGetWidth(self.view.bounds), 200);
    self.collectionView.backgroundColor = [UIColor orangeColor];
    self.collectionView.pagingEnabled = YES;
    [self.collectionView regCellNibWithClazz:[CollectionViewCell2 class]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UICollectionViewLayout *)collectionViewLayout{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    CircleArcViewLayout * layout = [[CircleArcViewLayout alloc] init];
    
    return layout;
}

#pragma mark  - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.collectionView.bounds.size;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary * model = self.dataArray[indexPath.row];
    NSString * title = model[@"title"];
    NSString * img = model[@"img"];
    
    CollectionViewCell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell2" forIndexPath:indexPath];
    cell.titleLabel.text = title;
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:nil];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"indexPath:(%@,%@)",@(indexPath.section),@(indexPath.row));
}

#pragma mark - DDLoopCollectionViewDelegate
- (void)loopCollectionView:(DDLoopCollectionView *)collectionView itemIndex:(NSInteger)itemIndex{
    NSLog(@"itemIndex:%@",@(itemIndex));
}

- (DDLoopCollectionView *)collectionView{
    if(!_collectionView){
        DDLoopCollectionView * v = [[DDLoopCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewLayout];
        v.backgroundColor = [UIColor whiteColor];//DD_COLOR_RGB(230, 230, 230);
        v.delegate = self;
        v.dataSource = self;
        v.LoopDelegate = self;
        _collectionView = v;
    }
    return _collectionView;
}

@end
