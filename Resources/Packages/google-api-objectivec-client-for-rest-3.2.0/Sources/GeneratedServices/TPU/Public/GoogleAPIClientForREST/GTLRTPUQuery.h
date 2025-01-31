// NOTE: This file was generated by the ServiceGenerator.

// ----------------------------------------------------------------------------
// API:
//   Cloud TPU API (tpu/v2)
// Description:
//   TPU API provides customers with access to Google TPU technology.
// Documentation:
//   https://cloud.google.com/tpu/

#import <GoogleAPIClientForREST/GTLRQuery.h>

#if GTLR_RUNTIME_VERSION != 3000
#error This file was generated by a different version of ServiceGenerator which is incompatible with this GTLR library source.
#endif

#import "GTLRTPUObjects.h"

// Generated comments include content from the discovery document; avoid them
// causing warnings since clang's checks are some what arbitrary.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

NS_ASSUME_NONNULL_BEGIN

/**
 *  Parent class for other TPU query classes.
 */
@interface GTLRTPUQuery : GTLRQuery

/** Selector specifying which fields to include in a partial response. */
@property(nonatomic, copy, nullable) NSString *fields;

@end

/**
 *  Gets AcceleratorType.
 *
 *  Method: tpu.projects.locations.acceleratorTypes.get
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeTPUCloudPlatform
 */
@interface GTLRTPUQuery_ProjectsLocationsAcceleratorTypesGet : GTLRTPUQuery

/** Required. The resource name. */
@property(nonatomic, copy, nullable) NSString *name;

/**
 *  Fetches a @c GTLRTPU_AcceleratorType.
 *
 *  Gets AcceleratorType.
 *
 *  @param name Required. The resource name.
 *
 *  @return GTLRTPUQuery_ProjectsLocationsAcceleratorTypesGet
 */
+ (instancetype)queryWithName:(NSString *)name;

@end

/**
 *  Lists accelerator types supported by this API.
 *
 *  Method: tpu.projects.locations.acceleratorTypes.list
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeTPUCloudPlatform
 */
@interface GTLRTPUQuery_ProjectsLocationsAcceleratorTypesList : GTLRTPUQuery

/** List filter. */
@property(nonatomic, copy, nullable) NSString *filter;

/** Sort results. */
@property(nonatomic, copy, nullable) NSString *orderBy;

/** The maximum number of items to return. */
@property(nonatomic, assign) NSInteger pageSize;

/**
 *  The next_page_token value returned from a previous List request, if any.
 */
@property(nonatomic, copy, nullable) NSString *pageToken;

/** Required. The parent resource name. */
@property(nonatomic, copy, nullable) NSString *parent;

/**
 *  Fetches a @c GTLRTPU_ListAcceleratorTypesResponse.
 *
 *  Lists accelerator types supported by this API.
 *
 *  @param parent Required. The parent resource name.
 *
 *  @return GTLRTPUQuery_ProjectsLocationsAcceleratorTypesList
 *
 *  @note Automatic pagination will be done when @c shouldFetchNextPages is
 *        enabled. See @c shouldFetchNextPages on @c GTLRService for more
 *        information.
 */
+ (instancetype)queryWithParent:(NSString *)parent;

@end

/**
 *  Generates the Cloud TPU service identity for the project.
 *
 *  Method: tpu.projects.locations.generateServiceIdentity
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeTPUCloudPlatform
 */
@interface GTLRTPUQuery_ProjectsLocationsGenerateServiceIdentity : GTLRTPUQuery

/** Required. The parent resource name. */
@property(nonatomic, copy, nullable) NSString *parent;

/**
 *  Fetches a @c GTLRTPU_GenerateServiceIdentityResponse.
 *
 *  Generates the Cloud TPU service identity for the project.
 *
 *  @param object The @c GTLRTPU_GenerateServiceIdentityRequest to include in
 *    the query.
 *  @param parent Required. The parent resource name.
 *
 *  @return GTLRTPUQuery_ProjectsLocationsGenerateServiceIdentity
 */
+ (instancetype)queryWithObject:(GTLRTPU_GenerateServiceIdentityRequest *)object
                         parent:(NSString *)parent;

@end

/**
 *  Gets information about a location.
 *
 *  Method: tpu.projects.locations.get
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeTPUCloudPlatform
 */
@interface GTLRTPUQuery_ProjectsLocationsGet : GTLRTPUQuery

/** Resource name for the location. */
@property(nonatomic, copy, nullable) NSString *name;

/**
 *  Fetches a @c GTLRTPU_Location.
 *
 *  Gets information about a location.
 *
 *  @param name Resource name for the location.
 *
 *  @return GTLRTPUQuery_ProjectsLocationsGet
 */
+ (instancetype)queryWithName:(NSString *)name;

