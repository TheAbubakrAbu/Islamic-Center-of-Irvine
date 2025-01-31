// NOTE: This file was generated by the ServiceGenerator.

// ----------------------------------------------------------------------------
// API:
//   DoubleClick Bid Manager API (doubleclickbidmanager/v2)
// Description:
//   DoubleClick Bid Manager API allows users to manage and create campaigns and
//   reports.
// Documentation:
//   https://developers.google.com/bid-manager/

#import <GoogleAPIClientForREST/GTLRDoubleClickBidManagerObjects.h>

// ----------------------------------------------------------------------------
// Constants

// GTLRDoubleClickBidManager_DataRange.range
NSString * const kGTLRDoubleClickBidManager_DataRange_Range_AllTime = @"ALL_TIME";
NSString * const kGTLRDoubleClickBidManager_DataRange_Range_CurrentDay = @"CURRENT_DAY";
NSString * const kGTLRDoubleClickBidManager_DataRange_Range_CustomDates = @"CUSTOM_DATES";
NSString * const kGTLRDoubleClickBidManager_DataRange_Range_Last14Days = @"LAST_14_DAYS";
NSString * const kGTLRDoubleClickBidManager_DataRange_Range_Last30Days = @"LAST_30_DAYS";
NSString * const kGTLRDoubleClickBidManager_DataRange_Range_Last365Days = @"LAST_365_DAYS";
NSString * const kGTLRDoubleClickBidManager_DataRange_Range_Last60Days = @"LAST_60_DAYS";
NSString * const kGTLRDoubleClickBidManager_DataRange_Range_Last7Days = @"LAST_7_DAYS";
NSString * const kGTLRDoubleClickBidManager_DataRange_Range_Last90Days = @"LAST_90_DAYS";
NSString * const kGTLRDoubleClickBidManager_DataRange_Range_MonthToDate = @"MONTH_TO_DATE";
NSString * const kGTLRDoubleClickBidManager_DataRange_Range_PreviousDay = @"PREVIOUS_DAY";
NSString * const kGTLRDoubleClickBidManager_DataRange_Range_PreviousMonth = @"PREVIOUS_MONTH";
NSString * const kGTLRDoubleClickBidManager_DataRange_Range_PreviousQuarter = @"PREVIOUS_QUARTER";
NSString * const kGTLRDoubleClickBidManager_DataRange_Range_PreviousWeek = @"PREVIOUS_WEEK";
NSString * const kGTLRDoubleClickBidManager_DataRange_Range_PreviousYear = @"PREVIOUS_YEAR";
NSString * const kGTLRDoubleClickBidManager_DataRange_Range_QuarterToDate = @"QUARTER_TO_DATE";
NSString * const kGTLRDoubleClickBidManager_DataRange_Range_RangeUnspecified = @"RANGE_UNSPECIFIED";
NSString * const kGTLRDoubleClickBidManager_DataRange_Range_WeekToDate = @"WEEK_TO_DATE";
NSString * const kGTLRDoubleClickBidManager_DataRange_Range_YearToDate = @"YEAR_TO_DATE";

// GTLRDoubleClickBidManager_Parameters.type
NSString * const kGTLRDoubleClickBidManager_Parameters_Type_AudienceComposition = @"AUDIENCE_COMPOSITION";
NSString * const kGTLRDoubleClickBidManager_Parameters_Type_Floodlight = @"FLOODLIGHT";
NSString * const kGTLRDoubleClickBidManager_Parameters_Type_FullPath = @"FULL_PATH";
NSString * const kGTLRDoubleClickBidManager_Parameters_Type_Grp = @"GRP";
NSString * const kGTLRDoubleClickBidManager_Parameters_Type_InventoryAvailability = @"INVENTORY_AVAILABILITY";
NSString * const kGTLRDoubleClickBidManager_Parameters_Type_PathAttribution = @"PATH_ATTRIBUTION";
NSString * const kGTLRDoubleClickBidManager_Parameters_Type_Reach = @"REACH";
NSString * const kGTLRDoubleClickBidManager_Parameters_Type_ReportTypeUnspecified = @"REPORT_TYPE_UNSPECIFIED";
NSString * const kGTLRDoubleClickBidManager_Parameters_Type_Standard = @"STANDARD";
NSString * const kGTLRDoubleClickBidManager_Parameters_Type_UniqueReachAudience = @"UNIQUE_REACH_AUDIENCE";
NSString * const kGTLRDoubleClickBidManager_Parameters_Type_Youtube = @"YOUTUBE";
NSString * const kGTLRDoubleClickBidManager_Parameters_Type_YoutubeProgrammaticGuaranteed = @"YOUTUBE_PROGRAMMATIC_GUARANTEED";

