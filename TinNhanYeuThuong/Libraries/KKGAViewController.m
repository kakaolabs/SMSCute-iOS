//
//  KKGAViewController.m
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 2/5/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import "GADAdMobExtras.h"
#import "KKGAViewController.h"

@implementation KKGAViewController

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.screenName = NSStringFromClass([self class]);
}


- (void) setUpBannerView
{
    // Create a view of the standard size at the top of the screen.
    // Available AdSize constants are explained in GADAdSize.h.
    bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    CGSize winSize = [[UIScreen mainScreen] bounds].size;
    CGSize bannerSize = bannerView.frame.size;
    bannerView.frame = CGRectMake(0, winSize.height - bannerSize.height, bannerSize.width, bannerSize.height);
    
    // Specify the ad unit ID.
    bannerView.adUnitID = ADMOD_ID;
    
    // Let the runtime know which UIViewController to restore after taking
    // the user wherever the ad goes and add it to the view hierarchy.
    bannerView.rootViewController = self;
    [self.view addSubview:bannerView];
    bannerView.layer.zPosition = 1000.0;
    
    // Initiate a generic request to load it with an ad.
    GADRequest *request = [GADRequest request];
    [request setTesting:YES];
    
    GADAdMobExtras *extras = [[GADAdMobExtras alloc] init];
    extras.additionalParameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                         @"144963", @"color_bg",
                                         nil];
    [request registerAdNetworkExtras:extras];
    
    [bannerView loadRequest:request];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self setUpBannerView];
    self.screenName = NSStringFromClass([self class]);
}

@end
