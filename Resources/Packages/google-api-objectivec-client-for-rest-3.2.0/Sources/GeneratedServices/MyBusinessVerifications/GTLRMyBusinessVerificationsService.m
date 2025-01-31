// NOTE: This file was generated by the ServiceGenerator.

// ----------------------------------------------------------------------------
// API:
//   My Business Verifications API (mybusinessverifications/v1)
// Description:
//   The My Business Verifications API provides an interface for taking
//   verifications related actions for locations.
// Documentation:
//   https://developers.google.com/my-business/

#import <GoogleAPIClientForREST/GTLRMyBusinessVerifications.h>

@implementation GTLRMyBusinessVerificationsService

- (instancetype)init {
  self = [super init];
  if (self) {
    // From discovery.
    self.rootURLString = @"https://mybusinessverifications.googleapis.com/";
    self.batchPath = @"batch";
    self.prettyPrintQueryParameterNames = @[ @"prettyPrint" ];
  }
  return self;
}

@end
