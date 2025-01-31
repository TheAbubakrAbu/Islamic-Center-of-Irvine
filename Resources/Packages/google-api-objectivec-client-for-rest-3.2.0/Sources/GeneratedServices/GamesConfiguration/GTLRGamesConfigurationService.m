// NOTE: This file was generated by the ServiceGenerator.

// ----------------------------------------------------------------------------
// API:
//   Google Play Game Services Publishing API (gamesConfiguration/v1configuration)
// Description:
//   The Google Play Game Services Publishing API allows developers to configure
//   their games in Game Services.
// Documentation:
//   https://developers.google.com/games/

#import <GoogleAPIClientForREST/GTLRGamesConfiguration.h>

// ----------------------------------------------------------------------------
// Authorization scope

NSString * const kGTLRAuthScopeGamesConfigurationAndroidpublisher = @"https://www.googleapis.com/auth/androidpublisher";

// ----------------------------------------------------------------------------
//   GTLRGamesConfigurationService
//

@implementation GTLRGamesConfigurationService

- (instancetype)init {
  self = [super init];
  if (self) {
    // From discovery.
    self.rootURLString = @"https://gamesconfiguration.googleapis.com/";
    self.batchPath = @"batch";
    self.prettyPrintQueryParameterNames = @[ @"prettyPrint" ];
  }
  return self;
}

@end
