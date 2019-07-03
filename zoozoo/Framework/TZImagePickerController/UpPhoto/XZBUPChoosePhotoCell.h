//
//  XZBUPChoosePhotoCell.h
//  ZhuiYiNaNian
//
//  Created by 肖志斌 on 2018/6/1.
//  Copyright © 2018年 xiao. All rights reserved.
//

#import <UIKit/UIKit.h>
//typedef void(^CollectionSelectedBlock)(NSMutableArray *Photos);
typedef void(^CollectionSelectedBlock)(NSMutableArray *Photos,NSMutableArray *Assets);
typedef void(^CollectionVideoSelectedBlock)(NSString *videoUrl,CGFloat videoScale,CGFloat videoWidth,CGFloat videoHeight, CGFloat playTimer,NSString *loactionStr);
@interface XZBUPChoosePhotoCell : UITableViewCell
@property (nonatomic, strong) NSMutableArray *selectedPhotos;
@property (nonatomic, strong) NSMutableArray *selectedAssets;
@property (nonatomic, assign) BOOL isPhoto;
@property (nonatomic, strong) NSString *upType;
@property (nonatomic, assign) BOOL isFeedBack; //若是意见反馈则最多只能选择3张图片
@property(nonatomic ,copy)CollectionSelectedBlock photosSelectedBlock;
@property(nonatomic ,copy)CollectionVideoSelectedBlock VideosSelectedBlock;
@end
