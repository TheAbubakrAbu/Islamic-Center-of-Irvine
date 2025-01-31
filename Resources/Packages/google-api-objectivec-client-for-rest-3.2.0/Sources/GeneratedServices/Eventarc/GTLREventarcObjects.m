// NOTE: This file was generated by the ServiceGenerator.

// ----------------------------------------------------------------------------
// API:
//   Eventarc API (eventarc/v1)
// Description:
//   Build event-driven applications on Google Cloud Platform.
// Documentation:
//   https://cloud.google.com/eventarc

#import <GoogleAPIClientForREST/GTLREventarcObjects.h>

// ----------------------------------------------------------------------------
// Constants

// GTLREventarc_AuditLogConfig.logType
NSString * const kGTLREventarc_AuditLogConfig_LogType_AdminRead = @"ADMIN_READ";
NSString * const kGTLREventarc_AuditLogConfig_LogType_DataRead = @"DATA_READ";
NSString * const kGTLREventarc_AuditLogConfig_LogType_DataWrite = @"DATA_WRITE";
NSString * const kGTLREventarc_AuditLogConfig_LogType_LogTypeUnspecified = @"LOG_TYPE_UNSPECIFIED";

// GTLREventarc_Channel.state
NSString * const kGTLREventarc_Channel_State_Active           = @"ACTIVE";
NSString * const kGTLREventarc_Channel_State_Inactive         = @"INACTIVE";
NSString * const kGTLREventarc_Channel_State_Pending          = @"PENDING";
NSString * const kGTLREventarc_Channel_State_StateUnspecified = @"STATE_UNSPECIFIED";

// GTLREventarc_StateCondition.code
NSString * const kGTLREventarc_StateCondition_Code_Aborted     = @"ABORTED";
NSString * const kGTLREventarc_StateCondition_Code_AlreadyExists = @"ALREADY_EXISTS";
NSString * const kGTLREventarc_StateCondition_Code_Cancelled   = @"CANCELLED";
NSString * const kGTLREventarc_StateCondition_Code_DataLoss    = @"DATA_LOSS";
NSString * const kGTLREventarc_StateCondition_Code_DeadlineExceeded = @"DEADLINE_EXCEEDED";
NSString * const kGTLREventarc_StateCondition_Code_FailedPrecondition = @"FAILED_PRECONDITION";
NSString * const kGTLREventarc_StateCondition_Code_Internal    = @"INTERNAL";
NSString * const kGTLREventarc_StateCondition_Code_InvalidArgument = @"INVALID_ARGUMENT";
NSString * const kGTLREventarc_StateCondition_Code_NotFound    = @"NOT_FOUND";
NSString * const kGTLREventarc_StateCondition_Code_Ok          = @"OK";
NSString * const kGTLREventarc_StateCondition_Code_OutOfRange  = @"OUT_OF_RANGE";
NSString * const kGTLREventarc_StateCondition_Code_PermissionDenied = @"PERMISSION_DENIED";
NSString * const kGTLREventarc_StateCondition_Code_ResourceExhausted = @"RESOURCE_EXHAUSTED";
NSString * const kGTLREventarc_StateCondition_Code_Unauthenticated = @"UNAUTHENTICATED";
NSString * const kGTLREventarc_StateCondition_Code_Unavailable = @"UNAVAILABLE";
NSString * const kGTLREventarc_StateCondition_Code_Unimplemented = @"UNIMPLEMENTED";
NSString * const kGTLREventarc_StateCondition_Code_Unknown     = @"UNKNOWN";

// ----------------------------------------------------------------------------
//
//   GTLREventarc_AuditConfig
//

@implementation GTLREventarc_AuditConfig
@dynamic auditLogConfigs, service;

+ (NSDictionary<NSString *, Class> *)arrayPropertyToClassMap {
  NSDictionary<NSString *, Class> *map = @{
    @"auditLogConfigs" : [GTLREventarc_AuditLogConfig class]
  };
  return map;
}

@end


// ----------------------------------------------------------------------------
//
//   GTLREventarc_AuditLogConfig
//

@implementation GTLREventarc_AuditLogConfig
@dynamic exemptedMembers, logType;

+ (NSDictionary<NSString *, Class> *)arrayPropertyToClassMap {
  NSDictionary<NSString *, Class> *map = @{
    @"exemptedMembers" : [NSString class]
  };
  return map;
}

@end


