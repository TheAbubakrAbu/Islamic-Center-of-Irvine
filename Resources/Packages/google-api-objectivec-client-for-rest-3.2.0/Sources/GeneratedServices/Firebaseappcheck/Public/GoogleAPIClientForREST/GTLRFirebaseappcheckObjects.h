// NOTE: This file was generated by the ServiceGenerator.

// ----------------------------------------------------------------------------
// API:
//   Firebase App Check API (firebaseappcheck/v1)
// Description:
//   Firebase App Check works alongside other Firebase services to help protect
//   your backend resources from abuse, such as billing fraud or phishing.
// Documentation:
//   https://firebase.google.com/docs/app-check

#import <GoogleAPIClientForREST/GTLRObject.h>

#if GTLR_RUNTIME_VERSION != 3000
#error This file was generated by a different version of ServiceGenerator which is incompatible with this GTLR library source.
#endif

@class GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1AppAttestConfig;
@class GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1AppCheckToken;
@class GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1DebugToken;
@class GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1DeviceCheckConfig;
@class GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1PlayIntegrityConfig;
@class GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1PublicJwk;
@class GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1RecaptchaEnterpriseConfig;
@class GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1RecaptchaV3Config;
@class GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1SafetyNetConfig;
@class GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1Service;
@class GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1UpdateServiceRequest;

// Generated comments include content from the discovery document; avoid them
// causing warnings since clang's checks are some what arbitrary.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

NS_ASSUME_NONNULL_BEGIN

// ----------------------------------------------------------------------------
// Constants - For some of the classes' properties below.

// ----------------------------------------------------------------------------
// GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1Service.enforcementMode

/**
 *  Firebase App Check is enforced for the service. The service will reject any
 *  request that attempts to access your project's resources if it does not have
 *  valid App Check token attached, with some exceptions depending on the
 *  service; for example, some services will still allow requests bearing the
 *  developer's privileged service account credentials without an App Check
 *  token. App Check metrics continue to be collected to help you detect issues
 *  with your App Check integration and monitor the composition of your callers.
 *  While the service is protected by App Check, other applicable protections,
 *  such as user authorization, continue to be enforced at the same time. Use
 *  caution when choosing to enforce App Check on a Firebase service. If your
 *  users have not updated to an App Check capable version of your app, their
 *  apps will no longer be able to use your Firebase services that are enforcing
 *  App Check. App Check metrics can help you decide whether to enforce App
 *  Check on your Firebase services. If your app has not launched yet, you
 *  should enable enforcement immediately, since there are no outdated clients
 *  in use. Some services require certain conditions to be met before they will
 *  work with App Check, such as requiring you to upgrade to a specific service
 *  tier or requiring you to enable the service first. Until those requirements
 *  are met for a service, this `ENFORCED` setting will have no effect and App
 *  Check will not work with that service.
 *
 *  Value: "ENFORCED"
 */
FOUNDATION_EXTERN NSString * const kGTLRFirebaseappcheck_GoogleFirebaseAppcheckV1Service_EnforcementMode_Enforced;
/**
 *  Firebase App Check is not enforced for the service, nor are App Check
 *  metrics collected. Though the service is not protected by App Check in this
 *  mode, other applicable protections, such as user authorization, are still
 *  enforced. An unconfigured service is in this mode by default. Note that
 *  resource policies behave slightly differently as an unconfigured resource
 *  policy means that the resource will inherit the EnforcementMode configured
 *  for the service it belongs to and will not be considered as being in OFF
 *  mode by default.
 *
 *  Value: "OFF"
 */
FOUNDATION_EXTERN NSString * const kGTLRFirebaseappcheck_GoogleFirebaseAppcheckV1Service_EnforcementMode_Off;
/**
 *  Firebase App Check is not enforced for the service. App Check metrics are
 *  collected to help you decide when to turn on enforcement for the service.
 *  Though the service is not protected by App Check in this mode, other
 *  applicable protections, such as user authorization, are still enforced. Some
 *  services require certain conditions to be met before they will work with App
 *  Check, such as requiring you to upgrade to a specific service tier. Until
 *  those requirements are met for a service, this `UNENFORCED` setting will
 *  have no effect and App Check will not work with that service.
 *
 *  Value: "UNENFORCED"
 */
FOUNDATION_EXTERN NSString * const kGTLRFirebaseappcheck_GoogleFirebaseAppcheckV1Service_EnforcementMode_Unenforced;

