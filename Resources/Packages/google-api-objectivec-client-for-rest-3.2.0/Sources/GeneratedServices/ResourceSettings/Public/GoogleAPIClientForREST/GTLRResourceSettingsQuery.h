// NOTE: This file was generated by the ServiceGenerator.

// ----------------------------------------------------------------------------
// API:
//   Resource Settings API (resourcesettings/v1)
// Description:
//   The Resource Settings API allows users to control and modify the behavior
//   of their GCP resources (e.g., VM, firewall, Project, etc.) across the Cloud
//   Resource Hierarchy.
// Documentation:
//   https://cloud.google.com/resource-manager/docs/resource-settings/overview

#import <GoogleAPIClientForREST/GTLRQuery.h>

#if GTLR_RUNTIME_VERSION != 3000
#error This file was generated by a different version of ServiceGenerator which is incompatible with this GTLR library source.
#endif

#import "GTLRResourceSettingsObjects.h"

// Generated comments include content from the discovery document; avoid them
// causing warnings since clang's checks are some what arbitrary.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

NS_ASSUME_NONNULL_BEGIN

// ----------------------------------------------------------------------------
// Constants - For some of the query classes' properties below.

// ----------------------------------------------------------------------------
// view

/**
 *  Include Setting.metadata, but nothing else. This is the default value (for
 *  both ListSettings and GetSetting).
 *
 *  Value: "SETTING_VIEW_BASIC"
 */
FOUNDATION_EXTERN NSString * const kGTLRResourceSettingsViewSettingViewBasic;
/**
 *  Include Setting.effective_value, but nothing else.
 *
 *  Value: "SETTING_VIEW_EFFECTIVE_VALUE"
 */
FOUNDATION_EXTERN NSString * const kGTLRResourceSettingsViewSettingViewEffectiveValue;
/**
 *  Include Setting.local_value, but nothing else.
 *
 *  Value: "SETTING_VIEW_LOCAL_VALUE"
 */
FOUNDATION_EXTERN NSString * const kGTLRResourceSettingsViewSettingViewLocalValue;
/**
 *  The default / unset value. The API will default to the SETTING_VIEW_BASIC
 *  view.
 *
 *  Value: "SETTING_VIEW_UNSPECIFIED"
 */
FOUNDATION_EXTERN NSString * const kGTLRResourceSettingsViewSettingViewUnspecified;

// ----------------------------------------------------------------------------
// Query Classes
//

/**
 *  Parent class for other Resource Settings query classes.
 */
@interface GTLRResourceSettingsQuery : GTLRQuery

/** Selector specifying which fields to include in a partial response. */
@property(nonatomic, copy, nullable) NSString *fields;

@end

/**
 *  Returns a specified setting. Returns a `google.rpc.Status` with
 *  `google.rpc.Code.NOT_FOUND` if the setting does not exist.
 *
 *  Method: resourcesettings.folders.settings.get
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeResourceSettingsCloudPlatform
 */
@interface GTLRResourceSettingsQuery_FoldersSettingsGet : GTLRResourceSettingsQuery

/**
 *  Required. The name of the setting to get. See Setting for naming
 *  requirements.
 */
@property(nonatomic, copy, nullable) NSString *name;

/**
 *  The SettingView for this request.
 *
 *  Likely values:
 *    @arg @c kGTLRResourceSettingsViewSettingViewUnspecified The default /
 *        unset value. The API will default to the SETTING_VIEW_BASIC view.
 *        (Value: "SETTING_VIEW_UNSPECIFIED")
 *    @arg @c kGTLRResourceSettingsViewSettingViewBasic Include
 *        Setting.metadata, but nothing else. This is the default value (for
 *        both ListSettings and GetSetting). (Value: "SETTING_VIEW_BASIC")
 *    @arg @c kGTLRResourceSettingsViewSettingViewEffectiveValue Include
 *        Setting.effective_value, but nothing else. (Value:
 *        "SETTING_VIEW_EFFECTIVE_VALUE")
 *    @arg @c kGTLRResourceSettingsViewSettingViewLocalValue Include
 *        Setting.local_value, but nothing else. (Value:
 *        "SETTING_VIEW_LOCAL_VALUE")
 */
@property(nonatomic, copy, nullable) NSString *view;

