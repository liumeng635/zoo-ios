//
//  TZAssetModel.h
//  TZImagePickerController
//
//  Created by 谭真 on 15/12/24.
//  Copyright © 2015年 谭真. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    TZAssetModelMediaTypePhoto = 0,
    TZAssetModelMediaTypeLivePhoto,
    TZAssetModelMediaTypePhotoGif,
    TZAssetModelMediaTypeVideo,
    TZAssetModelMediaTypeAudio
} TZAssetModelMediaType;



@class PHAsset;
@interface TZAssetModel : NSObject

@property (nonatomic, strong) id asset;             ///< PHAsset or ALAsset
@property (nonatomic, assign) BOOL isSelected;      ///< The select status of a photo, default is No
@property (nonatomic, assign) TZAssetModelMediaType type;
@property (assign, nonatomic) BOOL needOscillatoryAnimation;
@property (assign, nonatomic) BOOL isCanShowSelected;//是否能够勾选
@property (assign, nonatomic) BOOL isBackUP;//是否备份
@property (assign, nonatomic) BOOL isWebPic;//是否网络图片
@property (nonatomic, copy) NSString *timeLength;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *MD5;
@property (nonatomic, copy) NSString *YunWebImageUrl;
@property (nonatomic, assign) NSInteger aid;
@property (strong, nonatomic) UIImage *cachedImage;
@property (strong, nonatomic) NSIndexPath *index;

/// Init a photo dataModel With a asset
/// 用一个PHAsset/ALAsset实例，初始化一个照片模型
+ (instancetype)modelWithAsset:(id)asset type:(TZAssetModelMediaType)type;
+ (instancetype)modelWithAsset:(id)asset type:(TZAssetModelMediaType)type timeLength:(NSString *)timeLength;
+ (instancetype)modelWithAsset:(id)asset Image:(NSString *)YunWebImageUrl MD5:(NSString *)MD5 aid:(NSInteger )aid createTime:(NSString *)createTime;
@end


@class PHFetchResult;
@interface TZAlbumModel : NSObject

@property (nonatomic, strong) NSString *name;        ///< The album name
@property (nonatomic, assign) NSInteger count;       ///< Count of photos the album contain
@property (nonatomic, strong) id result;             ///< PHFetchResult<PHAsset> or ALAssetsGroup<ALAsset>

@property (nonatomic, strong) NSArray *models;
@property (nonatomic, strong) NSArray *selectedModels;
@property (nonatomic, assign) NSUInteger selectedCount;

@property (nonatomic, assign) BOOL isCameraRoll;

- (void)setResult:(id)result needFetchAssets:(BOOL)needFetchAssets;

@end
