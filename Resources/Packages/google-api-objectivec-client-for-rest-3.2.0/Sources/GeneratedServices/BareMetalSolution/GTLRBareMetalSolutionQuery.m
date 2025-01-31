// NOTE: This file was generated by the ServiceGenerator.

// ----------------------------------------------------------------------------
// API:
//   Bare Metal Solution API (baremetalsolution/v2)
// Description:
//   Provides ways to manage Bare Metal Solution hardware installed in a
//   regional extension located near a Google Cloud data center.
// Documentation:
//   https://cloud.google.com/bare-metal

#import <GoogleAPIClientForREST/GTLRBareMetalSolutionQuery.h>

@implementation GTLRBareMetalSolutionQuery

@dynamic fields;

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsGet

@dynamic name;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}";
  GTLRBareMetalSolutionQuery_ProjectsLocationsGet *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRBareMetalSolution_Location class];
  query.loggingName = @"baremetalsolution.projects.locations.get";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsInstancesDetachLun

@dynamic instance;

+ (instancetype)queryWithObject:(GTLRBareMetalSolution_DetachLunRequest *)object
                       instance:(NSString *)instance {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"instance" ];
  NSString *pathURITemplate = @"v2/{+instance}:detachLun";
  GTLRBareMetalSolutionQuery_ProjectsLocationsInstancesDetachLun *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.instance = instance;
  query.expectedObjectClass = [GTLRBareMetalSolution_Operation class];
  query.loggingName = @"baremetalsolution.projects.locations.instances.detachLun";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsInstancesDisableInteractiveSerialConsole

@dynamic name;

+ (instancetype)queryWithObject:(GTLRBareMetalSolution_DisableInteractiveSerialConsoleRequest *)object
                           name:(NSString *)name {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}:disableInteractiveSerialConsole";
  GTLRBareMetalSolutionQuery_ProjectsLocationsInstancesDisableInteractiveSerialConsole *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.name = name;
  query.expectedObjectClass = [GTLRBareMetalSolution_Operation class];
  query.loggingName = @"baremetalsolution.projects.locations.instances.disableInteractiveSerialConsole";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsInstancesEnableInteractiveSerialConsole

@dynamic name;

+ (instancetype)queryWithObject:(GTLRBareMetalSolution_EnableInteractiveSerialConsoleRequest *)object
                           name:(NSString *)name {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}:enableInteractiveSerialConsole";
  GTLRBareMetalSolutionQuery_ProjectsLocationsInstancesEnableInteractiveSerialConsole *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.name = name;
  query.expectedObjectClass = [GTLRBareMetalSolution_Operation class];
  query.loggingName = @"baremetalsolution.projects.locations.instances.enableInteractiveSerialConsole";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsInstancesGet

@dynamic name;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}";
  GTLRBareMetalSolutionQuery_ProjectsLocationsInstancesGet *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRBareMetalSolution_Instance class];
  query.loggingName = @"baremetalsolution.projects.locations.instances.get";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsInstancesList

@dynamic filter, pageSize, pageToken, parent;

+ (instancetype)queryWithParent:(NSString *)parent {
  NSArray *pathParams = @[ @"parent" ];
  NSString *pathURITemplate = @"v2/{+parent}/instances";
  GTLRBareMetalSolutionQuery_ProjectsLocationsInstancesList *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.parent = parent;
  query.expectedObjectClass = [GTLRBareMetalSolution_ListInstancesResponse class];
  query.loggingName = @"baremetalsolution.projects.locations.instances.list";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsInstancesPatch

@dynamic name, updateMask;

+ (instancetype)queryWithObject:(GTLRBareMetalSolution_Instance *)object
                           name:(NSString *)name {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}";
  GTLRBareMetalSolutionQuery_ProjectsLocationsInstancesPatch *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"PATCH"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.name = name;
  query.expectedObjectClass = [GTLRBareMetalSolution_Operation class];
  query.loggingName = @"baremetalsolution.projects.locations.instances.patch";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsInstancesRename

@dynamic name;

+ (instancetype)queryWithObject:(GTLRBareMetalSolution_RenameInstanceRequest *)object
                           name:(NSString *)name {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}:rename";
  GTLRBareMetalSolutionQuery_ProjectsLocationsInstancesRename *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.name = name;
  query.expectedObjectClass = [GTLRBareMetalSolution_Instance class];
  query.loggingName = @"baremetalsolution.projects.locations.instances.rename";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsInstancesReset

@dynamic name;

+ (instancetype)queryWithObject:(GTLRBareMetalSolution_ResetInstanceRequest *)object
                           name:(NSString *)name {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}:reset";
  GTLRBareMetalSolutionQuery_ProjectsLocationsInstancesReset *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.name = name;
  query.expectedObjectClass = [GTLRBareMetalSolution_Operation class];
  query.loggingName = @"baremetalsolution.projects.locations.instances.reset";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsInstancesStart

@dynamic name;

+ (instancetype)queryWithObject:(GTLRBareMetalSolution_StartInstanceRequest *)object
                           name:(NSString *)name {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}:start";
  GTLRBareMetalSolutionQuery_ProjectsLocationsInstancesStart *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.name = name;
  query.expectedObjectClass = [GTLRBareMetalSolution_Operation class];
  query.loggingName = @"baremetalsolution.projects.locations.instances.start";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsInstancesStop

@dynamic name;

+ (instancetype)queryWithObject:(GTLRBareMetalSolution_StopInstanceRequest *)object
                           name:(NSString *)name {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}:stop";
  GTLRBareMetalSolutionQuery_ProjectsLocationsInstancesStop *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.name = name;
  query.expectedObjectClass = [GTLRBareMetalSolution_Operation class];
  query.loggingName = @"baremetalsolution.projects.locations.instances.stop";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsList

@dynamic filter, name, pageSize, pageToken;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}/locations";
  GTLRBareMetalSolutionQuery_ProjectsLocationsList *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRBareMetalSolution_ListLocationsResponse class];
  query.loggingName = @"baremetalsolution.projects.locations.list";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsNetworksGet

@dynamic name;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}";
  GTLRBareMetalSolutionQuery_ProjectsLocationsNetworksGet *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRBareMetalSolution_Network class];
  query.loggingName = @"baremetalsolution.projects.locations.networks.get";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsNetworksList

@dynamic filter, pageSize, pageToken, parent;

+ (instancetype)queryWithParent:(NSString *)parent {
  NSArray *pathParams = @[ @"parent" ];
  NSString *pathURITemplate = @"v2/{+parent}/networks";
  GTLRBareMetalSolutionQuery_ProjectsLocationsNetworksList *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.parent = parent;
  query.expectedObjectClass = [GTLRBareMetalSolution_ListNetworksResponse class];
  query.loggingName = @"baremetalsolution.projects.locations.networks.list";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsNetworksListNetworkUsage

@dynamic location;

+ (instancetype)queryWithLocation:(NSString *)location {
  NSArray *pathParams = @[ @"location" ];
  NSString *pathURITemplate = @"v2/{+location}/networks:listNetworkUsage";
  GTLRBareMetalSolutionQuery_ProjectsLocationsNetworksListNetworkUsage *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.location = location;
  query.expectedObjectClass = [GTLRBareMetalSolution_ListNetworkUsageResponse class];
  query.loggingName = @"baremetalsolution.projects.locations.networks.listNetworkUsage";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsNetworksPatch

@dynamic name, updateMask;

+ (instancetype)queryWithObject:(GTLRBareMetalSolution_Network *)object
                           name:(NSString *)name {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}";
  GTLRBareMetalSolutionQuery_ProjectsLocationsNetworksPatch *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"PATCH"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.name = name;
  query.expectedObjectClass = [GTLRBareMetalSolution_Operation class];
  query.loggingName = @"baremetalsolution.projects.locations.networks.patch";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsNetworksRename

@dynamic name;

+ (instancetype)queryWithObject:(GTLRBareMetalSolution_RenameNetworkRequest *)object
                           name:(NSString *)name {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}:rename";
  GTLRBareMetalSolutionQuery_ProjectsLocationsNetworksRename *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.name = name;
  query.expectedObjectClass = [GTLRBareMetalSolution_Network class];
  query.loggingName = @"baremetalsolution.projects.locations.networks.rename";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsNfsSharesCreate

@dynamic parent;

+ (instancetype)queryWithObject:(GTLRBareMetalSolution_NfsShare *)object
                         parent:(NSString *)parent {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"parent" ];
  NSString *pathURITemplate = @"v2/{+parent}/nfsShares";
  GTLRBareMetalSolutionQuery_ProjectsLocationsNfsSharesCreate *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.parent = parent;
  query.expectedObjectClass = [GTLRBareMetalSolution_Operation class];
  query.loggingName = @"baremetalsolution.projects.locations.nfsShares.create";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsNfsSharesDelete

@dynamic name;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}";
  GTLRBareMetalSolutionQuery_ProjectsLocationsNfsSharesDelete *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"DELETE"
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRBareMetalSolution_Operation class];
  query.loggingName = @"baremetalsolution.projects.locations.nfsShares.delete";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsNfsSharesGet

@dynamic name;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}";
  GTLRBareMetalSolutionQuery_ProjectsLocationsNfsSharesGet *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRBareMetalSolution_NfsShare class];
  query.loggingName = @"baremetalsolution.projects.locations.nfsShares.get";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsNfsSharesList

@dynamic filter, pageSize, pageToken, parent;

+ (instancetype)queryWithParent:(NSString *)parent {
  NSArray *pathParams = @[ @"parent" ];
  NSString *pathURITemplate = @"v2/{+parent}/nfsShares";
  GTLRBareMetalSolutionQuery_ProjectsLocationsNfsSharesList *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.parent = parent;
  query.expectedObjectClass = [GTLRBareMetalSolution_ListNfsSharesResponse class];
  query.loggingName = @"baremetalsolution.projects.locations.nfsShares.list";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsNfsSharesPatch

@dynamic name, updateMask;

+ (instancetype)queryWithObject:(GTLRBareMetalSolution_NfsShare *)object
                           name:(NSString *)name {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}";
  GTLRBareMetalSolutionQuery_ProjectsLocationsNfsSharesPatch *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"PATCH"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.name = name;
  query.expectedObjectClass = [GTLRBareMetalSolution_Operation class];
  query.loggingName = @"baremetalsolution.projects.locations.nfsShares.patch";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsNfsSharesRename

@dynamic name;

+ (instancetype)queryWithObject:(GTLRBareMetalSolution_RenameNfsShareRequest *)object
                           name:(NSString *)name {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}:rename";
  GTLRBareMetalSolutionQuery_ProjectsLocationsNfsSharesRename *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.name = name;
  query.expectedObjectClass = [GTLRBareMetalSolution_NfsShare class];
  query.loggingName = @"baremetalsolution.projects.locations.nfsShares.rename";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsOperationsGet

@dynamic name;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}";
  GTLRBareMetalSolutionQuery_ProjectsLocationsOperationsGet *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRBareMetalSolution_Operation class];
  query.loggingName = @"baremetalsolution.projects.locations.operations.get";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsOsImagesList

@dynamic pageSize, pageToken, parent;

+ (instancetype)queryWithParent:(NSString *)parent {
  NSArray *pathParams = @[ @"parent" ];
  NSString *pathURITemplate = @"v2/{+parent}/osImages";
  GTLRBareMetalSolutionQuery_ProjectsLocationsOsImagesList *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.parent = parent;
  query.expectedObjectClass = [GTLRBareMetalSolution_ListOSImagesResponse class];
  query.loggingName = @"baremetalsolution.projects.locations.osImages.list";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsProvisioningConfigsCreate

@dynamic email, parent;

+ (instancetype)queryWithObject:(GTLRBareMetalSolution_ProvisioningConfig *)object
                         parent:(NSString *)parent {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"parent" ];
  NSString *pathURITemplate = @"v2/{+parent}/provisioningConfigs";
  GTLRBareMetalSolutionQuery_ProjectsLocationsProvisioningConfigsCreate *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.parent = parent;
  query.expectedObjectClass = [GTLRBareMetalSolution_ProvisioningConfig class];
  query.loggingName = @"baremetalsolution.projects.locations.provisioningConfigs.create";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsProvisioningConfigsGet

@dynamic name;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}";
  GTLRBareMetalSolutionQuery_ProjectsLocationsProvisioningConfigsGet *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRBareMetalSolution_ProvisioningConfig class];
  query.loggingName = @"baremetalsolution.projects.locations.provisioningConfigs.get";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsProvisioningConfigsPatch

@dynamic email, name, updateMask;

+ (instancetype)queryWithObject:(GTLRBareMetalSolution_ProvisioningConfig *)object
                           name:(NSString *)name {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}";
  GTLRBareMetalSolutionQuery_ProjectsLocationsProvisioningConfigsPatch *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"PATCH"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.name = name;
  query.expectedObjectClass = [GTLRBareMetalSolution_ProvisioningConfig class];
  query.loggingName = @"baremetalsolution.projects.locations.provisioningConfigs.patch";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsProvisioningConfigsSubmit

@dynamic parent;

+ (instancetype)queryWithObject:(GTLRBareMetalSolution_SubmitProvisioningConfigRequest *)object
                         parent:(NSString *)parent {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"parent" ];
  NSString *pathURITemplate = @"v2/{+parent}/provisioningConfigs:submit";
  GTLRBareMetalSolutionQuery_ProjectsLocationsProvisioningConfigsSubmit *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.parent = parent;
  query.expectedObjectClass = [GTLRBareMetalSolution_SubmitProvisioningConfigResponse class];
  query.loggingName = @"baremetalsolution.projects.locations.provisioningConfigs.submit";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsProvisioningQuotasList

@dynamic pageSize, pageToken, parent;

+ (instancetype)queryWithParent:(NSString *)parent {
  NSArray *pathParams = @[ @"parent" ];
  NSString *pathURITemplate = @"v2/{+parent}/provisioningQuotas";
  GTLRBareMetalSolutionQuery_ProjectsLocationsProvisioningQuotasList *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.parent = parent;
  query.expectedObjectClass = [GTLRBareMetalSolution_ListProvisioningQuotasResponse class];
  query.loggingName = @"baremetalsolution.projects.locations.provisioningQuotas.list";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsSshKeysCreate

@dynamic parent, sshKeyId;

+ (instancetype)queryWithObject:(GTLRBareMetalSolution_SSHKey *)object
                         parent:(NSString *)parent {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"parent" ];
  NSString *pathURITemplate = @"v2/{+parent}/sshKeys";
  GTLRBareMetalSolutionQuery_ProjectsLocationsSshKeysCreate *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.parent = parent;
  query.expectedObjectClass = [GTLRBareMetalSolution_SSHKey class];
  query.loggingName = @"baremetalsolution.projects.locations.sshKeys.create";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsSshKeysDelete

@dynamic name;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}";
  GTLRBareMetalSolutionQuery_ProjectsLocationsSshKeysDelete *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"DELETE"
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRBareMetalSolution_Empty class];
  query.loggingName = @"baremetalsolution.projects.locations.sshKeys.delete";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsSshKeysList

@dynamic pageSize, pageToken, parent;

+ (instancetype)queryWithParent:(NSString *)parent {
  NSArray *pathParams = @[ @"parent" ];
  NSString *pathURITemplate = @"v2/{+parent}/sshKeys";
  GTLRBareMetalSolutionQuery_ProjectsLocationsSshKeysList *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.parent = parent;
  query.expectedObjectClass = [GTLRBareMetalSolution_ListSSHKeysResponse class];
  query.loggingName = @"baremetalsolution.projects.locations.sshKeys.list";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsVolumesEvict

@dynamic name;

+ (instancetype)queryWithObject:(GTLRBareMetalSolution_EvictVolumeRequest *)object
                           name:(NSString *)name {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}:evict";
  GTLRBareMetalSolutionQuery_ProjectsLocationsVolumesEvict *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.name = name;
  query.expectedObjectClass = [GTLRBareMetalSolution_Operation class];
  query.loggingName = @"baremetalsolution.projects.locations.volumes.evict";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsVolumesGet

@dynamic name;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}";
  GTLRBareMetalSolutionQuery_ProjectsLocationsVolumesGet *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRBareMetalSolution_Volume class];
  query.loggingName = @"baremetalsolution.projects.locations.volumes.get";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsVolumesList

@dynamic filter, pageSize, pageToken, parent;

+ (instancetype)queryWithParent:(NSString *)parent {
  NSArray *pathParams = @[ @"parent" ];
  NSString *pathURITemplate = @"v2/{+parent}/volumes";
  GTLRBareMetalSolutionQuery_ProjectsLocationsVolumesList *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.parent = parent;
  query.expectedObjectClass = [GTLRBareMetalSolution_ListVolumesResponse class];
  query.loggingName = @"baremetalsolution.projects.locations.volumes.list";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsVolumesLunsEvict

@dynamic name;

+ (instancetype)queryWithObject:(GTLRBareMetalSolution_EvictLunRequest *)object
                           name:(NSString *)name {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}:evict";
  GTLRBareMetalSolutionQuery_ProjectsLocationsVolumesLunsEvict *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.name = name;
  query.expectedObjectClass = [GTLRBareMetalSolution_Operation class];
  query.loggingName = @"baremetalsolution.projects.locations.volumes.luns.evict";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsVolumesLunsGet

@dynamic name;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}";
  GTLRBareMetalSolutionQuery_ProjectsLocationsVolumesLunsGet *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRBareMetalSolution_Lun class];
  query.loggingName = @"baremetalsolution.projects.locations.volumes.luns.get";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsVolumesLunsList

@dynamic pageSize, pageToken, parent;

