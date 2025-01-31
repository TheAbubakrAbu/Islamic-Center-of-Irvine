// NOTE: This file was generated by the ServiceGenerator.

// ----------------------------------------------------------------------------
// API:
//   Policy Troubleshooter API (policytroubleshooter/v1)
// Documentation:
//   https://cloud.google.com/iam/

#import <GoogleAPIClientForREST/GTLRPolicyTroubleshooter.h>

// ----------------------------------------------------------------------------
// Authorization scope

NSString * const kGTLRAuthScopePolicyTroubleshooterCloudPlatform = @"https://www.googleapis.com/auth/cloud-platform";

// ----------------------------------------------------------------------------
//   GTLRPolicyTroubleshooterService
//

@implementation GTLRPolicyTroubleshooterService

- (instancetype)init {
  self = [super init];
  if (self) {
    // From discovery.
    self.rootURLString = @"https://policytroubleshooter.googleapis.com/";
    self.batchPath = @"batch";
    self.prettyPrintQueryParameterNames = @[ @"prettyPrint" ];
  }
  return self;
}

@end
