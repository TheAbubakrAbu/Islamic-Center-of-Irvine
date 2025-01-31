// NOTE: This file was generated by the ServiceGenerator.

// ----------------------------------------------------------------------------
// API:
//   Google Vault API (vault/v1)
// Description:
//   Retention and eDiscovery for Google Workspace. To work with Vault
//   resources, the account must have the [required Vault
//   privileges](https://support.google.com/vault/answer/2799699) and access to
//   the matter. To access a matter, the account must have created the matter,
//   have the matter shared with them, or have the **View All Matters**
//   privilege. For example, to download an export, an account needs the
//   **Manage Exports** privilege and the matter shared with them.
// Documentation:
//   https://developers.google.com/vault

#import <GoogleAPIClientForREST/GTLRQuery.h>

#if GTLR_RUNTIME_VERSION != 3000
#error This file was generated by a different version of ServiceGenerator which is incompatible with this GTLR library source.
#endif

#import "GTLRVaultObjects.h"

// Generated comments include content from the discovery document; avoid them
// causing warnings since clang's checks are some what arbitrary.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

NS_ASSUME_NONNULL_BEGIN

// ----------------------------------------------------------------------------
// Constants - For some of the query classes' properties below.

// ----------------------------------------------------------------------------
// state

/**
 *  The matter is closed.
 *
 *  Value: "CLOSED"
 */
FOUNDATION_EXTERN NSString * const kGTLRVaultStateClosed;
/**
 *  The matter is deleted.
 *
 *  Value: "DELETED"
 */
FOUNDATION_EXTERN NSString * const kGTLRVaultStateDeleted;
/**
 *  The matter is open.
 *
 *  Value: "OPEN"
 */
FOUNDATION_EXTERN NSString * const kGTLRVaultStateOpen;
/**
 *  The matter has no specified state.
 *
 *  Value: "STATE_UNSPECIFIED"
 */
FOUNDATION_EXTERN NSString * const kGTLRVaultStateStateUnspecified;

// ----------------------------------------------------------------------------
// view

/**
 *  Returns the matter ID, name, description, and state. Default choice.
 *
 *  Value: "BASIC"
 */
FOUNDATION_EXTERN NSString * const kGTLRVaultViewBasic;
/**
 *  Returns the hold ID, name, update time, service, and query.
 *
 *  Value: "BASIC_HOLD"
 */
FOUNDATION_EXTERN NSString * const kGTLRVaultViewBasicHold;
/**
 *  Returns the basic details and a list of matter owners and collaborators (see
 *  [MatterPermissions](https://developers.google.com/vault/reference/rest/v1/matters#matterpermission)).
 *
 *  Value: "FULL"
 */
FOUNDATION_EXTERN NSString * const kGTLRVaultViewFull;
/**
 *  Returns all details of **BASIC_HOLD** and the entities the hold applies to,
 *  such as accounts or organizational unit.
 *
 *  Value: "FULL_HOLD"
 */
FOUNDATION_EXTERN NSString * const kGTLRVaultViewFullHold;
/**
 *  Not specified. Defaults to **FULL_HOLD**.
 *
 *  Value: "HOLD_VIEW_UNSPECIFIED"
 */
FOUNDATION_EXTERN NSString * const kGTLRVaultViewHoldViewUnspecified;
/**
 *  The amount of detail is unspecified. Same as **BASIC**.
 *
 *  Value: "VIEW_UNSPECIFIED"
 */
FOUNDATION_EXTERN NSString * const kGTLRVaultViewViewUnspecified;

// ----------------------------------------------------------------------------
// Query Classes
//

/**
 *  Parent class for other Vault query classes.
 */
@interface GTLRVaultQuery : GTLRQuery

/** Selector specifying which fields to include in a partial response. */
@property(nonatomic, copy, nullable) NSString *fields;

@end

/**
 *  Adds an account as a matter collaborator.
 *
 *  Method: vault.matters.addPermissions
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeVaultEdiscovery
 */
@interface GTLRVaultQuery_MattersAddPermissions : GTLRVaultQuery

/** The matter ID. */
@property(nonatomic, copy, nullable) NSString *matterId;

/**
 *  Fetches a @c GTLRVault_MatterPermission.
 *
 *  Adds an account as a matter collaborator.
 *
 *  @param object The @c GTLRVault_AddMatterPermissionsRequest to include in the
 *    query.
 *  @param matterId The matter ID.
 *
 *  @return GTLRVaultQuery_MattersAddPermissions
 */
+ (instancetype)queryWithObject:(GTLRVault_AddMatterPermissionsRequest *)object
                       matterId:(NSString *)matterId;

@end

/**
 *  Closes the specified matter. Returns the matter with updated state.
 *
 *  Method: vault.matters.close
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeVaultEdiscovery
 */
@interface GTLRVaultQuery_MattersClose : GTLRVaultQuery

/** The matter ID. */
@property(nonatomic, copy, nullable) NSString *matterId;

