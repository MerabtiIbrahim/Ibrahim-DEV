({
    updateTable: function(component, event, helper) {
        var contract = component.get("v.contract");
        console.log(contract.Id)
        var updateEvent = component.getEvent("updateContractTable");
        updateEvent.setParams({ "contract": contract });
        updateEvent.fire();
    }
})