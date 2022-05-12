using { myapps.smartcontrols as sc } from '../db/smartcontrols-model';
type scaccode {
    scac: String(10);
}

entity info {
      userId: String(10);
      isCustomer: Boolean;
      isCarrier: Boolean;
      isEmployee: Boolean;
      region: String(2);
      scaccode: array of scaccode;      
  }

service smartControlsService {
  entity getUserInfo as projection on info;
  entity autoapproval as projection on sc.autoapproval;
  entity Products as projection on sc.Product;
  entity Categories as projection on sc.Category;
  entity Suppliers as projection on sc.Supplier;  

  entity ProductsVH as select key ProductID, ProductName from sc.Product;
  entity CategoriesVH as select key CategoryID, CategoryName from sc.Category;
  entity SuppliersVH as select key SupplierID, CompanyName from sc.Supplier;

  entity Employees as projection on sc.managedEmployees;
  entity getEmployee1(p_emp : String(20)) as projection on sc.getEmployee1(p_emp : : p_emp);
    entity getEmployee2(p_emp : String(20)) as projection on sc.getEmployee2(p_emp : : p_emp);
 
}

annotate Products with @(
    UI : {
        SelectionFields : [
            ProductID,
            CategoryID,
            SupplierID
        ]
    }
) {
    ProductID @(Common : {
        ValueList : {
            SearchSupported : true,
            Label           : 'Products',
            CollectionPath  : 'ProductsVH',
            Parameters      : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : ProductID,
                    ValueListProperty : 'ProductID'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'ProductName'
                }
            ]
        }
    });
    CategoryID @(Common : {
        ValueList : {
            SearchSupported : true,
            Label           : 'Products',
            CollectionPath  : 'ProductsVH',
            Parameters      : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : CategoryID,
                    ValueListProperty : 'ProductID'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'ProductName'
                }
            ]
        }
    });
    SupplierID @(Common : {
        ValueList : {
            SearchSupported : true,
            Label           : 'Suppliers',
            CollectionPath  : 'SuppliersVH',
            Parameters      : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : SupplierID,
                    ValueListProperty : 'SupplierID'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'CompanyName'
                }
            ]
        }
    });
};