/**
 *  Fetches a @c GTLRVault_CloseMatterResponse.
 *
 *  Closes the specified matter. Returns the matter with updated state.
 *
 *  @param object The @c GTLRVault_CloseMatterRequest to include in the query.
 *  @param matterId The matter ID.
 *
 *  @return GTLRVaultQuery_MattersClose
 */
+ (instancetype)queryWithObject:(GTLRVault_CloseMatterRequest *)object
                       matterId:(NSString *)matterId;

@end

/**
 *  Counts the accounts processed by the specified query.
 *
 *  Method: vault.matters.count
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeVaultEdiscovery
 */
@interface GTLRVaultQuery_MattersCount : GTLRVaultQuery

/** The matter ID. */
@property(nonatomic, copy, nullable) NSString *matterId;

/**
 *  Fetches a @c GTLRVault_Operation.
 *
 *  Counts the accounts processed by the specified query.
 *
 *  @param object The @c GTLRVault_CountArtifactsRequest to include in the
 *    query.
 *  @param matterId The matter ID.
 *
 *  @return GTLRVaultQuery_MattersCount
 */
+ (instancetype)queryWithObject:(GTLRVault_CountArtifactsRequest *)object
                       matterId:(NSString *)matterId;

@end

/**
 *  Creates a matter with the given name and description. The initial state is
 *  open, and the owner is the method caller. Returns the created matter with
 *  default view.
 *
 *  Method: vault.matters.create
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeVaultEdiscovery
 */
@interface GTLRVaultQuery_MattersCreate : GTLRVaultQuery

/**
 *  Fetches a @c GTLRVault_Matter.
 *
 *  Creates a matter with the given name and description. The initial state is
 *  open, and the owner is the method caller. Returns the created matter with
 *  default view.
 *
 *  @param object The @c GTLRVault_Matter to include in the query.
 *
 *  @return GTLRVaultQuery_MattersCreate
 */
+ (instancetype)queryWithObject:(GTLRVault_Matter *)object;

@end

/**
 *  Deletes the specified matter. Returns the matter with updated state.
 *
 *  Method: vault.matters.delete
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeVaultEdiscovery
 */
@interface GTLRVaultQuery_MattersDelete : GTLRVaultQuery

/** The matter ID */
@property(nonatomic, copy, nullable) NSString *matterId;

/**
 *  Fetches a @c GTLRVault_Matter.
 *
 *  Deletes the specified matter. Returns the matter with updated state.
 *
 *  @param matterId The matter ID
 *
 *  @return GTLRVaultQuery_MattersDelete
 */
+ (instancetype)queryWithMatterId:(NSString *)matterId;

@end

/**
 *  Creates an export.
 *
 *  Method: vault.matters.exports.create
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeVaultEdiscovery
 */
@interface GTLRVaultQuery_MattersExportsCreate : GTLRVaultQuery

/** The matter ID. */
@property(nonatomic, copy, nullable) NSString *matterId;

/**
 *  Fetches a @c GTLRVault_Export.
 *
 *  Creates an export.
 *
 *  @param object The @c GTLRVault_Export to include in the query.
 *  @param matterId The matter ID.
 *
 *  @return GTLRVaultQuery_MattersExportsCreate
 */
+ (instancetype)queryWithObject:(GTLRVault_Export *)object
                       matterId:(NSString *)matterId;

@end

/**
 *  Deletes an export.
 *
 *  Method: vault.matters.exports.delete
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeVaultEdiscovery
 */
@interface GTLRVaultQuery_MattersExportsDelete : GTLRVaultQuery

/** The export ID. */
@property(nonatomic, copy, nullable) NSString *exportId;

/** The matter ID. */
@property(nonatomic, copy, nullable) NSString *matterId;

/**
 *  Fetches a @c GTLRVault_Empty.
 *
 *  Deletes an export.
 *
 *  @param matterId The matter ID.
 *  @param exportId The export ID.
 *
 *  @return GTLRVaultQuery_MattersExportsDelete
 */
+ (instancetype)queryWithMatterId:(NSString *)matterId
                         exportId:(NSString *)exportId;

@end

/**
 *  Gets an export.
 *
 *  Method: vault.matters.exports.get
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeVaultEdiscovery
 *    @c kGTLRAuthScopeVaultEdiscoveryReadonly
 */
@interface GTLRVaultQuery_MattersExportsGet : GTLRVaultQuery

/** The export ID. */
@property(nonatomic, copy, nullable) NSString *exportId;

/** The matter ID. */
@property(nonatomic, copy, nullable) NSString *matterId;

/**
 *  Fetches a @c GTLRVault_Export.
 *
 *  Gets an export.
 *
 *  @param matterId The matter ID.
 *  @param exportId The export ID.
 *
 *  @return GTLRVaultQuery_MattersExportsGet
 */
+ (instancetype)queryWithMatterId:(NSString *)matterId
                         exportId:(NSString *)exportId;

@end

