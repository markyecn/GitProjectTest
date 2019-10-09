//
//  ImageSelectView.m
//  MarkImagePickerDemo
//
//  Created by markye on 2018/8/21.
//  Copyright © 2018年 markye. All rights reserved.
//

#import "ImageSelectView.h"
#import "ImageItemView.h"

#define MaxNumber 4

@interface ImageSelectView()<LFImagePickerControllerDelegate>

@property (strong,nonatomic) NSMutableArray *itemArray;

@end

@implementation ImageSelectView
    
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)setDefaultSelectImage:(NSArray<UIImage *> *)imgArr{
    for (UIImage* image in imgArr) {
        LFResultImage *resultImage = [[LFResultImage alloc] initWithImage:image];
        [self.imgArray addObject:resultImage];
    }
    [self showImages];
}

//初始化
-(void)initView{
    self.imgArray = [NSMutableArray array];
    self.itemArray = [NSMutableArray array];
    CGFloat offset = 15;//间隙
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 5*offset)*1.0/MaxNumber;
    for (int index = 0; index< MaxNumber; index++) {
        ImageItemView *itemV =  [[NSBundle mainBundle] loadNibNamed:@"ImageItemView" owner:self options:nil].lastObject;
        itemV.frame = CGRectMake(width*index + (index+1)*offset, 0, width,width);
        //设置回调block
        itemV.addBlock = ^{
            [self selectImage];
        };
        itemV.closeBlock = ^(NSInteger index) {
            [self.imgArray removeObjectAtIndex:index];
            [self showImages];
        };
        itemV.tag = index;
        //初始化显示第一个
        if (index == 0) {
            [itemV setItemType:ItemType_Add];
        }else{
            [itemV setItemType:ItemType_Hidden];
        }
        [self addSubview:itemV];
        [self.itemArray addObject:itemV];
    }
}

//处理点击添加图片
-(void)selectImage{
    LFImagePickerController *imagePicker = [[LFImagePickerController alloc] initWithMaxImagesCount:MaxNumber delegate:self];
    imagePicker.maxImagesCount = (MaxNumber-self.imgArray.count);
    imagePicker.doneBtnTitleStr = @"确定";
    imagePicker.cancelBtnTitleStr = @"取消";
    imagePicker.previewBtnTitleStr = @"预览";
    imagePicker.fullImageBtnTitleStr = @"原图";
//    imagePicker.defaultAlbumName = @"屏幕快照";
    imagePicker.allowTakePicture = NO;
    //imagePicker.maxVideosCount = 1; /** 解除混合选择- 要么1个视频，要么9个图片 */
    imagePicker.supportAutorotate = NO; /** 适配横屏 */
    imagePicker.allowPickingGif = NO; /** 支持GIF */
    imagePicker.allowPickingLivePhoto = NO; /** 支持Live Photo */
    //imagePicker.maxVideoDuration = 10; /** 10秒视频 */
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f) {
        imagePicker.syncAlbum = YES; /** 实时同步相册 */
    }
    //显示
    [[self viewController] presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark delegate
-(void)lf_imagePickerController:(LFImagePickerController *)picker didFinishPickingResult:(NSArray<LFResultObject *> *)results{
    //添加进入数组
    [self.imgArray addObjectsFromArray:results];
    //处理显示图片
    [self showImages];
}

//显示图片
-(void)showImages{
    for (int i = 0; i< self.imgArray.count; i++) {
        LFResultImage *resultImage = (LFResultImage *)self.imgArray[i];
        ImageItemView *itemV = self.itemArray[i];
        [itemV.imageView setImage:resultImage.thumbnailImage];
    }
    [self handleItemHidden];
    //有变动回调
    if(self.imgArrayChangedBlock){
        self.imgArrayChangedBlock();
    }
}

//处理选择回来的图片显示
-(void)handleItemHidden{
    NSInteger count = self.imgArray.count;
    switch (count) {
        case 0:{
            [((ImageItemView*)self.itemArray[0]) setItemType:ItemType_Add];
            [((ImageItemView*)self.itemArray[1]) setItemType:ItemType_Hidden];
            [((ImageItemView*)self.itemArray[2]) setItemType:ItemType_Hidden];
            [((ImageItemView*)self.itemArray[3]) setItemType:ItemType_Hidden];
            break;
        }
        case 1:{
            [((ImageItemView*)self.itemArray[0]) setItemType:ItemType_Image];
            [((ImageItemView*)self.itemArray[1]) setItemType:ItemType_Add];
            [((ImageItemView*)self.itemArray[2]) setItemType:ItemType_Hidden];
            [((ImageItemView*)self.itemArray[3]) setItemType:ItemType_Hidden];
            break;
        }
        case 2:{
            [((ImageItemView*)self.itemArray[0]) setItemType:ItemType_Image];
            [((ImageItemView*)self.itemArray[1]) setItemType:ItemType_Image];
            [((ImageItemView*)self.itemArray[2]) setItemType:ItemType_Add];
            [((ImageItemView*)self.itemArray[3]) setItemType:ItemType_Hidden];
            break;
        }
        case 3:{
            [((ImageItemView*)self.itemArray[0]) setItemType:ItemType_Image];
            [((ImageItemView*)self.itemArray[1]) setItemType:ItemType_Image];
            [((ImageItemView*)self.itemArray[2]) setItemType:ItemType_Image];
            [((ImageItemView*)self.itemArray[3]) setItemType:ItemType_Add];
            break;
        }
        case 4:{
            [((ImageItemView*)self.itemArray[0]) setItemType:ItemType_Image];
            [((ImageItemView*)self.itemArray[1]) setItemType:ItemType_Image];
            [((ImageItemView*)self.itemArray[2]) setItemType:ItemType_Image];
            [((ImageItemView*)self.itemArray[3]) setItemType:ItemType_Image];
            break;
        }
        default:
            break;
    }
}

- (UIViewController *)viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