/**
 *  Fetches a @c GTLRResourceSettings_GoogleCloudResourcesettingsV1Setting.
 *
 *  Returns a specified setting. Returns a `google.rpc.Status` with
 *  `google.rpc.Code.NOT_FOUND` if the setting does not exist.
 *
 *  @param name Required. The name of the setting to get. See Setting for naming
 *    requirements.
 *
 *  @return GTLRResourceSettingsQuery_FoldersSettingsGet
 */
+ (instancetype)queryWithName:(NSString *)name;

@end

/**
 *  Lists all the settings that are available on the Cloud resource `parent`.
 *
 *  Method: resourcesettings.folders.settings.list
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeResourceSettingsCloudPlatform
 */
@interface GTLRResourceSettingsQuery_FoldersSettingsList : GTLRResourceSettingsQuery

/** Unused. The size of the page to be returned. */
@property(nonatomic, assign) NSInteger pageSize;

/** Unused. A page token used to retrieve the next page. */
@property(nonatomic, copy, nullable) NSString *pageToken;

/**
 *  Required. The project, folder, or organization that is the parent resource
 *  for this setting. Must be in one of the following forms: *
 *  `projects/{project_number}` * `projects/{project_id}` *
 *  `folders/{folder_id}` * `organizations/{organization_id}`
 */
@property(nonatomic, copy, nullable) NSString *parent;

/**
 *  The SettingView for this request.
 *
 *  Likely values:
 *    @arg @c kGTLRResourceSettingsViewSettingViewUnspecified The default /
 *        unset value. The API will default to the SETTING_VIEW_BASIC view.
 *        (Value: "SETTING_VIEW_UNSPECIFIED")
 *    @arg @c kGTLRResourceSettingsViewSettingViewBasic Include
 *        Setting.metadata, but nothing else. This is the default value (for
 *        both ListSettings and GetSetting). (Value: "SETTING_VIEW_BASIC")
 *    @arg @c kGTLRResourceSettingsViewSettingViewEffectiveValue Include
 *        Setting.effective_value, but nothing else. (Value:
 *        "SETTING_VIEW_EFFECTIVE_VALUE")
 *    @arg @c kGTLRResourceSettingsViewSettingViewLocalValue Include
 *        Setting.local_value, but nothing else. (Value:
 *        "SETTING_VIEW_LOCAL_VALUE")
 */
@property(nonatomic, copy, nullable) NSString *view;

/**
 *  Fetches a @c
 *  GTLRResourceSettings_GoogleCloudResourcesettingsV1ListSettingsResponse.
 *
 *  Lists all the settings that are available on the Cloud resource `parent`.
 *
 *  @param parent Required. The project, folder, or organization that is the
 *    parent resource for this setting. Must be in one of the following forms: *
 *    `projects/{project_number}` * `projects/{project_id}` *
 *    `folders/{folder_id}` * `organizations/{organization_id}`
 *
 *  @return GTLRResourceSettingsQuery_FoldersSettingsList
 *
 *  @note Automatic pagination will be done when @c shouldFetchNextPages is
 *        enabled. See @c shouldFetchNextPages on @c GTLRService for more
 *        information.
 */
+ (instancetype)queryWithParent:(NSString *)parent;

@end

/**
 *  Updates a specified setting. Returns a `google.rpc.Status` with
 *  `google.rpc.Code.NOT_FOUND` if the setting does not exist. Returns a
 *  `google.rpc.Status` with `google.rpc.Code.FAILED_PRECONDITION` if the
 *  setting is flagged as read only. Returns a `google.rpc.Status` with
 *  `google.rpc.Code.ABORTED` if the etag supplied in the request does not match
 *  the persisted etag of the setting value. On success, the response will
 *  contain only `name`, `local_value` and `etag`. The `metadata` and
 *  `effective_value` cannot be updated through this API. Note: the supplied
 *  setting will perform a full overwrite of the `local_value` field.
 *
 *  Method: resourcesettings.folders.settings.patch
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeResourceSettingsCloudPlatform
 */
@interface GTLRResourceSettingsQuery_FoldersSettingsPatch : GTLRResourceSettingsQuery

/**
 *  The resource name of the setting. Must be in one of the following forms: *
 *  `projects/{project_number}/settings/{setting_name}` *
 *  `folders/{folder_id}/settings/{setting_name}` *
 *  `organizations/{organization_id}/settings/{setting_name}` For example,
 *  "/projects/123/settings/gcp-enableMyFeature"
 */
