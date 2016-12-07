//
//  OWTableViewCellPicker.m
//  OWTableViewCellEdit
//
//  Created by Wyman Chen on 2016/12/2.
//  Copyright © 2016年 conpak. All rights reserved.
//

#import "OWTableViewCellPicker.h"
#import "OWCustomPickerCell.h"

#define rowHeight 40.0
#define headerHeight 40.0

@interface OWTableViewCellPicker()<UITableViewDelegate, UITableViewDataSource, OWCustomPickerCellDelegate>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *currentArr;
@property (nonatomic, strong) NSMutableArray *optionalArr;
@property (nonatomic, strong) NSMutableArray *titleArr;
@property (nonatomic, strong) NSMutableArray *cantEditArr;

@end

@implementation OWTableViewCellPicker

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    [self initData];
    
    [self setMyTableView];
}

- (void)initData
{
    if ([self.dataSource respondsToSelector:@selector(currentArrayOnTableViewCellEditView:)]) {
        _currentArr = [NSMutableArray arrayWithArray:[self.dataSource currentArrayOnTableViewCellEditView:self]];
    }
    
    if ([self.dataSource respondsToSelector:@selector(optionalArrayOnTableViewCellEditView:)]) {
        _optionalArr = [NSMutableArray arrayWithArray:[self.dataSource optionalArrayOnTableViewCellEditView:self]];
    }
    
    if ([self.dataSource respondsToSelector:@selector(sectionTitleArrayOnTableViewCellEditView:)]) {
        _titleArr = [NSMutableArray arrayWithArray:[self.dataSource sectionTitleArrayOnTableViewCellEditView:self]];
    }
    
    if ([self.dataSource respondsToSelector:@selector(cantEditArrayOnTableViewCellEditView:)]) {
        _cantEditArr = [NSMutableArray arrayWithArray:[self.dataSource cantEditArrayOnTableViewCellEditView:self]];
    }
}