+ (instancetype)queryWithParent:(NSString *)parent {
  NSArray *pathParams = @[ @"parent" ];
  NSString *pathURITemplate = @"v2/{+parent}/luns";
  GTLRBareMetalSolutionQuery_ProjectsLocationsVolumesLunsList *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.parent = parent;
  query.expectedObjectClass = [GTLRBareMetalSolution_ListLunsResponse class];
  query.loggingName = @"baremetalsolution.projects.locations.volumes.luns.list";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsVolumesPatch

@dynamic name, updateMask;

+ (instancetype)queryWithObject:(GTLRBareMetalSolution_Volume *)object
                           name:(NSString *)name {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}";
  GTLRBareMetalSolutionQuery_ProjectsLocationsVolumesPatch *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"PATCH"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.name = name;
  query.expectedObjectClass = [GTLRBareMetalSolution_Operation class];
  query.loggingName = @"baremetalsolution.projects.locations.volumes.patch";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsVolumesRename

@dynamic name;

+ (instancetype)queryWithObject:(GTLRBareMetalSolution_RenameVolumeRequest *)object
                           name:(NSString *)name {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}:rename";
  GTLRBareMetalSolutionQuery_ProjectsLocationsVolumesRename *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.name = name;
  query.expectedObjectClass = [GTLRBareMetalSolution_Volume class];
  query.loggingName = @"baremetalsolution.projects.locations.volumes.rename";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsVolumesResize

@dynamic volume;

+ (instancetype)queryWithObject:(GTLRBareMetalSolution_ResizeVolumeRequest *)object
                         volume:(NSString *)volume {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"volume" ];
  NSString *pathURITemplate = @"v2/{+volume}:resize";
  GTLRBareMetalSolutionQuery_ProjectsLocationsVolumesResize *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.volume = volume;
  query.expectedObjectClass = [GTLRBareMetalSolution_Operation class];
  query.loggingName = @"baremetalsolution.projects.locations.volumes.resize";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsVolumesSnapshotsCreate

@dynamic parent;

+ (instancetype)queryWithObject:(GTLRBareMetalSolution_VolumeSnapshot *)object
                         parent:(NSString *)parent {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"parent" ];
  NSString *pathURITemplate = @"v2/{+parent}/snapshots";
  GTLRBareMetalSolutionQuery_ProjectsLocationsVolumesSnapshotsCreate *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.parent = parent;
  query.expectedObjectClass = [GTLRBareMetalSolution_VolumeSnapshot class];
  query.loggingName = @"baremetalsolution.projects.locations.volumes.snapshots.create";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsVolumesSnapshotsDelete

@dynamic name;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}";
  GTLRBareMetalSolutionQuery_ProjectsLocationsVolumesSnapshotsDelete *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"DELETE"
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRBareMetalSolution_Empty class];
  query.loggingName = @"baremetalsolution.projects.locations.volumes.snapshots.delete";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsVolumesSnapshotsGet

@dynamic name;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v2/{+name}";
  GTLRBareMetalSolutionQuery_ProjectsLocationsVolumesSnapshotsGet *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRBareMetalSolution_VolumeSnapshot class];
  query.loggingName = @"baremetalsolution.projects.locations.volumes.snapshots.get";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsVolumesSnapshotsList

@dynamic pageSize, pageToken, parent;

+ (instancetype)queryWithParent:(NSString *)parent {
  NSArray *pathParams = @[ @"parent" ];
  NSString *pathURITemplate = @"v2/{+parent}/snapshots";
  GTLRBareMetalSolutionQuery_ProjectsLocationsVolumesSnapshotsList *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.parent = parent;
  query.expectedObjectClass = [GTLRBareMetalSolution_ListVolumeSnapshotsResponse class];
  query.loggingName = @"baremetalsolution.projects.locations.volumes.snapshots.list";
  return query;
}

@end

@implementation GTLRBareMetalSolutionQuery_ProjectsLocationsVolumesSnapshotsRestoreVolumeSnapshot

@dynamic volumeSnapshot;

+ (instancetype)queryWithObject:(GTLRBareMetalSolution_RestoreVolumeSnapshotRequest *)object
                 volumeSnapshot:(NSString *)volumeSnapshot {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"volumeSnapshot" ];
  NSString *pathURITemplate = @"v2/{+volumeSnapshot}:restoreVolumeSnapshot";
  GTLRBareMetalSolutionQuery_ProjectsLocationsVolumesSnapshotsRestoreVolumeSnapshot *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.volumeSnapshot = volumeSnapshot;
  query.expectedObjectClass = [GTLRBareMetalSolution_Operation class];
  query.loggingName = @"baremetalsolution.projects.locations.volumes.snapshots.restoreVolumeSnapshot";
  return query;
}

@end
