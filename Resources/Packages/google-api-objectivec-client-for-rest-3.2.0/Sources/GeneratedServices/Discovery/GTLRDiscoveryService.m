// NOTE: This file was generated by the ServiceGenerator.

// ----------------------------------------------------------------------------
// API:
//   API Discovery Service (discovery/v1)
// Description:
//   Provides information about other Google APIs, such as what APIs are
//   available, the resource, and method details for each API.
// Documentation:
//   https://developers.google.com/discovery/

#import <GoogleAPIClientForREST/GTLRDiscovery.h>

@implementation GTLRDiscoveryService

- (instancetype)init {
  self = [super init];
  if (self) {
    // From discovery.
    self.rootURLString = @"https://www.googleapis.com/";
    self.servicePath = @"discovery/v1/";
    self.batchPath = @"batch/discovery/v1";
    self.prettyPrintQueryParameterNames = @[ @"prettyPrint" ];
  }
  return self;
}

+ (NSDictionary<NSString *, Class> *)kindStringToClassMap {
  return @{
    @"discovery#directoryItem" : [GTLRDiscovery_DirectoryList_Items_Item class],
    @"discovery#directoryList" : [GTLRDiscovery_DirectoryList class],
    @"discovery#restDescription" : [GTLRDiscovery_RestDescription class],
  };
}

@end