@end

/**
 *  Lists information about the supported locations for this service.
 *
 *  Method: tpu.projects.locations.list
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeTPUCloudPlatform
 */
@interface GTLRTPUQuery_ProjectsLocationsList : GTLRTPUQuery

/**
 *  A filter to narrow down results to a preferred subset. The filtering
 *  language accepts strings like `"displayName=tokyo"`, and is documented in
 *  more detail in [AIP-160](https://google.aip.dev/160).
 */
@property(nonatomic, copy, nullable) NSString *filter;

/** The resource that owns the locations collection, if applicable. */
@property(nonatomic, copy, nullable) NSString *name;

/**
 *  The maximum number of results to return. If not set, the service selects a
 *  default.
 */
@property(nonatomic, assign) NSInteger pageSize;

/**
 *  A page token received from the `next_page_token` field in the response. Send
 *  that page token to receive the subsequent page.
 */
@property(nonatomic, copy, nullable) NSString *pageToken;

/**
 *  Fetches a @c GTLRTPU_ListLocationsResponse.
 *
 *  Lists information about the supported locations for this service.
 *
 *  @param name The resource that owns the locations collection, if applicable.
 *
 *  @return GTLRTPUQuery_ProjectsLocationsList
 *
 *  @note Automatic pagination will be done when @c shouldFetchNextPages is
 *        enabled. See @c shouldFetchNextPages on @c GTLRService for more
 *        information.
 */
+ (instancetype)queryWithName:(NSString *)name;

@end

/**
 *  Creates a node.
 *
 *  Method: tpu.projects.locations.nodes.create
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeTPUCloudPlatform
 */
@interface GTLRTPUQuery_ProjectsLocationsNodesCreate : GTLRTPUQuery

/** The unqualified resource name. */
@property(nonatomic, copy, nullable) NSString *nodeId;

/** Required. The parent resource name. */
@property(nonatomic, copy, nullable) NSString *parent;

/**
 *  Fetches a @c GTLRTPU_Operation.
 *
 *  Creates a node.
 *
 *  @param object The @c GTLRTPU_Node to include in the query.
 *  @param parent Required. The parent resource name.
 *
 *  @return GTLRTPUQuery_ProjectsLocationsNodesCreate
 */
+ (instancetype)queryWithObject:(GTLRTPU_Node *)object
                         parent:(NSString *)parent;

@end

/**
 *  Deletes a node.
 *
 *  Method: tpu.projects.locations.nodes.delete
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeTPUCloudPlatform
 */
@interface GTLRTPUQuery_ProjectsLocationsNodesDelete : GTLRTPUQuery

/** Required. The resource name. */
@property(nonatomic, copy, nullable) NSString *name;

/**
 *  Fetches a @c GTLRTPU_Operation.
 *
 *  Deletes a node.
 *
 *  @param name Required. The resource name.
 *
 *  @return GTLRTPUQuery_ProjectsLocationsNodesDelete
 */
+ (instancetype)queryWithName:(NSString *)name;

@end

/**
 *  Gets the details of a node.
 *
 *  Method: tpu.projects.locations.nodes.get
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeTPUCloudPlatform
 */
@interface GTLRTPUQuery_ProjectsLocationsNodesGet : GTLRTPUQuery

/** Required. The resource name. */
@property(nonatomic, copy, nullable) NSString *name;

/**
 *  Fetches a @c GTLRTPU_Node.
 *
 *  Gets the details of a node.
 *
 *  @param name Required. The resource name.
 *
 *  @return GTLRTPUQuery_ProjectsLocationsNodesGet
 */
+ (instancetype)queryWithName:(NSString *)name;

@end

/**
 *  Retrieves the guest attributes for the node.
 *
 *  Method: tpu.projects.locations.nodes.getGuestAttributes
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeTPUCloudPlatform
 */
@interface GTLRTPUQuery_ProjectsLocationsNodesGetGuestAttributes : GTLRTPUQuery

/** Required. The resource name. */
@property(nonatomic, copy, nullable) NSString *name;

/**
 *  Fetches a @c GTLRTPU_GetGuestAttributesResponse.
 *
 *  Retrieves the guest attributes for the node.
 *
 *  @param object The @c GTLRTPU_GetGuestAttributesRequest to include in the
 *    query.
 *  @param name Required. The resource name.
 *
 *  @return GTLRTPUQuery_ProjectsLocationsNodesGetGuestAttributes
 */
+ (instancetype)queryWithObject:(GTLRTPU_GetGuestAttributesRequest *)object
                           name:(NSString *)name;

@end

/**
 *  Lists nodes.
 *
 *  Method: tpu.projects.locations.nodes.list
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeTPUCloudPlatform
 */
@interface GTLRTPUQuery_ProjectsLocationsNodesList : GTLRTPUQuery

