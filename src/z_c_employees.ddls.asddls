@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View for Z_I_EMPLOYEES'
@Metadata.ignorePropagatedAnnotations: true
define view entity Z_C_EMPLOYEES
  as projection on Z_I_EMPLOYEES
{


     @UI.facet: [ { id: 'Employee',
      purpose: #STANDARD,
      type: #IDENTIFICATION_REFERENCE,
      label: 'Employee Details',
      position: 10 },
      { id: 'emplyees' }]
//      purpose: #STANDARD,
//      type: #LINEITEM_REFERENCE,
//      label: 'Company Details',
//      position: 20,
//      targetElement: '_company'}]


      @UI.lineItem: [{ position: 10, label: 'Company Id' }]
      @UI.identification: [{ position: 10, label: 'Company Id' }]
  key CompanyId,
      @UI.lineItem: [{ position: 20, label: 'Employee Id' }]
      @UI.identification: [{ position: 20, label: 'Employee Id' }]
  key EmployeeId,
      @UI.lineItem: [{ position: 30, label: 'Employee Name' }]
      @UI.identification: [{ position: 30, label: 'Employee Name' }]
      Employeename,
      @UI.lineItem: [{ position: 40, label: 'Gender' }]
      @UI.identification: [{ position: 40, label: 'Gender' }]
      Gender,
      @UI.lineItem: [{ position: 50, label: 'Designation' }]
      @UI.identification: [{ position: 50, label: 'Designation' }]
      Designation,
      @UI.hidden: true
      Currency,
      @UI.lineItem: [{ position: 60, label: 'Salary' }]
      @UI.identification: [{ position: 60, label: 'Salary' }]
      @Semantics.amount.currencyCode: 'Currency'
      Salary,
      @UI.lineItem: [{ position: 70, label: 'Mobile No' }]
      @UI.identification: [{ position: 70, label: 'Mobile No' }]
      Mobileno,
      @UI.lineItem: [{ position: 80, label: 'Login Status' }]
      @UI.identification: [{ position: 80, label: 'Login Status' }]
      @Consumption.valueHelpDefinition: [{ entity:{ name: 'ZEMPATTEN_VH', element: 'Statustext' }  }]
      loginstatus,
      @UI.lineItem: [{ position: 90, label: 'Joining Date' }]
      @UI.identification: [{ position: 90, label: 'Joing Date' }]
      Joiningdate,
      @UI.hidden: true
      Createdby,
      @UI.hidden: true
      Createdat,
      @UI.hidden: true
      Lastchangedby,
      @UI.hidden: true
      Lastchangesat,
      /* Associations */
      _company : redirected to parent Z_C_COMPANY
}