/**
 *  Lists details about the exports in the specified matter.
 *
 *  Method: vault.matters.exports.list
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeVaultEdiscovery
 *    @c kGTLRAuthScopeVaultEdiscoveryReadonly
 */
@interface GTLRVaultQuery_MattersExportsList : GTLRVaultQuery

/** The matter ID. */
@property(nonatomic, copy, nullable) NSString *matterId;

/** The number of exports to return in the response. */
@property(nonatomic, assign) NSInteger pageSize;

/** The pagination token as returned in the response. */
@property(nonatomic, copy, nullable) NSString *pageToken;

/**
 *  Fetches a @c GTLRVault_ListExportsResponse.
 *
 *  Lists details about the exports in the specified matter.
 *
 *  @param matterId The matter ID.
 *
 *  @return GTLRVaultQuery_MattersExportsList
 *
 *  @note Automatic pagination will be done when @c shouldFetchNextPages is
 *        enabled. See @c shouldFetchNextPages on @c GTLRService for more
 *        information.
 */
+ (instancetype)queryWithMatterId:(NSString *)matterId;

@end

/**
 *  Gets the specified matter.
 *
 *  Method: vault.matters.get
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeVaultEdiscovery
 *    @c kGTLRAuthScopeVaultEdiscoveryReadonly
 */
@interface GTLRVaultQuery_MattersGet : GTLRVaultQuery

/** The matter ID. */
@property(nonatomic, copy, nullable) NSString *matterId;

/**
 *  Specifies how much information about the matter to return in the response.
 *
 *  Likely values:
 *    @arg @c kGTLRVaultViewViewUnspecified The amount of detail is unspecified.
 *        Same as **BASIC**. (Value: "VIEW_UNSPECIFIED")
 *    @arg @c kGTLRVaultViewBasic Returns the matter ID, name, description, and
 *        state. Default choice. (Value: "BASIC")
 *    @arg @c kGTLRVaultViewFull Returns the basic details and a list of matter
 *        owners and collaborators (see
 *        [MatterPermissions](https://developers.google.com/vault/reference/rest/v1/matters#matterpermission)).
 *        (Value: "FULL")
 */
@property(nonatomic, copy, nullable) NSString *view;

/**
 *  Fetches a @c GTLRVault_Matter.
 *
 *  Gets the specified matter.
 *
 *  @param matterId The matter ID.
 *
 *  @return GTLRVaultQuery_MattersGet
 */
+ (instancetype)queryWithMatterId:(NSString *)matterId;

@end

/**
 *  Adds an account to a hold. Accounts can be added only to a hold that does
 *  not have an organizational unit set. If you try to add an account to an
 *  organizational unit-based hold, an error is returned.
 *
 *  Method: vault.matters.holds.accounts.create
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeVaultEdiscovery
 */
@interface GTLRVaultQuery_MattersHoldsAccountsCreate : GTLRVaultQuery

/** The hold ID. */
@property(nonatomic, copy, nullable) NSString *holdId;

/** The matter ID. */
@property(nonatomic, copy, nullable) NSString *matterId;

/**
 *  Fetches a @c GTLRVault_HeldAccount.
 *
 *  Adds an account to a hold. Accounts can be added only to a hold that does
 *  not have an organizational unit set. If you try to add an account to an
 *  organizational unit-based hold, an error is returned.
 *
 *  @param object The @c GTLRVault_HeldAccount to include in the query.
 *  @param matterId The matter ID.
 *  @param holdId The hold ID.
 *
 *  @return GTLRVaultQuery_MattersHoldsAccountsCreate
 */
+ (instancetype)queryWithObject:(GTLRVault_HeldAccount *)object
                       matterId:(NSString *)matterId
                         holdId:(NSString *)holdId;

@end

/**
 *  Removes an account from a hold.
 *
 *  Method: vault.matters.holds.accounts.delete
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeVaultEdiscovery
 */
@interface GTLRVaultQuery_MattersHoldsAccountsDelete : GTLRVaultQuery

/** The ID of the account to remove from the hold. */
@property(nonatomic, copy, nullable) NSString *accountId;

/** The hold ID. */
@property(nonatomic, copy, nullable) NSString *holdId;

/** The matter ID. */
@property(nonatomic, copy, nullable) NSString *matterId;

/**
 *  Fetches a @c GTLRVault_Empty.
 *
 *  Removes an account from a hold.
 *
 *  @param matterId The matter ID.
 *  @param holdId The hold ID.
 *  @param accountId The ID of the account to remove from the hold.
 *
 *  @return GTLRVaultQuery_MattersHoldsAccountsDelete
 */
+ (instancetype)queryWithMatterId:(NSString *)matterId
                           holdId:(NSString *)holdId
                        accountId:(NSString *)accountId;

@end

/**
 *  Lists the accounts covered by a hold. This can list only
 *  individually-specified accounts covered by the hold. If the hold covers an
 *  organizational unit, use the [Admin
 *  SDK](https://developers.google.com/admin-sdk/). to list the members of the
 *  organizational unit on hold.
 *
 *  Method: vault.matters.holds.accounts.list
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeVaultEdiscovery
 *    @c kGTLRAuthScopeVaultEdiscoveryReadonly
 */
