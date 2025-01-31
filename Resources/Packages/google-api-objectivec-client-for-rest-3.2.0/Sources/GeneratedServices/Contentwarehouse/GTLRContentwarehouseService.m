// NOTE: This file was generated by the ServiceGenerator.

// ----------------------------------------------------------------------------
// API:
//   Document AI Warehouse API (contentwarehouse/v1)
// Documentation:
//   https://cloud.google.com/document-warehouse

#import <GoogleAPIClientForREST/GTLRContentwarehouse.h>

// ----------------------------------------------------------------------------
// Authorization scope

NSString * const kGTLRAuthScopeContentwarehouseCloudPlatform = @"https://www.googleapis.com/auth/cloud-platform";

// ----------------------------------------------------------------------------
//   GTLRContentwarehouseService
//

@implementation GTLRContentwarehouseService

- (instancetype)init {
  self = [super init];
  if (self) {
    // From discovery.
    self.rootURLString = @"https://contentwarehouse.googleapis.com/";
    self.batchPath = @"batch";
    self.prettyPrintQueryParameterNames = @[ @"prettyPrint" ];
  }
  return self;
}

@end
