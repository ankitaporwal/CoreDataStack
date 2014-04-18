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
@property (nonatomic, strong) NSManagedObjectImporter *importer;

@end

@implementation CoreDataStackTests

- (void)setUp
{
    _stack = [CoreDataStack stackWithStoreNamed:@"Person" identifier:@"main"];
    _stack.modelBundle = [NSBundle bundleForClass:[Person class]];

    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}


- (void)test1
{
    Person *person = [[Person findBy:@{ @"personID": @1 }] createIfNotExists];
    person.personID = @1;
    person.name = @"Piet";
    person.age = @54;
    [person save];
    
    XCTAssertNotNil(person);
}

- (void)test2
{
    Person *person = [[Person findBy:@{ @"personID": @1 }] object];
    
    XCTAssertNotNil(person);
    XCTAssertTrue([person.name isEqualToString:@"Piet"]);
}

- (void)test3
{
    Person *person = [[Person findBy:@{ @"personID": @2 }] createIfNotExists];
    person.personID = @2;
    person.name = @"Klaas";
    person.age = @58;

    [_stack.managedObjectContext saveWithTypeAndWait:NSSaveSelfAndParent];
    
    Person *test = [[Person findBy:@{ @"personID": @2 } inContext:_stack.rootManagedObjectContext] object];
    XCTAssertNotNil(test);
    XCTAssertTrue([test.name isEqualToString:@"Klaas"]);
}

- (void)test4
{
    Person *person = [[Person findBy:@{ @"personID": @3 }] createIfNotExists];
    person.personID = @3;
    person.name = @"Klaas";
    person.age = @28;
    
    NSUInteger count = [[Person findBy:@{ @"name": @"Klaas" }] count];
    XCTAssertTrue(count == 2);
}

- (void)test5
{
    NSDictionary *group = [[Person all] groupBy:@"name"];
    
    NSUInteger countForKlaas = [group[@"Klaas"] count];
    NSUInteger countForPiet = [group[@"Piet"] count];

    XCTAssertTrue(countForKlaas == 2);
    XCTAssertTrue(countForPiet == 1);
}