// GTLRDoubleClickBidManager_PathFilter.pathMatchPosition
NSString * const kGTLRDoubleClickBidManager_PathFilter_PathMatchPosition_Any = @"ANY";
NSString * const kGTLRDoubleClickBidManager_PathFilter_PathMatchPosition_First = @"FIRST";
NSString * const kGTLRDoubleClickBidManager_PathFilter_PathMatchPosition_Last = @"LAST";
NSString * const kGTLRDoubleClickBidManager_PathFilter_PathMatchPosition_PathMatchPositionUnspecified = @"PATH_MATCH_POSITION_UNSPECIFIED";

// GTLRDoubleClickBidManager_PathQueryOptionsFilter.match
NSString * const kGTLRDoubleClickBidManager_PathQueryOptionsFilter_Match_BeginsWith = @"BEGINS_WITH";
NSString * const kGTLRDoubleClickBidManager_PathQueryOptionsFilter_Match_Exact = @"EXACT";
NSString * const kGTLRDoubleClickBidManager_PathQueryOptionsFilter_Match_Partial = @"PARTIAL";
NSString * const kGTLRDoubleClickBidManager_PathQueryOptionsFilter_Match_Unknown = @"UNKNOWN";
NSString * const kGTLRDoubleClickBidManager_PathQueryOptionsFilter_Match_WildcardExpression = @"WILDCARD_EXPRESSION";

// GTLRDoubleClickBidManager_QueryMetadata.format
NSString * const kGTLRDoubleClickBidManager_QueryMetadata_Format_Csv = @"CSV";
NSString * const kGTLRDoubleClickBidManager_QueryMetadata_Format_FormatUnspecified = @"FORMAT_UNSPECIFIED";
NSString * const kGTLRDoubleClickBidManager_QueryMetadata_Format_Xlsx = @"XLSX";

// GTLRDoubleClickBidManager_QuerySchedule.frequency
NSString * const kGTLRDoubleClickBidManager_QuerySchedule_Frequency_Daily = @"DAILY";
NSString * const kGTLRDoubleClickBidManager_QuerySchedule_Frequency_FrequencyUnspecified = @"FREQUENCY_UNSPECIFIED";
NSString * const kGTLRDoubleClickBidManager_QuerySchedule_Frequency_Monthly = @"MONTHLY";
NSString * const kGTLRDoubleClickBidManager_QuerySchedule_Frequency_OneTime = @"ONE_TIME";
NSString * const kGTLRDoubleClickBidManager_QuerySchedule_Frequency_Quarterly = @"QUARTERLY";
NSString * const kGTLRDoubleClickBidManager_QuerySchedule_Frequency_SemiMonthly = @"SEMI_MONTHLY";
NSString * const kGTLRDoubleClickBidManager_QuerySchedule_Frequency_Weekly = @"WEEKLY";
NSString * const kGTLRDoubleClickBidManager_QuerySchedule_Frequency_Yearly = @"YEARLY";

// GTLRDoubleClickBidManager_ReportStatus.format
NSString * const kGTLRDoubleClickBidManager_ReportStatus_Format_Csv = @"CSV";
NSString * const kGTLRDoubleClickBidManager_ReportStatus_Format_FormatUnspecified = @"FORMAT_UNSPECIFIED";
NSString * const kGTLRDoubleClickBidManager_ReportStatus_Format_Xlsx = @"XLSX";