@property(nonatomic, copy, nullable) NSString *name;

/**
 *  Fetches a @c GTLRResourceSettings_GoogleCloudResourcesettingsV1Setting.
 *
 *  Updates a specified setting. Returns a `google.rpc.Status` with
 *  `google.rpc.Code.NOT_FOUND` if the setting does not exist. Returns a
 *  `google.rpc.Status` with `google.rpc.Code.FAILED_PRECONDITION` if the
 *  setting is flagged as read only. Returns a `google.rpc.Status` with
 *  `google.rpc.Code.ABORTED` if the etag supplied in the request does not match
 *  the persisted etag of the setting value. On success, the response will
 *  contain only `name`, `local_value` and `etag`. The `metadata` and
 *  `effective_value` cannot be updated through this API. Note: the supplied
 *  setting will perform a full overwrite of the `local_value` field.
 *
 *  @param object The @c
 *    GTLRResourceSettings_GoogleCloudResourcesettingsV1Setting to include in
 *    the query.
 *  @param name The resource name of the setting. Must be in one of the
 *    following forms: * `projects/{project_number}/settings/{setting_name}` *
 *    `folders/{folder_id}/settings/{setting_name}` *
 *    `organizations/{organization_id}/settings/{setting_name}` For example,
 *    "/projects/123/settings/gcp-enableMyFeature"
 *
 *  @return GTLRResourceSettingsQuery_FoldersSettingsPatch
 */
+ (instancetype)queryWithObject:(GTLRResourceSettings_GoogleCloudResourcesettingsV1Setting *)object
                           name:(NSString *)name;

@end

/**
 *  Returns a specified setting. Returns a `google.rpc.Status` with
 *  `google.rpc.Code.NOT_FOUND` if the setting does not exist.
 *
 *  Method: resourcesettings.organizations.settings.get
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeResourceSettingsCloudPlatform
 */
@interface GTLRResourceSettingsQuery_OrganizationsSettingsGet : GTLRResourceSettingsQuery

/**
 *  Required. The name of the setting to get. See Setting for naming
 *  requirements.
 */
@property(nonatomic, copy, nullable) NSString *name;

/**
 *  The SettingView for this request.
 *
 *  Likely values:
 *    @arg @c kGTLRResourceSettingsViewSettingViewUnspecified The default /
 *        unset value. The API will default to the SETTING_VIEW_BASIC view.
 *        (Value: "SETTING_VIEW_UNSPECIFIED")
 *    @arg @c kGTLRResourceSettingsViewSettingViewBasic Include
 *        Setting.metadata, but nothing else. This is the default value (for
 *        both ListSettings and GetSetting). (Value: "SETTING_VIEW_BASIC")
 *    @arg @c kGTLRResourceSettingsViewSettingViewEffectiveValue Include
 *        Setting.effective_value, but nothing else. (Value:
 *        "SETTING_VIEW_EFFECTIVE_VALUE")
 *    @arg @c kGTLRResourceSettingsViewSettingViewLocalValue Include
 *        Setting.local_value, but nothing else. (Value:
 *        "SETTING_VIEW_LOCAL_VALUE")
 */
@property(nonatomic, copy, nullable) NSString *view;

/**
 *  Fetches a @c GTLRResourceSettings_GoogleCloudResourcesettingsV1Setting.
 *
 *  Returns a specified setting. Returns a `google.rpc.Status` with
 *  `google.rpc.Code.NOT_FOUND` if the setting does not exist.
 *
 *  @param name Required. The name of the setting to get. See Setting for naming
 *    requirements.
 *
 *  @return GTLRResourceSettingsQuery_OrganizationsSettingsGet
 */
+ (instancetype)queryWithName:(NSString *)name;

@end

/**
 *  Lists all the settings that are available on the Cloud resource `parent`.
 *
 *  Method: resourcesettings.organizations.settings.list
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeResourceSettingsCloudPlatform
 */
@interface GTLRResourceSettingsQuery_OrganizationsSettingsList : GTLRResourceSettingsQuery

/** Unused. The size of the page to be returned. */
@property(nonatomic, assign) NSInteger pageSize;

