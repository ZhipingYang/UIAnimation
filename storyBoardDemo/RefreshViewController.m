//
//  RefreshViewController.m
//  storyBoardDemo
//
//  Created by XcodeYang on 7/23/15.
//  Copyright (c) 2015 XcodeYang. All rights reserved.
//

#import "RefreshViewController.h"
#import "UIScrollView+UzysAnimatedGifPullToRefresh.h"
#import "OFFCountingAnimationView.h"

#define CELLIDENTIFIER @"CELL"

@interface RefreshViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *pData;

@property (nonatomic,assign) BOOL useActivityIndicator;
@property (nonatomic,assign) BOOL isLoading;

@end

@implementation RefreshViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupDataSource];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"UzysAnimatedGifPullToRefresh";
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CELLIDENTIFIER];

    __weak typeof(self) weakSelf =self;
    [_tableView addPullToRefreshActionHandler:^{
        [weakSelf insertRowAtTop];
        
    } ProgressImagesGifName:@"animation.gif" LoadingImagesGifName:@"animation.gif" ProgressScrollThreshold:70 LoadingImageFrameRate:30];
    
    [_tableView addTopInsetInPortrait:64 TopInsetInLandscape:44];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //    Manually trigger
    [_tableView triggerPullToRefresh];
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark UITableView DataManagement
- (void)setupDataSource {
    self.pData = [NSMutableArray array];
    
    for(int i=0; i<20; i++){
        [self.pData addObject:[NSDate dateWithTimeIntervalSinceNow:-(i*100)]];
    }
}

- (void)insertRowAtTop {
    __weak typeof(self) weakSelf = self;
    self.isLoading =YES;
    int64_t delayInSeconds = 3.2;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [weakSelf.tableView beginUpdates];
        [weakSelf.pData insertObject:[NSDate date] atIndex:0];
        [weakSelf.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]
                                  withRowAnimation:UITableViewRowAnimationBottom];
        [weakSelf.tableView endUpdates];
        
        [weakSelf.tableView stopPullToRefreshAnimation];
        weakSelf.isLoading =NO;
    });
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLIDENTIFIER];
    
    NSDate *date = [self.pData objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.text = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterMediumStyle];
    
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [OFFCountingAnimationView showCountingViewWithStartStr:@"XcodeYangOne"
                                                 middleStr:@"XcodeYangTwo"
                                                    endStr:@"XcodeYangThree"
                                       animateWithDuration:4
                                                animations:^{
                                                    
                                                }];

}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

@end