- (void)test6
{
    NSString *json = @"[{\"about\": \"Take PAUSE and enjoy the best songs, videos, albums and charts along with  the best music writing of Q1, 2014.\", \"assets\": [{\"width\": 1536, \"url\": \"https://d2pdfwfdhlv7he.cloudfront.net/assets/1176/tuutgigecgbx.jpg\", \"created_at\": \"2014-04-15T11:25:18\", \"parent_type\": \"Issue\", \"updated_at\": \"2014-04-15T11:25:18\", \"height\": 2048, \"parent_id\": 10, \"key\": \"assets/1176/tuutgigecgbx.jpg\", \"id\": 1176}, {\"width\": 1536, \"url\": \"https://d2pdfwfdhlv7he.cloudfront.net/assets/1175/oppybyqsnttr.jpg\", \"created_at\": \"2014-04-10T13:01:41\", \"parent_type\": \"Issue\", \"updated_at\": \"2014-04-10T13:01:41\", \"height\": 2048, \"parent_id\": 10, \"key\": \"assets/1175/oppybyqsnttr.jpg\", \"id\": 1175}, {\"width\": 3840, \"url\": \"https://d2pdfwfdhlv7he.cloudfront.net/assets/1093/xjefolaumkcx.jpg\", \"created_at\": \"2014-04-08T15:49:10\", \"parent_type\": \"Issue\", \"updated_at\": \"2014-04-08T15:49:10\", \"height\": 5760, \"parent_id\": 10, \"key\": \"assets/1093/xjefolaumkcx.jpg\", \"id\": 1093}, {\"width\": 1536, \"url\": \"https://d2pdfwfdhlv7he.cloudfront.net/assets/991/vnbgmfxeugzc.jpg\", \"created_at\": \"2014-04-03T14:12:38\", \"parent_type\": \"Issue\", \"updated_at\": \"2014-04-03T14:12:38\", \"height\": 2048, \"parent_id\": 10, \"key\": \"assets/991/vnbgmfxeugzc.jpg\", \"id\": 991}, {\"width\": 1536, \"url\": \"https://d2pdfwfdhlv7he.cloudfront.net/assets/814/dpkhikrxrdee.jpg\", \"created_at\": \"2014-03-28T09:59:30\", \"parent_type\": \"Issue\", \"updated_at\": \"2014-03-28T09:59:30\", \"height\": 2048, \"parent_id\": 10, \"key\": \"assets/814/dpkhikrxrdee.jpg\", \"id\": 814}, {\"width\": 1536, \"url\": \"https://d2pdfwfdhlv7he.cloudfront.net/assets/291/xlgeeqfwarbs.jpg\", \"created_at\": \"2014-03-27T11:28:20\", \"parent_type\": \"Issue\", \"updated_at\": \"2014-03-27T11:28:20\", \"height\": 2048, \"parent_id\": 10, \"key\": \"assets/291/xlgeeqfwarbs.jpg\", \"id\": 291}, {\"width\": 648, \"url\": \"https://d2pdfwfdhlv7he.cloudfront.net/assets/60/rbyxmtictoja.jpg\", \"created_at\": \"2014-03-18T11:33:22\", \"parent_type\": \"Issue\", \"updated_at\": \"2014-03-18T11:33:22\", \"height\": 864, \"parent_id\": 10, \"key\": \"assets/60/rbyxmtictoja.jpg\", \"id\": 60}, {\"width\": 512, \"url\": \"https://d2pdfwfdhlv7he.cloudfront.net/assets/59/sanonaswzjjg.jpg\", \"created_at\": \"2014-03-14T10:14:37\", \"parent_type\": \"Issue\", \"updated_at\": \"2014-03-14T10:14:37\", \"height\": 768, \"parent_id\": 10, \"key\": \"assets/59/sanonaswzjjg.jpg\", \"id\": 59}, {\"width\": 2448, \"url\": \"https://d2pdfwfdhlv7he.cloudfront.net/assets/6/fjdbljjihhdh.jpg\", \"created_at\": \"2014-03-11T10:01:39\", \"parent_type\": \"Issue\", \"updated_at\": \"2014-03-11T10:01:39\", \"height\": 2448, \"parent_id\": 10, \"key\": \"assets/6/fjdbljjihhdh.jpg\", \"id\": 6}], \"title\": \"Q1 2014\", \"created_at\": \"2014-03-11T09:40:42\", \"updated_at\": \"2014-04-16T14:12:35\", \"state\": \"public\", \"position\": 1, \"id\": 10}, {\"about\": \"Take PAUSE and enjoy the best songs, videos, albums and charts along with  the best music writing of 2013\", \"assets\": [{\"width\": 1536, \"url\": \"https://d2pdfwfdhlv7he.cloudfront.net/assets/992/paoyqnandbaz.jpg\", \"created_at\": \"2014-04-03T14:12:51\", \"parent_type\": \"Issue\", \"updated_at\": \"2014-04-03T14:12:51\", \"height\": 2048, \"parent_id\": 15, \"key\": \"assets/992/paoyqnandbaz.jpg\", \"id\": 992}, {\"width\": 1536, \"url\": \"https://d2pdfwfdhlv7he.cloudfront.net/assets/815/vrqutwjrunlb.jpg\", \"created_at\": \"2014-03-28T10:01:12\", \"parent_type\": \"Issue\", \"updated_at\": \"2014-03-28T10:01:12\", \"height\": 2048, \"parent_id\": 15, \"key\": \"assets/815/vrqutwjrunlb.jpg\", \"id\": 815}, {\"width\": 1536, \"url\": \"https://d2pdfwfdhlv7he.cloudfront.net/assets/813/wtnicmyomunu.jpg\", \"created_at\": \"2014-03-28T09:59:05\", \"parent_type\": \"Issue\", \"updated_at\": \"2014-03-28T09:59:05\", \"height\": 2048, \"parent_id\": 15, \"key\": \"assets/813/wtnicmyomunu.jpg\", \"id\": 813}, {\"width\": 362, \"url\": \"https://d2pdfwfdhlv7he.cloudfront.net/assets/294/ijdxhqthxrmv.jpg\", \"created_at\": \"2014-03-27T15:42:10\", \"parent_type\": \"Issue\", \"updated_at\": \"2014-03-27T15:42:10\", \"height\": 512, \"parent_id\": 15, \"key\": \"assets/294/ijdxhqthxrmv.jpg\", \"id\": 294}], \"title\": \"Best of 2013\", \"created_at\": \"2014-03-27T15:42:09\", \"updated_at\": \"2014-04-03T10:28:20\", \"state\": \"public\", \"position\": 2, \"id\": 15}, {\"about\": \"Deezer prototype\", \"assets\": [{\"width\": 1024, \"url\": \"https://d2pdfwfdhlv7he.cloudfront.net/assets/1072/uljrnbuwnnwo.jpg\", \"created_at\": \"2014-04-08T14:52:42\", \"parent_type\": \"Issue\", \"updated_at\": \"2014-04-08T14:52:42\", \"height\": 1024, \"parent_id\": 17, \"key\": \"assets/1072/uljrnbuwnnwo.jpg\", \"id\": 1072}, {\"width\": 143, \"url\": \"https://d2pdfwfdhlv7he.cloudfront.net/assets/1071/caamjgfjhawn.jpg\", \"created_at\": \"2014-04-08T14:49:46\", \"parent_type\": \"Issue\", \"updated_at\": \"2014-04-08T14:49:46\", \"height\": 59, \"parent_id\": 17, \"key\": \"assets/1071/caamjgfjhawn.jpg\", \"id\": 1071}, {\"width\": 1920, \"url\": \"https://d2pdfwfdhlv7he.cloudfront.net/assets/1070/sopwucgqzldr.jpg\", \"created_at\": \"2014-04-08T14:48:36\", \"parent_type\": \"Issue\", \"updated_at\": \"2014-04-08T14:48:36\", \"height\": 1080, \"parent_id\": 17, \"key\": \"assets/1070/sopwucgqzldr.jpg\", \"id\": 1070}, {\"width\": 1920, \"url\": \"https://d2pdfwfdhlv7he.cloudfront.net/assets/1069/qaongrwxnmzz.jpg\", \"created_at\": \"2014-04-08T14:48:22\", \"parent_type\": \"Issue\", \"updated_at\": \"2014-04-08T14:48:22\", \"height\": 1080, \"parent_id\": 17, \"key\": \"assets/1069/qaongrwxnmzz.jpg\", \"id\": 1069}, {\"width\": 1536, \"url\": \"https://d2pdfwfdhlv7he.cloudfront.net/assets/993/dhgxwyldshct.jpg\", \"created_at\": \"2014-04-03T15:41:15\", \"parent_type\": \"Issue\", \"updated_at\": \"2014-04-03T15:41:15\", \"height\": 2048, \"parent_id\": 17, \"key\": \"assets/993/dhgxwyldshct.jpg\", \"id\": 993}], \"title\": \"Deezer\", \"created_at\": \"2014-04-03T10:24:20\", \"updated_at\": \"2014-04-03T15:41:25\", \"state\": \"private\", \"position\": 3, \"id\": 17}, {\"about\": \"description\", \"assets\": [{\"width\": 1440, \"url\": \"https://d2pdfwfdhlv7he.cloudfront.net/assets/874/zabjfzkmgoww.jpg\", \"created_at\": \"2014-03-31T10:06:54\", \"parent_type\": \"Issue\", \"updated_at\": \"2014-03-31T10:06:54\", \"height\": 900, \"parent_id\": 13, \"key\": \"assets/874/zabjfzkmgoww.jpg\", \"id\": 874}], \"title\": \"test issue\", \"created_at\": \"2014-03-20T15:54:20\", \"updated_at\": \"2014-04-16T10:23:26\", \"state\": \"private\", \"position\": 4, \"id\": 13}]";
    
    
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *objects = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
//    self.importer = [Person importer];
//    self.importer.identifier = @"personID";
//    self.importer.uniqueIdentifierForItem = ^id (NSDictionary *feedItem, NSInteger index) {
//        return [feedItem objectForKey:@"id"];
//    };
//    self.importer.updateEntity = ^(Person *person, NSDictionary *feedItem) {
//        person.personID = [feedItem objectForKey:@"id"];
//    };
//    [self.importer importWithFeed:objects];
    
    [Person importWithData:objects];

    
    NSLog(@"COUNT A %@", [[[Person all] sortBy:@{ @"personID" : @YES}] objects]);
}

