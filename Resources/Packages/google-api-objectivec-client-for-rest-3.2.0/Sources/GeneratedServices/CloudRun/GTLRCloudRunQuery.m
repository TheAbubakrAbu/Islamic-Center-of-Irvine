// NOTE: This file was generated by the ServiceGenerator.

// ----------------------------------------------------------------------------
// API:
//   Cloud Run Admin API (run/v2)
// Description:
//   Deploy and manage user provided container images that scale automatically
//   based on incoming requests. The Cloud Run Admin API v1 follows the Knative
//   Serving API specification, while v2 is aligned with Google Cloud AIP-based
//   API standards, as described in https://google.aip.dev/.
// Documentation:
//   https://cloud.google.com/run/

#import <GoogleAPIClientForREST/GTLRCloudRunQuery.h>

@implementation GTLRCloudRunQuery

@dynamic fields;

@end

@implementation GTLRCloudRunQuery_ProjectsLocationsJobsCreate

@dynamic jobId, parent, validateOnly;

+ (instancetype)queryWithObject:(GTLRCloudRun_GoogleCloudRunV2Job *)object
                         parent:(NSString *)parent {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"parent" ];
  NSString *pathURITemplate = @"v2/{+parent}/jobs";
  GTLRCloudRunQuery_ProjectsLocationsJobsCreate *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.parent = parent;
  query.expectedObjectClass = [GTLRCloudRun_GoogleLongrunningOperation class];
  query.loggingName = @"run.projects.locations.jobs.create";
  return query;
}

@end

@implementation GTLRCloudRunQuery_ProjectsLocationsJobsDelete

@dynamic ETag, name, validateOnly;

+ (NSDictionary<NSString *, NSString *> *)parameterNameMap {
  return @{ @"ETag" : @"etag" };
}

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}";
  GTLRCloudRunQuery_ProjectsLocationsJobsDelete *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"DELETE"
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRCloudRun_GoogleLongrunningOperation class];
  query.loggingName = @"run.projects.locations.jobs.delete";
  return query;
}

@end

@implementation GTLRCloudRunQuery_ProjectsLocationsJobsExecutionsCancel

@dynamic name;

+ (instancetype)queryWithObject:(GTLRCloudRun_GoogleCloudRunV2CancelExecutionRequest *)object
                           name:(NSString *)name {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}:cancel";
  GTLRCloudRunQuery_ProjectsLocationsJobsExecutionsCancel *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.name = name;
  query.expectedObjectClass = [GTLRCloudRun_GoogleLongrunningOperation class];
  query.loggingName = @"run.projects.locations.jobs.executions.cancel";
  return query;
}

@end

@implementation GTLRCloudRunQuery_ProjectsLocationsJobsExecutionsDelete

@dynamic ETag, name, validateOnly;

+ (NSDictionary<NSString *, NSString *> *)parameterNameMap {
  return @{ @"ETag" : @"etag" };
}

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}";
  GTLRCloudRunQuery_ProjectsLocationsJobsExecutionsDelete *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"DELETE"
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRCloudRun_GoogleLongrunningOperation class];
  query.loggingName = @"run.projects.locations.jobs.executions.delete";
  return query;
}

@end

@implementation GTLRCloudRunQuery_ProjectsLocationsJobsExecutionsGet

@dynamic name;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}";
  GTLRCloudRunQuery_ProjectsLocationsJobsExecutionsGet *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRCloudRun_GoogleCloudRunV2Execution class];
  query.loggingName = @"run.projects.locations.jobs.executions.get";
  return query;
}

@end

@implementation GTLRCloudRunQuery_ProjectsLocationsJobsExecutionsList

@dynamic pageSize, pageToken, parent, showDeleted;

+ (instancetype)queryWithParent:(NSString *)parent {
  NSArray *pathParams = @[ @"parent" ];
  NSString *pathURITemplate = @"v2/{+parent}/executions";
  GTLRCloudRunQuery_ProjectsLocationsJobsExecutionsList *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.parent = parent;
  query.expectedObjectClass = [GTLRCloudRun_GoogleCloudRunV2ListExecutionsResponse class];
  query.loggingName = @"run.projects.locations.jobs.executions.list";
  return query;
}

@end

@implementation GTLRCloudRunQuery_ProjectsLocationsJobsExecutionsTasksGet

