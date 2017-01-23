({
	goBackToContactList : function (component, event, helper) {
    var urlEvent = $A.get("e.force:navigateToURL");
    urlEvent.setParams({
      "url": "https://ibrahim-dev-ed.lightning.force.com/one/one.app#/sObject/Contract/home?t=1483709285352"
    });
                console.log('Je suis ici')
        var urlEvent = $A.get(urlEvent);
    urlEvent.fire();
}
})