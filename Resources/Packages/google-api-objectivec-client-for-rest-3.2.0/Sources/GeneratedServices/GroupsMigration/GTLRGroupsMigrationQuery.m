// NOTE: This file was generated by the ServiceGenerator.

// ----------------------------------------------------------------------------
// API:
//   Groups Migration API (groupsmigration/v1)
// Description:
//   The Groups Migration API allows domain administrators to archive emails
//   into Google groups.
// Documentation:
//   https://developers.google.com/google-apps/groups-migration/

#import <GoogleAPIClientForREST/GTLRGroupsMigrationQuery.h>

#import <GoogleAPIClientForREST/GTLRGroupsMigrationObjects.h>

@implementation GTLRGroupsMigrationQuery

@dynamic fields;

@end

@implementation GTLRGroupsMigrationQuery_ArchiveInsert

@dynamic groupId;

+ (instancetype)queryWithGroupId:(NSString *)groupId
                uploadParameters:(GTLRUploadParameters *)uploadParameters {
  NSArray *pathParams = @[ @"groupId" ];
  NSString *pathURITemplate = @"groups/v1/groups/{groupId}/archive";
  GTLRGroupsMigrationQuery_ArchiveInsert *query =
    [[self alloc] initWithPathURITemplate:pathURITemplate
                               HTTPMethod:@"POST"
                       pathParameterNames:pathParams];
  query.groupId = groupId;
  query.uploadParameters = uploadParameters;
  query.expectedObjectClass = [GTLRGroupsMigration_Groups class];
  query.loggingName = @"groupsmigration.archive.insert";
  return query;
}

@end
