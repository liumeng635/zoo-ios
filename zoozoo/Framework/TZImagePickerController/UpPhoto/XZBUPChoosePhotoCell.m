//
//  XZBUPChoosePhotoCell.m
//  ZhuiYiNaNian
//
//  Created by 肖志斌 on 2018/6/1.
//  Copyright © 2018年 xiao. All rights reserved.
//

#import "XZBUPChoosePhotoCell.h"
#import "TZTestCell.h"
#import "UIView+Layout.h"
#import "TZImagePickerController.h"
#import "LxGridViewFlowLayout.h"

#define mainScreenW [UIScreen mainScreen].bounds.size.width
#define ThmeColor  [UIColor colorWithRed:0.26 green:0.84 blue:0.6 alpha:1]
@interface XZBUPChoosePhotoCell ()<TZImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate>
{
    CGFloat _itemWH;
    CGFloat _margin;
    CGFloat _videoScale;
    CGFloat _videoWidth;
    CGFloat _videoHeight;
    CGFloat _playTimer;  //播放时长
    NSString *locationStr;
    NSString *upImage;
    NSString *upVideo;
     BOOL isVideo ;
    
}
@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (strong, nonatomic) LxGridViewFlowLayout *layout;
@end


@implementation XZBUPChoosePhotoCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self configCollectionView];
        
    }
    return self;
}

- (void)configCollectionView {
    // 如不需要长按排序效果，将LxGridViewFlowLayout类改成UICollectionViewFlowLayout即可
    _layout = [[LxGridViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.contentInset = UIEdgeInsetsMake(4, 10, 4, 10);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.bounces = false;
    _collectionView.scrollEnabled = false;
    _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.contentView addSubview:_collectionView];
    [_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
    _margin = 5;
    _itemWH = (mainScreenW - 20 - 3 * _margin) / 3 ;
    _layout.itemSize = CGSizeMake(_itemWH, _itemWH);
    _layout.minimumInteritemSpacing = _margin;
    _layout.minimumLineSpacing = _margin;
    [self.collectionView setCollectionViewLayout:_layout];
    self.collectionView.frame = CGRectMake(0, 10, mainScreenW, (_itemWH) );
    _isPhoto = true;
    
}
- (void)layoutIfNeeded{
    if (_selectedPhotos.count == 0) {
        _isPhoto = YES;
    }
    
    if (_isPhoto) {
         _layout.itemSize = CGSizeMake(_itemWH, _itemWH);
        NSInteger num = (_selectedPhotos.count + 1)/3 ;
        if (_selectedPhotos.count == 9 || _selectedPhotos.count == 5 || _selectedPhotos.count == 2 || _selectedPhotos.count == 8) {
            self.collectionView.frame = CGRectMake(0, 10, mainScreenW, (_itemWH + _margin)*num );
        }else{
            if (_isFeedBack && _selectedPhotos.count == 3) {
                self.collectionView.frame = CGRectMake(0, 10, mainScreenW, (_itemWH + _margin)*num );
            }else{
                self.collectionView.frame = CGRectMake(0, 10, mainScreenW, (_itemWH + _margin)*(num+1) );
            }
        }
    }else{
        if (_videoScale >= 1) {
            _layout.itemSize = CGSizeMake(_itemWH, _itemWH*_videoScale);
            self.collectionView.frame = CGRectMake(15, 10, _itemWH, _itemWH*_videoScale);
        }else{
            _layout.itemSize = CGSizeMake(_itemWH/_videoScale, _itemWH);
            self.collectionView.frame = CGRectMake(15, 10, _itemWH/_videoScale, _itemWH );
        }
    }
}


#pragma mark UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_isFeedBack && _selectedAssets.count == 3) {
        return _selectedAssets.count;
    }
    return _selectedAssets.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    cell.videoImageView.hidden = YES;
    __weak typeof(self) weakSelf = self;
    if (indexPath.row == _selectedAssets.count) {
        if (!_isPhoto && _selectedAssets.count==1) {
            cell.imageView.hidden = YES;
        }

        cell.videoImageView.hidden = YES;
        cell.imageView.hidden = false;
        NSString *str = [NSString stringWithFormat:@"%@", _upType];
        cell.imageView.image = [UIImage imageNamed:str];
        cell.deleteBtn.hidden = YES;
        cell.gifLable.hidden = YES;
        
    } else {
        
        cell.imageView.image = _selectedPhotos[indexPath.row];
       
        cell.deleteBtn.hidden = NO;

        cell.deleteClickBlock = ^{
            [weakSelf deleteSelectItemAtIndexPath:indexPath];
        };
    }
    cell.showImageClickBlock = ^{
        [weakSelf showViewdidSelectItemAtIndexPath:indexPath];
    };
    
    if (_isPhoto) {
        cell.videoImageView.hidden = YES;
        if (_photosSelectedBlock) {
            _photosSelectedBlock(self.selectedPhotos,self.selectedAssets);
        }
    }else{
         cell.videoImageView.hidden = NO;
        if (_VideosSelectedBlock) {
            _VideosSelectedBlock(self->upVideo,self->_videoScale,self->_videoWidth,self->_videoHeight,self->_playTimer,self->locationStr);
        }
    }
    
    
    return cell;
}

