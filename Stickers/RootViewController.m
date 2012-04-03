//
//  RootViewController.m
//  Stickers
//
//  Created by Haifa Carina Baluyos on 4/2/12.
//  Copyright 2012 NMG Resources, Inc. All rights reserved.
//

#import "RootViewController.h"


@implementation RootViewController
@synthesize contentView1;

- (void) singleTapGestureCaptured : (id) sender {
    NSLog(@"singletap");
    [GlobalData sharedGlobalData].currentPhotoView = [GlobalData sharedGlobalData].photoView1;
    [GlobalData sharedGlobalData].currentScrollView = scrollview1;
    [GlobalData sharedGlobalData].currentPhotoTag = 1;
    NSLog(@"zoomscale %f", scrollview1.zoomScale);
    StickersViewController *aController = [[StickersViewController alloc]init];
    [self.navigationController  pushViewController:aController animated:YES];
    [aController release];
}
- (void) handleLongPress: (UILongPressGestureRecognizer *) recognizer {
    NSLog(@"long press");
    
    [self presentModalViewController:imgPicker animated:YES];
    
}

- (void) viewWillAppear:(BOOL)animated {
    
    
    
    if ([GlobalData sharedGlobalData].fromEffectsTag == 1) {
        
        UIScrollView *tmpScrollView = [GlobalData sharedGlobalData].currentScrollView;
        [contentView1 removeFromSuperview];
        [contentView1 addSubview:[GlobalData sharedGlobalData].currentPhotoView];
        
        for (UIImageView *h in [GlobalData sharedGlobalData].stickersArray) {
            NSLog(@"Frame %f, %f, %f, %f", h.frame.origin.x, h.frame.origin.y, h.frame.size.width, h.frame.size.height);
            
            UIImageView *s = [[UIImageView alloc]initWithImage: h.image];
            s.frame = CGRectMake((h.frame.origin.x + tmpScrollView.contentOffset.x) / tmpScrollView.zoomScale , (h.frame.origin.y + tmpScrollView.contentOffset.y ) / tmpScrollView.zoomScale , h.frame.size.width / tmpScrollView.zoomScale, h.frame.size.height / tmpScrollView.zoomScale);
            NSLog(@"Updated Frame %f, %f, %f, %f", s.frame.origin.x, s.frame.origin.y, s.frame.size.width, s.frame.size.height);
            NSLog(@"Frame H %f, %f, %f, %f", h.frame.origin.x, h.frame.origin.y, h.frame.size.width, h.frame.size.height);
            [contentView1 addSubview:s];
            [s release];
        }
        [scrollview1 addSubview:contentView1];
        
        // SET ZOOM SCALE AND OFFSETS
        // Must be set after all scrollview subviews are added
        [scrollview1 setZoomScale:tmpScrollView.zoomScale animated:NO];
        [scrollview1 setContentOffset:CGPointMake(tmpScrollView.contentOffset.x , tmpScrollView.contentOffset.y)];
        
        
        [GlobalData sharedGlobalData].fromEffectsTag = 0;
    } else {
        [contentView1 removeFromSuperview];
        [contentView1 addSubview:[GlobalData sharedGlobalData].photoView1];
        [scrollview1 addSubview:contentView1];
    }
}
- (void) loadView {
    [super loadView];
    
    CGRect scrollviewRect1 = CGRectMake(40, 120, 100, 180);
    
    scrollview1 = [[UIScrollView alloc]initWithFrame: scrollviewRect1];
    scrollview1.scrollEnabled = YES;
    scrollview1.showsHorizontalScrollIndicator = TRUE;
    scrollview1.showsVerticalScrollIndicator = TRUE;
    scrollview1.contentSize = CGSizeMake(scrollviewRect1.size.width, scrollviewRect1.size.height);
    scrollview1.delegate = self;
    scrollview1.maximumZoomScale = 50;
    scrollview1.minimumZoomScale = .2;
    scrollview1.tag = 1;
    scrollview1.backgroundColor = [UIColor blueColor];
    
    contentView1 = [[UIView alloc]init];
    [contentView1 addSubview:[GlobalData sharedGlobalData].photoView1];
    [scrollview1 addSubview:contentView1];
    
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured: ) ];
    [scrollview1 addGestureRecognizer:singleTap1];
    [singleTap1 release];
    
    UILongPressGestureRecognizer* longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    [scrollview1 addGestureRecognizer:longPressRecognizer];
    [longPressRecognizer release];
    
    [self.view addSubview:scrollview1];
    imgPicker = [[UIImagePickerController alloc] init];
    imgPicker.allowsEditing = YES;
    imgPicker.delegate = self;
    imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)img editingInfo:(NSDictionary *)editInfo {
	
    NSLog(@"image picker ");
    [GlobalData sharedGlobalData].photoView1.image = img;
    [GlobalData sharedGlobalData].photoView1.frame = CGRectMake(0, 0, img.size.width, img.size.height);
    scrollview1.contentSize = CGSizeMake(img.size.width, img.size.height);
    contentView1.frame = CGRectMake(0, 0, img.size.width, img.size.height);
    
    [[picker parentViewController] dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UIScrollView Delegate
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    
}
- (UIView*)viewForZoomingInScrollView:(UIScrollView *)aScrollView {
    NSLog(@"it is zoooooooooming");
    return contentView1;
    //return [GlobalData sharedGlobalData].photoView1;
}
- (void)scrollViewDidEndZooming:(UIScrollView *)zoomedScrollView withView:(UIView *)view atScale:(float)scale
{
    NSLog(@"view scale %f", scale);
    
}

@end