/** Unused. A page token used to retrieve the next page. */
@property(nonatomic, copy, nullable) NSString *pageToken;

/**
 *  Required. The project, folder, or organization that is the parent resource
 *  for this setting. Must be in one of the following forms: *
 *  `projects/{project_number}` * `projects/{project_id}` *
 *  `folders/{folder_id}` * `organizations/{organization_id}`
 */
@property(nonatomic, copy, nullable) NSString *parent;

/**
 *  The SettingView for this request.
 *
 *  Likely values:
 *    @arg @c kGTLRResourceSettingsViewSettingViewUnspecified The default /
 *        unset value. The API will default to the SETTING_VIEW_BASIC view.
 *        (Value: "SETTING_VIEW_UNSPECIFIED")
 *    @arg @c kGTLRResourceSettingsViewSettingViewBasic Include
 *        Setting.metadata, but nothing else. This is the default value (for
 *        both ListSettings and GetSetting). (Value: "SETTING_VIEW_BASIC")
 *    @arg @c kGTLRResourceSettingsViewSettingViewEffectiveValue Include
 *        Setting.effective_value, but nothing else. (Value:
 *        "SETTING_VIEW_EFFECTIVE_VALUE")
 *    @arg @c kGTLRResourceSettingsViewSettingViewLocalValue Include
 *        Setting.local_value, but nothing else. (Value:
 *        "SETTING_VIEW_LOCAL_VALUE")
 */
@property(nonatomic, copy, nullable) NSString *view;

/**
 *  Fetches a @c
 *  GTLRResourceSettings_GoogleCloudResourcesettingsV1ListSettingsResponse.
 *
 *  Lists all the settings that are available on the Cloud resource `parent`.
 *
 *  @param parent Required. The project, folder, or organization that is the
 *    parent resource for this setting. Must be in one of the following forms: *
 *    `projects/{project_number}` * `projects/{project_id}` *
 *    `folders/{folder_id}` * `organizations/{organization_id}`
 *
 *  @return GTLRResourceSettingsQuery_OrganizationsSettingsList
 *
 *  @note Automatic pagination will be done when @c shouldFetchNextPages is
 *        enabled. See @c shouldFetchNextPages on @c GTLRService for more
 *        information.
 */
+ (instancetype)queryWithParent:(NSString *)parent;

@end

/**
 *  Updates a specified setting. Returns a `google.rpc.Status` with
 *  `google.rpc.Code.NOT_FOUND` if the setting does not exist. Returns a
 *  `google.rpc.Status` with `google.rpc.Code.FAILED_PRECONDITION` if the
 *  setting is flagged as read only. Returns a `google.rpc.Status` with
 *  `google.rpc.Code.ABORTED` if the etag supplied in the request does not match
 *  the persisted etag of the setting value. On success, the response will
 *  contain only `name`, `local_value` and `etag`. The `metadata` and
 *  `effective_value` cannot be updated through this API. Note: the supplied
 *  setting will perform a full overwrite of the `local_value` field.
 *
 *  Method: resourcesettings.organizations.settings.patch
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeResourceSettingsCloudPlatform
 */
@interface GTLRResourceSettingsQuery_OrganizationsSettingsPatch : GTLRResourceSettingsQuery

/**
 *  The resource name of the setting. Must be in one of the following forms: *
 *  `projects/{project_number}/settings/{setting_name}` *
 *  `folders/{folder_id}/settings/{setting_name}` *
 *  `organizations/{organization_id}/settings/{setting_name}` For example,
 *  "/projects/123/settings/gcp-enableMyFeature"
 */
@property(nonatomic, copy, nullable) NSString *name;

/**
 *  Fetches a @c GTLRResourceSettings_GoogleCloudResourcesettingsV1Setting.
 *
 *  Updates a specified setting. Returns a `google.rpc.Status` with
 *  `google.rpc.Code.NOT_FOUND` if the setting does not exist. Returns a
 *  `google.rpc.Status` with `google.rpc.Code.FAILED_PRECONDITION` if the
 *  setting is flagged as read only. Returns a `google.rpc.Status` with
 *  `google.rpc.Code.ABORTED` if the etag supplied in the request does not match
 *  the persisted etag of the setting value. On success, the response will
 *  contain only `name`, `local_value` and `etag`. The `metadata` and
 *  `effective_value` cannot be updated through this API. Note: the supplied
 *  setting will perform a full overwrite of the `local_value` field.
 *
 *  @param object The @c
 *    GTLRResourceSettings_GoogleCloudResourcesettingsV1Setting to include in
 *    the query.
 *  @param name The resource name of the setting. Must be in one of the
 *    following forms: * `projects/{project_number}/settings/{setting_name}` *
 *    `folders/{folder_id}/settings/{setting_name}` *
 *    `organizations/{organization_id}/settings/{setting_name}` For example,
 *    "/projects/123/settings/gcp-enableMyFeature"
 *
 *  @return GTLRResourceSettingsQuery_OrganizationsSettingsPatch
 */
