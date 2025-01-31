// NOTE: This file was generated by the ServiceGenerator.

// ----------------------------------------------------------------------------
// API:
//   My Business Business Information API (mybusinessbusinessinformation/v1)
// Description:
//   The My Business Business Information API provides an interface for managing
//   business information. Note - If you have a quota of 0 after enabling the
//   API, please request for GBP API access.
// Documentation:
//   https://developers.google.com/my-business/

#import <GoogleAPIClientForREST/GTLRMyBusinessBusinessInformationQuery.h>

// ----------------------------------------------------------------------------
// Constants

// view
NSString * const kGTLRMyBusinessBusinessInformationViewBasic   = @"BASIC";
NSString * const kGTLRMyBusinessBusinessInformationViewCategoryViewUnspecified = @"CATEGORY_VIEW_UNSPECIFIED";
NSString * const kGTLRMyBusinessBusinessInformationViewFull    = @"FULL";

// ----------------------------------------------------------------------------
// Query Classes
//

@implementation GTLRMyBusinessBusinessInformationQuery

@dynamic fields;

@end

@implementation GTLRMyBusinessBusinessInformationQuery_AccountsLocationsCreate

@dynamic parent, requestId, validateOnly;

+ (instancetype)queryWithObject:(GTLRMyBusinessBusinessInformation_Location *)object
                         parent:(NSString *)parent {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"parent" ];
  NSString *pathURITemplate = @"v1/{+parent}/locations";
  GTLRMyBusinessBusinessInformationQuery_AccountsLocationsCreate *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.parent = parent;
  query.expectedObjectClass = [GTLRMyBusinessBusinessInformation_Location class];
  query.loggingName = @"mybusinessbusinessinformation.accounts.locations.create";
  return query;
}

@end

@implementation GTLRMyBusinessBusinessInformationQuery_AccountsLocationsList

@dynamic filter, orderBy, pageSize, pageToken, parent, readMask;

+ (instancetype)queryWithParent:(NSString *)parent {
  NSArray *pathParams = @[ @"parent" ];
  NSString *pathURITemplate = @"v1/{+parent}/locations";
  GTLRMyBusinessBusinessInformationQuery_AccountsLocationsList *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.parent = parent;
  query.expectedObjectClass = [GTLRMyBusinessBusinessInformation_ListLocationsResponse class];
  query.loggingName = @"mybusinessbusinessinformation.accounts.locations.list";
  return query;
}

@end

@implementation GTLRMyBusinessBusinessInformationQuery_AttributesList

@dynamic categoryName, languageCode, pageSize, pageToken, parent, regionCode,
         showAll;

+ (instancetype)query {
  NSString *pathURITemplate = @"v1/attributes";
  GTLRMyBusinessBusinessInformationQuery_AttributesList *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:nil];
  query.expectedObjectClass = [GTLRMyBusinessBusinessInformation_ListAttributeMetadataResponse class];
  query.loggingName = @"mybusinessbusinessinformation.attributes.list";
  return query;
}

@end

@implementation GTLRMyBusinessBusinessInformationQuery_CategoriesBatchGet

@dynamic languageCode, names, regionCode, view;

+ (NSDictionary<NSString *, Class> *)arrayPropertyToClassMap {
  NSDictionary<NSString *, Class> *map = @{
    @"names" : [NSString class]
  };
  return map;
}

+ (instancetype)query {
  NSString *pathURITemplate = @"v1/categories:batchGet";
  GTLRMyBusinessBusinessInformationQuery_CategoriesBatchGet *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:nil];
  query.expectedObjectClass = [GTLRMyBusinessBusinessInformation_BatchGetCategoriesResponse class];
  query.loggingName = @"mybusinessbusinessinformation.categories.batchGet";
  return query;
}

@end

@implementation GTLRMyBusinessBusinessInformationQuery_CategoriesList

@dynamic filter, languageCode, pageSize, pageToken, regionCode, view;

+ (instancetype)query {
  NSString *pathURITemplate = @"v1/categories";
  GTLRMyBusinessBusinessInformationQuery_CategoriesList *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:nil];
  query.expectedObjectClass = [GTLRMyBusinessBusinessInformation_ListCategoriesResponse class];
  query.loggingName = @"mybusinessbusinessinformation.categories.list";
  return query;
}

@end

@implementation GTLRMyBusinessBusinessInformationQuery_ChainsGet

@dynamic name;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v1/{+name}";
  GTLRMyBusinessBusinessInformationQuery_ChainsGet *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRMyBusinessBusinessInformation_Chain class];
  query.loggingName = @"mybusinessbusinessinformation.chains.get";
  return query;
}

