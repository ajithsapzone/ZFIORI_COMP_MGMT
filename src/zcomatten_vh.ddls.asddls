@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help for Overall Attendance List'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCOMATTEN_VH as select from ZEMPATTEN_VH
{
    key Code as code,
        Statustext as Statustext
}