@interface GTLRVaultQuery_MattersHoldsAccountsList : GTLRVaultQuery

/** The hold ID. */
@property(nonatomic, copy, nullable) NSString *holdId;

/** The matter ID. */
@property(nonatomic, copy, nullable) NSString *matterId;

/**
 *  Fetches a @c GTLRVault_ListHeldAccountsResponse.
 *
 *  Lists the accounts covered by a hold. This can list only
 *  individually-specified accounts covered by the hold. If the hold covers an
 *  organizational unit, use the [Admin
 *  SDK](https://developers.google.com/admin-sdk/). to list the members of the
 *  organizational unit on hold.
 *
 *  @param matterId The matter ID.
 *  @param holdId The hold ID.
 *
 *  @return GTLRVaultQuery_MattersHoldsAccountsList
 */
+ (instancetype)queryWithMatterId:(NSString *)matterId
                           holdId:(NSString *)holdId;

@end

/**
 *  Adds accounts to a hold. Returns a list of accounts that have been
 *  successfully added. Accounts can be added only to an existing account-based
 *  hold.
 *
 *  Method: vault.matters.holds.addHeldAccounts
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeVaultEdiscovery
 */
@interface GTLRVaultQuery_MattersHoldsAddHeldAccounts : GTLRVaultQuery

/** The hold ID. */
@property(nonatomic, copy, nullable) NSString *holdId;

/** The matter ID. */
@property(nonatomic, copy, nullable) NSString *matterId;

/**
 *  Fetches a @c GTLRVault_AddHeldAccountsResponse.
 *
 *  Adds accounts to a hold. Returns a list of accounts that have been
 *  successfully added. Accounts can be added only to an existing account-based
 *  hold.
 *
 *  @param object The @c GTLRVault_AddHeldAccountsRequest to include in the
 *    query.
 *  @param matterId The matter ID.
 *  @param holdId The hold ID.
 *
 *  @return GTLRVaultQuery_MattersHoldsAddHeldAccounts
 */
+ (instancetype)queryWithObject:(GTLRVault_AddHeldAccountsRequest *)object
                       matterId:(NSString *)matterId
                         holdId:(NSString *)holdId;

@end

/**
 *  Creates a hold in the specified matter.
 *
 *  Method: vault.matters.holds.create
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeVaultEdiscovery
 */
@interface GTLRVaultQuery_MattersHoldsCreate : GTLRVaultQuery

/** The matter ID. */
@property(nonatomic, copy, nullable) NSString *matterId;

/**
 *  Fetches a @c GTLRVault_Hold.
 *
 *  Creates a hold in the specified matter.
 *
 *  @param object The @c GTLRVault_Hold to include in the query.
 *  @param matterId The matter ID.
 *
 *  @return GTLRVaultQuery_MattersHoldsCreate
 */
+ (instancetype)queryWithObject:(GTLRVault_Hold *)object
                       matterId:(NSString *)matterId;

@end

/**
 *  Removes the specified hold and releases the accounts or organizational unit
 *  covered by the hold. If the data is not preserved by another hold or
 *  retention rule, it might be purged.
 *
 *  Method: vault.matters.holds.delete
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeVaultEdiscovery
 */
@interface GTLRVaultQuery_MattersHoldsDelete : GTLRVaultQuery

/** The hold ID. */
@property(nonatomic, copy, nullable) NSString *holdId;

/** The matter ID. */
@property(nonatomic, copy, nullable) NSString *matterId;

/**
 *  Fetches a @c GTLRVault_Empty.
 *
 *  Removes the specified hold and releases the accounts or organizational unit
 *  covered by the hold. If the data is not preserved by another hold or
 *  retention rule, it might be purged.
 *
 *  @param matterId The matter ID.
 *  @param holdId The hold ID.
 *
 *  @return GTLRVaultQuery_MattersHoldsDelete
 */
+ (instancetype)queryWithMatterId:(NSString *)matterId
                           holdId:(NSString *)holdId;

@end

/**
 *  Gets the specified hold.
 *
 *  Method: vault.matters.holds.get
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeVaultEdiscovery
 *    @c kGTLRAuthScopeVaultEdiscoveryReadonly
 */
@interface GTLRVaultQuery_MattersHoldsGet : GTLRVaultQuery

/** The hold ID. */
@property(nonatomic, copy, nullable) NSString *holdId;

/** The matter ID. */
@property(nonatomic, copy, nullable) NSString *matterId;

/**
 *  The amount of detail to return for a hold.
 *
 *  Likely values:
 *    @arg @c kGTLRVaultViewHoldViewUnspecified Not specified. Defaults to
 *        **FULL_HOLD**. (Value: "HOLD_VIEW_UNSPECIFIED")
 *    @arg @c kGTLRVaultViewBasicHold Returns the hold ID, name, update time,
 *        service, and query. (Value: "BASIC_HOLD")
 *    @arg @c kGTLRVaultViewFullHold Returns all details of **BASIC_HOLD** and
 *        the entities the hold applies to, such as accounts or organizational
 *        unit. (Value: "FULL_HOLD")
 */
