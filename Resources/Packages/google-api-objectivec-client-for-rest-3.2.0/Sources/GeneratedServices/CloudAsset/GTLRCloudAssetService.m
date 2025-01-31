// NOTE: This file was generated by the ServiceGenerator.

// ----------------------------------------------------------------------------
// API:
//   Cloud Asset API (cloudasset/v1)
// Description:
//   The Cloud Asset API manages the history and inventory of Google Cloud
//   resources.
// Documentation:
//   https://cloud.google.com/asset-inventory/docs/quickstart

#import <GoogleAPIClientForREST/GTLRCloudAsset.h>

// ----------------------------------------------------------------------------
// Authorization scope

NSString * const kGTLRAuthScopeCloudAssetCloudPlatform = @"https://www.googleapis.com/auth/cloud-platform";

// ----------------------------------------------------------------------------
//   GTLRCloudAssetService
//

@implementation GTLRCloudAssetService

- (instancetype)init {
  self = [super init];
  if (self) {
    // From discovery.
    self.rootURLString = @"https://cloudasset.googleapis.com/";
    self.batchPath = @"batch";
    self.prettyPrintQueryParameterNames = @[ @"prettyPrint" ];
  }
  return self;
}

@end