@dynamic name;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}";
  GTLRCloudRunQuery_ProjectsLocationsJobsExecutionsTasksGet *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRCloudRun_GoogleCloudRunV2Task class];
  query.loggingName = @"run.projects.locations.jobs.executions.tasks.get";
  return query;
}

@end

@implementation GTLRCloudRunQuery_ProjectsLocationsJobsExecutionsTasksList

@dynamic pageSize, pageToken, parent, showDeleted;

+ (instancetype)queryWithParent:(NSString *)parent {
  NSArray *pathParams = @[ @"parent" ];
  NSString *pathURITemplate = @"v2/{+parent}/tasks";
  GTLRCloudRunQuery_ProjectsLocationsJobsExecutionsTasksList *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.parent = parent;
  query.expectedObjectClass = [GTLRCloudRun_GoogleCloudRunV2ListTasksResponse class];
  query.loggingName = @"run.projects.locations.jobs.executions.tasks.list";
  return query;
}

@end

@implementation GTLRCloudRunQuery_ProjectsLocationsJobsGet

@dynamic name;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}";
  GTLRCloudRunQuery_ProjectsLocationsJobsGet *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRCloudRun_GoogleCloudRunV2Job class];
  query.loggingName = @"run.projects.locations.jobs.get";
  return query;
}

@end

@implementation GTLRCloudRunQuery_ProjectsLocationsJobsGetIamPolicy

@dynamic optionsRequestedPolicyVersion, resource;

+ (NSDictionary<NSString *, NSString *> *)parameterNameMap {
  return @{ @"optionsRequestedPolicyVersion" : @"options.requestedPolicyVersion" };
}

+ (instancetype)queryWithResource:(NSString *)resource {
  NSArray *pathParams = @[ @"resource" ];
  NSString *pathURITemplate = @"v2/{+resource}:getIamPolicy";
  GTLRCloudRunQuery_ProjectsLocationsJobsGetIamPolicy *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.resource = resource;
  query.expectedObjectClass = [GTLRCloudRun_GoogleIamV1Policy class];
  query.loggingName = @"run.projects.locations.jobs.getIamPolicy";
  return query;
}

@end

@implementation GTLRCloudRunQuery_ProjectsLocationsJobsList

@dynamic pageSize, pageToken, parent, showDeleted;

+ (instancetype)queryWithParent:(NSString *)parent {
  NSArray *pathParams = @[ @"parent" ];
  NSString *pathURITemplate = @"v2/{+parent}/jobs";
  GTLRCloudRunQuery_ProjectsLocationsJobsList *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.parent = parent;
  query.expectedObjectClass = [GTLRCloudRun_GoogleCloudRunV2ListJobsResponse class];
  query.loggingName = @"run.projects.locations.jobs.list";
  return query;
}

@end

@implementation GTLRCloudRunQuery_ProjectsLocationsJobsPatch

@dynamic allowMissing, name, validateOnly;

+ (instancetype)queryWithObject:(GTLRCloudRun_GoogleCloudRunV2Job *)object
                           name:(NSString *)name {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}";
  GTLRCloudRunQuery_ProjectsLocationsJobsPatch *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"PATCH"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.name = name;
  query.expectedObjectClass = [GTLRCloudRun_GoogleLongrunningOperation class];
  query.loggingName = @"run.projects.locations.jobs.patch";
  return query;
}

@end

@implementation GTLRCloudRunQuery_ProjectsLocationsJobsRun

@dynamic name;

+ (instancetype)queryWithObject:(GTLRCloudRun_GoogleCloudRunV2RunJobRequest *)object
                           name:(NSString *)name {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}:run";
  GTLRCloudRunQuery_ProjectsLocationsJobsRun *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.name = name;
  query.expectedObjectClass = [GTLRCloudRun_GoogleLongrunningOperation class];
  query.loggingName = @"run.projects.locations.jobs.run";
  return query;
}

@end

@implementation GTLRCloudRunQuery_ProjectsLocationsJobsSetIamPolicy

@dynamic resource;

+ (instancetype)queryWithObject:(GTLRCloudRun_GoogleIamV1SetIamPolicyRequest *)object
                       resource:(NSString *)resource {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"resource" ];
  NSString *pathURITemplate = @"v2/{+resource}:setIamPolicy";
  GTLRCloudRunQuery_ProjectsLocationsJobsSetIamPolicy *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.resource = resource;
  query.expectedObjectClass = [GTLRCloudRun_GoogleIamV1Policy class];
  query.loggingName = @"run.projects.locations.jobs.setIamPolicy";
  return query;
}