/**
 *  An app's App Attest configuration object. This configuration controls
 *  certain properties of the `AppCheckToken` returned by
 *  ExchangeAppAttestAttestation and ExchangeAppAttestAssertion, such as its
 *  ttl. Note that the Team ID registered with your app is used as part of the
 *  validation process. Please register it via the Firebase Console or
 *  programmatically via the [Firebase Management
 *  Service](https://firebase.google.com/docs/projects/api/reference/rest/v11/projects.iosApps/patch).
 */
@interface GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1AppAttestConfig : GTLRObject

/**
 *  Required. The relative resource name of the App Attest configuration object,
 *  in the format: ``` projects/{project_number}/apps/{app_id}/appAttestConfig
 *  ```
 */
@property(nonatomic, copy, nullable) NSString *name;

/**
 *  Specifies the duration for which App Check tokens exchanged from App Attest
 *  artifacts will be valid. If unset, a default value of 1 hour is assumed.
 *  Must be between 30 minutes and 7 days, inclusive.
 */
@property(nonatomic, strong, nullable) GTLRDuration *tokenTtl;

@end


/**
 *  Encapsulates an *App Check token*, which are used to access Firebase
 *  services protected by App Check.
 */
@interface GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1AppCheckToken : GTLRObject

/**
 *  The App Check token. App Check tokens are signed
 *  [JWTs](https://tools.ietf.org/html/rfc7519) containing claims that identify
 *  the attested app and Firebase project. This token is used to access Firebase
 *  services protected by App Check. These tokens can also be [verified by your
 *  own custom
 *  backends](https://firebase.google.com/docs/app-check/custom-resource-backend)
 *  using the Firebase Admin SDK.
 */
@property(nonatomic, copy, nullable) NSString *token;

/**
 *  The duration from the time this token is minted until its expiration. This
 *  field is intended to ease client-side token management, since the client may
 *  have clock skew, but is still able to accurately measure a duration.
 */
@property(nonatomic, strong, nullable) GTLRDuration *ttl;

@end


/**
 *  Response message for the BatchGetAppAttestConfigs method.
 */
@interface GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1BatchGetAppAttestConfigsResponse : GTLRObject

/** AppAttestConfigs retrieved. */
@property(nonatomic, strong, nullable) NSArray<GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1AppAttestConfig *> *configs;

@end


/**
 *  Response message for the BatchGetDeviceCheckConfigs method.
 */
@interface GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1BatchGetDeviceCheckConfigsResponse : GTLRObject

/** DeviceCheckConfigs retrieved. */
@property(nonatomic, strong, nullable) NSArray<GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1DeviceCheckConfig *> *configs;

@end


/**
 *  Response message for the BatchGetPlayIntegrityConfigs method.
 */
@interface GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1BatchGetPlayIntegrityConfigsResponse : GTLRObject

/** PlayIntegrityConfigs retrieved. */
@property(nonatomic, strong, nullable) NSArray<GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1PlayIntegrityConfig *> *configs;

@end


/**
 *  Response message for the BatchGetRecaptchaEnterpriseConfigs method.
 */
@interface GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1BatchGetRecaptchaEnterpriseConfigsResponse : GTLRObject

/** RecaptchaEnterpriseConfigs retrieved. */
@property(nonatomic, strong, nullable) NSArray<GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1RecaptchaEnterpriseConfig *> *configs;

@end


/**
 *  Response message for the BatchGetRecaptchaV3Configs method.
 */
@interface GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1BatchGetRecaptchaV3ConfigsResponse : GTLRObject

/** RecaptchaV3Configs retrieved. */
@property(nonatomic, strong, nullable) NSArray<GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1RecaptchaV3Config *> *configs;

@end


/**
 *  Response message for the BatchGetSafetyNetConfigs method.
 */
GTLR_DEPRECATED
@interface GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1BatchGetSafetyNetConfigsResponse : GTLRObject

/** SafetyNetConfigs retrieved. */
@property(nonatomic, strong, nullable) NSArray<GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1SafetyNetConfig *> *configs;

@end


/**
 *  Request message for the BatchUpdateServices method.
 */
@interface GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1BatchUpdateServicesRequest : GTLRObject

/**
 *  Required. The request messages specifying the Services to update. A maximum
 *  of 100 objects can be updated in a batch.
 */
@property(nonatomic, strong, nullable) NSArray<GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1UpdateServiceRequest *> *requests;

/**
 *  Optional. A comma-separated list of names of fields in the Services to
 *  update. Example: `display_name`. If the `update_mask` field is set in both
 *  this request and any of the UpdateServiceRequest messages, they must match
 *  or the entire batch fails and no updates will be committed.
 *
 *  String format is a comma-separated list of fields.
 */