- (void)showViewdidSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row ==  _selectedAssets.count) {
        if (_isPhoto) {
            [self pushTZImagePickerController];
        }
        
    }else{
        
        PHAsset *asset = _selectedAssets[indexPath.item];
       
        isVideo = asset.mediaType == PHAssetMediaTypeVideo;
        if (isVideo){ // perview video / 预览视频
            TZVideoPlayerController *vc = [[TZVideoPlayerController alloc] init];
            TZAssetModel *model = [TZAssetModel modelWithAsset:asset type:TZAssetModelMediaTypeVideo timeLength:@""];
            vc.model = model;
            [self.getSuperController presentViewController:vc animated:YES completion:nil];
        } else { // preview photos / 预览照片
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:_selectedAssets selectedPhotos:_selectedPhotos index:indexPath.item];
            imagePickerVc.iconThemeColor = ThmeColor;
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                self->_selectedPhotos = [NSMutableArray arrayWithArray:photos];
                self->_selectedAssets = [NSMutableArray arrayWithArray:assets];
                [self->_collectionView reloadData];
                self->_collectionView.contentSize = CGSizeMake(0, ((self->_selectedPhotos.count + 2) / 3 ) * (self->_margin + self->_itemWH));
            }];
            [self.getSuperController presentViewController:imagePickerVc animated:YES completion:nil];
        }
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}
#pragma mark - TZImagePickerController

- (void)pushTZImagePickerController {
    
    NSInteger imgMaxCount =  9;
    NSInteger columnNum =  3;
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:imgMaxCount columnNumber:columnNum delegate:self pushPhotoPickerVc:YES];
    [imagePickerVc.navigationBar setTranslucent:false];
    [imagePickerVc setNavLeftBarButtonSettingBlock:^(UIButton *leftButton){
        [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    }];
    [imagePickerVc setPhotoPickerPageUIConfigBlock:^(UICollectionView *collectionView, UIView *bottomToolBar, UIButton *previewButton, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel, UIView *divideLine) {
       
        [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       
       
    }];
    //imagePickerVc.isStatusBarDefault = NO;
    imagePickerVc.statusBarStyle = UIStatusBarStyleLightContent;
    imagePickerVc.selectedAssets = _selectedAssets;
    imagePickerVc.naviBgColor = [UIColor whiteColor];
    imagePickerVc.naviTitleColor = [UIColor blackColor];
    imagePickerVc.barItemTextFont = [UIFont boldSystemFontOfSize:15];
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.iconThemeColor = ThmeColor;
//    imagePickerVc.videoMaximumDuration = 1 * 30.5 ;
   
    imagePickerVc.showSelectedIndex = YES;
    imagePickerVc.showPhotoCannotSelectLayer = YES;
  

    [self.getSuperController presentViewController:imagePickerVc animated:YES completion:nil];
}

- (UIViewController *)getSuperController{
    UIViewController *vc = [[UIViewController alloc]init];
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];

        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            vc = (UIViewController*)nextResponder;
            break;
        }
    }
    return vc;
}

