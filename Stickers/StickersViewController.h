//
//  StickersViewController.h
//  Stickers
//
//  Created by Haifa Carina Baluyos on 4/2/12.
//  Copyright 2012 NMG Resources, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "GlobalData.h"

@interface StickersViewController : UIViewController <UIScrollViewDelegate>{
    UIScrollView *imageScrollView;
    UIImage *image;
    UIView *contentView;    
    
    UIImage *sticker1;
    UIImage *sticker2;
    UIImage *sticker3;
    UIImage *sticker4;
    
    int stickersCount;
    
    CGFloat initialDistance;
    CGFloat finalDistance;
    
    CGPoint touch1;
    CGPoint touch2;
    
    UIImageView *sticker;
    
    float angle;
    float rotation;
}

@end
