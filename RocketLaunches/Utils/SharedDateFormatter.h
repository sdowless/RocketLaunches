//
//  SharedDateFormatter.h
//  RocketLaunches
//
//  Created by Stephen Dowless on 1/31/20.
//  Copyright © 2020 Stephan Dowless. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface SharedDateFormatter: NSObject

+ (SharedDateFormatter *) shared;

@property (readonly) NSDateFormatter * shortDateFormatter;

@end

NS_ASSUME_NONNULL_END


