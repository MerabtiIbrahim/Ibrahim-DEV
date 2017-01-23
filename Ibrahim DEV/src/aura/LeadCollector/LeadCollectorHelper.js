({
 save: function(component, expense) {
    var action = component.get("c.saveLead");
    action.setParams({
        "lead": lead
    });
    action.setCallback(this, function(response){
        var state = response.getState();
        if (component.isValid() && state === "SUCCESS") {
            /*
            var expenses = component.get("v.expenses");
            expenses.push(response.getReturnValue());
            component.set("v.expenses", expenses);
            */
        }
    });
    $A.enqueueAction(action);
},
})