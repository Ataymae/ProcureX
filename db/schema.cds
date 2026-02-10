namespace purchasereq.db;

using {
    cuid,
    managed,
    sap.common.Currencies
} from '@sap/cds/common';

using {Attachments} from '@cap-js/attachments';


entity PRStatus {
    key code        : String(1) enum {
            Draft = 'D';
            Submitted = 'S';
            Approved = 'A';
            Rejected = 'R';
            Ordered = 'O';
        };
        criticality : Integer;
        displayText : String(60);
}

entity UoM {
    key code        : String(10);
        description : String(60);
}

entity MaterialGroups {
    key code        : String(20);
        description : String(120);
}

/** =========
  Master Data
  ========= */

entity Suppliers : cuid, managed {
    name    : String(120);
    email   : String(255);
    phone   : String(50);
    country : String(2);
    rating  : Integer;
}

entity CostCenters {
    key code        : String(20);
        name        : String(120);
        manager     : String(255);
        companyCode : String(4);
}

/** =========
  Transactions
  ========= */

entity PurchaseRequests : cuid, managed {
    requestNo     : String(20);
    title         : String(120);
    description   : String(2000);

    status        : Association to PRStatus;

    requestedDate : Date;
    neededByDate  : Date;

    costCenter    : Association to CostCenters;

    currency      : Association to Currencies;

    managerNote   : String(500);

    Items         : Composition of many PurchaseItems
                        on Items.parent = $self;

    attachments   : Composition of many Attachments;
}

/**
 * Items are owned by the PR (Composition).
 * Line amount can be computed later as a virtual field in the service layer.
 */
entity PurchaseItems : cuid, managed {
    parent        : Association to PurchaseRequests;

    itemNo        : Integer;
    description   : String(200);

    materialGroup : Association to MaterialGroups;

    quantity      : Decimal(13, 3) default 1;
    uom           : Association to UoM;

    unitPrice     : Decimal(15, 2) default 0;

    supplier      : Association to Suppliers;

    deliveryDate  : Date;
}

/** =========
  Budget (Optional but very useful)
  ========= */

entity Budgets : cuid, managed {
    costCenter    : Association to CostCenters;

    fiscalYear    : Integer;
    period        : Integer; // 1..12

    plannedAmount : Decimal(15, 2);
    currency      : Association to Currencies;
}
