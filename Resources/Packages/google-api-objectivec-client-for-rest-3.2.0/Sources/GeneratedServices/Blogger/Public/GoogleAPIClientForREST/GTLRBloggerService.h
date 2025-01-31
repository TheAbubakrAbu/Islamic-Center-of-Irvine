// NOTE: This file was generated by the ServiceGenerator.

// ----------------------------------------------------------------------------
// API:
//   Blogger API (blogger/v3)
// Description:
//   The Blogger API provides access to posts, comments and pages of a Blogger
//   blog.
// Documentation:
//   https://developers.google.com/blogger/docs/3.0/getting_started

#import <GoogleAPIClientForREST/GTLRService.h>

#if GTLR_RUNTIME_VERSION != 3000
#error This file was generated by a different version of ServiceGenerator which is incompatible with this GTLR library source.
#endif

// Generated comments include content from the discovery document; avoid them
// causing warnings since clang's checks are some what arbitrary.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

NS_ASSUME_NONNULL_BEGIN

// ----------------------------------------------------------------------------
// Authorization scopes

/**
 *  Authorization scope: Manage your Blogger account
 *
 *  Value "https://www.googleapis.com/auth/blogger"
 */
FOUNDATION_EXTERN NSString * const kGTLRAuthScopeBlogger;
/**
 *  Authorization scope: View your Blogger account
 *
 *  Value "https://www.googleapis.com/auth/blogger.readonly"
 */
FOUNDATION_EXTERN NSString * const kGTLRAuthScopeBloggerReadonly;

// ----------------------------------------------------------------------------
//   GTLRBloggerService
//

/**
 *  Service for executing Blogger API queries.
 *
 *  The Blogger API provides access to posts, comments and pages of a Blogger
 *  blog.
 */
@interface GTLRBloggerService : GTLRService

// No new methods

// Clients should create a standard query with any of the class methods in
// GTLRBloggerQuery.h. The query can the be sent with GTLRService's execute
// methods,
//
//   - (GTLRServiceTicket *)executeQuery:(GTLRQuery *)query
//                     completionHandler:(void (^)(GTLRServiceTicket *ticket,
//                                                 id object, NSError *error))handler;
// or
//   - (GTLRServiceTicket *)executeQuery:(GTLRQuery *)query
//                              delegate:(id)delegate
//                     didFinishSelector:(SEL)finishedSelector;
//
// where finishedSelector has a signature of:
//
//   - (void)serviceTicket:(GTLRServiceTicket *)ticket
//      finishedWithObject:(id)object
//                   error:(NSError *)error;
//
// The object passed to the completion handler or delegate method
// is a subclass of GTLRObject, determined by the query method executed.

@end

NS_ASSUME_NONNULL_END

#pragma clang diagnostic pop
