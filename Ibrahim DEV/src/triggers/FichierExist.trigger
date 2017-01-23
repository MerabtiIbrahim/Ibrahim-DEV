trigger FichierExist on Case (before update) {

     List<ID> IdCases = new List<ID>();
       for (Case c : Trigger.new) {
       IdCases.add(c.id);
    }
   System.debug('Je suis la 1');
    List<Attachment> AttchmentList = [select id,Name from Attachment where ParentId In :IdCases];
     System.debug('Je suis la 2');
    for (Case c : Trigger.new) {
         System.debug('Je suis la 3');
        for(Attachment att: AttchmentList){
            if(att.ParentId == c.id){
                 System.debug('Je suis la 4');
                if(att.Name.contains('Réponse')){
                    c.testNumber__c = 1;
                }
            }
        }
    }
}