@property(nonatomic, copy, nullable) NSString *updateMask;

@end


/**
 *  Response message for the BatchUpdateServices method.
 */
@interface GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1BatchUpdateServicesResponse : GTLRObject

/** Service objects after the updates have been applied. */
@property(nonatomic, strong, nullable) NSArray<GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1Service *> *services;

@end


/**
 *  A *debug token* is a secret used during the development or integration
 *  testing of an app. It essentially allows the development or integration
 *  testing to bypass app attestation while still allowing App Check to enforce
 *  protection on supported production Firebase services.
 */
@interface GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1DebugToken : GTLRObject

/**
 *  Required. A human readable display name used to identify this debug token.
 */
@property(nonatomic, copy, nullable) NSString *displayName;

/**
 *  Required. The relative resource name of the debug token, in the format: ```
 *  projects/{project_number}/apps/{app_id}/debugTokens/{debug_token_id} ```
 */
@property(nonatomic, copy, nullable) NSString *name;

/**
 *  Required. Input only. Immutable. The secret token itself. Must be provided
 *  during creation, and must be a UUID4, case insensitive. This field is
 *  immutable once set, and cannot be provided during an UpdateDebugToken
 *  request. You can, however, delete this debug token using DeleteDebugToken to
 *  revoke it. For security reasons, this field will never be populated in any
 *  response.
 */
@property(nonatomic, copy, nullable) NSString *token;

@end


/**
 *  An app's DeviceCheck configuration object. This configuration is used by
 *  ExchangeDeviceCheckToken to validate device tokens issued to apps by
 *  DeviceCheck. It also controls certain properties of the returned
 *  `AppCheckToken`, such as its ttl. Note that the Team ID registered with your
 *  app is used as part of the validation process. Please register it via the
 *  Firebase Console or programmatically via the [Firebase Management
 *  Service](https://firebase.google.com/docs/projects/api/reference/rest/v11/projects.iosApps/patch).
 */
@interface GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1DeviceCheckConfig : GTLRObject

/**
 *  Required. The key identifier of a private key enabled with DeviceCheck,
 *  created in your Apple Developer account.
 */
@property(nonatomic, copy, nullable) NSString *keyId;

/**
 *  Required. The relative resource name of the DeviceCheck configuration
 *  object, in the format: ```
 *  projects/{project_number}/apps/{app_id}/deviceCheckConfig ```
 */
@property(nonatomic, copy, nullable) NSString *name;

/**
 *  Required. Input only. The contents of the private key (`.p8`) file
 *  associated with the key specified by `key_id`. For security reasons, this
 *  field will never be populated in any response.
 */
@property(nonatomic, copy, nullable) NSString *privateKey;

/**
 *  Output only. Whether the `private_key` field was previously set. Since we
 *  will never return the `private_key` field, this field is the only way to
 *  find out whether it was previously set.
 *
 *  Uses NSNumber of boolValue.
 */
@property(nonatomic, strong, nullable) NSNumber *privateKeySet;

/**
 *  Specifies the duration for which App Check tokens exchanged from DeviceCheck
 *  tokens will be valid. If unset, a default value of 1 hour is assumed. Must
 *  be between 30 minutes and 7 days, inclusive.
 */
@property(nonatomic, strong, nullable) GTLRDuration *tokenTtl;

@end


/**
 *  Request message for the ExchangeAppAttestAssertion method.
 */
@interface GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1ExchangeAppAttestAssertionRequest : GTLRObject

/**
 *  Required. The artifact returned by a previous call to
 *  ExchangeAppAttestAttestation.
 *
 *  Contains encoded binary data; GTLRBase64 can encode/decode (probably
 *  web-safe format).
 */
@property(nonatomic, copy, nullable) NSString *artifact;

/**
 *  Required. The CBOR-encoded assertion returned by the client-side App Attest
 *  API.
 *
 *  Contains encoded binary data; GTLRBase64 can encode/decode (probably
 *  web-safe format).
 */
@property(nonatomic, copy, nullable) NSString *assertion;

/**
 *  Required. A one-time challenge returned by an immediately prior call to
 *  GenerateAppAttestChallenge.
 *
 *  Contains encoded binary data; GTLRBase64 can encode/decode (probably
 *  web-safe format).
 */
@property(nonatomic, copy, nullable) NSString *challenge;

/**
 *  Forces a short lived token with a 5 minute TTL. Useful when the client
 *  wishes to self impose stricter TTL requirements for this exchange. Default:
 *  false.
 *
 *  Uses NSNumber of boolValue.
 */
