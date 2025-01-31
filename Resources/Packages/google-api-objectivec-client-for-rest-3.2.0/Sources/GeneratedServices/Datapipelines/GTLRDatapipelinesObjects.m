// NOTE: This file was generated by the ServiceGenerator.

// ----------------------------------------------------------------------------
// API:
//   Data pipelines API (datapipelines/v1)
// Description:
//   Data Pipelines provides an interface for creating, updating, and managing
//   recurring Data Analytics jobs.
// Documentation:
//   https://cloud.google.com/dataflow/docs/guides/data-pipelines

#import <GoogleAPIClientForREST/GTLRDatapipelinesObjects.h>

// ----------------------------------------------------------------------------
// Constants

// GTLRDatapipelines_GoogleCloudDatapipelinesV1FlexTemplateRuntimeEnvironment.flexrsGoal
NSString * const kGTLRDatapipelines_GoogleCloudDatapipelinesV1FlexTemplateRuntimeEnvironment_FlexrsGoal_FlexrsCostOptimized = @"FLEXRS_COST_OPTIMIZED";
NSString * const kGTLRDatapipelines_GoogleCloudDatapipelinesV1FlexTemplateRuntimeEnvironment_FlexrsGoal_FlexrsSpeedOptimized = @"FLEXRS_SPEED_OPTIMIZED";
NSString * const kGTLRDatapipelines_GoogleCloudDatapipelinesV1FlexTemplateRuntimeEnvironment_FlexrsGoal_FlexrsUnspecified = @"FLEXRS_UNSPECIFIED";

// GTLRDatapipelines_GoogleCloudDatapipelinesV1FlexTemplateRuntimeEnvironment.ipConfiguration
NSString * const kGTLRDatapipelines_GoogleCloudDatapipelinesV1FlexTemplateRuntimeEnvironment_IpConfiguration_WorkerIpPrivate = @"WORKER_IP_PRIVATE";
NSString * const kGTLRDatapipelines_GoogleCloudDatapipelinesV1FlexTemplateRuntimeEnvironment_IpConfiguration_WorkerIpPublic = @"WORKER_IP_PUBLIC";
NSString * const kGTLRDatapipelines_GoogleCloudDatapipelinesV1FlexTemplateRuntimeEnvironment_IpConfiguration_WorkerIpUnspecified = @"WORKER_IP_UNSPECIFIED";

// GTLRDatapipelines_GoogleCloudDatapipelinesV1Job.state
NSString * const kGTLRDatapipelines_GoogleCloudDatapipelinesV1Job_State_StateCancelled = @"STATE_CANCELLED";
NSString * const kGTLRDatapipelines_GoogleCloudDatapipelinesV1Job_State_StateDone = @"STATE_DONE";
NSString * const kGTLRDatapipelines_GoogleCloudDatapipelinesV1Job_State_StateFailed = @"STATE_FAILED";
NSString * const kGTLRDatapipelines_GoogleCloudDatapipelinesV1Job_State_StatePending = @"STATE_PENDING";
NSString * const kGTLRDatapipelines_GoogleCloudDatapipelinesV1Job_State_StateRunning = @"STATE_RUNNING";
NSString * const kGTLRDatapipelines_GoogleCloudDatapipelinesV1Job_State_StateUnspecified = @"STATE_UNSPECIFIED";

// GTLRDatapipelines_GoogleCloudDatapipelinesV1Pipeline.state
NSString * const kGTLRDatapipelines_GoogleCloudDatapipelinesV1Pipeline_State_StateActive = @"STATE_ACTIVE";
NSString * const kGTLRDatapipelines_GoogleCloudDatapipelinesV1Pipeline_State_StateArchived = @"STATE_ARCHIVED";
NSString * const kGTLRDatapipelines_GoogleCloudDatapipelinesV1Pipeline_State_StatePaused = @"STATE_PAUSED";
NSString * const kGTLRDatapipelines_GoogleCloudDatapipelinesV1Pipeline_State_StateResuming = @"STATE_RESUMING";
NSString * const kGTLRDatapipelines_GoogleCloudDatapipelinesV1Pipeline_State_StateStopping = @"STATE_STOPPING";
NSString * const kGTLRDatapipelines_GoogleCloudDatapipelinesV1Pipeline_State_StateUnspecified = @"STATE_UNSPECIFIED";

// GTLRDatapipelines_GoogleCloudDatapipelinesV1Pipeline.type
NSString * const kGTLRDatapipelines_GoogleCloudDatapipelinesV1Pipeline_Type_PipelineTypeBatch = @"PIPELINE_TYPE_BATCH";
NSString * const kGTLRDatapipelines_GoogleCloudDatapipelinesV1Pipeline_Type_PipelineTypeStreaming = @"PIPELINE_TYPE_STREAMING";
NSString * const kGTLRDatapipelines_GoogleCloudDatapipelinesV1Pipeline_Type_PipelineTypeUnspecified = @"PIPELINE_TYPE_UNSPECIFIED";

