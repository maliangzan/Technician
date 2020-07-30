//
//  EditDataStepThreeViewController.m
//  Technician
//
//  Created by TianQian on 2017/4/8.
//  Copyright © 2017年 马良赞. All rights reserved.
//

#import "EditDataStepThreeViewController.h"
#import "DataImageCell.h"
#import "CustomTipsSheet.h"

static NSString *dataImageCellID = @"DataImageCell";
@interface EditDataStepThreeViewController ()
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation EditDataStepThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)buildUI{
    [super buildUI];
    
    [self.nextActionBtn setTitle:Localized(@"提交审核") forState:(UIControlStateNormal)];
    
    WeakSelf;
    self.nextStep = ^{
        [weakself CommitAction];
    };
}
-(void)registerCell{
    [self.tableView registerNib:[UINib nibWithNibName:dataImageCellID bundle:nil] forCellReuseIdentifier:dataImageCellID];
}

#pragma mark superMethod
- (void)congigHeadView{
    [self.headView.stepOneBtn setBackgroundImage:PNGIMAGE(@"complete") forState:(UIControlStateNormal)];
    [self.headView.stepTwoBtn setBackgroundImage:PNGIMAGE(@"complete") forState:(UIControlStateNormal)];
    [self.headView.stepThreeBtn setBackgroundImage:PNGIMAGE(@"current_selected3") forState:(UIControlStateNormal)];
}

#pragma mark Method
- (void)CommitAction{
    WeakSelf;
    CustomTipsSheet *servicePicker = [[CustomTipsSheet alloc] initWithFrame:self.view.bounds tipType:SYTipTypeCommitSuccess title:Localized(@"资料成功提交！") contenViewHeight:0];
    servicePicker.pickerDone = ^(NSString *selectedStr) {
 
    };
    [self.view addSubview:servicePicker];
}

#pragma mark <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DataImageCell *cell = [tableView dequeueReusableCellWithIdentifier:dataImageCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150 * kHeightFactor;
}

#pragma mark 懒加载
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithArray:@[@"手持身份证明",@"职业资格证明"]];
    }
    return _dataArray;
}

@end
