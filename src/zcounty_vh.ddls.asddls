@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help for County Field'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCOUNTY_VH as select from zcompany_vh
{
    key companyid as Companyid,
        country as Country
}