+ (instancetype)queryWithObject:(GTLRResourceSettings_GoogleCloudResourcesettingsV1Setting *)object
                           name:(NSString *)name;

@end

/**
 *  Returns a specified setting. Returns a `google.rpc.Status` with
 *  `google.rpc.Code.NOT_FOUND` if the setting does not exist.
 *
 *  Method: resourcesettings.projects.settings.get
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeResourceSettingsCloudPlatform
 */
@interface GTLRResourceSettingsQuery_ProjectsSettingsGet : GTLRResourceSettingsQuery

/**
 *  Required. The name of the setting to get. See Setting for naming
 *  requirements.
 */
@property(nonatomic, copy, nullable) NSString *name;

/**
 *  The SettingView for this request.
 *
 *  Likely values:
 *    @arg @c kGTLRResourceSettingsViewSettingViewUnspecified The default /
 *        unset value. The API will default to the SETTING_VIEW_BASIC view.
 *        (Value: "SETTING_VIEW_UNSPECIFIED")
 *    @arg @c kGTLRResourceSettingsViewSettingViewBasic Include
 *        Setting.metadata, but nothing else. This is the default value (for
 *        both ListSettings and GetSetting). (Value: "SETTING_VIEW_BASIC")
 *    @arg @c kGTLRResourceSettingsViewSettingViewEffectiveValue Include
 *        Setting.effective_value, but nothing else. (Value:
 *        "SETTING_VIEW_EFFECTIVE_VALUE")
 *    @arg @c kGTLRResourceSettingsViewSettingViewLocalValue Include
 *        Setting.local_value, but nothing else. (Value:
 *        "SETTING_VIEW_LOCAL_VALUE")
 */
@property(nonatomic, copy, nullable) NSString *view;

/**
 *  Fetches a @c GTLRResourceSettings_GoogleCloudResourcesettingsV1Setting.
 *
 *  Returns a specified setting. Returns a `google.rpc.Status` with
 *  `google.rpc.Code.NOT_FOUND` if the setting does not exist.
 *
 *  @param name Required. The name of the setting to get. See Setting for naming
 *    requirements.
 *
 *  @return GTLRResourceSettingsQuery_ProjectsSettingsGet
 */
+ (instancetype)queryWithName:(NSString *)name;

@end

/**
 *  Lists all the settings that are available on the Cloud resource `parent`.
 *
 *  Method: resourcesettings.projects.settings.list
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeResourceSettingsCloudPlatform
 */
@interface GTLRResourceSettingsQuery_ProjectsSettingsList : GTLRResourceSettingsQuery

/** Unused. The size of the page to be returned. */
@property(nonatomic, assign) NSInteger pageSize;

/** Unused. A page token used to retrieve the next page. */
@property(nonatomic, copy, nullable) NSString *pageToken;

/**
 *  Required. The project, folder, or organization that is the parent resource
 *  for this setting. Must be in one of the following forms: *
 *  `projects/{project_number}` * `projects/{project_id}` *
 *  `folders/{folder_id}` * `organizations/{organization_id}`
 */
@property(nonatomic, copy, nullable) NSString *parent;

/**
 *  The SettingView for this request.
 *
 *  Likely values:
 *    @arg @c kGTLRResourceSettingsViewSettingViewUnspecified The default /
 *        unset value. The API will default to the SETTING_VIEW_BASIC view.
 *        (Value: "SETTING_VIEW_UNSPECIFIED")
 *    @arg @c kGTLRResourceSettingsViewSettingViewBasic Include
 *        Setting.metadata, but nothing else. This is the default value (for
 *        both ListSettings and GetSetting). (Value: "SETTING_VIEW_BASIC")
 *    @arg @c kGTLRResourceSettingsViewSettingViewEffectiveValue Include
 *        Setting.effective_value, but nothing else. (Value:
 *        "SETTING_VIEW_EFFECTIVE_VALUE")
 *    @arg @c kGTLRResourceSettingsViewSettingViewLocalValue Include
 *        Setting.local_value, but nothing else. (Value:
 *        "SETTING_VIEW_LOCAL_VALUE")
 */