- (void)test7
{
    NSString *json = @"[{\"about\": \"Take PAUSE and enjoy the best songs, videos, albums and charts along with  the best music writing of Q1, 2014.\", \"assets\": [{\"width\": 1536, \"url\": \"https://d2pdfwfdhlv7he.cloudfront.net/assets/1176/tuutgigecgbx.jpg\", \"created_at\": \"2014-04-15T11:25:18\", \"parent_type\": \"Issue\", \"updated_at\": \"2014-04-15T11:25:18\", \"height\": 2048, \"parent_id\": 10, \"key\": \"assets/1176/tuutgigecgbx.jpg\", \"id\": 1176}, {\"width\": 1536, \"url\": \"https://d2pdfwfdhlv7he.cloudfront.net/assets/1175/oppybyqsnttr.jpg\", \"created_at\": \"2014-04-10T13:01:41\", \"parent_type\": \"Issue\", \"updated_at\": \"2014-04-10T13:01:41\", \"height\": 2048, \"parent_id\": 10, \"key\": \"assets/1175/oppybyqsnttr.jpg\", \"id\": 1175}, {\"width\": 3840, \"url\": \"https://d2pdfwfdhlv7he.cloudfront.net/assets/1093/xjefolaumkcx.jpg\", \"created_at\": \"2014-04-08T15:49:10\", \"parent_type\": \"Issue\", \"updated_at\": \"2014-04-08T15:49:10\", \"height\": 5760, \"parent_id\": 10, \"key\": \"assets/1093/xjefolaumkcx.jpg\", \"id\": 1093}, {\"width\": 1536, \"url\": \"https://d2pdfwfdhlv7he.cloudfront.net/assets/991/vnbgmfxeugzc.jpg\", \"created_at\": \"2014-04-03T14:12:38\", \"parent_type\": \"Issue\", \"updated_at\": \"2014-04-03T14:12:38\", \"height\": 2048, \"parent_id\": 10, \"key\": \"assets/991/vnbgmfxeugzc.jpg\", \"id\": 991}, {\"width\": 1536, \"url\": \"https://d2pdfwfdhlv7he.cloudfront.net/assets/814/dpkhikrxrdee.jpg\", \"created_at\": \"2014-03-28T09:59:30\", \"parent_type\": \"Issue\", \"updated_at\": \"2014-03-28T09:59:30\", \"height\": 2048, \"parent_id\": 10, \"key\": \"assets/814/dpkhikrxrdee.jpg\", \"id\": 814}, {\"width\": 1536, \"url\": \"https://d2pdfwfdhlv7he.cloudfront.net/assets/291/xlgeeqfwarbs.jpg\", \"created_at\": \"2014-03-27T11:28:20\", \"parent_type\": \"Issue\", \"updated_at\": \"2014-03-27T11:28:20\", \"height\": 2048, \"parent_id\": 10, \"key\": \"assets/291/xlgeeqfwarbs.jpg\", \"id\": 291}, {\"width\": 648, \"url\": \"https://d2pdfwfdhlv7he.cloudfront.net/assets/60/rbyxmtictoja.jpg\", \"created_at\": \"2014-03-18T11:33:22\", \"parent_type\": \"Issue\", \"updated_at\": \"2014-03-18T11:33:22\", \"height\": 864, \"parent_id\": 10, \"key\": \"assets/60/rbyxmtictoja.jpg\", \"id\": 60}, {\"width\": 512, \"url\": \"https://d2pdfwfdhlv7he.cloudfront.net/assets/59/sanonaswzjjg.jpg\", \"created_at\": \"2014-03-14T10:14:37\", \"parent_type\": \"Issue\", \"updated_at\": \"2014-03-14T10:14:37\", \"height\": 768, \"parent_id\": 10, \"key\": \"assets/59/sanonaswzjjg.jpg\", \"id\": 59}, {\"width\": 2448, \"url\": \"https://d2pdfwfdhlv7he.cloudfront.net/assets/6/fjdbljjihhdh.jpg\", \"created_at\": \"2014-03-11T10:01:39\", \"parent_type\": \"Issue\", \"updated_at\": \"2014-03-11T10:01:39\", \"height\": 2448, \"parent_id\": 10, \"key\": \"assets/6/fjdbljjihhdh.jpg\", \"id\": 6}], \"title\": \"Q1 2014\", \"created_at\": \"2014-03-11T09:40:42\", \"updated_at\": \"2014-04-16T14:12:35\", \"state\": \"public\", \"position\": 1, \"id\": 10}, {\"about\": \"Take PAUSE and enjoy the best songs, videos, albums and charts along with  the best music writing of 2013\", \"assets\": [{\"width\": 1536, \"url\": \"https://d2pdfwfdhlv7he.cloudfront.net/assets/992/paoyqnandbaz.jpg\", \"created_at\": \"2014-04-03T14:12:51\", \"parent_type\": \"Issue\", \"updated_at\": \"2014-04-03T14:12:51\", \"height\": 2048, \"parent_id\": 15, \"key\": \"assets/992/paoyqnandbaz.jpg\", \"id\": 992}, {\"width\": 1536, \"url\": \"https://d2pdfwfdhlv7he.cloudfront.net/assets/815/vrqutwjrunlb.jpg\", \"created_at\": \"2014-03-28T10:01:12\", \"parent_type\": \"Issue\", \"updated_at\": \"2014-03-28T10:01:12\", \"height\": 2048, \"parent_id\": 15, \"key\": \"assets/815/vrqutwjrunlb.jpg\", \"id\": 815}, {\"width\": 1536, \"url\": \"https://d2pdfwfdhlv7he.cloudfront.net/assets/813/wtnicmyomunu.jpg\", \"created_at\": \"2014-03-28T09:59:05\", \"parent_type\": \"Issue\", \"updated_at\": \"2014-03-28T09:59:05\", \"height\": 2048, \"parent_id\": 15, \"key\": \"assets/813/wtnicmyomunu.jpg\", \"id\": 813}, {\"width\": 362, \"url\": \"https://d2pdfwfdhlv7he.cloudfront.net/assets/294/ijdxhqthxrmv.jpg\", \"created_at\": \"2014-03-27T15:42:10\", \"parent_type\": \"Issue\", \"updated_at\": \"2014-03-27T15:42:10\", \"height\": 512, \"parent_id\": 15, \"key\": \"assets/294/ijdxhqthxrmv.jpg\", \"id\": 294}], \"title\": \"Best of 2013\", \"created_at\": \"2014-03-27T15:42:09\", \"updated_at\": \"2014-04-03T10:28:20\", \"state\": \"public\", \"position\": 2, \"id\": 15}, {\"about\": \"Deezer prototype\", \"assets\": [{\"width\": 1024, \"url\": \"https://d2pdfwfdhlv7he.cloudfront.net/assets/1072/uljrnbuwnnwo.jpg\", \"created_at\": \"2014-04-08T14:52:42\", \"parent_type\": \"Issue\", \"updated_at\": \"2014-04-08T14:52:42\", \"height\": 1024, \"parent_id\": 17, \"key\": \"assets/1072/uljrnbuwnnwo.jpg\", \"id\": 1072}, {\"width\": 143, \"url\": \"https://d2pdfwfdhlv7he.cloudfront.net/assets/1071/caamjgfjhawn.jpg\", \"created_at\": \"2014-04-08T14:49:46\", \"parent_type\": \"Issue\", \"updated_at\": \"2014-04-08T14:49:46\", \"height\": 59, \"parent_id\": 17, \"key\": \"assets/1071/caamjgfjhawn.jpg\", \"id\": 1071}, {\"width\": 1920, \"url\": \"https://d2pdfwfdhlv7he.cloudfront.net/assets/1070/sopwucgqzldr.jpg\", \"created_at\": \"2014-04-08T14:48:36\", \"parent_type\": \"Issue\", \"updated_at\": \"2014-04-08T14:48:36\", \"height\": 1080, \"parent_id\": 17, \"key\": \"assets/1070/sopwucgqzldr.jpg\", \"id\": 1070}, {\"width\": 1920, \"url\": \"https://d2pdfwfdhlv7he.cloudfront.net/assets/1069/qaongrwxnmzz.jpg\", \"created_at\": \"2014-04-08T14:48:22\", \"parent_type\": \"Issue\", \"updated_at\": \"2014-04-08T14:48:22\", \"height\": 1080, \"parent_id\": 17, \"key\": \"assets/1069/qaongrwxnmzz.jpg\", \"id\": 1069}, {\"width\": 1536, \"url\": \"https://d2pdfwfdhlv7he.cloudfront.net/assets/993/dhgxwyldshct.jpg\", \"created_at\": \"2014-04-03T15:41:15\", \"parent_type\": \"Issue\", \"updated_at\": \"2014-04-03T15:41:15\", \"height\": 2048, \"parent_id\": 17, \"key\": \"assets/993/dhgxwyldshct.jpg\", \"id\": 993}], \"title\": \"Deezer\", \"created_at\": \"2014-04-03T10:24:20\", \"updated_at\": \"2014-04-03T15:41:25\", \"state\": \"private\", \"position\": 3, \"id\": 17}, {\"about\": \"description\", \"assets\": [{\"width\": 1440, \"url\": \"https://d2pdfwfdhlv7he.cloudfront.net/assets/874/zabjfzkmgoww.jpg\", \"created_at\": \"2014-03-31T10:06:54\", \"parent_type\": \"Issue\", \"updated_at\": \"2014-03-31T10:06:54\", \"height\": 900, \"parent_id\": 13, \"key\": \"assets/874/zabjfzkmgoww.jpg\", \"id\": 874}], \"title\": \"test issue\", \"created_at\": \"2014-03-20T15:54:20\", \"updated_at\": \"2014-04-16T10:23:26\", \"state\": \"private\", \"position\": 4, \"id\": 13}]";
    
    
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *objects = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    [Person setAllowsDeletion:YES];
    [Person importWithData:objects];
    
    
//    self.importer.identifier = @"personID";
//    self.importer.allowsDeletion = YES;
//    self.importer.uniqueIdentifierForItem = ^id (NSDictionary *feedItem, NSInteger index) {
//        return [feedItem objectForKey:@"id"];
//    };
//    self.importer.updateEntity = ^(Person *person, NSDictionary *feedItem) {
//        person.personID = [feedItem objectForKey:@"id"];
//    };
//    [self.importer importWithFeed:objects];
    
    NSLog(@"COUNT B %@", [[[Person all] sortBy:@{ @"personID" : @YES}] objects]);
}

@end
