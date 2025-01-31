// NOTE: This file was generated by the ServiceGenerator.

// ----------------------------------------------------------------------------
// API:
//   Data pipelines API (datapipelines/v1)
// Description:
//   Data Pipelines provides an interface for creating, updating, and managing
//   recurring Data Analytics jobs.
// Documentation:
//   https://cloud.google.com/dataflow/docs/guides/data-pipelines

#import <GoogleAPIClientForREST/GTLRQuery.h>

#if GTLR_RUNTIME_VERSION != 3000
#error This file was generated by a different version of ServiceGenerator which is incompatible with this GTLR library source.
#endif

#import "GTLRDatapipelinesObjects.h"

// Generated comments include content from the discovery document; avoid them
// causing warnings since clang's checks are some what arbitrary.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

NS_ASSUME_NONNULL_BEGIN

/**
 *  Parent class for other Datapipelines query classes.
 */
@interface GTLRDatapipelinesQuery : GTLRQuery

/** Selector specifying which fields to include in a partial response. */
@property(nonatomic, copy, nullable) NSString *fields;

@end

/**
 *  Creates a pipeline. For a batch pipeline, you can pass scheduler
 *  information. Data Pipelines uses the scheduler information to create an
 *  internal scheduler that runs jobs periodically. If the internal scheduler is
 *  not configured, you can use RunPipeline to run jobs.
 *
 *  Method: datapipelines.projects.locations.pipelines.create
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeDatapipelinesCloudPlatform
 */
@interface GTLRDatapipelinesQuery_ProjectsLocationsPipelinesCreate : GTLRDatapipelinesQuery

/**
 *  Required. The location name. For example:
 *  `projects/PROJECT_ID/locations/LOCATION_ID`.
 */
@property(nonatomic, copy, nullable) NSString *parent;

/**
 *  Fetches a @c GTLRDatapipelines_GoogleCloudDatapipelinesV1Pipeline.
 *
 *  Creates a pipeline. For a batch pipeline, you can pass scheduler
 *  information. Data Pipelines uses the scheduler information to create an
 *  internal scheduler that runs jobs periodically. If the internal scheduler is
 *  not configured, you can use RunPipeline to run jobs.
 *
 *  @param object The @c GTLRDatapipelines_GoogleCloudDatapipelinesV1Pipeline to
 *    include in the query.
 *  @param parent Required. The location name. For example:
 *    `projects/PROJECT_ID/locations/LOCATION_ID`.
 *
 *  @return GTLRDatapipelinesQuery_ProjectsLocationsPipelinesCreate
 */
+ (instancetype)queryWithObject:(GTLRDatapipelines_GoogleCloudDatapipelinesV1Pipeline *)object
                         parent:(NSString *)parent;

@end

/**
 *  Deletes a pipeline. If a scheduler job is attached to the pipeline, it will
 *  be deleted.
 *
 *  Method: datapipelines.projects.locations.pipelines.delete
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeDatapipelinesCloudPlatform
 */
@interface GTLRDatapipelinesQuery_ProjectsLocationsPipelinesDelete : GTLRDatapipelinesQuery

/**
 *  Required. The pipeline name. For example:
 *  `projects/PROJECT_ID/locations/LOCATION_ID/pipelines/PIPELINE_ID`.
 */
@property(nonatomic, copy, nullable) NSString *name;

/**
 *  Fetches a @c GTLRDatapipelines_GoogleProtobufEmpty.
 *
 *  Deletes a pipeline. If a scheduler job is attached to the pipeline, it will
 *  be deleted.
 *
 *  @param name Required. The pipeline name. For example:
 *    `projects/PROJECT_ID/locations/LOCATION_ID/pipelines/PIPELINE_ID`.
 *
 *  @return GTLRDatapipelinesQuery_ProjectsLocationsPipelinesDelete
 */
+ (instancetype)queryWithName:(NSString *)name;

@end

/**
 *  Looks up a single pipeline. Returns a "NOT_FOUND" error if no such pipeline
 *  exists. Returns a "FORBIDDEN" error if the caller doesn't have permission to
 *  access it.
 *
 *  Method: datapipelines.projects.locations.pipelines.get
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeDatapipelinesCloudPlatform
 */