@property(nonatomic, strong, nullable) NSNumber *limitedUse;

@end


/**
 *  Request message for the ExchangeAppAttestAttestation method.
 */
@interface GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1ExchangeAppAttestAttestationRequest : GTLRObject

/**
 *  Required. The App Attest statement returned by the client-side App Attest
 *  API. This is a base64url encoded CBOR object in the JSON response.
 *
 *  Contains encoded binary data; GTLRBase64 can encode/decode (probably
 *  web-safe format).
 */
@property(nonatomic, copy, nullable) NSString *attestationStatement;

/**
 *  Required. A one-time challenge returned by an immediately prior call to
 *  GenerateAppAttestChallenge.
 *
 *  Contains encoded binary data; GTLRBase64 can encode/decode (probably
 *  web-safe format).
 */
@property(nonatomic, copy, nullable) NSString *challenge;

/**
 *  Required. The key ID generated by App Attest for the client app.
 *
 *  Contains encoded binary data; GTLRBase64 can encode/decode (probably
 *  web-safe format).
 */
@property(nonatomic, copy, nullable) NSString *keyId;

/**
 *  Forces a short lived token with a 5 minute TTL. Useful when the client
 *  wishes to self impose stricter TTL requirements for this exchange. Default:
 *  false.
 *
 *  Uses NSNumber of boolValue.
 */
@property(nonatomic, strong, nullable) NSNumber *limitedUse;

@end


/**
 *  Response message for the ExchangeAppAttestAttestation method.
 */
@interface GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1ExchangeAppAttestAttestationResponse : GTLRObject

/** Encapsulates an App Check token. */
@property(nonatomic, strong, nullable) GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1AppCheckToken *appCheckToken;

/**
 *  An artifact that can be used in future calls to ExchangeAppAttestAssertion.
 *
 *  Contains encoded binary data; GTLRBase64 can encode/decode (probably
 *  web-safe format).
 */
@property(nonatomic, copy, nullable) NSString *artifact;

@end


/**
 *  Request message for the ExchangeCustomToken method.
 */
@interface GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1ExchangeCustomTokenRequest : GTLRObject

/**
 *  Required. A custom token signed using your project's Admin SDK service
 *  account credentials.
 */
@property(nonatomic, copy, nullable) NSString *customToken;

/**
 *  Forces a short lived token with a 5 minute TTL. Useful when the client
 *  wishes to self impose stricter TTL requirements for this exchange. Default:
 *  false.
 *
 *  Uses NSNumber of boolValue.
 */
@property(nonatomic, strong, nullable) NSNumber *limitedUse;

@end


/**
 *  Request message for the ExchangeDebugToken method.
 */
@interface GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1ExchangeDebugTokenRequest : GTLRObject

/**
 *  Required. A debug token secret. This string must match a debug token secret
 *  previously created using CreateDebugToken.
 */
@property(nonatomic, copy, nullable) NSString *debugToken;

/**
 *  Forces a short lived token with a 5 minute TTL. Useful when the client
 *  wishes to self impose stricter TTL requirements for this exchange. Default:
 *  false.
 *
 *  Uses NSNumber of boolValue.
 */
@property(nonatomic, strong, nullable) NSNumber *limitedUse;

@end


/**
 *  Request message for the ExchangeDeviceCheckToken method.
 */
@interface GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1ExchangeDeviceCheckTokenRequest : GTLRObject

/**
 *  Required. The `device_token` as returned by Apple's client-side [DeviceCheck
 *  API](https://developer.apple.com/documentation/devicecheck/dcdevice). This
 *  is the base64 encoded `Data` (Swift) or `NSData` (ObjC) object.
 */
@property(nonatomic, copy, nullable) NSString *deviceToken;

/**
 *  Forces a short lived token with a 5 minute TTL. Useful when the client
 *  wishes to self impose stricter TTL requirements for this exchange. Default:
 *  false.
 *
 *  Uses NSNumber of boolValue.
 */
@property(nonatomic, strong, nullable) NSNumber *limitedUse;

@end


/**
 *  Request message for the ExchangePlayIntegrityToken method.
 */
@interface GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1ExchangePlayIntegrityTokenRequest : GTLRObject

/**
 *  Forces a short-lived token with a 5 minute TTL. Useful when the client
 *  wishes to impose stricter TTL requirements for this exchange. Default:
 *  false.
 *
 *  Uses NSNumber of boolValue.
 */
@property(nonatomic, strong, nullable) NSNumber *limitedUse;

/**
 *  Required. The [integrity verdict response token from Play
 *  Integrity](https://developer.android.com/google/play/integrity/verdict#decrypt-verify)
 *  issued to your app.
 */