@end

@implementation GTLRMyBusinessBusinessInformationQuery_ChainsSearch

@dynamic chainName, pageSize;

+ (instancetype)query {
  NSString *pathURITemplate = @"v1/chains:search";
  GTLRMyBusinessBusinessInformationQuery_ChainsSearch *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:nil];
  query.expectedObjectClass = [GTLRMyBusinessBusinessInformation_SearchChainsResponse class];
  query.loggingName = @"mybusinessbusinessinformation.chains.search";
  return query;
}

@end

@implementation GTLRMyBusinessBusinessInformationQuery_GoogleLocationsSearch

+ (instancetype)queryWithObject:(GTLRMyBusinessBusinessInformation_SearchGoogleLocationsRequest *)object {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSString *pathURITemplate = @"v1/googleLocations:search";
  GTLRMyBusinessBusinessInformationQuery_GoogleLocationsSearch *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:nil];
  query.bodyObject = object;
  query.expectedObjectClass = [GTLRMyBusinessBusinessInformation_SearchGoogleLocationsResponse class];
  query.loggingName = @"mybusinessbusinessinformation.googleLocations.search";
  return query;
}

@end

@implementation GTLRMyBusinessBusinessInformationQuery_LocationsAttributesGetGoogleUpdated

@dynamic name;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v1/{+name}:getGoogleUpdated";
  GTLRMyBusinessBusinessInformationQuery_LocationsAttributesGetGoogleUpdated *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRMyBusinessBusinessInformation_Attributes class];
  query.loggingName = @"mybusinessbusinessinformation.locations.attributes.getGoogleUpdated";
  return query;
}

@end

@implementation GTLRMyBusinessBusinessInformationQuery_LocationsDelete

@dynamic name;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v1/{+name}";
  GTLRMyBusinessBusinessInformationQuery_LocationsDelete *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"DELETE"
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRMyBusinessBusinessInformation_Empty class];
  query.loggingName = @"mybusinessbusinessinformation.locations.delete";
  return query;
}

@end

@implementation GTLRMyBusinessBusinessInformationQuery_LocationsGet

@dynamic name, readMask;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v1/{+name}";
  GTLRMyBusinessBusinessInformationQuery_LocationsGet *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRMyBusinessBusinessInformation_Location class];
  query.loggingName = @"mybusinessbusinessinformation.locations.get";
  return query;
}

@end

@implementation GTLRMyBusinessBusinessInformationQuery_LocationsGetAttributes

@dynamic name;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v1/{+name}";
  GTLRMyBusinessBusinessInformationQuery_LocationsGetAttributes *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRMyBusinessBusinessInformation_Attributes class];
  query.loggingName = @"mybusinessbusinessinformation.locations.getAttributes";
  return query;
}

@end

@implementation GTLRMyBusinessBusinessInformationQuery_LocationsGetGoogleUpdated

@dynamic name, readMask;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v1/{+name}:getGoogleUpdated";
  GTLRMyBusinessBusinessInformationQuery_LocationsGetGoogleUpdated *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRMyBusinessBusinessInformation_GoogleUpdatedLocation class];
  query.loggingName = @"mybusinessbusinessinformation.locations.getGoogleUpdated";
  return query;
}

@end

@implementation GTLRMyBusinessBusinessInformationQuery_LocationsPatch

@dynamic name, updateMask, validateOnly;

+ (instancetype)queryWithObject:(GTLRMyBusinessBusinessInformation_Location *)object
                           name:(NSString *)name {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v1/{+name}";
  GTLRMyBusinessBusinessInformationQuery_LocationsPatch *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"PATCH"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.name = name;
  query.expectedObjectClass = [GTLRMyBusinessBusinessInformation_Location class];
  query.loggingName = @"mybusinessbusinessinformation.locations.patch";
  return query;
}

@end

@implementation GTLRMyBusinessBusinessInformationQuery_LocationsUpdateAttributes

@dynamic attributeMask, name;

+ (instancetype)queryWithObject:(GTLRMyBusinessBusinessInformation_Attributes *)object
                           name:(NSString *)name {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v1/{+name}";
  GTLRMyBusinessBusinessInformationQuery_LocationsUpdateAttributes *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"PATCH"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.name = name;
  query.expectedObjectClass = [GTLRMyBusinessBusinessInformation_Attributes class];
  query.loggingName = @"mybusinessbusinessinformation.locations.updateAttributes";
  return query;
}

@end