@interface GTLRDatapipelinesQuery_ProjectsLocationsPipelinesGet : GTLRDatapipelinesQuery

/**
 *  Required. The pipeline name. For example:
 *  `projects/PROJECT_ID/locations/LOCATION_ID/pipelines/PIPELINE_ID`.
 */
@property(nonatomic, copy, nullable) NSString *name;

/**
 *  Fetches a @c GTLRDatapipelines_GoogleCloudDatapipelinesV1Pipeline.
 *
 *  Looks up a single pipeline. Returns a "NOT_FOUND" error if no such pipeline
 *  exists. Returns a "FORBIDDEN" error if the caller doesn't have permission to
 *  access it.
 *
 *  @param name Required. The pipeline name. For example:
 *    `projects/PROJECT_ID/locations/LOCATION_ID/pipelines/PIPELINE_ID`.
 *
 *  @return GTLRDatapipelinesQuery_ProjectsLocationsPipelinesGet
 */
+ (instancetype)queryWithName:(NSString *)name;

@end

/**
 *  Lists jobs for a given pipeline. Throws a "FORBIDDEN" error if the caller
 *  doesn't have permission to access it.
 *
 *  Method: datapipelines.projects.locations.pipelines.jobs.list
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeDatapipelinesCloudPlatform
 */
@interface GTLRDatapipelinesQuery_ProjectsLocationsPipelinesJobsList : GTLRDatapipelinesQuery

/**
 *  The maximum number of entities to return. The service may return fewer than
 *  this value, even if there are additional pages. If unspecified, the max
 *  limit will be determined by the backend implementation.
 */
@property(nonatomic, assign) NSInteger pageSize;

/**
 *  A page token, received from a previous `ListJobs` call. Provide this to
 *  retrieve the subsequent page. When paginating, all other parameters provided
 *  to `ListJobs` must match the call that provided the page token.
 */
@property(nonatomic, copy, nullable) NSString *pageToken;

/**
 *  Required. The pipeline name. For example:
 *  `projects/PROJECT_ID/locations/LOCATION_ID/pipelines/PIPELINE_ID`.
 */
@property(nonatomic, copy, nullable) NSString *parent;

/**
 *  Fetches a @c GTLRDatapipelines_GoogleCloudDatapipelinesV1ListJobsResponse.
 *
 *  Lists jobs for a given pipeline. Throws a "FORBIDDEN" error if the caller
 *  doesn't have permission to access it.
 *
 *  @param parent Required. The pipeline name. For example:
 *    `projects/PROJECT_ID/locations/LOCATION_ID/pipelines/PIPELINE_ID`.
 *
 *  @return GTLRDatapipelinesQuery_ProjectsLocationsPipelinesJobsList
 *
 *  @note Automatic pagination will be done when @c shouldFetchNextPages is
 *        enabled. See @c shouldFetchNextPages on @c GTLRService for more
 *        information.
 */
+ (instancetype)queryWithParent:(NSString *)parent;

@end

/**
 *  Lists pipelines. Returns a "FORBIDDEN" error if the caller doesn't have
 *  permission to access it.
 *
 *  Method: datapipelines.projects.locations.pipelines.list
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeDatapipelinesCloudPlatform
 */
@interface GTLRDatapipelinesQuery_ProjectsLocationsPipelinesList : GTLRDatapipelinesQuery

/**
 *  An expression for filtering the results of the request. If unspecified, all
 *  pipelines will be returned. Multiple filters can be applied and must be
 *  comma separated. Fields eligible for filtering are: + `type`: The type of
 *  the pipeline (streaming or batch). Allowed values are `ALL`, `BATCH`, and
 *  `STREAMING`. + `status`: The activity status of the pipeline. Allowed values
 *  are `ALL`, `ACTIVE`, `ARCHIVED`, and `PAUSED`. For example, to limit results
 *  to active batch processing pipelines: type:BATCH,status:ACTIVE
 */
@property(nonatomic, copy, nullable) NSString *filter;

/**
 *  The maximum number of entities to return. The service may return fewer than
 *  this value, even if there are additional pages. If unspecified, the max
 *  limit is yet to be determined by the backend implementation.
 */
