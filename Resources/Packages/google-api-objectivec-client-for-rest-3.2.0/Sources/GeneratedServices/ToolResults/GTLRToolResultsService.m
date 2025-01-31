// NOTE: This file was generated by the ServiceGenerator.

// ----------------------------------------------------------------------------
// API:
//   Cloud Tool Results API (toolresults/v1beta3)
// Description:
//   API to publish and access results from developer tools.
// Documentation:
//   https://firebase.google.com/docs/test-lab/

#import <GoogleAPIClientForREST/GTLRToolResults.h>

// ----------------------------------------------------------------------------
// Authorization scope

NSString * const kGTLRAuthScopeToolResultsCloudPlatform = @"https://www.googleapis.com/auth/cloud-platform";

// ----------------------------------------------------------------------------
//   GTLRToolResultsService
//

@implementation GTLRToolResultsService

- (instancetype)init {
  self = [super init];
  if (self) {
    // From discovery.
    self.rootURLString = @"https://toolresults.googleapis.com/";
    self.batchPath = @"batch";
    self.prettyPrintQueryParameterNames = @[ @"prettyPrint" ];
  }
  return self;
}

@end