// GTLRDatapipelines_GoogleCloudDatapipelinesV1RuntimeEnvironment.ipConfiguration
NSString * const kGTLRDatapipelines_GoogleCloudDatapipelinesV1RuntimeEnvironment_IpConfiguration_WorkerIpPrivate = @"WORKER_IP_PRIVATE";
NSString * const kGTLRDatapipelines_GoogleCloudDatapipelinesV1RuntimeEnvironment_IpConfiguration_WorkerIpPublic = @"WORKER_IP_PUBLIC";
NSString * const kGTLRDatapipelines_GoogleCloudDatapipelinesV1RuntimeEnvironment_IpConfiguration_WorkerIpUnspecified = @"WORKER_IP_UNSPECIFIED";

// GTLRDatapipelines_GoogleCloudDatapipelinesV1SdkVersion.sdkSupportStatus
NSString * const kGTLRDatapipelines_GoogleCloudDatapipelinesV1SdkVersion_SdkSupportStatus_Deprecated = @"DEPRECATED";
NSString * const kGTLRDatapipelines_GoogleCloudDatapipelinesV1SdkVersion_SdkSupportStatus_Stale = @"STALE";
NSString * const kGTLRDatapipelines_GoogleCloudDatapipelinesV1SdkVersion_SdkSupportStatus_Supported = @"SUPPORTED";
NSString * const kGTLRDatapipelines_GoogleCloudDatapipelinesV1SdkVersion_SdkSupportStatus_Unknown = @"UNKNOWN";
NSString * const kGTLRDatapipelines_GoogleCloudDatapipelinesV1SdkVersion_SdkSupportStatus_Unsupported = @"UNSUPPORTED";

// ----------------------------------------------------------------------------
//
//   GTLRDatapipelines_GoogleCloudDatapipelinesV1DataflowJobDetails
//

@implementation GTLRDatapipelines_GoogleCloudDatapipelinesV1DataflowJobDetails
@dynamic currentWorkers, resourceInfo, sdkVersion;
@end


// ----------------------------------------------------------------------------
//
//   GTLRDatapipelines_GoogleCloudDatapipelinesV1DataflowJobDetails_ResourceInfo
//

@implementation GTLRDatapipelines_GoogleCloudDatapipelinesV1DataflowJobDetails_ResourceInfo

+ (Class)classForAdditionalProperties {
  return [NSNumber class];
}

@end


// ----------------------------------------------------------------------------
//
//   GTLRDatapipelines_GoogleCloudDatapipelinesV1FlexTemplateRuntimeEnvironment
//

@implementation GTLRDatapipelines_GoogleCloudDatapipelinesV1FlexTemplateRuntimeEnvironment
@dynamic additionalExperiments, additionalUserLabels, enableStreamingEngine,
         flexrsGoal, ipConfiguration, kmsKeyName, machineType, maxWorkers,
         network, numWorkers, serviceAccountEmail, subnetwork, tempLocation,
         workerRegion, workerZone, zoneProperty;

+ (NSDictionary<NSString *, NSString *> *)propertyToJSONKeyMap {
  return @{ @"zoneProperty" : @"zone" };
}

+ (NSDictionary<NSString *, Class> *)arrayPropertyToClassMap {
  NSDictionary<NSString *, Class> *map = @{
    @"additionalExperiments" : [NSString class]
  };
  return map;
}

@end


// ----------------------------------------------------------------------------
//
//   GTLRDatapipelines_GoogleCloudDatapipelinesV1FlexTemplateRuntimeEnvironment_AdditionalUserLabels
//

@implementation GTLRDatapipelines_GoogleCloudDatapipelinesV1FlexTemplateRuntimeEnvironment_AdditionalUserLabels

+ (Class)classForAdditionalProperties {
  return [NSString class];
}

@end


// ----------------------------------------------------------------------------
//
//   GTLRDatapipelines_GoogleCloudDatapipelinesV1Job
//

@implementation GTLRDatapipelines_GoogleCloudDatapipelinesV1Job
@dynamic createTime, dataflowJobDetails, endTime, identifier, name, state,
         status;

+ (NSDictionary<NSString *, NSString *> *)propertyToJSONKeyMap {
  return @{ @"identifier" : @"id" };
}

@end


// ----------------------------------------------------------------------------
//
//   GTLRDatapipelines_GoogleCloudDatapipelinesV1LaunchFlexTemplateParameter
//

