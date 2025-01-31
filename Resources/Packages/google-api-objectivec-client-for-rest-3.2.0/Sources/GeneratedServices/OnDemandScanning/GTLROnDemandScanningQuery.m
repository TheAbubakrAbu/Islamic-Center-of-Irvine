// NOTE: This file was generated by the ServiceGenerator.

// ----------------------------------------------------------------------------
// API:
//   On-Demand Scanning API (ondemandscanning/v1)
// Description:
//   A service to scan container images for vulnerabilities.
// Documentation:
//   https://cloud.google.com/container-analysis/docs/on-demand-scanning/

#import <GoogleAPIClientForREST/GTLROnDemandScanningQuery.h>

@implementation GTLROnDemandScanningQuery

@dynamic fields;

@end

@implementation GTLROnDemandScanningQuery_ProjectsLocationsOperationsCancel

@dynamic name;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v1/{+name}:cancel";
  GTLROnDemandScanningQuery_ProjectsLocationsOperationsCancel *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLROnDemandScanning_Empty class];
  query.loggingName = @"ondemandscanning.projects.locations.operations.cancel";
  return query;
}

@end

@implementation GTLROnDemandScanningQuery_ProjectsLocationsOperationsDelete

@dynamic name;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v1/{+name}";
  GTLROnDemandScanningQuery_ProjectsLocationsOperationsDelete *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"DELETE"
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLROnDemandScanning_Empty class];
  query.loggingName = @"ondemandscanning.projects.locations.operations.delete";
  return query;
}

@end

@implementation GTLROnDemandScanningQuery_ProjectsLocationsOperationsGet

@dynamic name;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v1/{+name}";
  GTLROnDemandScanningQuery_ProjectsLocationsOperationsGet *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLROnDemandScanning_Operation class];
  query.loggingName = @"ondemandscanning.projects.locations.operations.get";
  return query;
}

@end

@implementation GTLROnDemandScanningQuery_ProjectsLocationsOperationsList

@dynamic filter, name, pageSize, pageToken;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v1/{+name}/operations";
  GTLROnDemandScanningQuery_ProjectsLocationsOperationsList *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLROnDemandScanning_ListOperationsResponse class];
  query.loggingName = @"ondemandscanning.projects.locations.operations.list";
  return query;
}

@end

@implementation GTLROnDemandScanningQuery_ProjectsLocationsOperationsWait

@dynamic name, timeout;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v1/{+name}:wait";
  GTLROnDemandScanningQuery_ProjectsLocationsOperationsWait *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLROnDemandScanning_Operation class];
  query.loggingName = @"ondemandscanning.projects.locations.operations.wait";
  return query;
}

@end

@implementation GTLROnDemandScanningQuery_ProjectsLocationsScansAnalyzePackages

@dynamic parent;

+ (instancetype)queryWithObject:(GTLROnDemandScanning_AnalyzePackagesRequestV1 *)object
                         parent:(NSString *)parent {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"parent" ];
  NSString *pathURITemplate = @"v1/{+parent}/scans:analyzePackages";
  GTLROnDemandScanningQuery_ProjectsLocationsScansAnalyzePackages *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.parent = parent;
  query.expectedObjectClass = [GTLROnDemandScanning_Operation class];
  query.loggingName = @"ondemandscanning.projects.locations.scans.analyzePackages";
  return query;
}

@end

@implementation GTLROnDemandScanningQuery_ProjectsLocationsScansVulnerabilitiesList

@dynamic pageSize, pageToken, parent;

+ (instancetype)queryWithParent:(NSString *)parent {
  NSArray *pathParams = @[ @"parent" ];
  NSString *pathURITemplate = @"v1/{+parent}/vulnerabilities";
  GTLROnDemandScanningQuery_ProjectsLocationsScansVulnerabilitiesList *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.parent = parent;
  query.expectedObjectClass = [GTLROnDemandScanning_ListVulnerabilitiesResponseV1 class];
  query.loggingName = @"ondemandscanning.projects.locations.scans.vulnerabilities.list";
  return query;
}

@end