// GTLRDoubleClickBidManager_ReportStatus.state
NSString * const kGTLRDoubleClickBidManager_ReportStatus_State_Done = @"DONE";
NSString * const kGTLRDoubleClickBidManager_ReportStatus_State_Failed = @"FAILED";
NSString * const kGTLRDoubleClickBidManager_ReportStatus_State_Queued = @"QUEUED";
NSString * const kGTLRDoubleClickBidManager_ReportStatus_State_Running = @"RUNNING";
NSString * const kGTLRDoubleClickBidManager_ReportStatus_State_StateUnspecified = @"STATE_UNSPECIFIED";

// ----------------------------------------------------------------------------
//
//   GTLRDoubleClickBidManager_ChannelGrouping
//

@implementation GTLRDoubleClickBidManager_ChannelGrouping
@dynamic fallbackName, name, rules;

+ (NSDictionary<NSString *, Class> *)arrayPropertyToClassMap {
  NSDictionary<NSString *, Class> *map = @{
    @"rules" : [GTLRDoubleClickBidManager_Rule class]
  };
  return map;
}

@end


// ----------------------------------------------------------------------------
//
//   GTLRDoubleClickBidManager_DataRange
//

@implementation GTLRDoubleClickBidManager_DataRange
@dynamic customEndDate, customStartDate, range;
@end


// ----------------------------------------------------------------------------
//
//   GTLRDoubleClickBidManager_Date
//

@implementation GTLRDoubleClickBidManager_Date
@dynamic day, month, year;
@end


// ----------------------------------------------------------------------------
//
//   GTLRDoubleClickBidManager_DisjunctiveMatchStatement
//

@implementation GTLRDoubleClickBidManager_DisjunctiveMatchStatement
@dynamic eventFilters;

+ (NSDictionary<NSString *, Class> *)arrayPropertyToClassMap {
  NSDictionary<NSString *, Class> *map = @{
    @"eventFilters" : [GTLRDoubleClickBidManager_EventFilter class]
  };
  return map;
}

@end


// ----------------------------------------------------------------------------
//
//   GTLRDoubleClickBidManager_EventFilter
//

@implementation GTLRDoubleClickBidManager_EventFilter
@dynamic dimensionFilter;
@end


// ----------------------------------------------------------------------------
//
//   GTLRDoubleClickBidManager_FilterPair
//

@implementation GTLRDoubleClickBidManager_FilterPair
@dynamic type, value;
@end


// ----------------------------------------------------------------------------
//
//   GTLRDoubleClickBidManager_ListQueriesResponse
//

@implementation GTLRDoubleClickBidManager_ListQueriesResponse
@dynamic nextPageToken, queries;

+ (NSDictionary<NSString *, Class> *)arrayPropertyToClassMap {
  NSDictionary<NSString *, Class> *map = @{
    @"queries" : [GTLRDoubleClickBidManager_Query class]
  };
  return map;
}

+ (NSString *)collectionItemsKey {
  return @"queries";
}

@end


// ----------------------------------------------------------------------------
//
//   GTLRDoubleClickBidManager_ListReportsResponse
//

@implementation GTLRDoubleClickBidManager_ListReportsResponse
@dynamic nextPageToken, reports;

+ (NSDictionary<NSString *, Class> *)arrayPropertyToClassMap {
  NSDictionary<NSString *, Class> *map = @{
    @"reports" : [GTLRDoubleClickBidManager_Report class]
  };
  return map;
}

+ (NSString *)collectionItemsKey {
  return @"reports";
}

@end


// ----------------------------------------------------------------------------
//
//   GTLRDoubleClickBidManager_Options
//

@implementation GTLRDoubleClickBidManager_Options
@dynamic includeOnlyTargetedUserLists, pathQueryOptions;
@end


// ----------------------------------------------------------------------------
//
//   GTLRDoubleClickBidManager_Parameters
//

@implementation GTLRDoubleClickBidManager_Parameters
@dynamic filters, groupBys, metrics, options, type;

+ (NSDictionary<NSString *, Class> *)arrayPropertyToClassMap {
  NSDictionary<NSString *, Class> *map = @{
    @"filters" : [GTLRDoubleClickBidManager_FilterPair class],
    @"groupBys" : [NSString class],
    @"metrics" : [NSString class]
  };
  return map;
}

