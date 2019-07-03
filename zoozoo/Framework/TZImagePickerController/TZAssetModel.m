//
//  TZAssetModel.m
//  TZImagePickerController
//
//  Created by 谭真 on 15/12/24.
//  Copyright © 2015年 谭真. All rights reserved.
//

#import "TZAssetModel.h"
#import "TZImageManager.h"

@implementation TZAssetModel

+ (instancetype)modelWithAsset:(id)asset type:(TZAssetModelMediaType)type{
    TZAssetModel *model = [[TZAssetModel alloc] init];
    model.asset = asset;
    model.isSelected = NO;
    model.type = type;
    model.isCanShowSelected = NO;
    model.isBackUP = NO;
    return model;
}

+ (instancetype)modelWithAsset:(id)asset type:(TZAssetModelMediaType)type timeLength:(NSString *)timeLength {
    TZAssetModel *model = [self modelWithAsset:asset type:type];
    model.timeLength = timeLength;
    return model;
}
+ (instancetype)modelWithAsset:(id)asset Image:(NSString *)YunWebImageUrl MD5:(NSString *)MD5 aid:(NSInteger )aid createTime:(NSString *)createTime {
    TZAssetModel *model = [[TZAssetModel alloc] init];
     model.asset = asset;
    model.isSelected = NO;
    model.YunWebImageUrl = YunWebImageUrl;
    model.createTime = createTime;
    model.MD5 = MD5;
    model.aid = aid;
    model.isCanShowSelected = NO;
    model.isBackUP = true;
    model.isWebPic = YES;
    return model;
}
@end



@implementation TZAlbumModel

- (void)setResult:(id)result needFetchAssets:(BOOL)needFetchAssets {
    _result = result;
    if (needFetchAssets) {
        [[TZImageManager manager] getAssetsFromFetchResult:result completion:^(NSArray<TZAssetModel *> *models) {
            self->_models = models;
            if (self->_selectedModels) {
                [self checkSelectedModels];
            }
        }];
    }
}

- (void)setSelectedModels:(NSArray *)selectedModels {
    _selectedModels = selectedModels;
    if (_models) {
        [self checkSelectedModels];
    }
}

- (void)checkSelectedModels {
    self.selectedCount = 0;
    NSMutableArray *selectedAssets = [NSMutableArray array];
    for (TZAssetModel *model in _selectedModels) {
        [selectedAssets addObject:model.asset];
    }
    for (TZAssetModel *model in _models) {
        if ([[TZImageManager manager] isAssetsArray:selectedAssets containAsset:model.asset]) {
            self.selectedCount ++;
        }
    }
}

- (NSString *)name {
    if (_name) {
        return _name;
    }
    return @"";
}

@end
