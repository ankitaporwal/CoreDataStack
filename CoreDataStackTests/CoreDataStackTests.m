//
//  CoreDataStackTests.m
//  CoreDataStackTests
//
//  Created by Menno Wildeboer on 28/12/13.
//  Copyright (c) 2013 Menno. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CoreData+Stack.h"
#import "Person.h"
#import "Crap.h"

@interface CoreDataStackTests : XCTestCase

@property (nonatomic, strong) CoreDataStack *stack;

@end

@implementation CoreDataStackTests

- (void)setUp
{
    _stack = [CoreDataStack stackWithIdentifier:@"Person"];
    _stack.modelBundle = [NSBundle bundleForClass:[Person class]];

    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}


- (void)test1
{
    Person *person = [Person findOrCreateWithID:@1];
    person.personID = @1;
    person.name = @"Piet";
    person.age = @54;
    [person save];
    
    XCTAssertNotNil(person);
}

- (void)test2
{
    Person *person = [Person findWithID:@1];
    
    XCTAssertNotNil(person);
    XCTAssertTrue([person.name isEqualToString:@"Piet"]);
}

- (void)test3
{
    Person *person = [Person findOrCreateWithID:@2];
    person.personID = @2;
    person.name = @"Klaas";
    person.age = @58;

    [_stack.managedObjectContext saveWithTypeAndWait:NSSaveSelfAndParent];
    
    Person *test = [Person find:^(id<NSFetchRequestBuilder> builder) {
        [builder setManagedObjectContext:_stack.rootManagedObjectContext];
        [builder where:@{ @"personID" : @2 }];
    }];
    
    XCTAssertNotNil(test);
    XCTAssertTrue([test.name isEqualToString:@"Klaas"]);
}

- (void)test4
{
    Person *person = [Person findOrCreateWithID:@3];
    person.personID = @3;
    person.name = @"Kees";
    person.age = @68;
}

- (void)test5
{
    Person *person = [Person findOrCreateWithID:@4];
    person.personID = @4;
    person.name = @"Klaas";
    person.age = @28;
    
    NSUInteger count = [Person count:^(id<NSFetchRequestBuilder> builder) {
        [builder where:@{ @"name"  : @"Klaas" }];
    }];
    XCTAssertTrue(count == 2);
}

@end
