//
//  SharedDateFormatter.m
//  RocketLaunches
//
//  Created by Stephen Dowless on 1/31/20.
//  Copyright © 2020 Stephan Dowless. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SharedDateFormatter.h"

@implementation SharedDateFormatter

static SharedDateFormatter * shared;

+ (void) initialize {
    shared = [SharedDateFormatter new];
}

+ (SharedDateFormatter *) shared {
    return shared;
}

- (NSDateFormatter *) shortDateFormatter {
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle: NSDateFormatterShortStyle];
    [formatter setTimeStyle: NSDateFormatterShortStyle];
    
    return formatter;
}

@end
