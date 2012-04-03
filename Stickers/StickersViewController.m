//
//  StickersViewController.m
//  Stickers
//
//  Created by Haifa Carina Baluyos on 4/2/12.
//  Copyright 2012 NMG Resources, Inc. All rights reserved.
//

#import "StickersViewController.h"


@implementation StickersViewController

- (void) doneAction {
    NSLog(@"done!");
    [GlobalData sharedGlobalData].fromEffectsTag = 1;
    //[GlobalData sharedGlobalData].currentScrollView = imageScrollView;
    NSLog(@"stickers count %d",[[GlobalData sharedGlobalData].stickersArray count]);
    
    for (UIImageView *s in [GlobalData sharedGlobalData].stickersArray) {
        NSLog(@"Frame %f, %f, %f, %f", s.frame.origin.x, s.frame.origin.y, s.frame.size.width, s.frame.size.height);
    }
}

- (void) addSticker: (UIImage *)img{
    UIImageView *imgView = [[UIImageView alloc]initWithImage:img];
    imgView.frame = CGRectMake(0, 0, 50, 50);
    imgView.tag = stickersCount;
    stickersCount++;
    imgView.userInteractionEnabled = YES;
    
    [contentView addSubview:imgView];
    [[GlobalData sharedGlobalData].stickersArray addObject:imgView];
    
}
- (void) singleTapGestureCaptured: (UITapGestureRecognizer *) recognizer {
    NSLog(@"%d",[recognizer view].tag);
    
    switch ([recognizer view].tag) {
        case 1: 
            [self addSticker:sticker1];
            break;
        case 2: 
            [self addSticker:sticker2];
            break;
        case 3: 
            [self addSticker:sticker3];
            break;
        case 4: 
            [self addSticker:sticker4];
            break;
            
    }
    
}
- (void) loadView {
    [super loadView];
    
    stickersCount = 101;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] 
                                   initWithTitle:@"Done"                                            
                                   style:UIBarButtonItemStyleBordered 
                                   target:self 
                                   action:@selector(doneAction)];
    
    self.navigationItem.rightBarButtonItem = doneButton;
    [doneButton release];
    
    /*
    UIScrollView *tmpScrollView = [GlobalData sharedGlobalData].currentScrollView;
    imageScrollView = [[UIScrollView alloc]initWithFrame: CGRectMake(0, 0, tmpScrollView.frame.size.width, tmpScrollView.frame.size.height)];
    imageScrollView.delegate = self;
    imageScrollView.scrollEnabled = NO;
    imageScrollView.showsHorizontalScrollIndicator = YES;
    imageScrollView.showsVerticalScrollIndicator = YES;
    
    imageScrollView.maximumZoomScale = tmpScrollView.maximumZoomScale;
    imageScrollView.minimumZoomScale = tmpScrollView.minimumZoomScale;
    imageScrollView.backgroundColor = [UIColor greenColor];
    
    imageScrollView.contentSize = [GlobalData sharedGlobalData].currentPhotoView.frame.size;
    contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [GlobalData sharedGlobalData].currentPhotoView.frame.size.width, [GlobalData sharedGlobalData].currentPhotoView.frame.size.height)];
    [contentView addSubview:[GlobalData sharedGlobalData].currentPhotoView];
    [contentView sendSubviewToBack:[GlobalData sharedGlobalData].currentPhotoView];
    [imageScrollView addSubview:contentView];
    
    // SET ZOOM SCALE AND OFFSETS
    // Must be set after all scrollview subviews are added
    [imageScrollView setZoomScale:tmpScrollView.zoomScale animated:NO];
    [imageScrollView setContentOffset:CGPointMake(tmpScrollView.contentOffset.x , tmpScrollView.contentOffset.y)];
    
    [imageScrollView setCenter:CGPointMake(CGRectGetMidX([self.view bounds]), CGRectGetMidY([self.view bounds])-100)];
    
    [self.view  addSubview:imageScrollView];
    */
    
    UIScrollView *scrollview1 = [[UIScrollView alloc]init];
    scrollview1 = [GlobalData sharedGlobalData].currentScrollView;
    
    UIView *sub = [[UIView alloc]init];
    sub = [[scrollview1 subviews] objectAtIndex:0] ;
    
    NSLog(@"Count content view subviews %d",[[sub subviews]count]);
    
    for (int i = 1; i < [[sub subviews] count]; i++ ) {
        UIView *aView = [[sub subviews] objectAtIndex:i];
        [aView removeFromSuperview];
        NSLog(@"remove %d", i);
    }
    
    
    
    CGSize pageSize1 = scrollview1.frame.size;
    UIGraphicsBeginImageContext(pageSize1);
    CGContextRef resizedContext1 = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(resizedContext1, -scrollview1.contentOffset.x, -scrollview1.contentOffset.y);
    [scrollview1.layer renderInContext:resizedContext1];
    UIImage *p1 = UIGraphicsGetImageFromCurrentImageContext();
    NSLog(@"GENERATED IMAGE W-H %3.0f, %3.0f", p1.size.width,p1.size.height);
    UIGraphicsEndImageContext();
    
    UIImageView *photoView1 = [[UIImageView alloc]initWithImage:p1];
    photoView1.frame = CGRectMake(0, 0, p1.size.width, p1.size.height);
    
    
    contentView = [[UIView alloc]initWithFrame: photoView1.frame]; 
    [contentView setCenter:CGPointMake(CGRectGetMidX([self.view bounds]), CGRectGetMidY([self.view bounds])-100)];
    contentView.backgroundColor = [UIColor greenColor];
    [contentView addSubview:photoView1];
    
    for (UIImageView *s in [GlobalData sharedGlobalData].stickersArray) {
        s.frame = CGRectMake(s.frame.origin.x, s.frame.origin.y, s.frame.size.width, s.frame.size.height);
        [contentView addSubview:s];
        [s release];
    }
    
    
    [self.view addSubview:contentView];
    
    UIScrollView *effectsScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 340, 320, 80)];
    effectsScrollView.backgroundColor = [UIColor grayColor];
    effectsScrollView.contentSize = CGSizeMake(500, 80);
    effectsScrollView.showsHorizontalScrollIndicator = YES;
    
    sticker1 = [UIImage imageNamed:@"spongebob.png"];
    UIImageView *stickerView1 = [[UIImageView alloc]initWithImage:sticker1];
    stickerView1.frame = CGRectMake(0, 10, 50,50);
    stickerView1.tag = 1;
    stickerView1.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured: )];
    [stickerView1 addGestureRecognizer:singleTap1]; 
    [singleTap1 release];
    [effectsScrollView addSubview:stickerView1];
    
    sticker2 = [UIImage imageNamed:@"bunny.png"];
    UIImageView *stickerView2 = [[UIImageView alloc]initWithImage:sticker2];
    stickerView2.frame = CGRectMake(60, 10, 50,50);
    stickerView2.tag = 2;
    stickerView2.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured: )];
    [stickerView2 addGestureRecognizer:singleTap2]; 
    [singleTap2 release];
    [effectsScrollView addSubview:stickerView2];
    
    sticker3 = [UIImage imageNamed:@"heart.png"];
    UIImageView *stickerView3 = [[UIImageView alloc]initWithImage:sticker3];
    stickerView3.frame = CGRectMake(120, 10, 50,50);
    stickerView3.tag = 3;
    stickerView3.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured: )];
    [stickerView3 addGestureRecognizer:singleTap3]; 
    [singleTap3 release];
    [effectsScrollView addSubview:stickerView3];
    
    sticker4 = [UIImage imageNamed:@"star.png"];
    UIImageView *stickerView4 = [[UIImageView alloc]initWithImage:sticker4];
    stickerView4.frame = CGRectMake(180, 10, 50,50);
    stickerView4.tag = 4;
    stickerView4.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured: )];
    [stickerView4 addGestureRecognizer:singleTap4]; 
    [singleTap4 release];
    [effectsScrollView addSubview:stickerView4];
    
    [self.view addSubview:effectsScrollView];
    [self.view sendSubviewToBack:effectsScrollView];
    
    [effectsScrollView release];
    
}