@property(nonatomic, copy, nullable) NSString *view;

/**
 *  Fetches a @c GTLRVault_Hold.
 *
 *  Gets the specified hold.
 *
 *  @param matterId The matter ID.
 *  @param holdId The hold ID.
 *
 *  @return GTLRVaultQuery_MattersHoldsGet
 */
+ (instancetype)queryWithMatterId:(NSString *)matterId
                           holdId:(NSString *)holdId;

@end

/**
 *  Lists the holds in a matter.
 *
 *  Method: vault.matters.holds.list
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeVaultEdiscovery
 *    @c kGTLRAuthScopeVaultEdiscoveryReadonly
 */
@interface GTLRVaultQuery_MattersHoldsList : GTLRVaultQuery

/** The matter ID. */
@property(nonatomic, copy, nullable) NSString *matterId;

/**
 *  The number of holds to return in the response, between 0 and 100 inclusive.
 *  Leaving this empty, or as 0, is the same as **page_size** = 100.
 */
@property(nonatomic, assign) NSInteger pageSize;

/**
 *  The pagination token as returned in the response. An empty token means start
 *  from the beginning.
 */
@property(nonatomic, copy, nullable) NSString *pageToken;

/**
 *  The amount of detail to return for a hold.
 *
 *  Likely values:
 *    @arg @c kGTLRVaultViewHoldViewUnspecified Not specified. Defaults to
 *        **FULL_HOLD**. (Value: "HOLD_VIEW_UNSPECIFIED")
 *    @arg @c kGTLRVaultViewBasicHold Returns the hold ID, name, update time,
 *        service, and query. (Value: "BASIC_HOLD")
 *    @arg @c kGTLRVaultViewFullHold Returns all details of **BASIC_HOLD** and
 *        the entities the hold applies to, such as accounts or organizational
 *        unit. (Value: "FULL_HOLD")
 */
@property(nonatomic, copy, nullable) NSString *view;

/**
 *  Fetches a @c GTLRVault_ListHoldsResponse.
 *
 *  Lists the holds in a matter.
 *
 *  @param matterId The matter ID.
 *
 *  @return GTLRVaultQuery_MattersHoldsList
 *
 *  @note Automatic pagination will be done when @c shouldFetchNextPages is
 *        enabled. See @c shouldFetchNextPages on @c GTLRService for more
 *        information.
 */
+ (instancetype)queryWithMatterId:(NSString *)matterId;

@end

/**
 *  Removes the specified accounts from a hold. Returns a list of statuses in
 *  the same order as the request.
 *
 *  Method: vault.matters.holds.removeHeldAccounts
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeVaultEdiscovery
 */
@interface GTLRVaultQuery_MattersHoldsRemoveHeldAccounts : GTLRVaultQuery

/** The hold ID. */
@property(nonatomic, copy, nullable) NSString *holdId;

/** The matter ID. */
@property(nonatomic, copy, nullable) NSString *matterId;

/**
 *  Fetches a @c GTLRVault_RemoveHeldAccountsResponse.
 *
 *  Removes the specified accounts from a hold. Returns a list of statuses in
 *  the same order as the request.
 *
 *  @param object The @c GTLRVault_RemoveHeldAccountsRequest to include in the
 *    query.
 *  @param matterId The matter ID.
 *  @param holdId The hold ID.
 *
 *  @return GTLRVaultQuery_MattersHoldsRemoveHeldAccounts
 */
+ (instancetype)queryWithObject:(GTLRVault_RemoveHeldAccountsRequest *)object
                       matterId:(NSString *)matterId
                         holdId:(NSString *)holdId;

@end

/**
 *  Updates the scope (organizational unit or accounts) and query parameters of
 *  a hold. You cannot add accounts to a hold that covers an organizational
 *  unit, nor can you add organizational units to a hold that covers individual
 *  accounts. If you try, the unsupported values are ignored.
 *
 *  Method: vault.matters.holds.update
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeVaultEdiscovery
 */
@interface GTLRVaultQuery_MattersHoldsUpdate : GTLRVaultQuery

/** The ID of the hold. */
@property(nonatomic, copy, nullable) NSString *holdId;

/** The matter ID. */
@property(nonatomic, copy, nullable) NSString *matterId;

/**
 *  Fetches a @c GTLRVault_Hold.
 *
 *  Updates the scope (organizational unit or accounts) and query parameters of
 *  a hold. You cannot add accounts to a hold that covers an organizational
 *  unit, nor can you add organizational units to a hold that covers individual
 *  accounts. If you try, the unsupported values are ignored.
 *
 *  @param object The @c GTLRVault_Hold to include in the query.
 *  @param matterId The matter ID.
 *  @param holdId The ID of the hold.
 *
 *  @return GTLRVaultQuery_MattersHoldsUpdate
 */
