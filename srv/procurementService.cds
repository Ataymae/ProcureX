using { purchasereq.db as db } from '../db/schema';

service ProcurementService @(path:'/proc') {

  entity PurchaseRequests as projection on db.PurchaseRequests;
  entity PurchaseItems    as projection on db.PurchaseItems;
  entity Suppliers        as projection on db.Suppliers;
  entity CostCenters      as projection on db.CostCenters;
  entity PRStatus         as projection on db.PRStatus;
  entity MaterialGroups   as projection on db.MaterialGroups;
  entity UoM              as projection on db.UoM;
  entity Budgets          as projection on db.Budgets;


  action approve ( ID : UUID ) returns Boolean;
  action reject  ( ID : UUID, reason : String );

  annotate PurchaseRequests with @(
    UI.LineItem : [
      { Value : requestNo },
      { Value : title },
      { Value : status }
    ]
  );

}
