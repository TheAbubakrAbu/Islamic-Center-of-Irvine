// NOTE: This file was generated by the ServiceGenerator.

// ----------------------------------------------------------------------------
// API:
//   Fitness API (fitness/v1)
// Description:
//   The Fitness API for managing users' fitness tracking data.
// Documentation:
//   https://developers.google.com/fit/rest/v1/get-started

#import <GoogleAPIClientForREST/GTLRService.h>

#if GTLR_RUNTIME_VERSION != 3000
#error This file was generated by a different version of ServiceGenerator which is incompatible with this GTLR library source.
#endif

// Generated comments include content from the discovery document; avoid them
// causing warnings since clang's checks are some what arbitrary.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

NS_ASSUME_NONNULL_BEGIN

// ----------------------------------------------------------------------------
// Authorization scopes

/**
 *  Authorization scope: Use Google Fit to see and store your physical activity
 *  data
 *
 *  Value "https://www.googleapis.com/auth/fitness.activity.read"
 */
FOUNDATION_EXTERN NSString * const kGTLRAuthScopeFitnessActivityRead;
/**
 *  Authorization scope: Add to your Google Fit physical activity data
 *
 *  Value "https://www.googleapis.com/auth/fitness.activity.write"
 */
FOUNDATION_EXTERN NSString * const kGTLRAuthScopeFitnessActivityWrite;
/**
 *  Authorization scope: See info about your blood glucose in Google Fit. I
 *  consent to Google sharing my blood glucose information with this app.
 *
 *  Value "https://www.googleapis.com/auth/fitness.blood_glucose.read"
 */
FOUNDATION_EXTERN NSString * const kGTLRAuthScopeFitnessBloodGlucoseRead;
/**
 *  Authorization scope: Add info about your blood glucose to Google Fit. I
 *  consent to Google using my blood glucose information with this app.
 *
 *  Value "https://www.googleapis.com/auth/fitness.blood_glucose.write"
 */
FOUNDATION_EXTERN NSString * const kGTLRAuthScopeFitnessBloodGlucoseWrite;
/**
 *  Authorization scope: See info about your blood pressure in Google Fit. I
 *  consent to Google sharing my blood pressure information with this app.
 *
 *  Value "https://www.googleapis.com/auth/fitness.blood_pressure.read"
 */
FOUNDATION_EXTERN NSString * const kGTLRAuthScopeFitnessBloodPressureRead;
/**
 *  Authorization scope: Add info about your blood pressure in Google Fit. I
 *  consent to Google using my blood pressure information with this app.
 *
 *  Value "https://www.googleapis.com/auth/fitness.blood_pressure.write"
 */
FOUNDATION_EXTERN NSString * const kGTLRAuthScopeFitnessBloodPressureWrite;
/**
 *  Authorization scope: See info about your body measurements in Google Fit
 *
 *  Value "https://www.googleapis.com/auth/fitness.body.read"
 */
FOUNDATION_EXTERN NSString * const kGTLRAuthScopeFitnessBodyRead;
/**
 *  Authorization scope: See info about your body temperature in Google Fit. I
 *  consent to Google sharing my body temperature information with this app.
 *
 *  Value "https://www.googleapis.com/auth/fitness.body_temperature.read"
 */
FOUNDATION_EXTERN NSString * const kGTLRAuthScopeFitnessBodyTemperatureRead;
/**
 *  Authorization scope: Add to info about your body temperature in Google Fit.
 *  I consent to Google using my body temperature information with this app.
 *
 *  Value "https://www.googleapis.com/auth/fitness.body_temperature.write"
 */
FOUNDATION_EXTERN NSString * const kGTLRAuthScopeFitnessBodyTemperatureWrite;
/**
 *  Authorization scope: Add info about your body measurements to Google Fit
 *
 *  Value "https://www.googleapis.com/auth/fitness.body.write"
 */
FOUNDATION_EXTERN NSString * const kGTLRAuthScopeFitnessBodyWrite;
/**
 *  Authorization scope: See your heart rate data in Google Fit. I consent to
 *  Google sharing my heart rate information with this app.
 *
 *  Value "https://www.googleapis.com/auth/fitness.heart_rate.read"
 */
FOUNDATION_EXTERN NSString * const kGTLRAuthScopeFitnessHeartRateRead;
/**
 *  Authorization scope: Add to your heart rate data in Google Fit. I consent to
 *  Google using my heart rate information with this app.
 *
 *  Value "https://www.googleapis.com/auth/fitness.heart_rate.write"
 */