- (void)setMyTableView
{
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStyleGrouped];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    [self addSubview:_myTableView];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGestureRecognized:)];
    [_myTableView addGestureRecognizer:longPress];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return _currentArr.count;
            break;
        case 1:
            return _optionalArr.count;
            break;
        default:
            return 0;
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return rowHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OWCustomPickerCell *cell;
    if (indexPath.section == 0) {
        for (NSInteger i = 0; i < _currentArr.count; i++) {
            if (i == indexPath.row) {
                for (NSInteger j = 0; j < _cantEditArr.count; j++) {
                    NSString *cantEditStr = _cantEditArr[j];
                    if ([cantEditStr isEqualToString:_currentArr[i]]) {
                        cell = [[OWCustomPickerCell alloc] initWithTitle:_currentArr[i] height:rowHeight width:self.frame.size.width indexPath:indexPath isEdit:NO];
                    } else {
                        cell = [[OWCustomPickerCell alloc] initWithTitle:_currentArr[i] height:rowHeight width:self.frame.size.width indexPath:indexPath isEdit:YES];
                    }
                }
            }
        }
    } else {
        for (NSInteger i = 0; i < _optionalArr.count; i++) {
            if (i == indexPath.row) {
                for (NSInteger j = 0; j < _cantEditArr.count; j++) {
                    NSString *cantEditStr = _cantEditArr[j];
                    if ([cantEditStr isEqualToString:_optionalArr[i]]) {
                        cell = [[OWCustomPickerCell alloc] initWithTitle:_optionalArr[i] height:rowHeight width:self.frame.size.width indexPath:indexPath isEdit:NO];
                    } else {
                        cell = [[OWCustomPickerCell alloc] initWithTitle:_optionalArr[i] height:rowHeight width:self.frame.size.width indexPath:indexPath isEdit:YES];
                    }
                }
            }
        }
    }
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if([view isKindOfClass:[UITableViewHeaderFooterView class]]){
        UITableViewHeaderFooterView *tableViewHeaderFooterView = (UITableViewHeaderFooterView *) view;
        tableViewHeaderFooterView.textLabel.text = [tableViewHeaderFooterView.textLabel.text capitalizedString];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return headerHeight;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _titleArr[section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

-(void)didClickButtonOnOWCustomPickerCell:(OWCustomPickerCell *)cell buttonType:(OWButtonType)buttonType indexPath:(NSIndexPath *)indexPath
{
    [_myTableView reloadData];
    
    if (buttonType == OWButtonType_delect) {
        NSString *string = [NSString stringWithFormat:@"%@",_currentArr[indexPath.row]];
        
        [_currentArr removeObjectAtIndex:indexPath.row];
        [_myTableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
        
        [_optionalArr addObject:string];
        
        [_myTableView beginUpdates];
        [_myTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:(_optionalArr.count - 1) inSection:1]] withRowAnimation:UITableViewRowAnimationMiddle];
        [_myTableView endUpdates];
    } else {
        NSString *string = [NSString stringWithFormat:@"%@",_optionalArr[indexPath.row]];
        
        [_optionalArr removeObjectAtIndex:indexPath.row];
        [_myTableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
        
        [_currentArr addObject:string];
        
        [_myTableView beginUpdates];
        [_myTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:(_currentArr.count - 1) inSection:0]] withRowAnimation:UITableViewRowAnimationMiddle];
        [_myTableView endUpdates];
    }
    
    if (self.delegate) {
        [self.delegate didChangedDataOnTableViewCellEditView:self currentArray:_currentArr];
        [self.delegate didChangedDataOnTableViewCellEditView:self optionalArray:_optionalArr];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

#pragma mark - 方法实现

- (void)longPressGestureRecognized:(UILongPressGestureRecognizer *)gestureRecognizer
{
    UILongPressGestureRecognizer *longPress = gestureRecognizer;
    UIGestureRecognizerState state = longPress.state;
    
    CGPoint location = [longPress locationInView:_myTableView];
    NSIndexPath *indexPath = [_myTableView indexPathForRowAtPoint:location];
    static UIView *snapshot = nil;        ///< A snapshot of the row user is moving.
    static NSIndexPath *sourceIndexPath = nil; ///< Initial index path, where gesture begins.
    
    if (state == UIGestureRecognizerStateBegan) {
        
        if (indexPath) {
            sourceIndexPath = indexPath;
            
            OWCustomPickerCell *cell = (OWCustomPickerCell *)[_myTableView cellForRowAtIndexPath:indexPath];
            
            // Take a snapshot of the selected row using helper method.
            snapshot = [self customSnapshotFromView:cell];
            
            // Add the snapshot as subview, centered at cell's center...
            __block CGPoint center = cell.center;
            snapshot.center = center;
            snapshot.alpha = 0.0;
            [_myTableView addSubview:snapshot];
            [UIView animateWithDuration:0.25 animations:^{
                // Offset for gesture location.
                center.y = location.y;
                snapshot.center = center;
                snapshot.transform = CGAffineTransformMakeScale(1.05, 1.05);
                snapshot.alpha = 0.98;
                cell.alpha = 0;
            } completion:^(BOOL finished) {
                
                cell.hidden = YES;
                
            }];
        }
        
    } else if(state == UIGestureRecognizerStateChanged) {
        CGPoint center = snapshot.center;
        center.y = location.y;
        snapshot.center = center;
        
        // Is destination valid and is it different from source?
        if (indexPath && ![indexPath isEqual:sourceIndexPath]) {
            
            // ... update data source.
            if (indexPath.section == sourceIndexPath.section) {
                if (indexPath.section == 0) {
                    [_currentArr exchangeObjectAtIndex:indexPath.row withObjectAtIndex:sourceIndexPath.row];
                } else {
                    [_optionalArr exchangeObjectAtIndex:indexPath.row withObjectAtIndex:sourceIndexPath.row];
                }
            } else {
                return;
            }
            
            // ... move the rows.
            [_myTableView moveRowAtIndexPath:sourceIndexPath toIndexPath:indexPath];
            
            // ... and update source so it is in sync with UI changes.
            sourceIndexPath = indexPath;
        }
        
        if (self.delegate) {
            [self.delegate didChangedDataOnTableViewCellEditView:self currentArray:_currentArr];
            [self.delegate didChangedDataOnTableViewCellEditView:self optionalArray:_optionalArr];
        }
    } else {
        // Clean up.
        OWCustomPickerCell *cell = (OWCustomPickerCell *)[_myTableView cellForRowAtIndexPath:sourceIndexPath];
        cell.hidden = NO;
        cell.alpha = 0;
        [UIView animateWithDuration:0.25 animations:^{
            
            snapshot.center = cell.center;
            snapshot.transform = CGAffineTransformIdentity;
            snapshot.alpha = 0.0;
            cell.alpha = 1;
            // Undo the black-out effect we did.
            cell.backgroundColor = [UIColor whiteColor];
            
        } completion:^(BOOL finished) {
            
            [snapshot removeFromSuperview];
            snapshot = nil;
            sourceIndexPath = nil;
            cell.hidden = NO;
        }];
    }
}

- (UIView *)customSnapshotFromView:(UIView *)inputView {
    
    // Make an image from the input view.
    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, NO, 0);
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;

    return snapshot;
}

@end
