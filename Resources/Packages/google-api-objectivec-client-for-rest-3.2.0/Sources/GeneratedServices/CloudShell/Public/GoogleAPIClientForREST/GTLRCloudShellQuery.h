// NOTE: This file was generated by the ServiceGenerator.

// ----------------------------------------------------------------------------
// API:
//   Cloud Shell API (cloudshell/v1)
// Description:
//   Allows users to start, configure, and connect to interactive shell sessions
//   running in the cloud.
// Documentation:
//   https://cloud.google.com/shell/docs/

#import <GoogleAPIClientForREST/GTLRQuery.h>

#if GTLR_RUNTIME_VERSION != 3000
#error This file was generated by a different version of ServiceGenerator which is incompatible with this GTLR library source.
#endif

#import "GTLRCloudShellObjects.h"

// Generated comments include content from the discovery document; avoid them
// causing warnings since clang's checks are some what arbitrary.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

NS_ASSUME_NONNULL_BEGIN

/**
 *  Parent class for other Cloud Shell query classes.
 */
@interface GTLRCloudShellQuery : GTLRQuery

/** Selector specifying which fields to include in a partial response. */
@property(nonatomic, copy, nullable) NSString *fields;

@end

/**
 *  Starts asynchronous cancellation on a long-running operation. The server
 *  makes a best effort to cancel the operation, but success is not guaranteed.
 *  If the server doesn't support this method, it returns
 *  `google.rpc.Code.UNIMPLEMENTED`. Clients can use Operations.GetOperation or
 *  other methods to check whether the cancellation succeeded or whether the
 *  operation completed despite cancellation. On successful cancellation, the
 *  operation is not deleted; instead, it becomes an operation with an
 *  Operation.error value with a google.rpc.Status.code of 1, corresponding to
 *  `Code.CANCELLED`.
 *
 *  Method: cloudshell.operations.cancel
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeCloudShellCloudPlatform
 */
@interface GTLRCloudShellQuery_OperationsCancel : GTLRCloudShellQuery

/** The name of the operation resource to be cancelled. */
@property(nonatomic, copy, nullable) NSString *name;

/**
 *  Fetches a @c GTLRCloudShell_Empty.
 *
 *  Starts asynchronous cancellation on a long-running operation. The server
 *  makes a best effort to cancel the operation, but success is not guaranteed.
 *  If the server doesn't support this method, it returns
 *  `google.rpc.Code.UNIMPLEMENTED`. Clients can use Operations.GetOperation or
 *  other methods to check whether the cancellation succeeded or whether the
 *  operation completed despite cancellation. On successful cancellation, the
 *  operation is not deleted; instead, it becomes an operation with an
 *  Operation.error value with a google.rpc.Status.code of 1, corresponding to
 *  `Code.CANCELLED`.
 *
 *  @param object The @c GTLRCloudShell_CancelOperationRequest to include in the
 *    query.
 *  @param name The name of the operation resource to be cancelled.
 *
 *  @return GTLRCloudShellQuery_OperationsCancel
 */
+ (instancetype)queryWithObject:(GTLRCloudShell_CancelOperationRequest *)object
                           name:(NSString *)name;

@end

/**
 *  Deletes a long-running operation. This method indicates that the client is
 *  no longer interested in the operation result. It does not cancel the
 *  operation. If the server doesn't support this method, it returns
 *  `google.rpc.Code.UNIMPLEMENTED`.
 *
 *  Method: cloudshell.operations.delete
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeCloudShellCloudPlatform
 */
@interface GTLRCloudShellQuery_OperationsDelete : GTLRCloudShellQuery

/** The name of the operation resource to be deleted. */
@property(nonatomic, copy, nullable) NSString *name;

/**
 *  Fetches a @c GTLRCloudShell_Empty.
 *
 *  Deletes a long-running operation. This method indicates that the client is
 *  no longer interested in the operation result. It does not cancel the
 *  operation. If the server doesn't support this method, it returns
 *  `google.rpc.Code.UNIMPLEMENTED`.
 *
 *  @param name The name of the operation resource to be deleted.
 *
 *  @return GTLRCloudShellQuery_OperationsDelete
 */
+ (instancetype)queryWithName:(NSString *)name;

@end

/**
 *  Gets the latest state of a long-running operation. Clients can use this
 *  method to poll the operation result at intervals as recommended by the API
 *  service.
 *
 *  Method: cloudshell.operations.get
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeCloudShellCloudPlatform
 */