@property(nonatomic, copy, nullable) NSString *playIntegrityToken;

@end


/**
 *  Request message for the ExchangeRecaptchaEnterpriseToken method.
 */
@interface GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1ExchangeRecaptchaEnterpriseTokenRequest : GTLRObject

/**
 *  Forces a short lived token with a 5 minute TTL. Useful when the client
 *  wishes to self impose stricter TTL requirements for this exchange. Default:
 *  false.
 *
 *  Uses NSNumber of boolValue.
 */
@property(nonatomic, strong, nullable) NSNumber *limitedUse;

/**
 *  Required. The reCAPTCHA token as returned by the [reCAPTCHA Enterprise
 *  JavaScript
 *  API](https://cloud.google.com/recaptcha-enterprise/docs/instrument-web-pages).
 */
@property(nonatomic, copy, nullable) NSString *recaptchaEnterpriseToken;

@end


/**
 *  Request message for the ExchangeRecaptchaV3Token method.
 */
@interface GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1ExchangeRecaptchaV3TokenRequest : GTLRObject

/**
 *  Forces a short lived token with a 5 minute TTL. Useful when the client
 *  wishes to self impose stricter TTL requirements for this exchange. Default:
 *  false.
 *
 *  Uses NSNumber of boolValue.
 */
@property(nonatomic, strong, nullable) NSNumber *limitedUse;

/**
 *  Required. The reCAPTCHA token as returned by the [reCAPTCHA v3 JavaScript
 *  API](https://developers.google.com/recaptcha/docs/v3).
 */
@property(nonatomic, copy, nullable) NSString *recaptchaV3Token;

@end


/**
 *  Request message for the ExchangeSafetyNetToken method.
 */
GTLR_DEPRECATED
@interface GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1ExchangeSafetyNetTokenRequest : GTLRObject

/**
 *  Required. The [SafetyNet attestation
 *  response](https://developer.android.com/training/safetynet/attestation#request-attestation-step)
 *  issued to your app.
 */
@property(nonatomic, copy, nullable) NSString *safetyNetToken;

@end


/**
 *  Request message for the GenerateAppAttestChallenge method.
 */
@interface GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1GenerateAppAttestChallengeRequest : GTLRObject
@end


/**
 *  Response message for the GenerateAppAttestChallenge method.
 */
@interface GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1GenerateAppAttestChallengeResponse : GTLRObject

/**
 *  A one-time use challenge for the client to pass to the App Attest API.
 *
 *  Contains encoded binary data; GTLRBase64 can encode/decode (probably
 *  web-safe format).
 */
@property(nonatomic, copy, nullable) NSString *challenge;

/**
 *  The duration from the time this challenge is minted until its expiration.
 *  This field is intended to ease client-side token management, since the
 *  client may have clock skew, but is still able to accurately measure a
 *  duration.
 */
@property(nonatomic, strong, nullable) GTLRDuration *ttl;

@end


/**
 *  Request message for the GeneratePlayIntegrityChallenge method.
 */
@interface GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1GeneratePlayIntegrityChallengeRequest : GTLRObject
@end


/**
 *  Response message for the GeneratePlayIntegrityChallenge method.
 */
@interface GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1GeneratePlayIntegrityChallengeResponse : GTLRObject

/**
 *  A one-time use
 *  [challenge](https://developer.android.com/google/play/integrity/verdict#protect-against-replay-attacks)
 *  for the client to pass to the Play Integrity API.
 */
@property(nonatomic, copy, nullable) NSString *challenge;

/**
 *  The duration from the time this challenge is minted until its expiration.
 *  This field is intended to ease client-side token management, since the
 *  client may have clock skew, but is still able to accurately measure a
 *  duration.
 */
@property(nonatomic, strong, nullable) GTLRDuration *ttl;

@end


/**
 *  Response message for the ListDebugTokens method.
 *
 *  @note This class supports NSFastEnumeration and indexed subscripting over
 *        its "debugTokens" property. If returned as the result of a query, it
 *        should support automatic pagination (when @c shouldFetchNextPages is
 *        enabled).
 */
@interface GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1ListDebugTokensResponse : GTLRCollectionObject

/**
 *  The DebugTokens retrieved.
 *
 *  @note This property is used to support NSFastEnumeration and indexed
 *        subscripting on this class.
 */
@property(nonatomic, strong, nullable) NSArray<GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1DebugToken *> *debugTokens;