/** The maximum number of items to return. */
@property(nonatomic, assign) NSInteger pageSize;

/**
 *  The next_page_token value returned from a previous List request, if any.
 */
@property(nonatomic, copy, nullable) NSString *pageToken;

/** Required. The parent resource name. */
@property(nonatomic, copy, nullable) NSString *parent;

/**
 *  Fetches a @c GTLRTPU_ListNodesResponse.
 *
 *  Lists nodes.
 *
 *  @param parent Required. The parent resource name.
 *
 *  @return GTLRTPUQuery_ProjectsLocationsNodesList
 *
 *  @note Automatic pagination will be done when @c shouldFetchNextPages is
 *        enabled. See @c shouldFetchNextPages on @c GTLRService for more
 *        information.
 */
+ (instancetype)queryWithParent:(NSString *)parent;

@end

/**
 *  Updates the configurations of a node.
 *
 *  Method: tpu.projects.locations.nodes.patch
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeTPUCloudPlatform
 */
@interface GTLRTPUQuery_ProjectsLocationsNodesPatch : GTLRTPUQuery

/** Output only. Immutable. The name of the TPU. */
@property(nonatomic, copy, nullable) NSString *name;

/**
 *  Required. Mask of fields from Node to update. Supported fields:
 *  [description, tags, labels, metadata, network_config.enable_external_ips].
 *
 *  String format is a comma-separated list of fields.
 */
@property(nonatomic, copy, nullable) NSString *updateMask;

/**
 *  Fetches a @c GTLRTPU_Operation.
 *
 *  Updates the configurations of a node.
 *
 *  @param object The @c GTLRTPU_Node to include in the query.
 *  @param name Output only. Immutable. The name of the TPU.
 *
 *  @return GTLRTPUQuery_ProjectsLocationsNodesPatch
 */
+ (instancetype)queryWithObject:(GTLRTPU_Node *)object
                           name:(NSString *)name;

@end

/**
 *  Starts a node.
 *
 *  Method: tpu.projects.locations.nodes.start
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeTPUCloudPlatform
 */
@interface GTLRTPUQuery_ProjectsLocationsNodesStart : GTLRTPUQuery

/** Required. The resource name. */
@property(nonatomic, copy, nullable) NSString *name;

/**
 *  Fetches a @c GTLRTPU_Operation.
 *
 *  Starts a node.
 *
 *  @param object The @c GTLRTPU_StartNodeRequest to include in the query.
 *  @param name Required. The resource name.
 *
 *  @return GTLRTPUQuery_ProjectsLocationsNodesStart
 */
+ (instancetype)queryWithObject:(GTLRTPU_StartNodeRequest *)object
                           name:(NSString *)name;

@end

/**
 *  Stops a node. This operation is only available with single TPU nodes.
 *
 *  Method: tpu.projects.locations.nodes.stop
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeTPUCloudPlatform
 */
@interface GTLRTPUQuery_ProjectsLocationsNodesStop : GTLRTPUQuery

/** Required. The resource name. */
@property(nonatomic, copy, nullable) NSString *name;

/**
 *  Fetches a @c GTLRTPU_Operation.
 *
 *  Stops a node. This operation is only available with single TPU nodes.
 *
 *  @param object The @c GTLRTPU_StopNodeRequest to include in the query.
 *  @param name Required. The resource name.
 *
 *  @return GTLRTPUQuery_ProjectsLocationsNodesStop
 */
+ (instancetype)queryWithObject:(GTLRTPU_StopNodeRequest *)object
                           name:(NSString *)name;

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
 *  Method: tpu.projects.locations.operations.cancel
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeTPUCloudPlatform
 */
@interface GTLRTPUQuery_ProjectsLocationsOperationsCancel : GTLRTPUQuery

/** The name of the operation resource to be cancelled. */
@property(nonatomic, copy, nullable) NSString *name;

/**
 *  Fetches a @c GTLRTPU_Empty.
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
 *  @param name The name of the operation resource to be cancelled.
 *
 *  @return GTLRTPUQuery_ProjectsLocationsOperationsCancel
 */
+ (instancetype)queryWithName:(NSString *)name;

@end

/**
 *  Deletes a long-running operation. This method indicates that the client is
 *  no longer interested in the operation result. It does not cancel the
 *  operation. If the server doesn't support this method, it returns
 *  `google.rpc.Code.UNIMPLEMENTED`.
 *
 *  Method: tpu.projects.locations.operations.delete
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeTPUCloudPlatform
 */
@interface GTLRTPUQuery_ProjectsLocationsOperationsDelete : GTLRTPUQuery

/** The name of the operation resource to be deleted. */
@property(nonatomic, copy, nullable) NSString *name;

