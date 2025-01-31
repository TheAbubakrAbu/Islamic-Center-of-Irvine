// NOTE: This file was generated by the ServiceGenerator.

// ----------------------------------------------------------------------------
// API:
//   Vertex AI API (aiplatform/v1)
// Description:
//   Train high-quality custom machine learning models with minimal machine
//   learning expertise and effort.
// Documentation:
//   https://cloud.google.com/vertex-ai/

#import <GoogleAPIClientForREST/GTLRAiplatform.h>

// ----------------------------------------------------------------------------
// Authorization scopes

NSString * const kGTLRAuthScopeAiplatformCloudPlatform         = @"https://www.googleapis.com/auth/cloud-platform";
NSString * const kGTLRAuthScopeAiplatformCloudPlatformReadOnly = @"https://www.googleapis.com/auth/cloud-platform.read-only";

// ----------------------------------------------------------------------------
//   GTLRAiplatformService
//

@implementation GTLRAiplatformService

- (instancetype)init {
  self = [super init];
  if (self) {
    // From discovery.
    self.rootURLString = @"https://aiplatform.googleapis.com/";
    self.batchPath = @"batch";
    self.prettyPrintQueryParameterNames = @[ @"prettyPrint" ];
  }
  return self;
}

@end
