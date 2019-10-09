//
//  ImageAddView.h
//  MarkImagePickerDemo
//
//  Created by markye on 2018/8/21.
//  Copyright © 2018年 markye. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ItemType_Add,
    ItemType_Image,
    ItemType_Hidden,
} ItemType;

@interface ImageItemView : UIView

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
//回调
@property (copy,nonatomic) void(^addBlock)(void);
@property (copy,nonatomic) void(^closeBlock)(NSInteger index);

-(void)setItemType:(ItemType)type;

@end
