//
//  OWCustomPickerCell.h
//  OWTableViewCellEdit
//
//  Created by Wyman Chen on 2016/12/5.
//  Copyright © 2016年 conpak. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    OWButtonType_delect,
    OWButtonType_add,
} OWButtonType;

@class OWCustomPickerCell;

@protocol OWCustomPickerCellDelegate <NSObject>

- (void)didClickButtonOnOWCustomPickerCell:(OWCustomPickerCell *)cell buttonType:(OWButtonType)buttonType indexPath:(NSIndexPath *)indexPath;

@end

@interface OWCustomPickerCell : UITableViewCell

@property (weak, nonatomic) id <OWCustomPickerCellDelegate> delegate;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic) BOOL isEdit;

- (instancetype)initWithTitle:(NSString *)cellTitle height:(CGFloat)cellHeight width:(CGFloat)cellWidth indexPath:(NSIndexPath *)indexPath isEdit:(BOOL)isEdit;

@end