@interface GTLRCloudShellQuery_OperationsGet : GTLRCloudShellQuery

/** The name of the operation resource. */
@property(nonatomic, copy, nullable) NSString *name;

/**
 *  Fetches a @c GTLRCloudShell_Operation.
 *
 *  Gets the latest state of a long-running operation. Clients can use this
 *  method to poll the operation result at intervals as recommended by the API
 *  service.
 *
 *  @param name The name of the operation resource.
 *
 *  @return GTLRCloudShellQuery_OperationsGet
 */
+ (instancetype)queryWithName:(NSString *)name;

@end

/**
 *  Lists operations that match the specified filter in the request. If the
 *  server doesn't support this method, it returns `UNIMPLEMENTED`.
 *
 *  Method: cloudshell.operations.list
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeCloudShellCloudPlatform
 */
@interface GTLRCloudShellQuery_OperationsList : GTLRCloudShellQuery

/** The standard list filter. */
@property(nonatomic, copy, nullable) NSString *filter;

/** The name of the operation's parent resource. */
@property(nonatomic, copy, nullable) NSString *name;

/** The standard list page size. */
@property(nonatomic, assign) NSInteger pageSize;

/** The standard list page token. */
@property(nonatomic, copy, nullable) NSString *pageToken;

/**
 *  Fetches a @c GTLRCloudShell_ListOperationsResponse.
 *
 *  Lists operations that match the specified filter in the request. If the
 *  server doesn't support this method, it returns `UNIMPLEMENTED`.
 *
 *  @param name The name of the operation's parent resource.
 *
 *  @return GTLRCloudShellQuery_OperationsList
 *
 *  @note Automatic pagination will be done when @c shouldFetchNextPages is
 *        enabled. See @c shouldFetchNextPages on @c GTLRService for more
 *        information.
 */
+ (instancetype)queryWithName:(NSString *)name;

@end

/**
 *  Adds a public SSH key to an environment, allowing clients with the
 *  corresponding private key to connect to that environment via SSH. If a key
 *  with the same content already exists, this will error with ALREADY_EXISTS.
 *
 *  Method: cloudshell.users.environments.addPublicKey
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeCloudShellCloudPlatform
 */
@interface GTLRCloudShellQuery_UsersEnvironmentsAddPublicKey : GTLRCloudShellQuery

/**
 *  Environment this key should be added to, e.g.
 *  `users/me/environments/default`.
 */
@property(nonatomic, copy, nullable) NSString *environment;

/**
 *  Fetches a @c GTLRCloudShell_Operation.
 *
 *  Adds a public SSH key to an environment, allowing clients with the
 *  corresponding private key to connect to that environment via SSH. If a key
 *  with the same content already exists, this will error with ALREADY_EXISTS.
 *
 *  @param object The @c GTLRCloudShell_AddPublicKeyRequest to include in the
 *    query.
 *  @param environment Environment this key should be added to, e.g.
 *    `users/me/environments/default`.
 *
 *  @return GTLRCloudShellQuery_UsersEnvironmentsAddPublicKey
 */
+ (instancetype)queryWithObject:(GTLRCloudShell_AddPublicKeyRequest *)object
                    environment:(NSString *)environment;

@end

/**
 *  Sends OAuth credentials to a running environment on behalf of a user. When
 *  this completes, the environment will be authorized to run various Google
 *  Cloud command line tools without requiring the user to manually
 *  authenticate.
 *
 *  Method: cloudshell.users.environments.authorize
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeCloudShellCloudPlatform
 */
@interface GTLRCloudShellQuery_UsersEnvironmentsAuthorize : GTLRCloudShellQuery

/**
 *  Name of the resource that should receive the credentials, for example
 *  `users/me/environments/default` or
 *  `users/someone\@example.com/environments/default`.
 */
@property(nonatomic, copy, nullable) NSString *name;

/**
 *  Fetches a @c GTLRCloudShell_Operation.
 *
 *  Sends OAuth credentials to a running environment on behalf of a user. When
 *  this completes, the environment will be authorized to run various Google
 *  Cloud command line tools without requiring the user to manually
 *  authenticate.
 *
 *  @param object The @c GTLRCloudShell_AuthorizeEnvironmentRequest to include
 *    in the query.
 *  @param name Name of the resource that should receive the credentials, for
 *    example `users/me/environments/default` or
 *    `users/someone\@example.com/environments/default`.
 *
 *  @return GTLRCloudShellQuery_UsersEnvironmentsAuthorize
 */
