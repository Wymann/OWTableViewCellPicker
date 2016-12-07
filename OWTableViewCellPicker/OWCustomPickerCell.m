//
//  OWCustomPickerCell.m
//  OWTableViewCellEdit
//
//  Created by Wyman Chen on 2016/12/5.
//  Copyright © 2016年 conpak. All rights reserved.
//

#import "OWCustomPickerCell.h"

@interface OWCustomPickerCell()

@property (nonatomic, strong) NSString *cellTitle;
@property (nonatomic) CGFloat cellHeight;
@property (nonatomic) CGFloat cellWidth;
@property (nonatomic, strong) UIView *managerView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic) BOOL isEdit;

@end

@implementation OWCustomPickerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithTitle:(NSString *)cellTitle height:(CGFloat)cellHeight width:(CGFloat)cellWidth indexPath:(NSIndexPath *)indexPath isEdit:(BOOL)isEdit
{
    self = [super init];
    if (self) {
        _cellTitle = cellTitle;
        _cellHeight = cellHeight;
        _indexPath = indexPath;
        _cellWidth = cellWidth;
        _isEdit = isEdit;
        [self setUI];
    }
    return self;
}

- (void)setUI
{
    self.clipsToBounds = YES;
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(45.0, (_cellHeight - 20.0)/2, _cellWidth - 70.0, 20.0);
    label.text = _cellTitle;
    label.textColor = [UIColor darkGrayColor];
    label.font = [UIFont systemFontOfSize:16.0];
    [self addSubview:label];
    
    _managerView = [[UIView alloc] init];
    _managerView.frame = CGRectMake(_cellWidth - 35.0, (_cellHeight - 15.0)/2, 20.0, 15.0);
    [self addSubview:_managerView];
    
    for (NSInteger i = 0; i < 3; i++) {
        CGFloat X = 0.0;
        CGFloat Y = 6.0 * i;
        CGFloat width = 20.0;
        CGFloat height = 2.0;
        CGRect rect = CGRectMake(X, Y, width, height);
        UIView *lineView = [[UIView alloc] initWithFrame:rect];
        lineView.backgroundColor = [UIColor darkGrayColor];
        [_managerView addSubview:lineView];
    }
    
    if (_isEdit) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(15.0, (_cellHeight - 20.0)/2, 20.0, 20.0);
        _button.layer.cornerRadius = 10.0;
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button];
        
        if (_indexPath.section == 0) {
            _button.backgroundColor = [UIColor redColor];
            [_button setTitle:@"-" forState:UIControlStateNormal];
        } else {
            _button.backgroundColor = [UIColor blueColor];
            [_button setTitle:@"+" forState:UIControlStateNormal];
        }
    }
    
    if (_indexPath.section == 1) {
        _managerView.hidden = YES;
    }
}

- (void)buttonClick
{
    if (self.delegate) {
        OWButtonType buttonType;
        if (_indexPath.section == 0) {
            buttonType = OWButtonType_delect;
        } else {
            buttonType = OWButtonType_add;
        }
        [self.delegate didClickButtonOnOWCustomPickerCell:self buttonType:buttonType indexPath:_indexPath];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
