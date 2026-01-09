@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface view Company Details'
@Metadata.ignorePropagatedAnnotations: true
define root view entity Z_I_COMPANY as select from zcompany_db
  composition [*] of Z_I_EMPLOYEES as _employees
{
 
  @EndUserText.label: 'Company ID'
  key company_id    as CompanyId,
      company_name  as CompanyName,
      resgno        as Resgno,
      industry      as Industry,
      nobranch      as Nobranch,
      overloginstatus        as overloginstatus,
      country       as Country,
      @Semantics.user.createdBy: true
      createdby     as Createdby,
      @Semantics.systemDateTime.createdAt: true
      createdat     as Createdat,
      @Semantics.user.lastChangedBy: true
      lastchangedby as Lastchangedby,
      @Semantics.systemDateTime.lastChangedAt: true
      lastchangesat as Lastchangesat,
      _employees
}