@implementation GTLRDatapipelines_GoogleCloudDatapipelinesV1LaunchFlexTemplateParameter
@dynamic containerSpecGcsPath, environment, jobName, launchOptions, parameters,
         transformNameMappings, update;
@end


// ----------------------------------------------------------------------------
//
//   GTLRDatapipelines_GoogleCloudDatapipelinesV1LaunchFlexTemplateParameter_LaunchOptions
//

@implementation GTLRDatapipelines_GoogleCloudDatapipelinesV1LaunchFlexTemplateParameter_LaunchOptions

+ (Class)classForAdditionalProperties {
  return [NSString class];
}

@end


// ----------------------------------------------------------------------------
//
//   GTLRDatapipelines_GoogleCloudDatapipelinesV1LaunchFlexTemplateParameter_Parameters
//

@implementation GTLRDatapipelines_GoogleCloudDatapipelinesV1LaunchFlexTemplateParameter_Parameters

+ (Class)classForAdditionalProperties {
  return [NSString class];
}

@end


// ----------------------------------------------------------------------------
//
//   GTLRDatapipelines_GoogleCloudDatapipelinesV1LaunchFlexTemplateParameter_TransformNameMappings
//

@implementation GTLRDatapipelines_GoogleCloudDatapipelinesV1LaunchFlexTemplateParameter_TransformNameMappings

+ (Class)classForAdditionalProperties {
  return [NSString class];
}

@end


// ----------------------------------------------------------------------------
//
//   GTLRDatapipelines_GoogleCloudDatapipelinesV1LaunchFlexTemplateRequest
//

@implementation GTLRDatapipelines_GoogleCloudDatapipelinesV1LaunchFlexTemplateRequest
@dynamic launchParameter, location, projectId, validateOnly;
@end


// ----------------------------------------------------------------------------
//
//   GTLRDatapipelines_GoogleCloudDatapipelinesV1LaunchTemplateParameters
//

@implementation GTLRDatapipelines_GoogleCloudDatapipelinesV1LaunchTemplateParameters
@dynamic environment, jobName, parameters, transformNameMapping, update;
@end


// ----------------------------------------------------------------------------
//
//   GTLRDatapipelines_GoogleCloudDatapipelinesV1LaunchTemplateParameters_Parameters
//

@implementation GTLRDatapipelines_GoogleCloudDatapipelinesV1LaunchTemplateParameters_Parameters

+ (Class)classForAdditionalProperties {
  return [NSString class];
}

@end


// ----------------------------------------------------------------------------
//
//   GTLRDatapipelines_GoogleCloudDatapipelinesV1LaunchTemplateParameters_TransformNameMapping
//

@implementation GTLRDatapipelines_GoogleCloudDatapipelinesV1LaunchTemplateParameters_TransformNameMapping

+ (Class)classForAdditionalProperties {
  return [NSString class];
}

@end


// ----------------------------------------------------------------------------
//
//   GTLRDatapipelines_GoogleCloudDatapipelinesV1LaunchTemplateRequest
//

@implementation GTLRDatapipelines_GoogleCloudDatapipelinesV1LaunchTemplateRequest
@dynamic gcsPath, launchParameters, location, projectId, validateOnly;
@end


// ----------------------------------------------------------------------------
//
//   GTLRDatapipelines_GoogleCloudDatapipelinesV1ListJobsResponse
//

@implementation GTLRDatapipelines_GoogleCloudDatapipelinesV1ListJobsResponse
@dynamic jobs, nextPageToken;

+ (NSDictionary<NSString *, Class> *)arrayPropertyToClassMap {
  NSDictionary<NSString *, Class> *map = @{
    @"jobs" : [GTLRDatapipelines_GoogleCloudDatapipelinesV1Job class]
  };
  return map;
}

+ (NSString *)collectionItemsKey {
  return @"jobs";
}

@end


// ----------------------------------------------------------------------------
//
//   GTLRDatapipelines_GoogleCloudDatapipelinesV1ListPipelinesResponse
//

@implementation GTLRDatapipelines_GoogleCloudDatapipelinesV1ListPipelinesResponse
@dynamic nextPageToken, pipelines;

+ (NSDictionary<NSString *, Class> *)arrayPropertyToClassMap {
  NSDictionary<NSString *, Class> *map = @{
    @"pipelines" : [GTLRDatapipelines_GoogleCloudDatapipelinesV1Pipeline class]
  };
  return map;
}

+ (NSString *)collectionItemsKey {
  return @"pipelines";
}

@end


// ----------------------------------------------------------------------------
//
//   GTLRDatapipelines_GoogleCloudDatapipelinesV1Pipeline
//

