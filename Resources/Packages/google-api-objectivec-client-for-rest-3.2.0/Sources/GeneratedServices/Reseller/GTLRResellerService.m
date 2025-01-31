// NOTE: This file was generated by the ServiceGenerator.

// ----------------------------------------------------------------------------
// API:
//   Google Workspace Reseller API (reseller/v1)
// Description:
//   Perform common functions that are available on the Channel Services console
//   at scale, like placing orders and viewing customer information
// Documentation:
//   https://developers.google.com/google-apps/reseller/

#import <GoogleAPIClientForREST/GTLRReseller.h>

// ----------------------------------------------------------------------------
// Authorization scopes

NSString * const kGTLRAuthScopeResellerAppsOrder         = @"https://www.googleapis.com/auth/apps.order";
NSString * const kGTLRAuthScopeResellerAppsOrderReadonly = @"https://www.googleapis.com/auth/apps.order.readonly";

// ----------------------------------------------------------------------------
//   GTLRResellerService
//

@implementation GTLRResellerService

- (instancetype)init {
  self = [super init];
  if (self) {
    // From discovery.
    self.rootURLString = @"https://reseller.googleapis.com/";
    self.batchPath = @"batch";
    self.prettyPrintQueryParameterNames = @[ @"prettyPrint" ];
  }
  return self;
}

+ (NSDictionary<NSString *, Class> *)kindStringToClassMap {
  return @{
    @"customers#address" : [GTLRReseller_Address class],
    @"reseller#customer" : [GTLRReseller_Customer class],
    @"reseller#subscription" : [GTLRReseller_Subscription class],
    @"reseller#subscriptions" : [GTLRReseller_Subscriptions class],
    @"subscriptions#changePlanRequest" : [GTLRReseller_ChangePlanRequest class],
    @"subscriptions#renewalSettings" : [GTLRReseller_RenewalSettings class],
    @"subscriptions#seats" : [GTLRReseller_Seats class],
  };
}

@end