// ----------------------------------------------------------------------------
//
//   GTLREventarc_Binding
//

@implementation GTLREventarc_Binding
@dynamic condition, members, role;

+ (NSDictionary<NSString *, Class> *)arrayPropertyToClassMap {
  NSDictionary<NSString *, Class> *map = @{
    @"members" : [NSString class]
  };
  return map;
}

@end


// ----------------------------------------------------------------------------
//
//   GTLREventarc_Channel
//

@implementation GTLREventarc_Channel
@dynamic activationToken, createTime, cryptoKeyName, name, provider,
         pubsubTopic, state, uid, updateTime;
@end


// ----------------------------------------------------------------------------
//
//   GTLREventarc_ChannelConnection
//

@implementation GTLREventarc_ChannelConnection
@dynamic activationToken, channel, createTime, name, uid, updateTime;
@end


// ----------------------------------------------------------------------------
//
//   GTLREventarc_CloudRun
//

@implementation GTLREventarc_CloudRun
@dynamic path, region, service;
@end


// ----------------------------------------------------------------------------
//
//   GTLREventarc_Destination
//

@implementation GTLREventarc_Destination
@dynamic cloudFunction, cloudRun, gke, workflow;
@end


// ----------------------------------------------------------------------------
//
//   GTLREventarc_Empty
//

@implementation GTLREventarc_Empty
@end


// ----------------------------------------------------------------------------
//
//   GTLREventarc_EventFilter
//

@implementation GTLREventarc_EventFilter
@dynamic attribute, operatorProperty, value;

+ (NSDictionary<NSString *, NSString *> *)propertyToJSONKeyMap {
  return @{ @"operatorProperty" : @"operator" };
}

@end


// ----------------------------------------------------------------------------
//
//   GTLREventarc_EventType
//

@implementation GTLREventarc_EventType
@dynamic descriptionProperty, eventSchemaUri, filteringAttributes, type;

+ (NSDictionary<NSString *, NSString *> *)propertyToJSONKeyMap {
  return @{ @"descriptionProperty" : @"description" };
}

+ (NSDictionary<NSString *, Class> *)arrayPropertyToClassMap {
  NSDictionary<NSString *, Class> *map = @{
    @"filteringAttributes" : [GTLREventarc_FilteringAttribute class]
  };
  return map;
}

@end


// ----------------------------------------------------------------------------
//
//   GTLREventarc_Expr
//

@implementation GTLREventarc_Expr
@dynamic descriptionProperty, expression, location, title;

+ (NSDictionary<NSString *, NSString *> *)propertyToJSONKeyMap {
  return @{ @"descriptionProperty" : @"description" };
}

@end


// ----------------------------------------------------------------------------
//
//   GTLREventarc_FilteringAttribute
//

@implementation GTLREventarc_FilteringAttribute
@dynamic attribute, descriptionProperty, pathPatternSupported, required;

+ (NSDictionary<NSString *, NSString *> *)propertyToJSONKeyMap {
  return @{ @"descriptionProperty" : @"description" };
}

@end


// ----------------------------------------------------------------------------
//
//   GTLREventarc_GKE
//

@implementation GTLREventarc_GKE
@dynamic cluster, location, namespaceProperty, path, service;

+ (NSDictionary<NSString *, NSString *> *)propertyToJSONKeyMap {
  return @{ @"namespaceProperty" : @"namespace" };
}

@end


// ----------------------------------------------------------------------------
//
//   GTLREventarc_GoogleChannelConfig
//

@implementation GTLREventarc_GoogleChannelConfig
@dynamic cryptoKeyName, name, updateTime;
@end


// ----------------------------------------------------------------------------
//
//   GTLREventarc_GoogleLongrunningCancelOperationRequest
//

@implementation GTLREventarc_GoogleLongrunningCancelOperationRequest
@end


// ----------------------------------------------------------------------------
//
//   GTLREventarc_GoogleLongrunningListOperationsResponse
//

@implementation GTLREventarc_GoogleLongrunningListOperationsResponse
@dynamic nextPageToken, operations;

+ (NSDictionary<NSString *, Class> *)arrayPropertyToClassMap {
  NSDictionary<NSString *, Class> *map = @{
    @"operations" : [GTLREventarc_GoogleLongrunningOperation class]
  };
  return map;
}

+ (NSString *)collectionItemsKey {
  return @"operations";
}

@end


// ----------------------------------------------------------------------------
//
//   GTLREventarc_GoogleLongrunningOperation
//

