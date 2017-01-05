//
//  serviceDetailsVC.m
//  Technician
//
//  Created by 马良赞 on 16/12/30.
//  Copyright © 2016年 马良赞. All rights reserved.
//

#import "serviceDetailsVC.h"
#import "OrdersCell.h"
#import "serviceImageCell.h"
#import "serviceAddressCell.h"
#import "ordersBtnCell.h"
@interface serviceDetailsVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSArray *cellArray;
@property(nonatomic, strong)NSArray *cellheight;
@end

@implementation serviceDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSArray *)cellheight{
    if (!_cellheight) {
        _cellheight = [[NSArray alloc]initWithObjects:[NSNumber numberWithInt:170],[NSNumber numberWithInt:35],[NSNumber numberWithInt:100],[NSNumber numberWithInt:35],[NSNumber numberWithInt:100], nil];
    }
    
    return _cellheight;
}
-(NSArray *)cellArray{
    if (!_cellArray) {
        _cellArray = [[NSArray alloc]initWithObjects:@"cell1",@"cell2", nil];
    }
    return _cellArray;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_Frame_Width, 1)];
        [view setBackgroundColor:[UIColor whiteColor]];
        _tableView.tableHeaderView = view;
    }
    return _tableView;
}
-(void)buildUI{
    [super buildUI];
    self.titleLabel.text = @"服务详情";
    __block typeof(self) weakSelf = self;
    self.blackBtn =^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self .tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(65*kWidthFactor);
        make.bottom.equalTo(self.view);
        
    }];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell2"];
    [self.tableView registerNib:[UINib nibWithNibName:@"serviceImageCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"serviceAddressCell" bundle:nil] forCellReuseIdentifier:@"cell3"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ordersBtnCell" bundle:nil] forCellReuseIdentifier:@"cell4"];
}
#pragma mark UITableViewDelegate, UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([indexPath section] ==0) {
        serviceImageCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        [cell setBackgroundColor:[UIColor clearColor]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        if ([indexPath section] == 4) {
            ordersBtnCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell4"];
            [cell setBackgroundColor:[UIColor whiteColor]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            if ([indexPath section] ==2) {
                serviceAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
                [cell setBackgroundColor:[UIColor whiteColor]];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }else{
                UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
                cell.textLabel.text = @"服务时间：今天（周六）9:00";
                [cell setBackgroundColor:[UIColor whiteColor]];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }

        }
        
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [[self.cellheight objectAtIndex:[indexPath section]] intValue]*kHeightFactor;
}
- (CGFloat)tableView:( UITableView *)tableView heightForHeaderInSection:( NSInteger )section
{
    return 0.01;
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    NSString *reuseIdetify = [NSString stringWithFormat:@"OCHomeHeaderView"];
//    OCHomeHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseIdetify];
//    if (!headerView) {
//        headerView = [[OCHomeHeaderView alloc]initWithReuseIdentifier:reuseIdetify];
//    }
//    headerView.titlelab.text = @"123";
//    return headerView;}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0.01;
//}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [self.tabBarController.navigationController pushViewController:[serviceDetailsVC new] animated:YES];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
