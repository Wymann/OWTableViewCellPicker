//
//  ViewController.m
//  OWTableViewCellEdit
//
//  Created by Wyman Chen on 2016/12/2.
//  Copyright © 2016年 conpak. All rights reserved.
//

#import "ViewController.h"
#import "OWTableViewCellEditVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"HOME";
}

- (IBAction)goToNextVC:(id)sender {
    
    OWTableViewCellEditVC *vc = [[OWTableViewCellEditVC alloc ] init];
    vc.title = @"Cell Manager";
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
