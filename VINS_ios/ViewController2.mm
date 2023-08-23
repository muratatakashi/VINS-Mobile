//
//  ViewController2.m
//  VINS_ios
//
//  Created by HKUST Aerial Robotics on 2016/10/18.
//  Copyright © 2017 HKUST Aerial Robotics. All rights reserved.
//

#import "ViewController2.h"
#import "CameraUtils.h"

@interface ViewController2 ()

@end

@implementation ViewController2

/*************************** Save data for debug ***************************/

// Used for show VINS trajectory and AR
@synthesize imageView;

@synthesize videoCamera;


// MARK: ViewController Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*******************************************Camera setup*******************************************/
    self.videoCamera = [[CvVideoCamera alloc]
                        initWithParentView:imageView];
    
    self.videoCamera.delegate = self;
    self.videoCamera.defaultAVCaptureDevicePosition =
    AVCaptureDevicePositionBack;
    
    self.videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    self.videoCamera.defaultAVCaptureSessionPreset =
    AVCaptureSessionPreset640x480;
#ifdef DATA_EXPORT
    self.videoCamera.defaultFPS = 1;
#else
    self.videoCamera.defaultFPS = 30;
#endif
    
    [CameraUtils setExposureOffset: -1.0f];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [videoCamera start];
    });
}

- (void)processImage:(cv::Mat&)image
{
}


/***********************************************************About record and playback data for debug********************************************************/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**************************************************************About record and playback data for debug**********************************************************/

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [videoCamera stop];
}

-(void)viewDidUnload{
    [super viewDidUnload];
}

- (void)dealloc
{
    videoCamera.delegate = nil;
}

@end
