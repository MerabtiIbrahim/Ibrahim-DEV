trigger EventAfterInsert on Event (after insert) {

    System.debug('########### trigger BEGIN: EventAfterinsert#####################');
    
    // utilisé pour bypasser la recursion des triggers
    if(Blocktrigger.blocOrNot()){
        
        // contient les actions declenchés sur des contrats seulement 
        list<Event> ContractEvent = new  list<Event>();
        
        // contient les IDs des contracts 
        List<ID> ListContractID = new List<ID>();
        
        // récuperer les Ids des contrats sur lesquels on a fait des actions
        for(Event ev: trigger.new){
            if(String.valueof(ev.WhatID).substring(0,3) == '800'){
                ev.DuplicateActionsID__c = ev.id;
                ListContractID.add(ev.WhatID); 
                ContractEvent.add(ev);
            }
        }
        
        // cette liste utiliser seulement pour bulkify l'insertion des actions 
        List<Event> listEvents = new List<Event>();
        
        // récuperer , à partir des Ids dans la liste "ListContractID", les contrats 
        if(ListContractID.size() != 0){
            List<Contract> ContractList = [select id,group__c, GroupAction__c from Contract where id in:ListContractID and GroupAction__c =: true ];
            
            // filtrer les contrats sur lesquels on dublique les actions 
            Map<Event,List<Contract>> MAPContrcatsPerEvent = TestActionFunction.DuplicateEvents(ContractEvent,ContractList);
            
            // Dupliquer les actions sur les contrats qui ont le meme group et le champ Actiongroup Activé  
            for(Event ev: MAPContrcatsPerEvent.keySet()){
                for(Contract cont: MAPContrcatsPerEvent.get(ev)){
                    Event newEvent = ev.clone();
                    newEvent.WhatId = cont.id;
                    newEvent.DuplicateActionsID__c = ev.ID;
                    listEvents.add(newEvent);
                }
            }
        }
        for(Event ev: trigger.new){
            system.debug(ev);
        }
        Blocktrigger.test = false;
        update ContractEvent;
        insert listEvents;    
    }
}