trigger EventBeforeUpdate on Event (before update) {
    System.debug('################ Trigger Begin: EventBeforeUpdate #########################');
 if(Blocktrigger.blocOrNot()){
    
    // récupere tous le champs de l'objet Event
    Map<String, Schema.SObjectField> fldObjMap = schema.SObjectType.Event.fields.getMap();
    List<Schema.SObjectField> fldObjMapValues = fldObjMap.values();
    
    // construire une requete dynamique pour recuperer tous les actions concernées
    String theQuery = 'SELECT ';
    for(Schema.SObjectField s : fldObjMapValues)
    {
    
        String theName = s.getDescribe().getName();
        
        // continuer à construire la requete
        theQuery += theName + ',';
    }
    
    // éléminer la derniere ,
    theQuery = theQuery.subString(0, theQuery.length() - 1);
    
    String DuplicateActionID = Trigger.new.get(0).DuplicateActionsID__c;
    String IdCurrentEvent = Trigger.new.get(0).Id;
    // finaliser la requete 
    theQuery += ' FROM Event WHERE DuplicateActionsID__c =: DuplicateActionID And id !=: IdCurrentEvent';
    
    // faire un appel dynamique
    List<Event> events = Database.query(theQuery);
    system.debug('La taille de la liste Events = '+events.size());
    
    // comparer les valeurs des actions et copier les modifications sur les autres actions dupliquées        
    for(String fieldName : fldObjMap.keySet())
    {
        if(fieldName != 'Id' && fieldName != 'WhatID'){
        for(Event ev: events){
            if(ev.id != trigger.new.get(0).Id){
                 system.debug('old value = '+trigger.new.get(0).get(fldObjMap.get(fieldName)));
                 system.debug('new value = '+ev.get(fldObjMap.get(fieldName)));
            if(trigger.new.get(0).get(fldObjMap.get(fieldName)) != ev.get(fldObjMap.get(fieldName))){
                ev.put(fieldName, trigger.new.get(0).get(fldObjMap.get(fieldName)));
            }
            }
        }
        }
        
    }
     Blocktrigger.test = false;
    update events;
 }
    System.debug('################ Trigger END: EventBeforeUpdate ###########################');
    
}