//
//  GlobalData.h
//  TheLoveContract
//
//  Created by Haifa Carina Baluyos on 3/20/12.
//  Copyright 2012 NMG Resources, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GlobalData : NSObject {
    UIImage *currentPhoto;
    UIImageView *currentPhotoView;
    UIScrollView *currentScrollView;
    UIImage *sticker;
    int currentPhotoTag;
    int fromEffectsTag;
    
    UIImageView *photoView1;
    NSMutableArray *stickersArray;
    
}

@property (nonatomic, retain) UIImage *currentPhoto;
@property (nonatomic, retain) UIImageView *currentPhotoView;
@property (nonatomic, retain) UIScrollView *currentScrollView;
@property (nonatomic, retain) UIImage *sticker;
@property (nonatomic, retain) UIImageView *photoView1;
@property (nonatomic) int currentPhotoTag;
@property (nonatomic) int fromEffectsTag;
@property (nonatomic, retain) NSMutableArray *stickersArray;

+ (GlobalData*)sharedGlobalData;

@end
