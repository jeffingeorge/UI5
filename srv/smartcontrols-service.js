const cds = require ('@sap/cds')
module.exports = cds.service.impl (function() {
    const { Category, Product } = cds.entities('myapps.smartcontrols');
    this.on('READ',"getUserInfo", async (req) => {
        return {
            "userId": 'JGEORGE',
            "isCustomer": false,
            "isCarrier": false,
            "isEmployee": true,
            "region": 'US',
            "scaccode": [{"scac":"STVV"},{"scac":"TVWL"}]
        }
    });

    this.on('READ','Products',async (req) => {
        debugger
        const tx = cds.transaction(req);
        const nCategoryID = 1;
        await UPDATE (Category) 
            .set({CategoryName: 'Beverages-002'}) 
            .where({CategoryID:nCategoryID});
        const aProducts = await tx.run (
            SELECT.from(Product)
        )
        // return tx.run ([
        //         UPDATE (Category) .set({CategoryName: 'Beverages-001'}) .where({CategoryID:nCategoryID})
        //     ]).catch(() => req.reject(400, 'Failed to update!!!'))
        return aProducts;
    });

    this.on(['PATCH','PUT'],"Employees", async (req)=> {
        const { managedEmployees } = cds.entities;
        const aData = req.data;
        
        let updateRes = await cds.tx(req).run(UPDATE.entity(managedEmployees)
            .data({ 
                empAge: aData.empAge
            })
            .where({ empID: aData.empID }))
            .catch((e) =>
                req.info({ code: 400, message: e.message }));
        if(updateRes > 0 ) {
            // return await SELECT.from (managedEmployees,aData.empID);
            req.info(200, 'Updated successfully');
            req.error (400,'Failed to update','',200); 
        } else {
            req.info ({code:400,message:'Failed to update 2',status:207}); 
            req.info({code:200, message:'Updated successfully 2'});  
            req.info ({code:400,message:'Failed to update 3',status:207}); 
        }
       return req.messages; 
    });
});