#pragma mark -
#pragma mark Touches & Moves Delegate
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    UIView *sub = [[UIView alloc]init];
    sub = contentView; //[[self subviews] objectAtIndex:0] ;
    
    //NSLog(@"Count content view subviews %d",[[sub subviews]count]);
    sub.backgroundColor = [UIColor greenColor];
    for (int i = 1; i < [[sub subviews] count]; i++ ) {
        UIImageView *aView = [[sub subviews] objectAtIndex:i];
        
        if (CGRectContainsPoint([aView frame], [touch locationInView:sub])) {
            //aView.center = location;
            sticker = aView;
        }
    }
	NSLog(@"sticker tag %d", sticker.tag);
    // If double tap remove sticker
    if ([touch tapCount] == 2) {
        [sticker removeFromSuperview];
        [[GlobalData sharedGlobalData].stickersArray removeObjectIdenticalTo:sticker];
    } else {
    
        NSArray *allTouches = [touches allObjects];
        
        UITouch* t;
        if([[event allTouches] count]==1){
            if (CGRectContainsPoint([sticker frame], [[allTouches objectAtIndex:0] locationInView:contentView])) {
                t=[[[event allTouches] allObjects] objectAtIndex:0];
                touch1=[t locationInView:nil];
            }
        }else{
            t=[[[event allTouches] allObjects] objectAtIndex:0];
            touch1=[t locationInView:nil];
            t=[[[event allTouches] allObjects] objectAtIndex:1];
            touch2=[t locationInView:nil];
        }
    }
}