+ (instancetype)queryWithObject:(GTLRVault_Hold *)object
                       matterId:(NSString *)matterId
                         holdId:(NSString *)holdId;

@end

/**
 *  Lists matters the requestor has access to.
 *
 *  Method: vault.matters.list
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeVaultEdiscovery
 *    @c kGTLRAuthScopeVaultEdiscoveryReadonly
 */
@interface GTLRVaultQuery_MattersList : GTLRVaultQuery

/**
 *  The number of matters to return in the response. Default and maximum are
 *  100.
 */
@property(nonatomic, assign) NSInteger pageSize;

/** The pagination token as returned in the response. */
@property(nonatomic, copy, nullable) NSString *pageToken;

/**
 *  If set, lists only matters with the specified state. The default lists
 *  matters of all states.
 *
 *  Likely values:
 *    @arg @c kGTLRVaultStateStateUnspecified The matter has no specified state.
 *        (Value: "STATE_UNSPECIFIED")
 *    @arg @c kGTLRVaultStateOpen The matter is open. (Value: "OPEN")
 *    @arg @c kGTLRVaultStateClosed The matter is closed. (Value: "CLOSED")
 *    @arg @c kGTLRVaultStateDeleted The matter is deleted. (Value: "DELETED")
 */
@property(nonatomic, copy, nullable) NSString *state;

/**
 *  Specifies how much information about the matter to return in response.
 *
 *  Likely values:
 *    @arg @c kGTLRVaultViewViewUnspecified The amount of detail is unspecified.
 *        Same as **BASIC**. (Value: "VIEW_UNSPECIFIED")
 *    @arg @c kGTLRVaultViewBasic Returns the matter ID, name, description, and
 *        state. Default choice. (Value: "BASIC")
 *    @arg @c kGTLRVaultViewFull Returns the basic details and a list of matter
 *        owners and collaborators (see
 *        [MatterPermissions](https://developers.google.com/vault/reference/rest/v1/matters#matterpermission)).
 *        (Value: "FULL")
 */
@property(nonatomic, copy, nullable) NSString *view;

/**
 *  Fetches a @c GTLRVault_ListMattersResponse.
 *
 *  Lists matters the requestor has access to.
 *
 *  @return GTLRVaultQuery_MattersList
 *
 *  @note Automatic pagination will be done when @c shouldFetchNextPages is
 *        enabled. See @c shouldFetchNextPages on @c GTLRService for more
 *        information.
 */
+ (instancetype)query;

@end

/**
 *  Removes an account as a matter collaborator.
 *
 *  Method: vault.matters.removePermissions
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeVaultEdiscovery
 */
@interface GTLRVaultQuery_MattersRemovePermissions : GTLRVaultQuery

/** The matter ID. */
@property(nonatomic, copy, nullable) NSString *matterId;

/**
 *  Fetches a @c GTLRVault_Empty.
 *
 *  Removes an account as a matter collaborator.
 *
 *  @param object The @c GTLRVault_RemoveMatterPermissionsRequest to include in
 *    the query.
 *  @param matterId The matter ID.
 *
 *  @return GTLRVaultQuery_MattersRemovePermissions
 */
+ (instancetype)queryWithObject:(GTLRVault_RemoveMatterPermissionsRequest *)object
                       matterId:(NSString *)matterId;

@end

/**
 *  Reopens the specified matter. Returns the matter with updated state.
 *
 *  Method: vault.matters.reopen
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeVaultEdiscovery
 */
@interface GTLRVaultQuery_MattersReopen : GTLRVaultQuery

/** The matter ID. */
@property(nonatomic, copy, nullable) NSString *matterId;

/**
 *  Fetches a @c GTLRVault_ReopenMatterResponse.
 *
 *  Reopens the specified matter. Returns the matter with updated state.
 *
 *  @param object The @c GTLRVault_ReopenMatterRequest to include in the query.
 *  @param matterId The matter ID.
 *
 *  @return GTLRVaultQuery_MattersReopen
 */
+ (instancetype)queryWithObject:(GTLRVault_ReopenMatterRequest *)object
                       matterId:(NSString *)matterId;

@end

/**
 *  Creates a saved query.
 *
 *  Method: vault.matters.savedQueries.create
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeVaultEdiscovery
 */
@interface GTLRVaultQuery_MattersSavedQueriesCreate : GTLRVaultQuery

/** The ID of the matter to create the saved query in. */
@property(nonatomic, copy, nullable) NSString *matterId;

/**
 *  Fetches a @c GTLRVault_SavedQuery.
 *
 *  Creates a saved query.
 *
 *  @param object The @c GTLRVault_SavedQuery to include in the query.
 *  @param matterId The ID of the matter to create the saved query in.
 *
 *  @return GTLRVaultQuery_MattersSavedQueriesCreate
 */
+ (instancetype)queryWithObject:(GTLRVault_SavedQuery *)object
                       matterId:(NSString *)matterId;

@end