@property(nonatomic, assign) NSInteger pageSize;

/**
 *  A page token, received from a previous `ListPipelines` call. Provide this to
 *  retrieve the subsequent page. When paginating, all other parameters provided
 *  to `ListPipelines` must match the call that provided the page token.
 */
@property(nonatomic, copy, nullable) NSString *pageToken;

/**
 *  Required. The location name. For example:
 *  `projects/PROJECT_ID/locations/LOCATION_ID`.
 */
@property(nonatomic, copy, nullable) NSString *parent;

/**
 *  Fetches a @c
 *  GTLRDatapipelines_GoogleCloudDatapipelinesV1ListPipelinesResponse.
 *
 *  Lists pipelines. Returns a "FORBIDDEN" error if the caller doesn't have
 *  permission to access it.
 *
 *  @param parent Required. The location name. For example:
 *    `projects/PROJECT_ID/locations/LOCATION_ID`.
 *
 *  @return GTLRDatapipelinesQuery_ProjectsLocationsPipelinesList
 *
 *  @note Automatic pagination will be done when @c shouldFetchNextPages is
 *        enabled. See @c shouldFetchNextPages on @c GTLRService for more
 *        information.
 */
+ (instancetype)queryWithParent:(NSString *)parent;

@end

/**
 *  Updates a pipeline. If successful, the updated Pipeline is returned. Returns
 *  `NOT_FOUND` if the pipeline doesn't exist. If UpdatePipeline does not return
 *  successfully, you can retry the UpdatePipeline request until you receive a
 *  successful response.
 *
 *  Method: datapipelines.projects.locations.pipelines.patch
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeDatapipelinesCloudPlatform
 */
@interface GTLRDatapipelinesQuery_ProjectsLocationsPipelinesPatch : GTLRDatapipelinesQuery

/**
 *  The pipeline name. For example:
 *  `projects/PROJECT_ID/locations/LOCATION_ID/pipelines/PIPELINE_ID`. *
 *  `PROJECT_ID` can contain letters ([A-Za-z]), numbers ([0-9]), hyphens (-),
 *  colons (:), and periods (.). For more information, see [Identifying
 *  projects](https://cloud.google.com/resource-manager/docs/creating-managing-projects#identifying_projects).
 *  * `LOCATION_ID` is the canonical ID for the pipeline's location. The list of
 *  available locations can be obtained by calling
 *  `google.cloud.location.Locations.ListLocations`. Note that the Data
 *  Pipelines service is not available in all regions. It depends on Cloud
 *  Scheduler, an App Engine application, so it's only available in [App Engine
 *  regions](https://cloud.google.com/about/locations#region). * `PIPELINE_ID`
 *  is the ID of the pipeline. Must be unique for the selected project and
 *  location.
 */
@property(nonatomic, copy, nullable) NSString *name;

/**
 *  The list of fields to be updated.
 *
 *  String format is a comma-separated list of fields.
 */
@property(nonatomic, copy, nullable) NSString *updateMask;

/**
 *  Fetches a @c GTLRDatapipelines_GoogleCloudDatapipelinesV1Pipeline.
 *
 *  Updates a pipeline. If successful, the updated Pipeline is returned. Returns
 *  `NOT_FOUND` if the pipeline doesn't exist. If UpdatePipeline does not return
 *  successfully, you can retry the UpdatePipeline request until you receive a
 *  successful response.
 *
 *  @param object The @c GTLRDatapipelines_GoogleCloudDatapipelinesV1Pipeline to
 *    include in the query.
 *  @param name The pipeline name. For example:
 *    `projects/PROJECT_ID/locations/LOCATION_ID/pipelines/PIPELINE_ID`. *
 *    `PROJECT_ID` can contain letters ([A-Za-z]), numbers ([0-9]), hyphens (-),
 *    colons (:), and periods (.). For more information, see [Identifying
 *    projects](https://cloud.google.com/resource-manager/docs/creating-managing-projects#identifying_projects).
 *    * `LOCATION_ID` is the canonical ID for the pipeline's location. The list
 *    of available locations can be obtained by calling
 *    `google.cloud.location.Locations.ListLocations`. Note that the Data
 *    Pipelines service is not available in all regions. It depends on Cloud
 *    Scheduler, an App Engine application, so it's only available in [App
 *    Engine regions](https://cloud.google.com/about/locations#region). *
 *    `PIPELINE_ID` is the ID of the pipeline. Must be unique for the selected
 *    project and location.
 *
 *  @return GTLRDatapipelinesQuery_ProjectsLocationsPipelinesPatch
 */
