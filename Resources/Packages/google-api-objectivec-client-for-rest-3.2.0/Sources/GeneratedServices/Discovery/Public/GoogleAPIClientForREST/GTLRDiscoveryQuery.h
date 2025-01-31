// NOTE: This file was generated by the ServiceGenerator.

// ----------------------------------------------------------------------------
// API:
//   API Discovery Service (discovery/v1)
// Description:
//   Provides information about other Google APIs, such as what APIs are
//   available, the resource, and method details for each API.
// Documentation:
//   https://developers.google.com/discovery/

#import <GoogleAPIClientForREST/GTLRQuery.h>

#if GTLR_RUNTIME_VERSION != 3000
#error This file was generated by a different version of ServiceGenerator which is incompatible with this GTLR library source.
#endif

// Generated comments include content from the discovery document; avoid them
// causing warnings since clang's checks are some what arbitrary.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

NS_ASSUME_NONNULL_BEGIN

/**
 *  Parent class for other Discovery query classes.
 */
@interface GTLRDiscoveryQuery : GTLRQuery

/** Selector specifying which fields to include in a partial response. */
@property(nonatomic, copy, nullable) NSString *fields;

@end

/**
 *  Retrieve the description of a particular version of an api.
 *
 *  Method: discovery.apis.getRest
 */
@interface GTLRDiscoveryQuery_ApisGetRest : GTLRDiscoveryQuery

/** The name of the API. */
@property(nonatomic, copy, nullable) NSString *api;

/** The version of the API. */
@property(nonatomic, copy, nullable) NSString *version;

/**
 *  Fetches a @c GTLRDiscovery_RestDescription.
 *
 *  Retrieve the description of a particular version of an api.
 *
 *  @param api The name of the API.
 *  @param version The version of the API.
 *
 *  @return GTLRDiscoveryQuery_ApisGetRest
 */
+ (instancetype)queryWithApi:(NSString *)api
                     version:(NSString *)version;

@end

/**
 *  Retrieve the list of APIs supported at this endpoint.
 *
 *  Method: discovery.apis.list
 */
@interface GTLRDiscoveryQuery_ApisList : GTLRDiscoveryQuery

/** Only include APIs with the given name. */
@property(nonatomic, copy, nullable) NSString *name;

/**
 *  Return only the preferred version of an API.
 *
 *  @note If not set, the documented server-side default will be false.
 */
@property(nonatomic, assign) BOOL preferred;

/**
 *  Fetches a @c GTLRDiscovery_DirectoryList.
 *
 *  Retrieve the list of APIs supported at this endpoint.
 *
 *  @return GTLRDiscoveryQuery_ApisList
 */
+ (instancetype)query;

@end

NS_ASSUME_NONNULL_END

#pragma clang diagnostic pop
