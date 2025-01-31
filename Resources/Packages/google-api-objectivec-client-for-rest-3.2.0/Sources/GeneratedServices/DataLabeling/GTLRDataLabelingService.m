// NOTE: This file was generated by the ServiceGenerator.

// ----------------------------------------------------------------------------
// API:
//   Data Labeling API (datalabeling/v1beta1)
// Description:
//   Public API for Google Cloud AI Data Labeling Service.
// Documentation:
//   https://cloud.google.com/data-labeling/docs/

#import <GoogleAPIClientForREST/GTLRDataLabeling.h>

// ----------------------------------------------------------------------------
// Authorization scope

NSString * const kGTLRAuthScopeDataLabelingCloudPlatform = @"https://www.googleapis.com/auth/cloud-platform";

// ----------------------------------------------------------------------------
//   GTLRDataLabelingService
//

@implementation GTLRDataLabelingService

- (instancetype)init {
  self = [super init];
  if (self) {
    // From discovery.
    self.rootURLString = @"https://datalabeling.googleapis.com/";
    self.batchPath = @"batch";
    self.prettyPrintQueryParameterNames = @[ @"prettyPrint" ];
  }
  return self;
}

@end