/**
 *  If the result list is too large to fit in a single response, then a token is
 *  returned. If the string is empty or omitted, then this response is the last
 *  page of results. This token can be used in a subsequent call to
 *  ListDebugTokens to find the next group of DebugTokens. Page tokens are
 *  short-lived and should not be persisted.
 */
@property(nonatomic, copy, nullable) NSString *nextPageToken;

@end


/**
 *  Response message for the ListServices method.
 *
 *  @note This class supports NSFastEnumeration and indexed subscripting over
 *        its "services" property. If returned as the result of a query, it
 *        should support automatic pagination (when @c shouldFetchNextPages is
 *        enabled).
 */
@interface GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1ListServicesResponse : GTLRCollectionObject

/**
 *  If the result list is too large to fit in a single response, then a token is
 *  returned. If the string is empty or omitted, then this response is the last
 *  page of results. This token can be used in a subsequent call to ListServices
 *  to find the next group of Services. Page tokens are short-lived and should
 *  not be persisted.
 */
@property(nonatomic, copy, nullable) NSString *nextPageToken;

/**
 *  The Services retrieved.
 *
 *  @note This property is used to support NSFastEnumeration and indexed
 *        subscripting on this class.
 */
@property(nonatomic, strong, nullable) NSArray<GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1Service *> *services;

@end


/**
 *  An app's Play Integrity configuration object. This configuration controls
 *  certain properties of the `AppCheckToken` returned by
 *  ExchangePlayIntegrityToken, such as its ttl. Note that your registered
 *  SHA-256 certificate fingerprints are used to validate tokens issued by the
 *  Play Integrity API; please register them via the Firebase Console or
 *  programmatically via the [Firebase Management
 *  Service](https://firebase.google.com/docs/projects/api/reference/rest/v1beta1/projects.androidApps.sha/create).
 */
@interface GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1PlayIntegrityConfig : GTLRObject

/**
 *  Required. The relative resource name of the Play Integrity configuration
 *  object, in the format: ```
 *  projects/{project_number}/apps/{app_id}/playIntegrityConfig ```
 */
@property(nonatomic, copy, nullable) NSString *name;

/**
 *  Specifies the duration for which App Check tokens exchanged from Play
 *  Integrity tokens will be valid. If unset, a default value of 1 hour is
 *  assumed. Must be between 30 minutes and 7 days, inclusive.
 */
@property(nonatomic, strong, nullable) GTLRDuration *tokenTtl;

@end


/**
 *  A JWK as specified by [section 4 of RFC
 *  7517](https://tools.ietf.org/html/rfc7517#section-4) and [section 6.3.1 of
 *  RFC 7518](https://tools.ietf.org/html/rfc7518#section-6.3.1).
 */
@interface GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1PublicJwk : GTLRObject

/**
 *  See [section 4.4 of RFC
 *  7517](https://tools.ietf.org/html/rfc7517#section-4.4).
 */
@property(nonatomic, copy, nullable) NSString *alg;

/**
 *  See [section 6.3.1.2 of RFC
 *  7518](https://tools.ietf.org/html/rfc7518#section-6.3.1.2).
 */
@property(nonatomic, copy, nullable) NSString *e;

/**
 *  See [section 4.5 of RFC
 *  7517](https://tools.ietf.org/html/rfc7517#section-4.5).
 */
@property(nonatomic, copy, nullable) NSString *kid;

/**
 *  See [section 4.1 of RFC
 *  7517](https://tools.ietf.org/html/rfc7517#section-4.1).
 */
@property(nonatomic, copy, nullable) NSString *kty;

/**
 *  See [section 6.3.1.1 of RFC
 *  7518](https://tools.ietf.org/html/rfc7518#section-6.3.1.1).
 */
@property(nonatomic, copy, nullable) NSString *n;

/**
 *  See [section 4.2 of RFC
 *  7517](https://tools.ietf.org/html/rfc7517#section-4.2).
 */
@property(nonatomic, copy, nullable) NSString *use;

@end


/**
 *  The currently active set of public keys that can be used to verify App Check
 *  tokens. This object is a JWK set as specified by [section 5 of RFC
 *  7517](https://tools.ietf.org/html/rfc7517#section-5). For security, the
 *  response **must not** be cached for longer than six hours.
 */
@interface GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1PublicJwkSet : GTLRObject

/**
 *  The set of public keys. See [section 5.1 of RFC
 *  7517](https://tools.ietf.org/html/rfc7517#section-5).
 */
@property(nonatomic, strong, nullable) NSArray<GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1PublicJwk *> *keys;

@end