/**
 *  Fetches a @c GTLRTPU_Empty.
 *
 *  Deletes a long-running operation. This method indicates that the client is
 *  no longer interested in the operation result. It does not cancel the
 *  operation. If the server doesn't support this method, it returns
 *  `google.rpc.Code.UNIMPLEMENTED`.
 *
 *  @param name The name of the operation resource to be deleted.
 *
 *  @return GTLRTPUQuery_ProjectsLocationsOperationsDelete
 */
+ (instancetype)queryWithName:(NSString *)name;

@end

/**
 *  Gets the latest state of a long-running operation. Clients can use this
 *  method to poll the operation result at intervals as recommended by the API
 *  service.
 *
 *  Method: tpu.projects.locations.operations.get
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeTPUCloudPlatform
 */
@interface GTLRTPUQuery_ProjectsLocationsOperationsGet : GTLRTPUQuery

/** The name of the operation resource. */
@property(nonatomic, copy, nullable) NSString *name;

/**
 *  Fetches a @c GTLRTPU_Operation.
 *
 *  Gets the latest state of a long-running operation. Clients can use this
 *  method to poll the operation result at intervals as recommended by the API
 *  service.
 *
 *  @param name The name of the operation resource.
 *
 *  @return GTLRTPUQuery_ProjectsLocationsOperationsGet
 */
+ (instancetype)queryWithName:(NSString *)name;

@end

/**
 *  Lists operations that match the specified filter in the request. If the
 *  server doesn't support this method, it returns `UNIMPLEMENTED`.
 *
 *  Method: tpu.projects.locations.operations.list
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeTPUCloudPlatform
 */
@interface GTLRTPUQuery_ProjectsLocationsOperationsList : GTLRTPUQuery

/** The standard list filter. */
@property(nonatomic, copy, nullable) NSString *filter;

/** The name of the operation's parent resource. */
@property(nonatomic, copy, nullable) NSString *name;

/** The standard list page size. */
@property(nonatomic, assign) NSInteger pageSize;

/** The standard list page token. */
@property(nonatomic, copy, nullable) NSString *pageToken;

/**
 *  Fetches a @c GTLRTPU_ListOperationsResponse.
 *
 *  Lists operations that match the specified filter in the request. If the
 *  server doesn't support this method, it returns `UNIMPLEMENTED`.
 *
 *  @param name The name of the operation's parent resource.
 *
 *  @return GTLRTPUQuery_ProjectsLocationsOperationsList
 *
 *  @note Automatic pagination will be done when @c shouldFetchNextPages is
 *        enabled. See @c shouldFetchNextPages on @c GTLRService for more
 *        information.
 */
+ (instancetype)queryWithName:(NSString *)name;

@end

/**
 *  Gets a runtime version.
 *
 *  Method: tpu.projects.locations.runtimeVersions.get
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeTPUCloudPlatform
 */
@interface GTLRTPUQuery_ProjectsLocationsRuntimeVersionsGet : GTLRTPUQuery

/** Required. The resource name. */
@property(nonatomic, copy, nullable) NSString *name;

/**
 *  Fetches a @c GTLRTPU_RuntimeVersion.
 *
 *  Gets a runtime version.
 *
 *  @param name Required. The resource name.
 *
 *  @return GTLRTPUQuery_ProjectsLocationsRuntimeVersionsGet
 */
+ (instancetype)queryWithName:(NSString *)name;

@end

/**
 *  Lists runtime versions supported by this API.
 *
 *  Method: tpu.projects.locations.runtimeVersions.list
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeTPUCloudPlatform
 */
@interface GTLRTPUQuery_ProjectsLocationsRuntimeVersionsList : GTLRTPUQuery

/** List filter. */
@property(nonatomic, copy, nullable) NSString *filter;

/** Sort results. */
@property(nonatomic, copy, nullable) NSString *orderBy;

/** The maximum number of items to return. */
@property(nonatomic, assign) NSInteger pageSize;

/**
 *  The next_page_token value returned from a previous List request, if any.
 */
@property(nonatomic, copy, nullable) NSString *pageToken;

/** Required. The parent resource name. */
@property(nonatomic, copy, nullable) NSString *parent;

/**
 *  Fetches a @c GTLRTPU_ListRuntimeVersionsResponse.
 *
 *  Lists runtime versions supported by this API.
 *
 *  @param parent Required. The parent resource name.
 *
 *  @return GTLRTPUQuery_ProjectsLocationsRuntimeVersionsList
 *
 *  @note Automatic pagination will be done when @c shouldFetchNextPages is
 *        enabled. See @c shouldFetchNextPages on @c GTLRService for more
 *        information.
 */
+ (instancetype)queryWithParent:(NSString *)parent;

@end

NS_ASSUME_NONNULL_END

#pragma clang diagnostic pop
