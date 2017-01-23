({
      
clickCreateContract: function(component, event, helper) {
        var newContract = component.get("v.theContract");
        helper.createContract(component, newContract);
    
},
    
doInit: function(component, event, helper) {

    // Create the action

    var action = component.get("c.getContracts");
    
    var test = component.get("v.recordId");
    console.log(test);
        action.setParams({
        accountId : component.get("v.recordId")
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
    handleUpdateContract: function(component, event, helper) {
    var updatedContract = event.getParam("contract");
        console.log(updatedContract);
    helper.updateContract(component, updatedContract);
}

    
})