@end

@implementation GTLRCloudRunQuery_ProjectsLocationsJobsTestIamPermissions

@dynamic resource;

+ (instancetype)queryWithObject:(GTLRCloudRun_GoogleIamV1TestIamPermissionsRequest *)object
                       resource:(NSString *)resource {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"resource" ];
  NSString *pathURITemplate = @"v2/{+resource}:testIamPermissions";
  GTLRCloudRunQuery_ProjectsLocationsJobsTestIamPermissions *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.resource = resource;
  query.expectedObjectClass = [GTLRCloudRun_GoogleIamV1TestIamPermissionsResponse class];
  query.loggingName = @"run.projects.locations.jobs.testIamPermissions";
  return query;
}

@end

@implementation GTLRCloudRunQuery_ProjectsLocationsOperationsDelete

@dynamic name;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}";
  GTLRCloudRunQuery_ProjectsLocationsOperationsDelete *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"DELETE"
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRCloudRun_GoogleProtobufEmpty class];
  query.loggingName = @"run.projects.locations.operations.delete";
  return query;
}

@end

@implementation GTLRCloudRunQuery_ProjectsLocationsOperationsGet

@dynamic name;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}";
  GTLRCloudRunQuery_ProjectsLocationsOperationsGet *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRCloudRun_GoogleLongrunningOperation class];
  query.loggingName = @"run.projects.locations.operations.get";
  return query;
}

@end

@implementation GTLRCloudRunQuery_ProjectsLocationsOperationsList

@dynamic filter, name, pageSize, pageToken;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}/operations";
  GTLRCloudRunQuery_ProjectsLocationsOperationsList *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRCloudRun_GoogleLongrunningListOperationsResponse class];
  query.loggingName = @"run.projects.locations.operations.list";
  return query;
}

@end

@implementation GTLRCloudRunQuery_ProjectsLocationsOperationsWait

@dynamic name;

+ (instancetype)queryWithObject:(GTLRCloudRun_GoogleLongrunningWaitOperationRequest *)object
                           name:(NSString *)name {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}:wait";
  GTLRCloudRunQuery_ProjectsLocationsOperationsWait *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.name = name;
  query.expectedObjectClass = [GTLRCloudRun_GoogleLongrunningOperation class];
  query.loggingName = @"run.projects.locations.operations.wait";
  return query;
}

@end

@implementation GTLRCloudRunQuery_ProjectsLocationsServicesCreate

@dynamic parent, serviceId, validateOnly;

+ (instancetype)queryWithObject:(GTLRCloudRun_GoogleCloudRunV2Service *)object
                         parent:(NSString *)parent {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"parent" ];
  NSString *pathURITemplate = @"v2/{+parent}/services";
  GTLRCloudRunQuery_ProjectsLocationsServicesCreate *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.parent = parent;
  query.expectedObjectClass = [GTLRCloudRun_GoogleLongrunningOperation class];
  query.loggingName = @"run.projects.locations.services.create";
  return query;
}

@end

@implementation GTLRCloudRunQuery_ProjectsLocationsServicesDelete

@dynamic ETag, name, validateOnly;

+ (NSDictionary<NSString *, NSString *> *)parameterNameMap {
  return @{ @"ETag" : @"etag" };
}

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}";
  GTLRCloudRunQuery_ProjectsLocationsServicesDelete *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"DELETE"
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRCloudRun_GoogleLongrunningOperation class];
  query.loggingName = @"run.projects.locations.services.delete";
  return query;
}

@end

@implementation GTLRCloudRunQuery_ProjectsLocationsServicesGet

@dynamic name;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}";
  GTLRCloudRunQuery_ProjectsLocationsServicesGet *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRCloudRun_GoogleCloudRunV2Service class];
  query.loggingName = @"run.projects.locations.services.get";
  return query;
}

@end

@implementation GTLRCloudRunQuery_ProjectsLocationsServicesGetIamPolicy

@dynamic optionsRequestedPolicyVersion, resource;

+ (NSDictionary<NSString *, NSString *> *)parameterNameMap {
  return @{ @"optionsRequestedPolicyVersion" : @"options.requestedPolicyVersion" };
}

