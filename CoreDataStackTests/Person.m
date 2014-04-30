//
//  Person.m
//  CoreDataStack
//
//  Created by Menno Wildeboer on 28/12/13.
//  Copyright (c) 2013 Menno. All rights reserved.
//

#import "Person.h"
#import "CoreData+Stack.h"

static BOOL kAllowDeletion = NO;

@implementation Person

@dynamic personID;
@dynamic name;
@dynamic age;

+ (void)setAllowsDeletion:(BOOL)allowsDeletion
{
    kAllowDeletion = allowsDeletion;
}

@end
