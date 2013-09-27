//
//  ViewController.h
//  PusherTest
//
//  Created by Rusznyák Gábor on 26/09/2013.
//  Copyright (c) 2013 Sunflower Software Management Kft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTPusher.h"
#import <MediaPlayer/MediaPlayer.h>
#import "AudioStreamer.h"

@interface ViewController : UIViewController <PTPusherDelegate> {
    PTPusher *client;
    IBOutlet UIButton *play, *onair;
    IBOutlet UILabel *label;
    IBOutlet UIView *radioIndyView;
	AudioStreamer *streamer;
	NSTimer *progressUpdateTimer;
    bool playing;
}

@property (strong, nonatomic) MPVolumeView *volumeView;

@end