@implementation GTLREventarc_GoogleLongrunningOperation
@dynamic done, error, metadata, name, response;
@end


// ----------------------------------------------------------------------------
//
//   GTLREventarc_GoogleLongrunningOperation_Metadata
//

@implementation GTLREventarc_GoogleLongrunningOperation_Metadata

+ (Class)classForAdditionalProperties {
  return [NSObject class];
}

@end


// ----------------------------------------------------------------------------
//
//   GTLREventarc_GoogleLongrunningOperation_Response
//

@implementation GTLREventarc_GoogleLongrunningOperation_Response

+ (Class)classForAdditionalProperties {
  return [NSObject class];
}

@end


// ----------------------------------------------------------------------------
//
//   GTLREventarc_GoogleRpcStatus
//

@implementation GTLREventarc_GoogleRpcStatus
@dynamic code, details, message;

+ (NSDictionary<NSString *, Class> *)arrayPropertyToClassMap {
  NSDictionary<NSString *, Class> *map = @{
    @"details" : [GTLREventarc_GoogleRpcStatus_Details_Item class]
  };
  return map;
}

@end


// ----------------------------------------------------------------------------
//
//   GTLREventarc_GoogleRpcStatus_Details_Item
//

@implementation GTLREventarc_GoogleRpcStatus_Details_Item

+ (Class)classForAdditionalProperties {
  return [NSObject class];
}

@end


// ----------------------------------------------------------------------------
//
//   GTLREventarc_ListChannelConnectionsResponse
//

@implementation GTLREventarc_ListChannelConnectionsResponse
@dynamic channelConnections, nextPageToken, unreachable;

+ (NSDictionary<NSString *, Class> *)arrayPropertyToClassMap {
  NSDictionary<NSString *, Class> *map = @{
    @"channelConnections" : [GTLREventarc_ChannelConnection class],
    @"unreachable" : [NSString class]
  };
  return map;
}

+ (NSString *)collectionItemsKey {
  return @"channelConnections";
}

@end


// ----------------------------------------------------------------------------
//
//   GTLREventarc_ListChannelsResponse
//

@implementation GTLREventarc_ListChannelsResponse
@dynamic channels, nextPageToken, unreachable;

+ (NSDictionary<NSString *, Class> *)arrayPropertyToClassMap {
  NSDictionary<NSString *, Class> *map = @{
    @"channels" : [GTLREventarc_Channel class],
    @"unreachable" : [NSString class]
  };
  return map;
}

+ (NSString *)collectionItemsKey {
  return @"channels";
}

@end


// ----------------------------------------------------------------------------
//
//   GTLREventarc_ListLocationsResponse
//

@implementation GTLREventarc_ListLocationsResponse
@dynamic locations, nextPageToken;

+ (NSDictionary<NSString *, Class> *)arrayPropertyToClassMap {
  NSDictionary<NSString *, Class> *map = @{
    @"locations" : [GTLREventarc_Location class]
  };
  return map;
}

+ (NSString *)collectionItemsKey {
  return @"locations";
}

@end


// ----------------------------------------------------------------------------
//
//   GTLREventarc_ListProvidersResponse
//

@implementation GTLREventarc_ListProvidersResponse
@dynamic nextPageToken, providers, unreachable;

+ (NSDictionary<NSString *, Class> *)arrayPropertyToClassMap {
  NSDictionary<NSString *, Class> *map = @{
    @"providers" : [GTLREventarc_Provider class],
    @"unreachable" : [NSString class]
  };
  return map;
}

+ (NSString *)collectionItemsKey {
  return @"providers";
}

@end


// ----------------------------------------------------------------------------
//
//   GTLREventarc_ListTriggersResponse
//

@implementation GTLREventarc_ListTriggersResponse
@dynamic nextPageToken, triggers, unreachable;

+ (NSDictionary<NSString *, Class> *)arrayPropertyToClassMap {
  NSDictionary<NSString *, Class> *map = @{
    @"triggers" : [GTLREventarc_Trigger class],
    @"unreachable" : [NSString class]
  };
  return map;
}

+ (NSString *)collectionItemsKey {
  return @"triggers";
}

@end


// ----------------------------------------------------------------------------
//
//   GTLREventarc_Location
//

@implementation GTLREventarc_Location
@dynamic displayName, labels, locationId, metadata, name;
@end


