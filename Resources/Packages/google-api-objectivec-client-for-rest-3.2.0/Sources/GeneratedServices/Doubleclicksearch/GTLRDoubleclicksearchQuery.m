// NOTE: This file was generated by the ServiceGenerator.

// ----------------------------------------------------------------------------
// API:
//   Search Ads 360 API (doubleclicksearch/v2)
// Description:
//   The Search Ads 360 API allows developers to automate uploading conversions
//   and downloading reports from Search Ads 360.
// Documentation:
//   https://developers.google.com/search-ads

#import <GoogleAPIClientForREST/GTLRDoubleclicksearchQuery.h>

@implementation GTLRDoubleclicksearchQuery

@dynamic fields;

@end

@implementation GTLRDoubleclicksearchQuery_ConversionGet

@dynamic adGroupId, adId, advertiserId, agencyId, campaignId, criterionId,
         customerId, endDate, engineAccountId, rowCount, startDate, startRow;

+ (instancetype)queryWithAgencyId:(long long)agencyId
                     advertiserId:(long long)advertiserId
                  engineAccountId:(long long)engineAccountId
                          endDate:(NSInteger)endDate
                         rowCount:(NSInteger)rowCount
                        startDate:(NSInteger)startDate
                         startRow:(NSUInteger)startRow {
  NSArray *pathParams = @[
    @"advertiserId", @"agencyId", @"engineAccountId"
  ];
  NSString *pathURITemplate = @"doubleclicksearch/v2/agency/{agencyId}/advertiser/{advertiserId}/engine/{engineAccountId}/conversion";
  GTLRDoubleclicksearchQuery_ConversionGet *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.agencyId = agencyId;
  query.advertiserId = advertiserId;
  query.engineAccountId = engineAccountId;
  query.endDate = endDate;
  query.rowCount = rowCount;
  query.startDate = startDate;
  query.startRow = startRow;
  query.expectedObjectClass = [GTLRDoubleclicksearch_ConversionList class];
  query.loggingName = @"doubleclicksearch.conversion.get";
  return query;
}

@end

@implementation GTLRDoubleclicksearchQuery_ConversionGetByCustomerId

@dynamic adGroupId, adId, advertiserId, agencyId, campaignId, criterionId,
         customerId, endDate, engineAccountId, rowCount, startDate, startRow;

+ (instancetype)queryWithCustomerId:(NSString *)customerId
                            endDate:(NSInteger)endDate
                           rowCount:(NSInteger)rowCount
                          startDate:(NSInteger)startDate
                           startRow:(NSUInteger)startRow {
  NSArray *pathParams = @[ @"customerId" ];
  NSString *pathURITemplate = @"doubleclicksearch/v2/customer/{customerId}/conversion";
  GTLRDoubleclicksearchQuery_ConversionGetByCustomerId *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.customerId = customerId;
  query.endDate = endDate;
  query.rowCount = rowCount;
  query.startDate = startDate;
  query.startRow = startRow;
  query.expectedObjectClass = [GTLRDoubleclicksearch_ConversionList class];
  query.loggingName = @"doubleclicksearch.conversion.getByCustomerId";
  return query;
}

@end

@implementation GTLRDoubleclicksearchQuery_ConversionInsert

+ (instancetype)queryWithObject:(GTLRDoubleclicksearch_ConversionList *)object {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSString *pathURITemplate = @"doubleclicksearch/v2/conversion";
  GTLRDoubleclicksearchQuery_ConversionInsert *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:nil];
  query.bodyObject = object;
  query.expectedObjectClass = [GTLRDoubleclicksearch_ConversionList class];
  query.loggingName = @"doubleclicksearch.conversion.insert";
  return query;
}

@end

@implementation GTLRDoubleclicksearchQuery_ConversionUpdate

+ (instancetype)queryWithObject:(GTLRDoubleclicksearch_ConversionList *)object {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSString *pathURITemplate = @"doubleclicksearch/v2/conversion";
  GTLRDoubleclicksearchQuery_ConversionUpdate *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"PUT"
                       pathParameterNames:nil];
  query.bodyObject = object;
  query.expectedObjectClass = [GTLRDoubleclicksearch_ConversionList class];
  query.loggingName = @"doubleclicksearch.conversion.update";
  return query;
}

@end

@implementation GTLRDoubleclicksearchQuery_ConversionUpdateAvailability

+ (instancetype)queryWithObject:(GTLRDoubleclicksearch_UpdateAvailabilityRequest *)object {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSString *pathURITemplate = @"doubleclicksearch/v2/conversion/updateAvailability";
  GTLRDoubleclicksearchQuery_ConversionUpdateAvailability *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:nil];
  query.bodyObject = object;
  query.expectedObjectClass = [GTLRDoubleclicksearch_UpdateAvailabilityResponse class];
  query.loggingName = @"doubleclicksearch.conversion.updateAvailability";
  return query;
}

@end

@implementation GTLRDoubleclicksearchQuery_ReportsGenerate