/**
 *  Deletes the specified saved query.
 *
 *  Method: vault.matters.savedQueries.delete
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeVaultEdiscovery
 */
@interface GTLRVaultQuery_MattersSavedQueriesDelete : GTLRVaultQuery

/** The ID of the matter to delete the saved query from. */
@property(nonatomic, copy, nullable) NSString *matterId;

/** ID of the saved query to delete. */
@property(nonatomic, copy, nullable) NSString *savedQueryId;

/**
 *  Fetches a @c GTLRVault_Empty.
 *
 *  Deletes the specified saved query.
 *
 *  @param matterId The ID of the matter to delete the saved query from.
 *  @param savedQueryId ID of the saved query to delete.
 *
 *  @return GTLRVaultQuery_MattersSavedQueriesDelete
 */
+ (instancetype)queryWithMatterId:(NSString *)matterId
                     savedQueryId:(NSString *)savedQueryId;

@end

/**
 *  Retrieves the specified saved query.
 *
 *  Method: vault.matters.savedQueries.get
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeVaultEdiscovery
 *    @c kGTLRAuthScopeVaultEdiscoveryReadonly
 */
@interface GTLRVaultQuery_MattersSavedQueriesGet : GTLRVaultQuery

/** The ID of the matter to get the saved query from. */
@property(nonatomic, copy, nullable) NSString *matterId;

/** ID of the saved query to retrieve. */
@property(nonatomic, copy, nullable) NSString *savedQueryId;

/**
 *  Fetches a @c GTLRVault_SavedQuery.
 *
 *  Retrieves the specified saved query.
 *
 *  @param matterId The ID of the matter to get the saved query from.
 *  @param savedQueryId ID of the saved query to retrieve.
 *
 *  @return GTLRVaultQuery_MattersSavedQueriesGet
 */
+ (instancetype)queryWithMatterId:(NSString *)matterId
                     savedQueryId:(NSString *)savedQueryId;

@end

/**
 *  Lists the saved queries in a matter.
 *
 *  Method: vault.matters.savedQueries.list
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeVaultEdiscovery
 *    @c kGTLRAuthScopeVaultEdiscoveryReadonly
 */
@interface GTLRVaultQuery_MattersSavedQueriesList : GTLRVaultQuery

/** The ID of the matter to get the saved queries for. */
@property(nonatomic, copy, nullable) NSString *matterId;

/** The maximum number of saved queries to return. */
@property(nonatomic, assign) NSInteger pageSize;

/**
 *  The pagination token as returned in the previous response. An empty token
 *  means start from the beginning.
 */
@property(nonatomic, copy, nullable) NSString *pageToken;

/**
 *  Fetches a @c GTLRVault_ListSavedQueriesResponse.
 *
 *  Lists the saved queries in a matter.
 *
 *  @param matterId The ID of the matter to get the saved queries for.
 *
 *  @return GTLRVaultQuery_MattersSavedQueriesList
 *
 *  @note Automatic pagination will be done when @c shouldFetchNextPages is
 *        enabled. See @c shouldFetchNextPages on @c GTLRService for more
 *        information.
 */
+ (instancetype)queryWithMatterId:(NSString *)matterId;

@end

/**
 *  Undeletes the specified matter. Returns the matter with updated state.
 *
 *  Method: vault.matters.undelete
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeVaultEdiscovery
 */
@interface GTLRVaultQuery_MattersUndelete : GTLRVaultQuery

/** The matter ID. */
@property(nonatomic, copy, nullable) NSString *matterId;

/**
 *  Fetches a @c GTLRVault_Matter.
 *
 *  Undeletes the specified matter. Returns the matter with updated state.
 *
 *  @param object The @c GTLRVault_UndeleteMatterRequest to include in the
 *    query.
 *  @param matterId The matter ID.
 *
 *  @return GTLRVaultQuery_MattersUndelete
 */
+ (instancetype)queryWithObject:(GTLRVault_UndeleteMatterRequest *)object
                       matterId:(NSString *)matterId;

@end

/**
 *  Updates the specified matter. This updates only the name and description of
 *  the matter, identified by matter ID. Changes to any other fields are
 *  ignored. Returns the default view of the matter.
 *
 *  Method: vault.matters.update
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeVaultEdiscovery
 */
@interface GTLRVaultQuery_MattersUpdate : GTLRVaultQuery

/** The matter ID. */
@property(nonatomic, copy, nullable) NSString *matterId;

/**
 *  Fetches a @c GTLRVault_Matter.
 *
 *  Updates the specified matter. This updates only the name and description of
 *  the matter, identified by matter ID. Changes to any other fields are
 *  ignored. Returns the default view of the matter.
 *
 *  @param object The @c GTLRVault_Matter to include in the query.
 *  @param matterId The matter ID.
 *
 *  @return GTLRVaultQuery_MattersUpdate
 */
+ (instancetype)queryWithObject:(GTLRVault_Matter *)object
                       matterId:(NSString *)matterId;

@end