-(double)distance:(CGPoint)point1 toPoint:(CGPoint)point2
{
	double deltaX, deltaY;
	deltaX = point1.x - point2.x;
	deltaY = point1.y - point2.y;
	return sqrt(deltaX * deltaX + deltaY * deltaY);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	
	CGPoint currentTouch1;
	CGPoint currentTouch2;
	NSArray *allTouches = [touches allObjects];
	UITouch* t;
	float scale;
    //float rotation;
	
	if([[event allTouches] count]==1){
		t=[[[event allTouches] allObjects] objectAtIndex:0];
		if (CGRectContainsPoint([sticker frame], [[allTouches objectAtIndex:0] locationInView:contentView]) )
		{ 
			touch2=[t locationInView:nil];
			sticker.center=CGPointMake(sticker.center.x+touch2.x-touch1.x,sticker.center.y+touch2.y-touch1.y);
			touch1=touch2;
		}
	}
	else if([[event allTouches] count]==2)
	{
		t=[[[event allTouches] allObjects] objectAtIndex:0];
		currentTouch1=[t locationInView:nil];
		
		t=[[[event allTouches] allObjects] objectAtIndex:1];
		currentTouch2=[t locationInView:nil];
		
		double distance1 =  [self distance:currentTouch1 toPoint:currentTouch2];
		double distance2 = [self distance:touch1 toPoint:touch2];
		
		if (distance2 == 0)
		{
			//handle the case where distance is zero
		}
		else {
			scale =distance1 / distance2;}
        
		//rotation=atan2(currentTouch2.y-currentTouch1.y, currentTouch2.x-currentTouch1.x)-atan2(touch2.y-touch1.y,touch2.x-touch1.x);
		if(isnan(scale)){
			scale=1.0f;
		}
		//NSLog(@"rotation %f",rotation);
		
		NSLog(@"scale %f",scale);
		
		if (CGRectContainsPoint([sticker frame], [[allTouches objectAtIndex:0] locationInView:contentView]))
		{
			
			sticker.transform=CGAffineTransformScale(sticker.transform, scale,scale);
			//sticker.transform=CGAffineTransformRotate(sticker.transform, rotation);
			
		}
		else // In case of scaling or rotating the background imageView
		{
			sticker.transform=CGAffineTransformScale(sticker.transform, scale,scale);
			//sticker.transform=CGAffineTransformRotate(sticker.transform, rotation);
		}
		
		touch1=currentTouch1;
		touch2=currentTouch2;
	}
}


/*
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    / *UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:imageScrollView];
    contentView.center = location;
    * /
    
    UITouch *touch = [[event allTouches] anyObject];
    NSLog(@"TouchVIEW IS A %@",touch.view);
    //CGPoint location = [touch locationInView:touch.view];
    CGPoint location = [touch locationInView:contentView];
    
    UIView *sub = [[UIView alloc]init];
    sub = contentView; //[[self subviews] objectAtIndex:0] ;
    
    NSLog(@"Count content view subviews %d",[[sub subviews]count]);
    sub.backgroundColor = [UIColor greenColor];
    for (int i = 1; i < [[sub subviews] count]; i++ ) {
        UIView *aView = [[sub subviews] objectAtIndex:i];
        
        if (CGRectContainsPoint([aView frame], [touch locationInView:sub])) {
            aView.center = location;
        }
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self touchesBegan:touches withEvent:event];
    NSLog(@"touched!");
}
*/
- (void) dealloc {
    [super dealloc];
}
@end
