//
//  ViewController.m
//  PusherTest
//
//  Created by Rusznyák Gábor on 26/09/2013.
//  Copyright (c) 2013 Sunflower Software Management Kft. All rights reserved.
//

#import "ViewController.h"
#import "PTPusherChannel.h"
#import "PTPusherEvent.h"
#import "Functions.h"
#import "View.h"
#import "AudioStreamer.h"
#import "String.h"
#import <Social/Social.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - Lifecycle

- (void)viewDidUnload {
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
    [super viewDidUnload];
}

- (IBAction)share:(id)sender {
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:[@"The music what I am now listening: " addString:label.text]];
        [self presentViewController:controller animated:YES completion:Nil];
    }
}

- (void)remoteControlReceivedWithEvent: (UIEvent *) receivedEvent {
    if (receivedEvent.type == UIEventTypeRemoteControl) {
        switch (receivedEvent.subtype) {
            case UIEventSubtypeRemoteControlTogglePlayPause:
                [self playStop:self];
                break;
            default:
                break;
        }
    }
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    float height=self.view.height;
    [_volumeView setFrame:CGRectMake(55, height-75, 210, 23)];
    client = [PTPusher pusherWithKey:@"dd7455c6cd1386091bc7" delegate:self encrypted:NO];
    PTPusherChannel *channel = [client subscribeToChannelNamed:@"my_channel"];
    [channel bindToEventNamed:@"my_event" handleWithBlock:^(PTPusherEvent *channelEvent) {
        // do something with channel event
        [label setText:[channelEvent.data replace:@"\"" with:@""]];
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:NULL];
    [[AVAudioSession sharedInstance] setActive:YES error:NULL];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
    
    _volumeView=[[MPVolumeView alloc] initWithFrame:CGRectMake(55, 385, 210, 23)];
    [_volumeView setMaximumVolumeSliderImage:[UIImage imageNamed:@"progressBarUnfilled.png"] forState:0];
    [_volumeView setMinimumVolumeSliderImage:[UIImage imageNamed:@"progressBarFilled.png"] forState:0];
    [_volumeView setVolumeThumbImage:[UIImage imageNamed:@"progressBarButton.png"] forState:0];
    [self.view addSubview: _volumeView];
    
    [self createStreamer];
    playing=NO;
}

- (IBAction)playStop:(id)sender {
    if (playing) {
        [play setBackgroundImage:[UIImage imageNamed:@"playButton.png"] forState:UIControlStateNormal];
        [streamer stop];
        onair.selected=NO;
    } else {
        if ([Functions loadStringFromURL:@"http://stream.musicfm.hu"]) {
            [play setBackgroundImage:[UIImage imageNamed:@"stopButton.png"] forState:UIControlStateNormal];
            radioIndyView.hidden=NO;
            [streamer start];
        } else {
            [Functions alert:@"We can not connect to media server!"];
        }
    }
    playing=!playing;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Streamer

- (void)destroyStreamer
{
	if (streamer)
	{
		[[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:ASStatusChangedNotification
                                                      object:streamer];
		[progressUpdateTimer invalidate];
		progressUpdateTimer = nil;
		[streamer stop];
		streamer = nil;
	}
}

- (void)createStreamer
{
	if (streamer) {
		return;
	}
	[self destroyStreamer];
	NSURL *url = [NSURL URLWithString:@"http://stream.musicfm.hu:8000/musicfm.mp3"];
	streamer = [[AudioStreamer alloc] initWithURL:url];
	progressUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                           target:self
                                                         selector:@selector(updateProgress:)
                                                         userInfo:nil
                                                          repeats:YES];
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playbackStateChanged:)
                                                 name:ASStatusChangedNotification
                                               object:streamer];
}

- (void)playbackStateChanged:(NSNotification *)aNotification
{
	if ([streamer isWaiting]) {
        onair.selected=NO;
	} else if ([streamer isPlaying]) {
        radioIndyView.hidden=YES;
        onair.selected=YES;
	} else if ([streamer isIdle]) {
        onair.selected=NO;
	}
}

- (void)updateProgress:(NSTimer *)updatedTimer {
    //Check volume
    Float32 volume;
    UInt32 dataSize = sizeof(Float32);
    AudioSessionGetProperty (kAudioSessionProperty_CurrentHardwareOutputVolume,
                             &dataSize,
                             &volume);
}

@end