@property(nonatomic, copy, nullable) NSString *view;

/**
 *  Fetches a @c
 *  GTLRResourceSettings_GoogleCloudResourcesettingsV1ListSettingsResponse.
 *
 *  Lists all the settings that are available on the Cloud resource `parent`.
 *
 *  @param parent Required. The project, folder, or organization that is the
 *    parent resource for this setting. Must be in one of the following forms: *
 *    `projects/{project_number}` * `projects/{project_id}` *
 *    `folders/{folder_id}` * `organizations/{organization_id}`
 *
 *  @return GTLRResourceSettingsQuery_ProjectsSettingsList
 *
 *  @note Automatic pagination will be done when @c shouldFetchNextPages is
 *        enabled. See @c shouldFetchNextPages on @c GTLRService for more
 *        information.
 */
+ (instancetype)queryWithParent:(NSString *)parent;

@end

/**
 *  Updates a specified setting. Returns a `google.rpc.Status` with
 *  `google.rpc.Code.NOT_FOUND` if the setting does not exist. Returns a
 *  `google.rpc.Status` with `google.rpc.Code.FAILED_PRECONDITION` if the
 *  setting is flagged as read only. Returns a `google.rpc.Status` with
 *  `google.rpc.Code.ABORTED` if the etag supplied in the request does not match
 *  the persisted etag of the setting value. On success, the response will
 *  contain only `name`, `local_value` and `etag`. The `metadata` and
 *  `effective_value` cannot be updated through this API. Note: the supplied
 *  setting will perform a full overwrite of the `local_value` field.
 *
 *  Method: resourcesettings.projects.settings.patch
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeResourceSettingsCloudPlatform
 */
@interface GTLRResourceSettingsQuery_ProjectsSettingsPatch : GTLRResourceSettingsQuery

/**
 *  The resource name of the setting. Must be in one of the following forms: *
 *  `projects/{project_number}/settings/{setting_name}` *
 *  `folders/{folder_id}/settings/{setting_name}` *
 *  `organizations/{organization_id}/settings/{setting_name}` For example,
 *  "/projects/123/settings/gcp-enableMyFeature"
 */
@property(nonatomic, copy, nullable) NSString *name;

/**
 *  Fetches a @c GTLRResourceSettings_GoogleCloudResourcesettingsV1Setting.
 *
 *  Updates a specified setting. Returns a `google.rpc.Status` with
 *  `google.rpc.Code.NOT_FOUND` if the setting does not exist. Returns a
 *  `google.rpc.Status` with `google.rpc.Code.FAILED_PRECONDITION` if the
 *  setting is flagged as read only. Returns a `google.rpc.Status` with
 *  `google.rpc.Code.ABORTED` if the etag supplied in the request does not match
 *  the persisted etag of the setting value. On success, the response will
 *  contain only `name`, `local_value` and `etag`. The `metadata` and
 *  `effective_value` cannot be updated through this API. Note: the supplied
 *  setting will perform a full overwrite of the `local_value` field.
 *
 *  @param object The @c
 *    GTLRResourceSettings_GoogleCloudResourcesettingsV1Setting to include in
 *    the query.
 *  @param name The resource name of the setting. Must be in one of the
 *    following forms: * `projects/{project_number}/settings/{setting_name}` *
 *    `folders/{folder_id}/settings/{setting_name}` *
 *    `organizations/{organization_id}/settings/{setting_name}` For example,
 *    "/projects/123/settings/gcp-enableMyFeature"
 *
 *  @return GTLRResourceSettingsQuery_ProjectsSettingsPatch
 */
+ (instancetype)queryWithObject:(GTLRResourceSettings_GoogleCloudResourcesettingsV1Setting *)object
                           name:(NSString *)name;

@end

NS_ASSUME_NONNULL_END

#pragma clang diagnostic pop