+ (instancetype)queryWithObject:(GTLRDatapipelines_GoogleCloudDatapipelinesV1Pipeline *)object
                           name:(NSString *)name;

@end

/**
 *  Creates a job for the specified pipeline directly. You can use this method
 *  when the internal scheduler is not configured and you want to trigger the
 *  job directly or through an external system. Returns a "NOT_FOUND" error if
 *  the pipeline doesn't exist. Returns a "FORBIDDEN" error if the user doesn't
 *  have permission to access the pipeline or run jobs for the pipeline.
 *
 *  Method: datapipelines.projects.locations.pipelines.run
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeDatapipelinesCloudPlatform
 */
@interface GTLRDatapipelinesQuery_ProjectsLocationsPipelinesRun : GTLRDatapipelinesQuery

/**
 *  Required. The pipeline name. For example:
 *  `projects/PROJECT_ID/locations/LOCATION_ID/pipelines/PIPELINE_ID`.
 */
@property(nonatomic, copy, nullable) NSString *name;

/**
 *  Fetches a @c
 *  GTLRDatapipelines_GoogleCloudDatapipelinesV1RunPipelineResponse.
 *
 *  Creates a job for the specified pipeline directly. You can use this method
 *  when the internal scheduler is not configured and you want to trigger the
 *  job directly or through an external system. Returns a "NOT_FOUND" error if
 *  the pipeline doesn't exist. Returns a "FORBIDDEN" error if the user doesn't
 *  have permission to access the pipeline or run jobs for the pipeline.
 *
 *  @param object The @c
 *    GTLRDatapipelines_GoogleCloudDatapipelinesV1RunPipelineRequest to include
 *    in the query.
 *  @param name Required. The pipeline name. For example:
 *    `projects/PROJECT_ID/locations/LOCATION_ID/pipelines/PIPELINE_ID`.
 *
 *  @return GTLRDatapipelinesQuery_ProjectsLocationsPipelinesRun
 */
+ (instancetype)queryWithObject:(GTLRDatapipelines_GoogleCloudDatapipelinesV1RunPipelineRequest *)object
                           name:(NSString *)name;

@end

/**
 *  Freezes pipeline execution permanently. If there's a corresponding scheduler
 *  entry, it's deleted, and the pipeline state is changed to "ARCHIVED".
 *  However, pipeline metadata is retained.
 *
 *  Method: datapipelines.projects.locations.pipelines.stop
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeDatapipelinesCloudPlatform
 */
@interface GTLRDatapipelinesQuery_ProjectsLocationsPipelinesStop : GTLRDatapipelinesQuery

/**
 *  Required. The pipeline name. For example:
 *  `projects/PROJECT_ID/locations/LOCATION_ID/pipelines/PIPELINE_ID`.
 */
@property(nonatomic, copy, nullable) NSString *name;

/**
 *  Fetches a @c GTLRDatapipelines_GoogleCloudDatapipelinesV1Pipeline.
 *
 *  Freezes pipeline execution permanently. If there's a corresponding scheduler
 *  entry, it's deleted, and the pipeline state is changed to "ARCHIVED".
 *  However, pipeline metadata is retained.
 *
 *  @param object The @c
 *    GTLRDatapipelines_GoogleCloudDatapipelinesV1StopPipelineRequest to include
 *    in the query.
 *  @param name Required. The pipeline name. For example:
 *    `projects/PROJECT_ID/locations/LOCATION_ID/pipelines/PIPELINE_ID`.
 *
 *  @return GTLRDatapipelinesQuery_ProjectsLocationsPipelinesStop
 */
+ (instancetype)queryWithObject:(GTLRDatapipelines_GoogleCloudDatapipelinesV1StopPipelineRequest *)object
                           name:(NSString *)name;

@end

NS_ASSUME_NONNULL_END

#pragma clang diagnostic pop