@end


// ----------------------------------------------------------------------------
//
//   GTLRDoubleClickBidManager_PathFilter
//

@implementation GTLRDoubleClickBidManager_PathFilter
@dynamic eventFilters, pathMatchPosition;

+ (NSDictionary<NSString *, Class> *)arrayPropertyToClassMap {
  NSDictionary<NSString *, Class> *map = @{
    @"eventFilters" : [GTLRDoubleClickBidManager_EventFilter class]
  };
  return map;
}

@end


// ----------------------------------------------------------------------------
//
//   GTLRDoubleClickBidManager_PathQueryOptions
//

@implementation GTLRDoubleClickBidManager_PathQueryOptions
@dynamic channelGrouping, pathFilters;

+ (NSDictionary<NSString *, Class> *)arrayPropertyToClassMap {
  NSDictionary<NSString *, Class> *map = @{
    @"pathFilters" : [GTLRDoubleClickBidManager_PathFilter class]
  };
  return map;
}

@end


// ----------------------------------------------------------------------------
//
//   GTLRDoubleClickBidManager_PathQueryOptionsFilter
//

@implementation GTLRDoubleClickBidManager_PathQueryOptionsFilter
@dynamic filter, match, values;

+ (NSDictionary<NSString *, Class> *)arrayPropertyToClassMap {
  NSDictionary<NSString *, Class> *map = @{
    @"values" : [NSString class]
  };
  return map;
}

@end


// ----------------------------------------------------------------------------
//
//   GTLRDoubleClickBidManager_Query
//

@implementation GTLRDoubleClickBidManager_Query
@dynamic metadata, params, queryId, schedule;
@end


// ----------------------------------------------------------------------------
//
//   GTLRDoubleClickBidManager_QueryMetadata
//

@implementation GTLRDoubleClickBidManager_QueryMetadata
@dynamic dataRange, format, sendNotification, shareEmailAddress, title;

+ (NSDictionary<NSString *, Class> *)arrayPropertyToClassMap {
  NSDictionary<NSString *, Class> *map = @{
    @"shareEmailAddress" : [NSString class]
  };
  return map;
}

@end


// ----------------------------------------------------------------------------
//
//   GTLRDoubleClickBidManager_QuerySchedule
//

@implementation GTLRDoubleClickBidManager_QuerySchedule
@dynamic endDate, frequency, nextRunTimezoneCode, startDate;
@end


// ----------------------------------------------------------------------------
//
//   GTLRDoubleClickBidManager_Report
//

@implementation GTLRDoubleClickBidManager_Report
@dynamic key, metadata, params;
@end


// ----------------------------------------------------------------------------
//
//   GTLRDoubleClickBidManager_ReportKey
//

@implementation GTLRDoubleClickBidManager_ReportKey
@dynamic queryId, reportId;
@end


// ----------------------------------------------------------------------------
//
//   GTLRDoubleClickBidManager_ReportMetadata
//

@implementation GTLRDoubleClickBidManager_ReportMetadata
@dynamic googleCloudStoragePath, reportDataEndDate, reportDataStartDate, status;
@end


// ----------------------------------------------------------------------------
//
//   GTLRDoubleClickBidManager_ReportStatus
//

@implementation GTLRDoubleClickBidManager_ReportStatus
@dynamic finishTime, format, state;
@end


// ----------------------------------------------------------------------------
//
//   GTLRDoubleClickBidManager_Rule
//

@implementation GTLRDoubleClickBidManager_Rule
@dynamic disjunctiveMatchStatements, name;

+ (NSDictionary<NSString *, Class> *)arrayPropertyToClassMap {
  NSDictionary<NSString *, Class> *map = @{
    @"disjunctiveMatchStatements" : [GTLRDoubleClickBidManager_DisjunctiveMatchStatement class]
  };
  return map;
}

@end


// ----------------------------------------------------------------------------
//
//   GTLRDoubleClickBidManager_RunQueryRequest
//

@implementation GTLRDoubleClickBidManager_RunQueryRequest
@dynamic dataRange;
@end
