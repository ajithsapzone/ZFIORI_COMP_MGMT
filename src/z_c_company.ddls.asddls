@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View for Z_I_COMPANY'
@Metadata.ignorePropagatedAnnotations: true

@UI.headerInfo: {
  typeName: 'Company Details',
  typeNamePlural: 'Company Details',
  title: {value : 'CompanyId' },
  description: {value : 'CompanyName' }
  }


define root view entity Z_C_COMPANY
  provider contract transactional_query
  as projection on Z_I_COMPANY
{

      @UI.facet: [ { id: 'Company',
      purpose: #STANDARD,
      type: #IDENTIFICATION_REFERENCE,
      label: 'Company Details',
      position: 10 },
      { id: 'emplyees',
      purpose: #STANDARD,
      type: #LINEITEM_REFERENCE,
      label: 'Employee Details',
      position: 20,
      targetElement: '_employees'}]


      @UI.lineItem: [{ position: 10, label: 'Company Id' }]
      @UI.identification: [{ position: 10, label: 'Company Id' }]
  key CompanyId,
      @UI.lineItem: [{ position: 20, label: 'Company Name' }]
      @UI.identification: [{ position: 20, label: 'Company Name' }]
      CompanyName,
      @UI.lineItem: [{ position: 30, label: 'Resigter No' }]
      @UI.identification: [{ position: 30, label: 'Resigter No' }]
      Resgno,
      @UI.lineItem: [{ position: 40, label: 'Industry' }]
      @UI.identification: [{ position: 40, label: 'Industry' }]
      Industry,
      @UI.lineItem: [{ position: 50, label: 'No Branch' }]
      @UI.identification: [{ position: 50, label: 'No Branch' }]
      Nobranch,
      @UI.lineItem: [{ position: 60, label: 'Overall Login Status'}, { type:#FOR_ACTION, dataAction: 'SETALLPRESENT', label:'Set all as Present' }]
      @UI.identification: [{ position: 60, label: 'Overall Login Status' }]
      @Consumption.valueHelpDefinition: [{ entity:{name: 'ZCOMATTEN_VH', element: 'Statustext' } }]
      overloginstatus,
      @UI.lineItem: [{ position: 70, label: 'Country' }]
      @UI.identification: [{ position: 70, label: 'Country' }]
      @Consumption.valueHelpDefinition: [{ entity:{ name: 'ZCOUNTY_VH', element: 'Country'} }]
      Country,
      @UI.hidden: true
      Createdby,
      @UI.hidden: true
      Createdat,
      @UI.hidden: true
      Lastchangedby,
      @UI.hidden: true
      Lastchangesat,
      /* Associations */
      _employees : redirected to composition child Z_C_EMPLOYEES
}
