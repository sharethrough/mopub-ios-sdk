//
//  SharethroughNativeAdAdapter.m
//  MoPubSDK
//
//  Created by Mark Meyer on 6/3/15.
//  Copyright (c) 2015 MoPub. All rights reserved.
//

#import <SharethroughSDK/SharethroughSDK.h>
#import "SharethroughNativeAdAdapter.h"
#import "MPNativeAdConstants.h"

@interface SharethroughNativeAdAdapter ()

@property (nonatomic, readonly, strong) STRAdvertisement *strAd;

@end

@implementation SharethroughNativeAdAdapter

@synthesize properties = _properties;

- (instancetype)initWithSharethroughNativeAd:(STRAdvertisement *)strAd {
    if (self = [super init]) {
        _strAd = strAd;
    }

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

- (void)displayContentForURL:(NSURL *)URL rootViewController:(UIViewController *)controller completion:(void (^)(BOOL, NSError *))completionBlock {
    //TODO

}

- (void)trackClick {
    //TODO

}

- (void)trackImpression {
    //TODO
}

//- (void)willAttachToView:(UIView *)view {}
//- (void)didDetachFromView:(UIView *)view{}

@end
