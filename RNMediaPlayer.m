//
//  RNMediaPlayer.m
//  RNMediaPlayer
//
//  Created by Chris Elly on 2015.07.12
//

#import "RNMediaPlayer.h"
#import "React/RCTLog.h"
#import "React/RCTConvert.h"

#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@implementation RNMediaPlayer
{
  AVPlayer *_player;
  AVPlayerViewController *_playerViewcontroller;

  NSString *_uri;
}


RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(open:(NSDictionary *)options)
{
  // this method can receive the following options
  //
  // uri: STRING (full resource name with file extension)
  //
  // missing: option to disable autoplay

  _uri = [options objectForKey:@"uri"];
  NSString *encodedString = [_uri stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  NSURL *fileURL = [[NSURL alloc] initWithString:encodedString];

  dispatch_async(dispatch_get_main_queue(), ^{

    AVPlayerViewController *playerViewController = [[AVPlayerViewController alloc] init];

    playerViewController.player = [AVPlayer playerWithURL:fileURL];

    // autoplay
    [playerViewController.player play];

    _playerViewcontroller = playerViewController;

    UIViewController *ctrl = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    UIView *view = [ctrl view];

    view.window.windowLevel = UIWindowLevelStatusBar;

    [ctrl presentViewController:playerViewController animated:TRUE completion: nil];

  });
}

@end