FOUNDATION_EXTERN NSString * const kGTLRAuthScopeFitnessHeartRateWrite;
/**
 *  Authorization scope: See your Google Fit speed and distance data
 *
 *  Value "https://www.googleapis.com/auth/fitness.location.read"
 */
FOUNDATION_EXTERN NSString * const kGTLRAuthScopeFitnessLocationRead;
/**
 *  Authorization scope: Add to your Google Fit location data
 *
 *  Value "https://www.googleapis.com/auth/fitness.location.write"
 */
FOUNDATION_EXTERN NSString * const kGTLRAuthScopeFitnessLocationWrite;
/**
 *  Authorization scope: See info about your nutrition in Google Fit
 *
 *  Value "https://www.googleapis.com/auth/fitness.nutrition.read"
 */
FOUNDATION_EXTERN NSString * const kGTLRAuthScopeFitnessNutritionRead;
/**
 *  Authorization scope: Add to info about your nutrition in Google Fit
 *
 *  Value "https://www.googleapis.com/auth/fitness.nutrition.write"
 */
FOUNDATION_EXTERN NSString * const kGTLRAuthScopeFitnessNutritionWrite;
/**
 *  Authorization scope: See info about your oxygen saturation in Google Fit. I
 *  consent to Google sharing my oxygen saturation information with this app.
 *
 *  Value "https://www.googleapis.com/auth/fitness.oxygen_saturation.read"
 */
FOUNDATION_EXTERN NSString * const kGTLRAuthScopeFitnessOxygenSaturationRead;
/**
 *  Authorization scope: Add info about your oxygen saturation in Google Fit. I
 *  consent to Google using my oxygen saturation information with this app.
 *
 *  Value "https://www.googleapis.com/auth/fitness.oxygen_saturation.write"
 */
FOUNDATION_EXTERN NSString * const kGTLRAuthScopeFitnessOxygenSaturationWrite;
/**
 *  Authorization scope: See info about your reproductive health in Google Fit.
 *  I consent to Google sharing my reproductive health information with this
 *  app.
 *
 *  Value "https://www.googleapis.com/auth/fitness.reproductive_health.read"
 */
FOUNDATION_EXTERN NSString * const kGTLRAuthScopeFitnessReproductiveHealthRead;
/**
 *  Authorization scope: Add info about your reproductive health in Google Fit.
 *  I consent to Google using my reproductive health information with this app.
 *
 *  Value "https://www.googleapis.com/auth/fitness.reproductive_health.write"
 */
FOUNDATION_EXTERN NSString * const kGTLRAuthScopeFitnessReproductiveHealthWrite;
/**
 *  Authorization scope: See your sleep data in Google Fit. I consent to Google
 *  sharing my sleep information with this app.
 *
 *  Value "https://www.googleapis.com/auth/fitness.sleep.read"
 */
FOUNDATION_EXTERN NSString * const kGTLRAuthScopeFitnessSleepRead;
/**
 *  Authorization scope: Add to your sleep data in Google Fit. I consent to
 *  Google using my sleep information with this app.
 *
 *  Value "https://www.googleapis.com/auth/fitness.sleep.write"
 */
FOUNDATION_EXTERN NSString * const kGTLRAuthScopeFitnessSleepWrite;

// ----------------------------------------------------------------------------
//   GTLRFitnessService
//

/**
 *  Service for executing Fitness API queries.
 *
 *  The Fitness API for managing users' fitness tracking data.
 */
@interface GTLRFitnessService : GTLRService

// No new methods

// Clients should create a standard query with any of the class methods in
// GTLRFitnessQuery.h. The query can the be sent with GTLRService's execute
// methods,
//
//   - (GTLRServiceTicket *)executeQuery:(GTLRQuery *)query
//                     completionHandler:(void (^)(GTLRServiceTicket *ticket,
//                                                 id object, NSError *error))handler;
// or
//   - (GTLRServiceTicket *)executeQuery:(GTLRQuery *)query
//                              delegate:(id)delegate
//                     didFinishSelector:(SEL)finishedSelector;
//
// where finishedSelector has a signature of:
//
//   - (void)serviceTicket:(GTLRServiceTicket *)ticket
//      finishedWithObject:(id)object
//                   error:(NSError *)error;
//
// The object passed to the completion handler or delegate method
// is a subclass of GTLRObject, determined by the query method executed.

@end

NS_ASSUME_NONNULL_END

#pragma clang diagnostic pop
