//
//  ImageAddView.m
//  MarkImagePickerDemo
//
//  Created by markye on 2018/8/21.
//  Copyright © 2018年 markye. All rights reserved.
//

#import "ImageItemView.h"

@implementation ImageItemView

-(void)awakeFromNib{
    [super awakeFromNib];
    //设置Border
//    self.addBtn.layer.cornerRadius = 4.0f;
//    self.addBtn.layer.borderWidth = 0.5f;
//    self.addBtn.layer.borderColor = [UIColor colorWithHexString:@"#DCDCDC"].CGColor;
//    self.addBtn.layer.masksToBounds = YES;
    [self setupButtonBorder:CGSizeMake(80, 80)];
}

//设置类型
-(void)setItemType:(ItemType)type{
    if (type == ItemType_Add) {
        self.addBtn.hidden = NO;
        self.imageView.hidden = YES;
        self.closeBtn.hidden = YES;
    }else if (type == ItemType_Image){
        self.addBtn.hidden = YES;
        self.imageView.hidden = NO;
        self.closeBtn.hidden = NO;
    }else if (type == ItemType_Hidden){
        self.addBtn.hidden = YES;
        self.imageView.hidden = YES;
        self.closeBtn.hidden = YES;
    }
}

//添加
- (IBAction)addBtnClicked:(id)sender {
    if(_addBlock){
        _addBlock();
    }
}

//关闭
- (IBAction)closeBtnClicked:(id)sender {
    if (_closeBlock) {
        _closeBlock(self.tag);
    }
}


//虚线边框
-(void)setupButtonBorder:(CGSize)size{
    CAShapeLayer *border = [CAShapeLayer layer];
    //虚线的颜色
    border.strokeColor = [UIColor lightGrayColor].CGColor;
    //填充的颜色
    border.fillColor = [UIColor clearColor].CGColor;

    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:0];

    //设置路径
    border.path = path.CGPath;

    border.frame = self.addBtn.bounds;
    //虚线的宽度
    border.lineWidth = 1.f;
    //设置线条的样式
    //    border.lineCap = @"square";
    //虚线的间隔
    border.lineDashPattern = @[@4, @2];

    [self.addBtn.layer addSublayer:border];
}

@end