/**
 *  Starts asynchronous cancellation on a long-running operation. The server
 *  makes a best effort to cancel the operation, but success is not guaranteed.
 *  If the server doesn't support this method, it returns
 *  `google.rpc.Code.UNIMPLEMENTED`. Clients can use Operations.GetOperation or
 *  other methods to check whether the cancellation succeeded or whether the
 *  operation completed despite cancellation. On successful cancellation, the
 *  operation is not deleted; instead, it becomes an operation with an
 *  Operation.error value with a google.rpc.Status.code of 1, corresponding to
 *  `Code.CANCELLED`.
 *
 *  Method: vault.operations.cancel
 */
@interface GTLRVaultQuery_OperationsCancel : GTLRVaultQuery

/** The name of the operation resource to be cancelled. */
@property(nonatomic, copy, nullable) NSString *name;

/**
 *  Fetches a @c GTLRVault_Empty.
 *
 *  Starts asynchronous cancellation on a long-running operation. The server
 *  makes a best effort to cancel the operation, but success is not guaranteed.
 *  If the server doesn't support this method, it returns
 *  `google.rpc.Code.UNIMPLEMENTED`. Clients can use Operations.GetOperation or
 *  other methods to check whether the cancellation succeeded or whether the
 *  operation completed despite cancellation. On successful cancellation, the
 *  operation is not deleted; instead, it becomes an operation with an
 *  Operation.error value with a google.rpc.Status.code of 1, corresponding to
 *  `Code.CANCELLED`.
 *
 *  @param object The @c GTLRVault_CancelOperationRequest to include in the
 *    query.
 *  @param name The name of the operation resource to be cancelled.
 *
 *  @return GTLRVaultQuery_OperationsCancel
 */
+ (instancetype)queryWithObject:(GTLRVault_CancelOperationRequest *)object
                           name:(NSString *)name;

@end

/**
 *  Deletes a long-running operation. This method indicates that the client is
 *  no longer interested in the operation result. It does not cancel the
 *  operation. If the server doesn't support this method, it returns
 *  `google.rpc.Code.UNIMPLEMENTED`.
 *
 *  Method: vault.operations.delete
 */
@interface GTLRVaultQuery_OperationsDelete : GTLRVaultQuery

/** The name of the operation resource to be deleted. */
@property(nonatomic, copy, nullable) NSString *name;

/**
 *  Fetches a @c GTLRVault_Empty.
 *
 *  Deletes a long-running operation. This method indicates that the client is
 *  no longer interested in the operation result. It does not cancel the
 *  operation. If the server doesn't support this method, it returns
 *  `google.rpc.Code.UNIMPLEMENTED`.
 *
 *  @param name The name of the operation resource to be deleted.
 *
 *  @return GTLRVaultQuery_OperationsDelete
 */
+ (instancetype)queryWithName:(NSString *)name;

@end

/**
 *  Gets the latest state of a long-running operation. Clients can use this
 *  method to poll the operation result at intervals as recommended by the API
 *  service.
 *
 *  Method: vault.operations.get
 *
 *  Authorization scope(s):
 *    @c kGTLRAuthScopeVaultEdiscovery
 *    @c kGTLRAuthScopeVaultEdiscoveryReadonly
 */
@interface GTLRVaultQuery_OperationsGet : GTLRVaultQuery

/** The name of the operation resource. */
@property(nonatomic, copy, nullable) NSString *name;

/**
 *  Fetches a @c GTLRVault_Operation.
 *
 *  Gets the latest state of a long-running operation. Clients can use this
 *  method to poll the operation result at intervals as recommended by the API
 *  service.
 *
 *  @param name The name of the operation resource.
 *
 *  @return GTLRVaultQuery_OperationsGet
 */
+ (instancetype)queryWithName:(NSString *)name;

@end

/**
 *  Lists operations that match the specified filter in the request. If the
 *  server doesn't support this method, it returns `UNIMPLEMENTED`.
 *
 *  Method: vault.operations.list
 */
@interface GTLRVaultQuery_OperationsList : GTLRVaultQuery

/** The standard list filter. */
@property(nonatomic, copy, nullable) NSString *filter;

/** The name of the operation's parent resource. */
@property(nonatomic, copy, nullable) NSString *name;

/** The standard list page size. */
@property(nonatomic, assign) NSInteger pageSize;

/** The standard list page token. */
@property(nonatomic, copy, nullable) NSString *pageToken;

/**
 *  Fetches a @c GTLRVault_ListOperationsResponse.
 *
 *  Lists operations that match the specified filter in the request. If the
 *  server doesn't support this method, it returns `UNIMPLEMENTED`.
 *
 *  @param name The name of the operation's parent resource.
 *
 *  @return GTLRVaultQuery_OperationsList
 *
 *  @note Automatic pagination will be done when @c shouldFetchNextPages is
 *        enabled. See @c shouldFetchNextPages on @c GTLRService for more
 *        information.
 */
+ (instancetype)queryWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END

#pragma clang diagnostic pop
