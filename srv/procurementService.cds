using {purchasereq.db as db} from '../db/schema';

service ProcurementService {
  entity PurchaseRequests as projection on db.PurchaseRequests;
  entity PurchaseItems    as projection on db.PurchaseItems;
  entity Suppliers        as projection on db.Suppliers;
  entity CostCenters      as projection on db.CostCenters;
  entity PRStatus         as projection on db.PRStatus;
  entity MaterialGroups   as projection on db.MaterialGroups;
  entity UoM              as projection on db.UoM;
  entity Budgets          as projection on db.Budgets;
}