// ----------------------------------------------------------------------------
//
//   GTLREventarc_Location_Labels
//

@implementation GTLREventarc_Location_Labels

+ (Class)classForAdditionalProperties {
  return [NSString class];
}

@end


// ----------------------------------------------------------------------------
//
//   GTLREventarc_Location_Metadata
//

@implementation GTLREventarc_Location_Metadata

+ (Class)classForAdditionalProperties {
  return [NSObject class];
}

@end


// ----------------------------------------------------------------------------
//
//   GTLREventarc_OperationMetadata
//

@implementation GTLREventarc_OperationMetadata
@dynamic apiVersion, createTime, endTime, requestedCancellation, statusMessage,
         target, verb;
@end


// ----------------------------------------------------------------------------
//
//   GTLREventarc_Policy
//

@implementation GTLREventarc_Policy
@dynamic auditConfigs, bindings, ETag, version;

+ (NSDictionary<NSString *, NSString *> *)propertyToJSONKeyMap {
  return @{ @"ETag" : @"etag" };
}

+ (NSDictionary<NSString *, Class> *)arrayPropertyToClassMap {
  NSDictionary<NSString *, Class> *map = @{
    @"auditConfigs" : [GTLREventarc_AuditConfig class],
    @"bindings" : [GTLREventarc_Binding class]
  };
  return map;
}

@end


// ----------------------------------------------------------------------------
//
//   GTLREventarc_Provider
//

@implementation GTLREventarc_Provider
@dynamic displayName, eventTypes, name;

+ (NSDictionary<NSString *, Class> *)arrayPropertyToClassMap {
  NSDictionary<NSString *, Class> *map = @{
    @"eventTypes" : [GTLREventarc_EventType class]
  };
  return map;
}

@end


// ----------------------------------------------------------------------------
//
//   GTLREventarc_Pubsub
//

@implementation GTLREventarc_Pubsub
@dynamic subscription, topic;
@end


// ----------------------------------------------------------------------------
//
//   GTLREventarc_SetIamPolicyRequest
//

@implementation GTLREventarc_SetIamPolicyRequest
@dynamic policy, updateMask;
@end


// ----------------------------------------------------------------------------
//
//   GTLREventarc_StateCondition
//

@implementation GTLREventarc_StateCondition
@dynamic code, message;
@end


// ----------------------------------------------------------------------------
//
//   GTLREventarc_TestIamPermissionsRequest
//

@implementation GTLREventarc_TestIamPermissionsRequest
@dynamic permissions;

+ (NSDictionary<NSString *, Class> *)arrayPropertyToClassMap {
  NSDictionary<NSString *, Class> *map = @{
    @"permissions" : [NSString class]
  };
  return map;
}

@end


// ----------------------------------------------------------------------------
//
//   GTLREventarc_TestIamPermissionsResponse
//

@implementation GTLREventarc_TestIamPermissionsResponse
@dynamic permissions;

+ (NSDictionary<NSString *, Class> *)arrayPropertyToClassMap {
  NSDictionary<NSString *, Class> *map = @{
    @"permissions" : [NSString class]
  };
  return map;
}

@end


// ----------------------------------------------------------------------------
//
//   GTLREventarc_Transport
//

@implementation GTLREventarc_Transport
@dynamic pubsub;
@end


// ----------------------------------------------------------------------------
//
//   GTLREventarc_Trigger
//

@implementation GTLREventarc_Trigger
@dynamic channel, conditions, createTime, destination, ETag,
         eventDataContentType, eventFilters, labels, name, serviceAccount,
         transport, uid, updateTime;

+ (NSDictionary<NSString *, NSString *> *)propertyToJSONKeyMap {
  return @{ @"ETag" : @"etag" };
}

+ (NSDictionary<NSString *, Class> *)arrayPropertyToClassMap {
  NSDictionary<NSString *, Class> *map = @{
    @"eventFilters" : [GTLREventarc_EventFilter class]
  };
  return map;
}

@end


// ----------------------------------------------------------------------------
//
//   GTLREventarc_Trigger_Conditions
//

@implementation GTLREventarc_Trigger_Conditions

+ (Class)classForAdditionalProperties {
  return [GTLREventarc_StateCondition class];
}

@end


// ----------------------------------------------------------------------------
//
//   GTLREventarc_Trigger_Labels
//

@implementation GTLREventarc_Trigger_Labels

+ (Class)classForAdditionalProperties {
  return [NSString class];
}

@end