/**
 *  An app's reCAPTCHA Enterprise configuration object. This configuration is
 *  used by ExchangeRecaptchaEnterpriseToken to validate reCAPTCHA tokens issued
 *  to apps by reCAPTCHA Enterprise. It also controls certain properties of the
 *  returned `AppCheckToken`, such as its ttl.
 */
@interface GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1RecaptchaEnterpriseConfig : GTLRObject

/**
 *  Required. The relative resource name of the reCAPTCHA Enterprise
 *  configuration object, in the format: ```
 *  projects/{project_number}/apps/{app_id}/recaptchaEnterpriseConfig ```
 */
@property(nonatomic, copy, nullable) NSString *name;

/**
 *  The score-based site key [created in reCAPTCHA
 *  Enterprise](https://cloud.google.com/recaptcha-enterprise/docs/create-key#creating_a_site_key)
 *  used to [invoke reCAPTCHA and generate the reCAPTCHA
 *  tokens](https://cloud.google.com/recaptcha-enterprise/docs/instrument-web-pages)
 *  for your application. Important: This is *not* the `site_secret` (as it is
 *  in reCAPTCHA v3), but rather your score-based reCAPTCHA Enterprise site key.
 */
@property(nonatomic, copy, nullable) NSString *siteKey;

/**
 *  Specifies the duration for which App Check tokens exchanged from reCAPTCHA
 *  Enterprise tokens will be valid. If unset, a default value of 1 hour is
 *  assumed. Must be between 30 minutes and 7 days, inclusive.
 */
@property(nonatomic, strong, nullable) GTLRDuration *tokenTtl;

@end


/**
 *  An app's reCAPTCHA v3 configuration object. This configuration is used by
 *  ExchangeRecaptchaV3Token to validate reCAPTCHA tokens issued to apps by
 *  reCAPTCHA v3. It also controls certain properties of the returned
 *  `AppCheckToken`, such as its ttl.
 */
@interface GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1RecaptchaV3Config : GTLRObject

/**
 *  Required. The relative resource name of the reCAPTCHA v3 configuration
 *  object, in the format: ```
 *  projects/{project_number}/apps/{app_id}/recaptchaV3Config ```
 */
@property(nonatomic, copy, nullable) NSString *name;

/**
 *  Required. Input only. The site secret used to identify your service for
 *  reCAPTCHA v3 verification. For security reasons, this field will never be
 *  populated in any response.
 */
@property(nonatomic, copy, nullable) NSString *siteSecret;

/**
 *  Output only. Whether the `site_secret` field was previously set. Since we
 *  will never return the `site_secret` field, this field is the only way to
 *  find out whether it was previously set.
 *
 *  Uses NSNumber of boolValue.
 */
@property(nonatomic, strong, nullable) NSNumber *siteSecretSet;

/**
 *  Specifies the duration for which App Check tokens exchanged from reCAPTCHA
 *  tokens will be valid. If unset, a default value of 1 day is assumed. Must be
 *  between 30 minutes and 7 days, inclusive.
 */
@property(nonatomic, strong, nullable) GTLRDuration *tokenTtl;

@end


/**
 *  An app's SafetyNet configuration object. This configuration controls certain
 *  properties of the `AppCheckToken` returned by ExchangeSafetyNetToken, such
 *  as its ttl. Note that your registered SHA-256 certificate fingerprints are
 *  used to validate tokens issued by SafetyNet; please register them via the
 *  Firebase Console or programmatically via the [Firebase Management
 *  Service](https://firebase.google.com/docs/projects/api/reference/rest/v11/projects.androidApps.sha/create).
 */
GTLR_DEPRECATED
@interface GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1SafetyNetConfig : GTLRObject

/**
 *  Required. The relative resource name of the SafetyNet configuration object,
 *  in the format: ``` projects/{project_number}/apps/{app_id}/safetyNetConfig
 *  ```
 */
@property(nonatomic, copy, nullable) NSString *name;

/**
 *  Specifies the duration for which App Check tokens exchanged from SafetyNet
 *  tokens will be valid. If unset, a default value of 1 hour is assumed. Must
 *  be between 30 minutes and 7 days, inclusive.
 */
@property(nonatomic, strong, nullable) GTLRDuration *tokenTtl;

@end


/**
 *  The enforcement configuration for a Firebase service supported by App Check.
 */
@interface GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1Service : GTLRObject

