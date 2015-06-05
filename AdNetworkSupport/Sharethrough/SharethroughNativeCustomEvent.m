//
//  SharethroughNativeCustomEvent.m
//  MoPubSDK
//
//  Created by Mark Meyer on 6/3/15.
//  Copyright (c) 2015 MoPub. All rights reserved.
//

#import <SharethroughSDK/SharethroughSDK.h>
#import "MPLogging.h"
#import "SharethroughNativeCustomEvent.h"
#import "SharethroughNativeAdAdapter.h"

@interface SharethroughNativeCustomEvent () <STRAdViewDelegate>

@property (nonatomic, readwrite, strong) STRAdvertisement *strAd;

@end

@implementation SharethroughNativeCustomEvent

- (void)requestAdWithCustomEventInfo:(NSDictionary *)info {
    NSString *placementKey = [info objectForKey:@"placement_key"];

    if (placementKey) {
        [[SharethroughSDK sharedInstance] prefetchAdForPlacementKey:placementKey delegate:self];
    } else {
        [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:[NSError errorWithDomain:MoPubNativeAdsSDKDomain code:MPNativeAdErrorInvalidServerResponse userInfo:nil]];
    }
}

#pragma mark - STRAdViewDelegate

- (void)didPrefetchAdvertisement:(STRAdvertisement *)strAd {
    SharethroughNativeAdAdapter *adAdapter = [[SharethroughNativeAdAdapter alloc] initWithSharethroughNativeAd:strAd];
    MPNativeAd *interfaceAd = [[MPNativeAd alloc] initWithAdAdapter:adAdapter];
    NSMutableArray *imageURLs = [NSMutableArray array];

    if (strAd.thumbnailURL) {
        [imageURLs addObject:strAd.thumbnailURL];
    }

    [super precacheImagesWithURLs:imageURLs completionBlock:^(NSArray *errors) {
        if (errors) {
            MPLogDebug(@"%@", errors);
            MPLogInfo(@"Error: data received was invalid.");
            [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:[NSError errorWithDomain:MoPubNativeAdsSDKDomain code:MPNativeAdErrorInvalidServerResponse userInfo:nil]];
        } else {
            [self.delegate nativeCustomEvent:self didLoadAd:interfaceAd];
        }
    }];
}

- (void)didFailToPrefetchForPlacementKey:(NSString *)placementKey {
    [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:[NSError errorWithDomain:MoPubNativeAdsSDKDomain code:MPNativeAdErrorNoInventory userInfo:nil]];
}

@end