+ (instancetype)queryWithObject:(GTLRDoubleclicksearch_ReportRequest *)object {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSString *pathURITemplate = @"doubleclicksearch/v2/reports/generate";
  GTLRDoubleclicksearchQuery_ReportsGenerate *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:nil];
  query.bodyObject = object;
  query.expectedObjectClass = [GTLRDoubleclicksearch_Report class];
  query.loggingName = @"doubleclicksearch.reports.generate";
  return query;
}

@end

@implementation GTLRDoubleclicksearchQuery_ReportsGet

@dynamic reportId;

+ (instancetype)queryWithReportId:(NSString *)reportId {
  NSArray *pathParams = @[ @"reportId" ];
  NSString *pathURITemplate = @"doubleclicksearch/v2/reports/{reportId}";
  GTLRDoubleclicksearchQuery_ReportsGet *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.reportId = reportId;
  query.expectedObjectClass = [GTLRDoubleclicksearch_Report class];
  query.loggingName = @"doubleclicksearch.reports.get";
  return query;
}

@end

@implementation GTLRDoubleclicksearchQuery_ReportsGetFile

@dynamic reportFragment, reportId;

+ (instancetype)queryWithReportId:(NSString *)reportId
                   reportFragment:(NSInteger)reportFragment {
  NSArray *pathParams = @[
    @"reportFragment", @"reportId"
  ];
  NSString *pathURITemplate = @"doubleclicksearch/v2/reports/{reportId}/files/{reportFragment}";
  GTLRDoubleclicksearchQuery_ReportsGetFile *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.reportId = reportId;
  query.reportFragment = reportFragment;
  query.loggingName = @"doubleclicksearch.reports.getFile";
  return query;
}

+ (instancetype)queryForMediaWithReportId:(NSString *)reportId
                           reportFragment:(NSInteger)reportFragment {
  GTLRDoubleclicksearchQuery_ReportsGetFile *query =
    [self queryWithReportId:reportId
             reportFragment:reportFragment];
  query.downloadAsDataObjectType = @"media";
  query.useMediaDownloadService = YES;
  query.loggingName = @"Download doubleclicksearch.reports.getFile";
  return query;
}

@end

@implementation GTLRDoubleclicksearchQuery_ReportsGetIdMappingFile

@dynamic advertiserId, agencyId;

+ (instancetype)queryWithAgencyId:(long long)agencyId
                     advertiserId:(long long)advertiserId {
  NSArray *pathParams = @[
    @"advertiserId", @"agencyId"
  ];
  NSString *pathURITemplate = @"doubleclicksearch/v2/agency/{agencyId}/advertiser/{advertiserId}/idmapping";
  GTLRDoubleclicksearchQuery_ReportsGetIdMappingFile *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.agencyId = agencyId;
  query.advertiserId = advertiserId;
  query.expectedObjectClass = [GTLRDoubleclicksearch_IdMappingFile class];
  query.loggingName = @"doubleclicksearch.reports.getIdMappingFile";
  return query;
}

+ (instancetype)queryForMediaWithAgencyId:(long long)agencyId
                             advertiserId:(long long)advertiserId {
  GTLRDoubleclicksearchQuery_ReportsGetIdMappingFile *query =
    [self queryWithAgencyId:agencyId
               advertiserId:advertiserId];
  query.downloadAsDataObjectType = @"media";
  query.useMediaDownloadService = YES;
  query.loggingName = @"Download doubleclicksearch.reports.getIdMappingFile";
  return query;
}

@end

@implementation GTLRDoubleclicksearchQuery_ReportsRequest

+ (instancetype)queryWithObject:(GTLRDoubleclicksearch_ReportRequest *)object {
  if (object == nil) {
#if defined(DEBUG) && DEBUG
    NSAssert(object != nil, @"Got a nil object");
#endif
    return nil;
  }
  NSString *pathURITemplate = @"doubleclicksearch/v2/reports";
  GTLRDoubleclicksearchQuery_ReportsRequest *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:nil];
  query.bodyObject = object;
  query.expectedObjectClass = [GTLRDoubleclicksearch_Report class];
  query.loggingName = @"doubleclicksearch.reports.request";
  return query;
}

@end

@implementation GTLRDoubleclicksearchQuery_SavedColumnsList

@dynamic advertiserId, agencyId;

+ (instancetype)queryWithAgencyId:(long long)agencyId
                     advertiserId:(long long)advertiserId {
  NSArray *pathParams = @[
    @"advertiserId", @"agencyId"
  ];
  NSString *pathURITemplate = @"doubleclicksearch/v2/agency/{agencyId}/advertiser/{advertiserId}/savedcolumns";
  GTLRDoubleclicksearchQuery_SavedColumnsList *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:nil
                       pathParameterNames:pathParams];
  query.agencyId = agencyId;
  query.advertiserId = advertiserId;
  query.expectedObjectClass = [GTLRDoubleclicksearch_SavedColumnList class];
  query.loggingName = @"doubleclicksearch.savedColumns.list";
  return query;
}

@end
