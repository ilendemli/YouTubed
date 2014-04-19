#import "XMLReader.h"

NSString *const kXMLReaderTextNodeKey = @"text";

@interface XMLReader (Internal)
-(id)initWithError:(NSError *)error;
-(NSDictionary *)objectWithData:(NSData *)data;
@end

@implementation XMLReader
+(NSDictionary *)dictionaryForXMLData:(NSData *)data error:(NSError *)error {
    XMLReader *reader = [[XMLReader alloc] initWithError:error];
    NSDictionary *rootDictionary = [reader objectWithData:data];
    [reader release];
    return rootDictionary;
}

+(NSDictionary *)dictionaryForXMLString:(NSString *)string error:(NSError *)error {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [XMLReader dictionaryForXMLData:data error:error];
}

-(id)initWithError:(NSError*)error {
    if(self = [super init]) {
        errorPointer = error;
    }
    return self;
}

-(void)dealloc {
    [dictionaryStack release];
    [textInProgress release];
    [super dealloc];
}

-(NSDictionary *)objectWithData:(NSData *)data {
    [dictionaryStack release];
    [textInProgress release];
    
    dictionaryStack = [[NSMutableArray alloc] init];
    textInProgress = [[NSMutableString alloc] init];
    
    [dictionaryStack addObject:[NSMutableDictionary dictionary]];
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate =(id)self;
    BOOL success = [parser parse];
    
    if(success) {
        NSDictionary *resultDict = [dictionaryStack objectAtIndex:0];
        return resultDict;
    }
    return nil;
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    NSMutableDictionary *parentDict = [dictionaryStack lastObject];
    NSMutableDictionary *childDict = [NSMutableDictionary dictionary];
    [childDict addEntriesFromDictionary:attributeDict];
    
    id existingValue = [parentDict objectForKey:elementName];
    if(existingValue) {
        NSMutableArray *array = nil;
        if([existingValue isKindOfClass:[NSMutableArray class]]) {
            array = (NSMutableArray *) existingValue;
            
        } else {
            array = [NSMutableArray array];
            [array addObject:existingValue];
            [parentDict setObject:array forKey:elementName];
        }
        
        [array addObject:childDict];
        
    } else {
        [parentDict setObject:childDict forKey:elementName];
    }
    
    [dictionaryStack addObject:childDict];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    NSMutableDictionary *dictInProgress = [dictionaryStack lastObject];
    
    if([textInProgress length] > 0) {
        [dictInProgress setObject:textInProgress forKey:kXMLReaderTextNodeKey];
        
        [textInProgress release];
        textInProgress = [[NSMutableString alloc] init];
    }
    
    [dictionaryStack removeLastObject];
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [textInProgress appendString:string];
}

-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    errorPointer = parseError;
}
@end