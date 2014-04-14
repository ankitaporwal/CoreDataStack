//
//  Person.m
//  CoreDataStack
//
//  Created by Menno Wildeboer on 28/12/13.
//  Copyright (c) 2013 Menno. All rights reserved.
//

#import "Person.h"
#import "CoreData+Stack.h"

@implementation Person

@dynamic personID;
@dynamic name;
@dynamic age;

+ (instancetype)findWithID:(NSNumber *)personID
{
    return [self find:^(id<NSFetchRequestBuilder> builder) {
        [builder where:@{ @"personID" : personID }];
    }];
}

+ (instancetype)findOrCreateWithID:(NSNumber *)personID
{
    return [self findOrCreate:^(id<NSFetchRequestBuilder> builder) {
        [builder where:@{ @"personID" : personID }];
    }];
}

@end
