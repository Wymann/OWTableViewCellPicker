//
//  OWTableViewCellPicker.h
//  OWTableViewCellEdit
//
//  Created by Wyman Chen on 2016/12/2.
//  Copyright © 2016年 conpak. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OWTableViewCellPicker;

@protocol OWTableViewCellPickerDataSource <NSObject>

@required

- (NSArray *)currentArrayOnTableViewCellEditView:(OWTableViewCellPicker *)view;
- (NSArray *)optionalArrayOnTableViewCellEditView:(OWTableViewCellPicker *)view;

@optional

- (NSArray *)sectionTitleArrayOnTableViewCellEditView:(OWTableViewCellPicker *)view;
- (NSArray *)cantEditArrayOnTableViewCellEditView:(OWTableViewCellPicker *)view;

@end

@protocol OWTableViewCellPickerDelegate <NSObject>

- (void)didChangedDataOnTableViewCellEditView:(OWTableViewCellPicker *)view currentArray:(NSArray *)currentArray;
- (void)didChangedDataOnTableViewCellEditView:(OWTableViewCellPicker *)view optionalArray:(NSArray *)optionalArray;

@end

@interface OWTableViewCellPicker : UIView

@property (nonatomic, weak) id <OWTableViewCellPickerDataSource> dataSource;
@property (nonatomic, weak) id <OWTableViewCellPickerDelegate> delegate;

@end