+ (instancetype)queryWithObject:(GTLRCloudShell_AuthorizeEnvironmentRequest *)object
                           name:(NSString *)name;

@end

/**
 *  Gets an environment. Returns NOT_FOUND if the environment does not exist.
 *
 *  Method: cloudshell.users.environments.get
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeCloudShellCloudPlatform
 */
@interface GTLRCloudShellQuery_UsersEnvironmentsGet : GTLRCloudShellQuery

/**
 *  Required. Name of the requested resource, for example
 *  `users/me/environments/default` or
 *  `users/someone\@example.com/environments/default`.
 */
@property(nonatomic, copy, nullable) NSString *name;

/**
 *  Fetches a @c GTLRCloudShell_Environment.
 *
 *  Gets an environment. Returns NOT_FOUND if the environment does not exist.
 *
 *  @param name Required. Name of the requested resource, for example
 *    `users/me/environments/default` or
 *    `users/someone\@example.com/environments/default`.
 *
 *  @return GTLRCloudShellQuery_UsersEnvironmentsGet
 */
+ (instancetype)queryWithName:(NSString *)name;

@end

/**
 *  Removes a public SSH key from an environment. Clients will no longer be able
 *  to connect to the environment using the corresponding private key. If a key
 *  with the same content is not present, this will error with NOT_FOUND.
 *
 *  Method: cloudshell.users.environments.removePublicKey
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeCloudShellCloudPlatform
 */
@interface GTLRCloudShellQuery_UsersEnvironmentsRemovePublicKey : GTLRCloudShellQuery

/**
 *  Environment this key should be removed from, e.g.
 *  `users/me/environments/default`.
 */
@property(nonatomic, copy, nullable) NSString *environment;

/**
 *  Fetches a @c GTLRCloudShell_Operation.
 *
 *  Removes a public SSH key from an environment. Clients will no longer be able
 *  to connect to the environment using the corresponding private key. If a key
 *  with the same content is not present, this will error with NOT_FOUND.
 *
 *  @param object The @c GTLRCloudShell_RemovePublicKeyRequest to include in the
 *    query.
 *  @param environment Environment this key should be removed from, e.g.
 *    `users/me/environments/default`.
 *
 *  @return GTLRCloudShellQuery_UsersEnvironmentsRemovePublicKey
 */
+ (instancetype)queryWithObject:(GTLRCloudShell_RemovePublicKeyRequest *)object
                    environment:(NSString *)environment;

@end

/**
 *  Starts an existing environment, allowing clients to connect to it. The
 *  returned operation will contain an instance of StartEnvironmentMetadata in
 *  its metadata field. Users can wait for the environment to start by polling
 *  this operation via GetOperation. Once the environment has finished starting
 *  and is ready to accept connections, the operation will contain a
 *  StartEnvironmentResponse in its response field.
 *
 *  Method: cloudshell.users.environments.start
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeCloudShellCloudPlatform
 */
@interface GTLRCloudShellQuery_UsersEnvironmentsStart : GTLRCloudShellQuery

/**
 *  Name of the resource that should be started, for example
 *  `users/me/environments/default` or
 *  `users/someone\@example.com/environments/default`.
 */
@property(nonatomic, copy, nullable) NSString *name;

/**
 *  Fetches a @c GTLRCloudShell_Operation.
 *
 *  Starts an existing environment, allowing clients to connect to it. The
 *  returned operation will contain an instance of StartEnvironmentMetadata in
 *  its metadata field. Users can wait for the environment to start by polling
 *  this operation via GetOperation. Once the environment has finished starting
 *  and is ready to accept connections, the operation will contain a
 *  StartEnvironmentResponse in its response field.
 *
 *  @param object The @c GTLRCloudShell_StartEnvironmentRequest to include in
 *    the query.
 *  @param name Name of the resource that should be started, for example
 *    `users/me/environments/default` or
 *    `users/someone\@example.com/environments/default`.
 *
 *  @return GTLRCloudShellQuery_UsersEnvironmentsStart
 */
+ (instancetype)queryWithObject:(GTLRCloudShell_StartEnvironmentRequest *)object
                           name:(NSString *)name;

@end

NS_ASSUME_NONNULL_END

#pragma clang diagnostic pop
