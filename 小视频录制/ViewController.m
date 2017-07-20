//
//  ViewController.m
//  小视频录制
//
//  Created by mac on 16/10/13.
//  Copyright © 2016年 沸腾医疗. All rights reserved.
//

#import "ViewController.h"
#import "KZVideoViewController.h"
#import "KZVideoPlayer.h"
@interface ViewController ()<KZVideoViewControllerDelegate>
{
    KZVideoModel *_videoModel;
}
@property (weak, nonatomic) IBOutlet UILabel *sizeLable;
@property (weak, nonatomic) IBOutlet UIView *videoView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)startRecord:(id)sender {
    
    KZVideoViewController *videoVC = [[KZVideoViewController alloc] init];
    videoVC.delegate = self;
    [videoVC startAnimationWithType:KZVideoViewShowTypeSmall];
}
- (void)videoViewController:(KZVideoViewController *)videoController didRecordVideo:(KZVideoModel *)videoModel {
    _videoModel = videoModel;
    NSError *error = nil;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSDictionary *attri = [fm attributesOfItemAtPath:_videoModel.videoAbsolutePath error:&error];
    if (error) {
        NSLog(@"error:%@",error);
    }
    else {
        self.sizeLable.text = [NSString stringWithFormat:@"视频总大小:%.0fKB",attri.fileSize/1024.0];
    }
    NSURL *videoUrl = [NSURL fileURLWithPath:_videoModel.videoAbsolutePath];
    KZVideoPlayer *player = [[KZVideoPlayer alloc] initWithFrame:self.videoView.bounds videoUrl:videoUrl];
    [self.videoView addSubview:player];
    
}
- (void)videoViewControllerDidCancel:(KZVideoViewController *)videoController {
    NSLog(@"没有录到视频");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
