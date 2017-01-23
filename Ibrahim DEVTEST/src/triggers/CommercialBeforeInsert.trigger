trigger CommercialBeforeInsert on Commercial_objective__c (before insert) {

    if(PAD.canTrigger('AP_Commercial_Objective')){
        system.debug('Yes, it works');
    }
}