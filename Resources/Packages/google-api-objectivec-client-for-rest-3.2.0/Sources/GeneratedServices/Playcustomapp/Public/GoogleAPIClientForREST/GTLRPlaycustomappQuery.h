// NOTE: This file was generated by the ServiceGenerator.

// ----------------------------------------------------------------------------
// API:
//   Google Play Custom App Publishing API (playcustomapp/v1)
// Description:
//   API to create and publish custom Android apps
// Documentation:
//   https://developers.google.com/android/work/play/custom-app-api/

#import <GoogleAPIClientForREST/GTLRQuery.h>

#if GTLR_RUNTIME_VERSION != 3000
#error This file was generated by a different version of ServiceGenerator which is incompatible with this GTLR library source.
#endif

#import "GTLRPlaycustomappObjects.h"

// Generated comments include content from the discovery document; avoid them
// causing warnings since clang's checks are some what arbitrary.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

NS_ASSUME_NONNULL_BEGIN

/**
 *  Parent class for other Playcustomapp query classes.
 */
@interface GTLRPlaycustomappQuery : GTLRQuery

/** Selector specifying which fields to include in a partial response. */
@property(nonatomic, copy, nullable) NSString *fields;

@end

/**
 *  Creates a new custom app.
 *
 *  Method: playcustomapp.accounts.customApps.create
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopePlaycustomappAndroidpublisher
 */
@interface GTLRPlaycustomappQuery_AccountsCustomAppsCreate : GTLRPlaycustomappQuery

/** Developer account ID. */
@property(nonatomic, assign) long long account;

/**
 *  Fetches a @c GTLRPlaycustomapp_CustomApp.
 *
 *  Creates a new custom app.
 *
 *  @param object The @c GTLRPlaycustomapp_CustomApp to include in the query.
 *  @param account Developer account ID.
 *  @param uploadParameters The media to include in this query. Maximum size
 *    10737418240. Accepted MIME type: * / *
 *
 *  @return GTLRPlaycustomappQuery_AccountsCustomAppsCreate
 */
+ (instancetype)queryWithObject:(GTLRPlaycustomapp_CustomApp *)object
                        account:(long long)account
               uploadParameters:(nullable GTLRUploadParameters *)uploadParameters;

@end

NS_ASSUME_NONNULL_END

#pragma clang diagnostic pop
