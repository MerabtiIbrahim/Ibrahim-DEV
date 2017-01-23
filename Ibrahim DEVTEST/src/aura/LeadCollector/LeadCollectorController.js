({
clickCreateLead: function(component, event, helper) {

        var newExpense = component.get("v.theLead");
        helper.save(component, newExpense);
   
},
})