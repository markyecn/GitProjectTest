//
//  ImageSelectView.h
//  MarkImagePickerDemo
//
//  Created by markye on 2018/8/21.
//  Copyright © 2018年 markye. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LFImagePickerController.h"


@interface ImageSelectView : UIView

@property (strong,nonatomic) NSMutableArray<LFResultImage*> *imgArray;
@property (copy,nonatomic) void(^imgArrayChangedBlock)(void);

-(void)setDefaultSelectImage:(NSArray<UIImage *> *)imgArr;

@end