@implementation GTLRDatapipelines_GoogleCloudDatapipelinesV1Pipeline
@dynamic createTime, displayName, jobCount, lastUpdateTime, name,
         pipelineSources, scheduleInfo, schedulerServiceAccountEmail, state,
         type, workload;
@end


// ----------------------------------------------------------------------------
//
//   GTLRDatapipelines_GoogleCloudDatapipelinesV1Pipeline_PipelineSources
//

@implementation GTLRDatapipelines_GoogleCloudDatapipelinesV1Pipeline_PipelineSources

+ (Class)classForAdditionalProperties {
  return [NSString class];
}

@end


// ----------------------------------------------------------------------------
//
//   GTLRDatapipelines_GoogleCloudDatapipelinesV1RunPipelineRequest
//

@implementation GTLRDatapipelines_GoogleCloudDatapipelinesV1RunPipelineRequest
@end


// ----------------------------------------------------------------------------
//
//   GTLRDatapipelines_GoogleCloudDatapipelinesV1RunPipelineResponse
//

@implementation GTLRDatapipelines_GoogleCloudDatapipelinesV1RunPipelineResponse
@dynamic job;
@end


// ----------------------------------------------------------------------------
//
//   GTLRDatapipelines_GoogleCloudDatapipelinesV1RuntimeEnvironment
//

@implementation GTLRDatapipelines_GoogleCloudDatapipelinesV1RuntimeEnvironment
@dynamic additionalExperiments, additionalUserLabels, bypassTempDirValidation,
         enableStreamingEngine, ipConfiguration, kmsKeyName, machineType,
         maxWorkers, network, numWorkers, serviceAccountEmail, subnetwork,
         tempLocation, workerRegion, workerZone, zoneProperty;

+ (NSDictionary<NSString *, NSString *> *)propertyToJSONKeyMap {
  return @{ @"zoneProperty" : @"zone" };
}

+ (NSDictionary<NSString *, Class> *)arrayPropertyToClassMap {
  NSDictionary<NSString *, Class> *map = @{
    @"additionalExperiments" : [NSString class]
  };
  return map;
}

@end


// ----------------------------------------------------------------------------
//
//   GTLRDatapipelines_GoogleCloudDatapipelinesV1RuntimeEnvironment_AdditionalUserLabels
//

@implementation GTLRDatapipelines_GoogleCloudDatapipelinesV1RuntimeEnvironment_AdditionalUserLabels

+ (Class)classForAdditionalProperties {
  return [NSString class];
}

@end


// ----------------------------------------------------------------------------
//
//   GTLRDatapipelines_GoogleCloudDatapipelinesV1ScheduleSpec
//

@implementation GTLRDatapipelines_GoogleCloudDatapipelinesV1ScheduleSpec
@dynamic nextJobTime, schedule, timeZone;
@end


// ----------------------------------------------------------------------------
//
//   GTLRDatapipelines_GoogleCloudDatapipelinesV1SdkVersion
//

@implementation GTLRDatapipelines_GoogleCloudDatapipelinesV1SdkVersion
@dynamic sdkSupportStatus, version, versionDisplayName;
@end


// ----------------------------------------------------------------------------
//
//   GTLRDatapipelines_GoogleCloudDatapipelinesV1StopPipelineRequest
//

@implementation GTLRDatapipelines_GoogleCloudDatapipelinesV1StopPipelineRequest
@end


// ----------------------------------------------------------------------------
//
//   GTLRDatapipelines_GoogleCloudDatapipelinesV1Workload
//

@implementation GTLRDatapipelines_GoogleCloudDatapipelinesV1Workload
@dynamic dataflowFlexTemplateRequest, dataflowLaunchTemplateRequest;
@end


// ----------------------------------------------------------------------------
//
//   GTLRDatapipelines_GoogleProtobufEmpty
//

@implementation GTLRDatapipelines_GoogleProtobufEmpty
@end


// ----------------------------------------------------------------------------
//
//   GTLRDatapipelines_GoogleRpcStatus
//

@implementation GTLRDatapipelines_GoogleRpcStatus
@dynamic code, details, message;

+ (NSDictionary<NSString *, Class> *)arrayPropertyToClassMap {
  NSDictionary<NSString *, Class> *map = @{
    @"details" : [GTLRDatapipelines_GoogleRpcStatus_Details_Item class]
  };
  return map;
}

@end


// ----------------------------------------------------------------------------
//
//   GTLRDatapipelines_GoogleRpcStatus_Details_Item
//

@implementation GTLRDatapipelines_GoogleRpcStatus_Details_Item

+ (Class)classForAdditionalProperties {
  return [NSObject class];
}

@end
