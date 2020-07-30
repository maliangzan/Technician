//
//  NewsViewController.m
//  Technician
//
//  Created by 马良赞 on 2017/2/4.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "NewsViewController.h"
#import "NewMessageCell.h"

static NSString *messageCellID = @"NewMessageCell";

@interface NewsViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>
@property(nonatomic, strong)UIImageView *imageView;
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)buildUI{
    [super buildUI];
    self.titleLabel.text = @"消息";
    WeakSelf;
    self.leftBtn =^{
        [weakself.navigationController popViewControllerAnimated:YES];
    };

    self.moreBtn.hidden = !self.dataArray.count;
    [self.moreBtn setTitle:Localized(@"清除") forState:(UIControlStateNormal)];
    self.rightBtn = ^{
        [weakself showTips];
    };
    
    [self.view addSubview:self.tableView];
}


#pragma mark <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:messageCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *message = [self.dataArray objectAtIndex:indexPath.row];
    cell.messageLabel.text = message;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *message = [self.dataArray objectAtIndex:indexPath.row];
    return 70 * kHeightFactor + [NSString heightForString:message labelWidth:KscreenWidth - 80 fontOfSize:15];
}
#pragma mark - empty-table
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    
    return PNGIMAGE(@"cf-message-empty");
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = Localized(@"暂无消息");
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName: [UIColor hexColor:0xb2b2b2]};
    return [[NSAttributedString alloc]initWithString:text attributes:attributes];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return -50 * kHeightFactor;
}

#pragma mark method


#pragma mark 清除
- (void)clearMessage{
    [self.dataArray removeAllObjects];
    self.moreBtn.hidden = !self.dataArray.count;
    [self.tableView reloadData];
}

- (void)showTips{
    WeakSelf;
    [[SYAlertViewTwo(Localized(@"提示"), Localized(@"是否确认清空所有的消息?"), Localized(@"取消"), Localized(@"确认"))
      setCompleteBlock:^(UIAlertView *alertView, NSInteger index){
          if (index == 1) {
              [weakself clearMessage];
          }
      }] show];
}


#pragma mark 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 65*kHeightFactor, KscreenWidth, KscreenHeight - 65*kHeightFactor) style:(UITableViewStylePlain)];
        _tableView.backgroundColor = kAppColorBackground;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        //这行代码必须加上，可以去除tableView的多余的线，否则会影响美观
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView registerNib:[UINib nibWithNibName:messageCellID bundle:nil] forCellReuseIdentifier:messageCellID];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        [_dataArray addObjectsFromArray:@[@"奖励政策有变动，请各位注意接听客服电话。",@"奖励政策有变动，请各位注意接听客服电话。",@"奖励政策有变动，请各位注意接听客服电话。奖励政策有变动，请各位注意接听客服电话。",@"The 7th Army was a Royal Yugoslav Army formation, raised three days before the German-led invasion of Yugoslavia of 6 April 1941, during World War II. On the first day of the invasion, the army's commander Dušan Trifunović was alarmed when the 4th ArmyThe 7th Army was a Royal Yugoslav Army formation, raised three days before the German-led invasion of Yugoslavia of 6 April 1941, during World War II. On the first day of the invasion, the army's commander Dušan Trifunović was alarmed when the 4th ArmyThe 7th Army was a Royal Yugoslav Army formation, raised three days before the German-led invasion of Yugoslavia of 6 April 1941, during World War II. On the first day of the invasion, the army's commander Dušan Trifunović was alarmed when the 4th ArmyThe 7th Army was a Royal Yugoslav Army formation, raised three days before the German-led invasion of Yugoslavia of 6 April 1941, during World War II. On the first day of the invasion, the army's commander Dušan Trifunović was alarmed when the 4th ArmyThe 7th Army was a Royal Yugoslav Army formation, raised three days before the German-led invasion of Yugoslavia of 6 April 1941, during World War II. On the first day of the invasion, the army's commander Dušan Trifunović was alarmed when the 4th ArmyThe 7th Army was a Royal Yugoslav Army formation, raised three days before the German-led invasion of Yugoslavia of 6 April 1941, during World War II. On the first day of the invasion, the army's commander Dušan Trifunović was alarmed when the 4th Army奖励政策有变动，请各位注意接听客服电话。奖励政策有变动，请各位注意接听客服电话。奖励政策有变动，请各位注意接听客服电话。奖励政策有变动，请各位注意接听客服电话。奖励政策有变动，请各位注意接听客服电话。",@"奖励政策有变动，请各位注意接听客服电话。奖励政策有变动，请各位注意接听客服电话。",@"The 7th Army was a Royal Yugoslav Army formation, raised three days before the German-led invasion of Yugoslavia of 6 April 1941, during World War II. On the first day of the invasion, the army's commander Dušan Trifunović was alarmed when the 4th Army",@"The 7th Army was a Royal Yugoslav Army formation, raised three days before the German-led invasion of Yugoslavia of 6 April 1941, during World War II. On the first day of the invasion, the army's commander Dušan Trifunović was alarmed when the 4th Army"]];
    }
    return _dataArray;
}

#pragma mark test
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.image = PNGIMAGE(@"test1");
    }
    return _imageView;
}

- (void)testView{
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(65*kWidthFactor);
        make.bottom.equalTo(self.view);
    }];

}

@end
