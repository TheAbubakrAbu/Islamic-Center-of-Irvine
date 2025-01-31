// NOTE: This file was generated by the ServiceGenerator.

// ----------------------------------------------------------------------------
// API:
//   Cloud Shell API (cloudshell/v1)
// Description:
//   Allows users to start, configure, and connect to interactive shell sessions
//   running in the cloud.
// Documentation:
//   https://cloud.google.com/shell/docs/

#import <GoogleAPIClientForREST/GTLRCloudShellQuery.h>

@implementation GTLRCloudShellQuery

@dynamic fields;

@end

@implementation GTLRCloudShellQuery_OperationsCancel

@dynamic name;

+ (instancetype)queryWithObject:(GTLRCloudShell_CancelOperationRequest *)object
                           name:(NSString *)name {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v1/{+name}:cancel";
  GTLRCloudShellQuery_OperationsCancel *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.name = name;
  query.expectedObjectClass = [GTLRCloudShell_Empty class];
  query.loggingName = @"cloudshell.operations.cancel";
  return query;
}

@end

@implementation GTLRCloudShellQuery_OperationsDelete

@dynamic name;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v1/{+name}";
  GTLRCloudShellQuery_OperationsDelete *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"DELETE"
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRCloudShell_Empty class];
  query.loggingName = @"cloudshell.operations.delete";
  return query;
}

@end

@implementation GTLRCloudShellQuery_OperationsGet

@dynamic name;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v1/{+name}";
  GTLRCloudShellQuery_OperationsGet *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRCloudShell_Operation class];
  query.loggingName = @"cloudshell.operations.get";
  return query;
}

@end

@implementation GTLRCloudShellQuery_OperationsList

@dynamic filter, name, pageSize, pageToken;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v1/{+name}";
  GTLRCloudShellQuery_OperationsList *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRCloudShell_ListOperationsResponse class];
  query.loggingName = @"cloudshell.operations.list";
  return query;
}

@end

@implementation GTLRCloudShellQuery_UsersEnvironmentsAddPublicKey

@dynamic environment;

+ (instancetype)queryWithObject:(GTLRCloudShell_AddPublicKeyRequest *)object
                    environment:(NSString *)environment {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"environment" ];
  NSString *pathURITemplate = @"v1/{+environment}:addPublicKey";
  GTLRCloudShellQuery_UsersEnvironmentsAddPublicKey *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.environment = environment;
  query.expectedObjectClass = [GTLRCloudShell_Operation class];
  query.loggingName = @"cloudshell.users.environments.addPublicKey";
  return query;
}

@end

@implementation GTLRCloudShellQuery_UsersEnvironmentsAuthorize

@dynamic name;

+ (instancetype)queryWithObject:(GTLRCloudShell_AuthorizeEnvironmentRequest *)object
                           name:(NSString *)name {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v1/{+name}:authorize";
  GTLRCloudShellQuery_UsersEnvironmentsAuthorize *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.name = name;
  query.expectedObjectClass = [GTLRCloudShell_Operation class];
  query.loggingName = @"cloudshell.users.environments.authorize";
  return query;
}

@end

@implementation GTLRCloudShellQuery_UsersEnvironmentsGet

@dynamic name;

+ (instancetype)queryWithName:(NSString *)name {
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v1/{+name}";
  GTLRCloudShellQuery_UsersEnvironmentsGet *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.name = name;
  query.expectedObjectClass = [GTLRCloudShell_Environment class];
  query.loggingName = @"cloudshell.users.environments.get";
  return query;
}

@end

@implementation GTLRCloudShellQuery_UsersEnvironmentsRemovePublicKey

@dynamic environment;

+ (instancetype)queryWithObject:(GTLRCloudShell_RemovePublicKeyRequest *)object
                    environment:(NSString *)environment {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"environment" ];
  NSString *pathURITemplate = @"v1/{+environment}:removePublicKey";
  GTLRCloudShellQuery_UsersEnvironmentsRemovePublicKey *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.environment = environment;
  query.expectedObjectClass = [GTLRCloudShell_Operation class];
  query.loggingName = @"cloudshell.users.environments.removePublicKey";
  return query;
}

@end

@implementation GTLRCloudShellQuery_UsersEnvironmentsStart

@dynamic name;

+ (instancetype)queryWithObject:(GTLRCloudShell_StartEnvironmentRequest *)object
                           name:(NSString *)name {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSArray *pathParams = @[ @"name" ];
  NSString *pathURITemplate = @"v1/{+name}:start";
  GTLRCloudShellQuery_UsersEnvironmentsStart *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.bodyObject = object;
  query.name = name;
  query.expectedObjectClass = [GTLRCloudShell_Operation class];
  query.loggingName = @"cloudshell.users.environments.start";
  return query;
}

@end
