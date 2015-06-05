//
//  SharethroughNativeAdAdapter.m
//  MoPubSDK
//
//  Created by Mark Meyer on 6/3/15.
//  Copyright (c) 2015 MoPub. All rights reserved.
//

#import <SharethroughSDK/SharethroughSDK.h>
#import <SharethroughSDK/STRAdvertisementDelegate.h>
#import "SharethroughNativeAdAdapter.h"
#import "MPLogging.h"
#import "MPNativeAdConstants.h"

@interface SharethroughNativeAdAdapter () <STRAdvertisementDelegate>

@property (nonatomic, readonly, strong) STRAdvertisement *strAd;

@end

@implementation SharethroughNativeAdAdapter

@synthesize properties = _properties;

- (instancetype)initWithSharethroughNativeAd:(STRAdvertisement *)strAd {
    if (self = [super init]) {
        _strAd = strAd;
        _strAd.delegate = self;

        NSMutableDictionary *properties = [NSMutableDictionary dictionary];

        if (strAd.title) {
            [properties setObject:strAd.title forKey:kAdTitleKey];
        }

        if (strAd.description) {
            [properties setObject:strAd.description forKey:kAdTextKey];
        }

        if (strAd.thumbnailURL.absoluteString) {
            [properties setObject:strAd.thumbnailURL.absoluteString forKey:kAdMainImageKey];
        }

        if (strAd.placementKey) {
            [properties setObject:strAd.placementKey forKey:@"placementKey"];
        }

        _properties = properties;
    }

    return self;
}

#pragma mark - MPNativeAdAdapter

- (NSTimeInterval)requiredSecondsForImpression
{
    return 1.0;
}

- (NSURL *)defaultActionURL
{
    return nil;
}

- (BOOL)enableThirdPartyImpressionTracking
{
    return YES;
}

- (BOOL)enableThirdPartyClickTracking
{
    return YES;
}

- (void)willAttachToView:(UIView *)view {
    [self.strAd registerViewForInteraction:view withViewController:[self.delegate viewControllerForPresentingModalView]];
}

- (void)didDetachFromView:(UIView *)view{
    [self.strAd unregisterView:view];
}

#pragma mark - STRAdvertisementDelegate
- (void)adWillLogImpression:(STRAdvertisement *)StrAd {
    if ([self.delegate respondsToSelector:@selector(nativeAdWillLogImpression:)]) {
        [self.delegate nativeAdWillLogImpression:self];
    } else {
        MPLogWarn(@"Delegate does not implement impression tracking callback. Impressions likely not being tracked.");
    }
}

- (void)adDidClick:(STRAdvertisement *)StrAd {
    if ([self.delegate respondsToSelector:@selector(nativeAdDidClick:)]) {
        [self.delegate nativeAdDidClick:self];
    } else {
        MPLogWarn(@"Delegate does not implement click tracking callback. Clicks likely not being tracked.");
    }
}
@end