/**
 *  Required. The App Check enforcement mode for this service.
 *
 *  Likely values:
 *    @arg @c kGTLRFirebaseappcheck_GoogleFirebaseAppcheckV1Service_EnforcementMode_Enforced
 *        Firebase App Check is enforced for the service. The service will
 *        reject any request that attempts to access your project's resources if
 *        it does not have valid App Check token attached, with some exceptions
 *        depending on the service; for example, some services will still allow
 *        requests bearing the developer's privileged service account
 *        credentials without an App Check token. App Check metrics continue to
 *        be collected to help you detect issues with your App Check integration
 *        and monitor the composition of your callers. While the service is
 *        protected by App Check, other applicable protections, such as user
 *        authorization, continue to be enforced at the same time. Use caution
 *        when choosing to enforce App Check on a Firebase service. If your
 *        users have not updated to an App Check capable version of your app,
 *        their apps will no longer be able to use your Firebase services that
 *        are enforcing App Check. App Check metrics can help you decide whether
 *        to enforce App Check on your Firebase services. If your app has not
 *        launched yet, you should enable enforcement immediately, since there
 *        are no outdated clients in use. Some services require certain
 *        conditions to be met before they will work with App Check, such as
 *        requiring you to upgrade to a specific service tier or requiring you
 *        to enable the service first. Until those requirements are met for a
 *        service, this `ENFORCED` setting will have no effect and App Check
 *        will not work with that service. (Value: "ENFORCED")
 *    @arg @c kGTLRFirebaseappcheck_GoogleFirebaseAppcheckV1Service_EnforcementMode_Off
 *        Firebase App Check is not enforced for the service, nor are App Check
 *        metrics collected. Though the service is not protected by App Check in
 *        this mode, other applicable protections, such as user authorization,
 *        are still enforced. An unconfigured service is in this mode by
 *        default. Note that resource policies behave slightly differently as an
 *        unconfigured resource policy means that the resource will inherit the
 *        EnforcementMode configured for the service it belongs to and will not
 *        be considered as being in OFF mode by default. (Value: "OFF")
 *    @arg @c kGTLRFirebaseappcheck_GoogleFirebaseAppcheckV1Service_EnforcementMode_Unenforced
 *        Firebase App Check is not enforced for the service. App Check metrics
 *        are collected to help you decide when to turn on enforcement for the
 *        service. Though the service is not protected by App Check in this
 *        mode, other applicable protections, such as user authorization, are
 *        still enforced. Some services require certain conditions to be met
 *        before they will work with App Check, such as requiring you to upgrade
 *        to a specific service tier. Until those requirements are met for a
 *        service, this `UNENFORCED` setting will have no effect and App Check
 *        will not work with that service. (Value: "UNENFORCED")
 */
@property(nonatomic, copy, nullable) NSString *enforcementMode;

/**
 *  Required. The relative resource name of the service configuration object, in
 *  the format: ``` projects/{project_number}/services/{service_id} ``` Note
 *  that the `service_id` element must be a supported service ID. Currently, the
 *  following service IDs are supported: * `firebasestorage.googleapis.com`
 *  (Cloud Storage for Firebase) * `firebasedatabase.googleapis.com` (Firebase
 *  Realtime Database) * `firestore.googleapis.com` (Cloud Firestore)
 */
@property(nonatomic, copy, nullable) NSString *name;

@end


/**
 *  Request message for the UpdateService method as well as an individual update
 *  message for the BatchUpdateServices method.
 */
@interface GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1UpdateServiceRequest : GTLRObject

/**
 *  Required. The Service to update. The Service's `name` field is used to
 *  identify the Service to be updated, in the format: ```
 *  projects/{project_number}/services/{service_id} ``` Note that the
 *  `service_id` element must be a supported service ID. Currently, the
 *  following service IDs are supported: * `firebasestorage.googleapis.com`
 *  (Cloud Storage for Firebase) * `firebasedatabase.googleapis.com` (Firebase
 *  Realtime Database) * `firestore.googleapis.com` (Cloud Firestore)
 */
@property(nonatomic, strong, nullable) GTLRFirebaseappcheck_GoogleFirebaseAppcheckV1Service *service;

/**
 *  Required. A comma-separated list of names of fields in the Service to
 *  update. Example: `enforcement_mode`.
 *
 *  String format is a comma-separated list of fields.
 */
@property(nonatomic, copy, nullable) NSString *updateMask;

@end


/**
 *  A generic empty message that you can re-use to avoid defining duplicated
 *  empty messages in your APIs. A typical example is to use it as the request
 *  or the response type of an API method. For instance: service Foo { rpc
 *  Bar(google.protobuf.Empty) returns (google.protobuf.Empty); }
 */
@interface GTLRFirebaseappcheck_GoogleProtobufEmpty : GTLRObject
@end

NS_ASSUME_NONNULL_END

#pragma clang diagnostic pop
