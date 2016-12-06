//
//  OWTableViewCellEditVC.m
//  OWTableViewCellEdit
//
//  Created by Wyman Chen on 2016/12/2.
//  Copyright © 2016年 conpak. All rights reserved.
//

#import "OWTableViewCellEditVC.h"
#import "OWTableViewCellPicker.h"

@interface OWTableViewCellEditVC ()<OWTableViewCellPickerDelegate, OWTableViewCellPickerDataSource>

@property (nonatomic, strong) OWTableViewCellPicker *cellEditView;

@end

@implementation OWTableViewCellEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUI];
}

- (void)setUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _cellEditView = [[OWTableViewCellPicker alloc] initWithFrame:CGRectMake(0, 64.0, self.view.frame.size.width, self.view.frame.size.height)];
    _cellEditView.dataSource = self;
    _cellEditView.delegate = self;
    [self.view addSubview:_cellEditView];
}

-(NSArray *)currentArrayOnTableViewCellEditView:(OWTableViewCellPicker *)view
{
    NSArray *arr = @[@"2016/17*"];
    return arr;
}

-(NSArray *)optionalArrayOnTableViewCellEditView:(OWTableViewCellPicker *)view
{
    NSArray *arr = @[@"2015/16", @"2014/15", @"2013/14",@"2012/13"];
    return arr;
}

-(NSArray *)sectionTitleArrayOnTableViewCellEditView:(OWTableViewCellPicker *)view
{
    NSArray *arr = @[@"Current Years", @"Add Other Years"];
    return arr;
}

-(NSArray *)cantEditArrayOnTableViewCellEditView:(OWTableViewCellPicker *)view
{
    return @[@"2016/17*"];
}

-(void)didChangedDataOnTableViewCellEditView:(OWTableViewCellPicker *)view currentArray:(NSArray *)currentArray
{
    NSLog(@"changed current :%@",currentArray);
}

-(void)didChangedDataOnTableViewCellEditView:(OWTableViewCellPicker *)view optionalArray:(NSArray *)optionalArray
{
    NSLog(@"changed optional :%@",optionalArray);
}

@end
