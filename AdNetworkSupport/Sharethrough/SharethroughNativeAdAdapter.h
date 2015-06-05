//
//  SharethroughNativeAdAdapter.h
//  MoPubSDK
//
//  Copyright (c) 2015 MoPub. All rights reserved.
//

#if __has_include(<MoPub/MoPub.h>)
#import <MoPub/MoPub.h>
#else
#import "MPNativeAdAdapter.h"
#endif

@class STRAdvertisement;

@interface SharethroughNativeAdAdapter : NSObject <MPNativeAdAdapter>

@property (nonatomic, weak) id<MPNativeAdAdapterDelegate> delegate;

- (instancetype)initWithSharethroughNativeAd:(STRAdvertisement *)strAd;

@end
