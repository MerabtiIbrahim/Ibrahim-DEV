({
 createContract: function(component, contract) {
     
    var action = component.get("c.saveContract");
    action.setParams({
        "contract": contract
    });
    action.setCallback(this, function(response){
        var state = response.getState();
        if (component.isValid() && state === "SUCCESS") {
           /* var expenses = component.get("v.expenses");
            expenses.push(response.getReturnValue());
            component.set("v.expenses", expenses);*/
        }
    });
    $A.enqueueAction(action);
},

    updateContract: function(component, contract) {
            // Create the action

    var action = component.get("c.getContracts");

        action.setParams({
        accountId : contract.Id
    });

    // Add callback behavior for when response is received
    action.setCallback(this, function(response) {
        var state = response.getState();
        if (component.isValid() && state === "SUCCESS") {
            component.set("v.contracts", response.getReturnValue());
        }
        else {
            console.log("Failed with state: " + state);
        }
    });

    // Send action off to be executed
    $A.enqueueAction(action);

},
               
                       
    
    
    

})