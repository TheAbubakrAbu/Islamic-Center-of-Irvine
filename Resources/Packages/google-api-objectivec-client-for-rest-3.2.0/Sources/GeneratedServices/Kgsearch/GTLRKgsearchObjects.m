// NOTE: This file was generated by the ServiceGenerator.

// ----------------------------------------------------------------------------
// API:
//   Knowledge Graph Search API (kgsearch/v1)
// Description:
//   Searches the Google Knowledge Graph for entities.
// Documentation:
//   https://developers.google.com/knowledge-graph/

#import <GoogleAPIClientForREST/GTLRKgsearchObjects.h>

// ----------------------------------------------------------------------------
//
//   GTLRKgsearch_SearchResponse
//

@implementation GTLRKgsearch_SearchResponse
@dynamic xContext, xType, itemListElement;

+ (NSDictionary<NSString *, NSString *> *)propertyToJSONKeyMap {
  NSDictionary<NSString *, NSString *> *map = @{
    @"xContext" : @"@context",
    @"xType" : @"@type"
  };
  return map;
}

+ (NSDictionary<NSString *, Class> *)arrayPropertyToClassMap {
  NSDictionary<NSString *, Class> *map = @{
    @"itemListElement" : [NSObject class]
  };
  return map;
}

@end
