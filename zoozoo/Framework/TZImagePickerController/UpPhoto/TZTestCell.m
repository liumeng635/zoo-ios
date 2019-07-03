//
//  TZTestCell.m
//  TZImagePickerController
//
//  Created by 谭真 on 16/1/3.
//  Copyright © 2016年 谭真. All rights reserved.
//

#import "TZTestCell.h"
#import "UIView+Layout.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
 

@implementation TZTestCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor colorWithRed:248 green:248 blue:248 alpha:1];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imageView];
        self.clipsToBounds = YES;
        
        _videoImageView = [[UIImageView alloc] init];
        _videoImageView.image = [UIImage imageNamed:@"shiping"];
        _videoImageView.contentMode = UIViewContentModeScaleAspectFill;
        _videoImageView.hidden = YES;
        [self addSubview:_videoImageView];
        
        _clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _clickBtn.frame = self.bounds;
         [_clickBtn addTarget:self action:@selector(showImage) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_clickBtn];
        
        
        
        
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        _deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(-10, 0, 0, -10);
        _deleteBtn.alpha = 0.6;
         [_deleteBtn addTarget:self action:@selector(deleteBtnClik) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_deleteBtn];
        _gifLable.hidden = YES;
        _gifLable = [[UILabel alloc] init];
        _gifLable.text = @"GIF";
        _gifLable.textColor = [UIColor whiteColor];
        _gifLable.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        _gifLable.textAlignment = NSTextAlignmentCenter;
        _gifLable.font = [UIFont systemFontOfSize:14];
        [self addSubview:_gifLable];
        _gifLable.hidden = YES;
    }
    return self;
}
- (void)showImage {
    self.showImageClickBlock();
}
- (void)deleteBtnClik {
    self.deleteClickBlock();
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = self.bounds;
    _gifLable.frame = CGRectMake(self.tz_width - 25, self.tz_height - 14, 25, 14);
    _deleteBtn.frame = CGRectMake(self.tz_width - 36, 0, 36, 36);
    CGFloat width = self.tz_width / 4.0;
    _videoImageView.frame = CGRectMake((self.tz_width-width)/2, (self.tz_height-width)/2, width, width);
}

- (void)setAsset:(id)asset {
    
    _asset = asset;
  
    
//    if ([asset isKindOfClass:[PHAsset class]]) {
//        PHAsset *phAsset = asset;
//        _videoImageView.hidden = phAsset.mediaType != PHAssetMediaTypeVideo;
//        _gifLable.hidden = ![[phAsset valueForKey:@"filename"] tz_containsString:@"GIF"];
//    } else if ([asset isKindOfClass:[ALAsset class]]) {
//        ALAsset *alAsset = asset;
//        _videoImageView.hidden = ![[alAsset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo];
//        _gifLable.hidden = YES;
//    }
 }

- (void)setRow:(NSInteger)row {
    _row = row;
    _deleteBtn.tag = row;
}

- (UIView *)snapshotView {
    UIView *snapshotView = [[UIView alloc]init];
    
    UIView *cellSnapshotView = nil;
    
    if ([self respondsToSelector:@selector(snapshotViewAfterScreenUpdates:)]) {
        cellSnapshotView = [self snapshotViewAfterScreenUpdates:NO];
    } else {
        CGSize size = CGSizeMake(self.bounds.size.width + 20, self.bounds.size.height + 20);
        UIGraphicsBeginImageContextWithOptions(size, self.opaque, 0);
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage * cellSnapshotImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        cellSnapshotView = [[UIImageView alloc]initWithImage:cellSnapshotImage];
    }
    
    snapshotView.frame = CGRectMake(0, 0, cellSnapshotView.frame.size.width, cellSnapshotView.frame.size.height);
    cellSnapshotView.frame = CGRectMake(0, 0, cellSnapshotView.frame.size.width, cellSnapshotView.frame.size.height);
    
    [snapshotView addSubview:cellSnapshotView];
    return snapshotView;
}

@end
