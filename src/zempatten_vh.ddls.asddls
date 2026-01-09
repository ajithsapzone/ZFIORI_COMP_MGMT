@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help for Employee Attendance List'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZEMPATTEN_VH as select from zattendance_vh
{
  key code       as Code,
      statustext as Statustext
}