+ (instancetype)queryWithResource:(NSString *)resource {
  NSArray *pathParams = @[ @"resource" ];
  NSString *pathURITemplate = @"v2/{+resource}:getIamPolicy";
  GTLRCloudRunQuery_ProjectsLocationsServicesGetIamPolicy *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.resource = resource;
  query.expectedObjectClass = [GTLRCloudRun_GoogleIamV1Policy class];
  query.loggingName = @"run.projects.locations.services.getIamPolicy";
  return query;
}

@end

@implementation GTLRCloudRunQuery_ProjectsLocationsServicesList

@dynamic pageSize, pageToken, parent, showDeleted;

+ (instancetype)queryWithParent:(NSString *)parent {
  NSArray *pathParams = @[ @"parent" ];
  NSString *pathURITemplate = @"v2/{+parent}/services";
  GTLRCloudRunQuery_ProjectsLocationsServicesList *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.parent = parent;
  query.expectedObjectClass = [GTLRCloudRun_GoogleCloudRunV2ListServicesResponse class];
  query.loggingName = @"run.projects.locations.services.list";
  return query;
}

@end

@implementation GTLRCloudRunQuery_ProjectsLocationsServicesPatch

@dynamic allowMissing, name, validateOnly;

+ (instancetype)queryWithObject:(GTLRCloudRun_GoogleCloudRunV2Service *)object
                           name:(NSString *)name {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}";
  GTLRCloudRunQuery_ProjectsLocationsServicesPatch *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"PATCH"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.name = name;
  query.expectedObjectClass = [GTLRCloudRun_GoogleLongrunningOperation class];
  query.loggingName = @"run.projects.locations.services.patch";
  return query;
}

@end

@implementation GTLRCloudRunQuery_ProjectsLocationsServicesRevisionsDelete

@dynamic ETag, name, validateOnly;

+ (NSDictionary<NSString *, NSString *> *)parameterNameMap {
  return @{ @"ETag" : @"etag" };
}

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}";
  GTLRCloudRunQuery_ProjectsLocationsServicesRevisionsDelete *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"DELETE"
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRCloudRun_GoogleLongrunningOperation class];
  query.loggingName = @"run.projects.locations.services.revisions.delete";
  return query;
}

@end

@implementation GTLRCloudRunQuery_ProjectsLocationsServicesRevisionsGet

@dynamic name;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}";
  GTLRCloudRunQuery_ProjectsLocationsServicesRevisionsGet *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRCloudRun_GoogleCloudRunV2Revision class];
  query.loggingName = @"run.projects.locations.services.revisions.get";
  return query;
}

@end

@implementation GTLRCloudRunQuery_ProjectsLocationsServicesRevisionsList

@dynamic pageSize, pageToken, parent, showDeleted;

+ (instancetype)queryWithParent:(NSString *)parent {
  NSArray *pathParams = @[ @"parent" ];
  NSString *pathURITemplate = @"v2/{+parent}/revisions";
  GTLRCloudRunQuery_ProjectsLocationsServicesRevisionsList *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.parent = parent;
  query.expectedObjectClass = [GTLRCloudRun_GoogleCloudRunV2ListRevisionsResponse class];
  query.loggingName = @"run.projects.locations.services.revisions.list";
  return query;
}

@end

@implementation GTLRCloudRunQuery_ProjectsLocationsServicesSetIamPolicy

@dynamic resource;

+ (instancetype)queryWithObject:(GTLRCloudRun_GoogleIamV1SetIamPolicyRequest *)object
                       resource:(NSString *)resource {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"resource" ];
  NSString *pathURITemplate = @"v2/{+resource}:setIamPolicy";
  GTLRCloudRunQuery_ProjectsLocationsServicesSetIamPolicy *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.resource = resource;
  query.expectedObjectClass = [GTLRCloudRun_GoogleIamV1Policy class];
  query.loggingName = @"run.projects.locations.services.setIamPolicy";
  return query;
}

@end

@implementation GTLRCloudRunQuery_ProjectsLocationsServicesTestIamPermissions

@dynamic resource;

+ (instancetype)queryWithObject:(GTLRCloudRun_GoogleIamV1TestIamPermissionsRequest *)object
                       resource:(NSString *)resource {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"resource" ];
  NSString *pathURITemplate = @"v2/{+resource}:testIamPermissions";
  GTLRCloudRunQuery_ProjectsLocationsServicesTestIamPermissions *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.resource = resource;
  query.expectedObjectClass = [GTLRCloudRun_GoogleIamV1TestIamPermissionsResponse class];
  query.loggingName = @"run.projects.locations.services.testIamPermissions";
  return query;
}

@end
