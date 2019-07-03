//
//  CWFlieManager.m
//  QQVoiceDemo
//
//  Created by chavez on 2017/10/13.
//  Copyright © 2017年 陈旺. All rights reserved.
//

#import "CWFlieManager.h"

@implementation CWFlieManager

singtonImplement(CWFlieManager);

+ (NSString *)CWFolderPath {
    NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *CWFolderPath = [NSString stringWithFormat:@"%@/CWVoice",documentDir];
    BOOL isExist =  [[NSFileManager defaultManager]fileExistsAtPath:CWFolderPath];
    if (!isExist) {
         [[NSFileManager defaultManager] createDirectoryAtPath:CWFolderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return CWFolderPath;
}

+ (NSString *)soundTouchSavePathWithFileName:(NSString *)fileName {
//    NSString *fileName = [self fileName];
    
    NSString *wavfilepath = [NSString stringWithFormat:@"%@/SoundTouch",[CWFlieManager CWFolderPath]];
    
    NSString *writeFilePath = [NSString stringWithFormat:@"%@/%@",wavfilepath, fileName];
    BOOL isExist =  [[NSFileManager defaultManager] fileExistsAtPath:writeFilePath];
    if (isExist) {
        //如果存在则移除 以防止 文件冲突
//        NSError *err = nil;
        [CWFlieManager removeFile:writeFilePath];
//        [[NSFileManager defaultManager] removeItemAtPath:writeFilePath error:&err];
    }
    
    BOOL isExistDic =  [[NSFileManager defaultManager] fileExistsAtPath:wavfilepath];
    if (!isExistDic) {
        [[NSFileManager defaultManager] createDirectoryAtPath:wavfilepath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return writeFilePath;
}
+ (NSString *)getPlaySoundTouchSavePathWithFileName:(NSString *)fileName {
    
    NSString *wavfilepath = [NSString stringWithFormat:@"%@/SoundTouch",[CWFlieManager CWFolderPath]];
    
    NSString *writeFilePath = [NSString stringWithFormat:@"%@/%@",wavfilepath, fileName];
    return writeFilePath;
    
}

+ (NSString *)fileName {
    NSString *fileName = [NSString stringWithFormat:@"CWVoice%lld.wav",(long long)[NSDate timeIntervalSinceReferenceDate]];
    return fileName;
}

+ (NSString *)filePath {
    NSString *path = [CWFlieManager CWFolderPath];
    NSString *fileName = [CWFlieManager fileName];
    return [path stringByAppendingPathComponent:fileName];
}

+ (void)removeFile:(NSString *)filePath{
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}
@end