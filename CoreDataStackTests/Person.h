//
//  Person.h
//  CoreDataStack
//
//  Created by Menno Wildeboer on 28/12/13.
//  Copyright (c) 2013 Menno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSManagedObject+Import.h"

@interface Person : NSManagedObject <NSImportable>

@property (nonatomic, retain) NSNumber *personID;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSNumber *age;

+ (void)setAllowsDeletion:(BOOL)allowsDeletion;

@end