- (void)refreshCollectionViewWithAddedAsset:(id)asset image:(UIImage *)image {
    [_selectedAssets addObject:asset];
    [_selectedPhotos addObject:image];
    [_collectionView reloadData];



}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset {
   _isPhoto = true;
   PHAsset *videoasset = asset;
    if (videoasset.duration > 30.5) {
        _isPhoto = true;
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"视频时长不能超过30秒，请重新选择" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self.getSuperController  presentViewController:alertController animated:YES completion:nil];
        return;
    }
    
    
    // 发送视频
    [[TZImageManager manager] getVideoOutputPathWithAsset:asset presetName:AVAssetExportPreset640x480 success:^(NSString *outputPath) {
//        NSLog(@"视频导出到本地完成,沙盒路径为:%@",outputPath);
        
        self->_isPhoto = false;
        CGFloat h = videoasset.pixelHeight;
        CGFloat w = videoasset.pixelWidth;
        NSString *addressPhoto = @"";
        if (videoasset.location != nil) {
            addressPhoto = [NSString stringWithFormat:@"%lf,%lf",videoasset.location.coordinate.latitude,videoasset.location.coordinate.longitude];
        }
        self->_videoWidth = w;
        self->_videoHeight = h;
        self->_playTimer = videoasset.duration;
        self->locationStr = addressPhoto;
        self->_videoScale =  h / w;
        self->_selectedPhotos = [NSMutableArray arrayWithArray:@[coverImage]];
        self->_selectedAssets = [NSMutableArray arrayWithArray:@[asset]];
        self->upVideo = outputPath;
       
        [self->_collectionView reloadData];
    } failure:^(NSString *errorMessage, NSError *error) {
        self->_isPhoto = true;
        NSLog(@"视频导出失败:%@,error:%@",errorMessage, error);
    }];
  
   
}
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    _isPhoto = true;
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
     _selectedAssets = [NSMutableArray arrayWithArray:assets];

    [_collectionView reloadData];

    
    
}

#pragma mark - LxGridViewDataSource

/// 以下三个方法为长按排序相关代码
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.item < _selectedAssets.count;
}

- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath canMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    return (sourceIndexPath.item < _selectedAssets.count && destinationIndexPath.item < _selectedAssets.count);
}

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath didMoveToIndexPath:(NSIndexPath *)destinationIndexPath {

    UIImage *image = _selectedPhotos[sourceIndexPath.item];
    [_selectedPhotos removeObjectAtIndex:sourceIndexPath.item];
    [_selectedPhotos insertObject:image atIndex:destinationIndexPath.item];
    
    id asset = _selectedAssets[sourceIndexPath.item];
    [_selectedAssets removeObjectAtIndex:sourceIndexPath.item];
    [_selectedAssets insertObject:asset atIndex:destinationIndexPath.item];
    
    
    [_collectionView reloadData];
}
#pragma mark - Click Event

- (void)deleteSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self collectionView:self.collectionView numberOfItemsInSection:0] <= _selectedAssets.count) {
        [_selectedPhotos removeObjectAtIndex:indexPath.row];
        [_selectedAssets removeObjectAtIndex:indexPath.row];
        [self.collectionView reloadData];
        return;
    }
   [_selectedPhotos removeObjectAtIndex:indexPath.row];
    [_selectedAssets removeObjectAtIndex:indexPath.row];
    
    [_collectionView performBatchUpdates:^{
        [self->_collectionView deleteItemsAtIndexPaths:@[indexPath]];
        
    } completion:^(BOOL finished) {
       
        [self->_collectionView reloadData];
    }];
}





@end

