@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface view Employee Details'
@Metadata.ignorePropagatedAnnotations: true
define view entity Z_I_EMPLOYEES as select from zemployee_db
association to parent Z_I_COMPANY as _company on $projection.CompanyId = _company.CompanyId
{
    @EndUserText.label: 'Company ID'
    key company_id as CompanyId,
    key employee_id as EmployeeId,
    employeename as Employeename,
    gender as Gender,
    designation as Designation,
    currency as Currency,
    @Semantics.amount.currencyCode: 'currency'
    salary as Salary,
    mobileno as Mobileno,
    @EndUserText.label: 'Login Status'
    
    loginstatus as loginstatus,
    joiningdate as Joiningdate,
    @Semantics.user.createdBy: true
    createdby as Createdby,
    @Semantics.systemDateTime.createdAt: true
    createdat as Createdat,
    @Semantics.user.lastChangedBy: true
    lastchangedby as Lastchangedby,
    @Semantics.systemDateTime.lastChangedAt: true
    lastchangesat as Lastchangesat,
    _company
}
