trigger AttachFichier on Attachment (before insert) {

     List<ID> IdCases = new List<ID>();
       for (Attachment c : Trigger.new) {
       IdCases.add(c.ParentId);
    }
    List<Case> CaseList = [select id,testNumber__c from Case where id In :IdCases];
     System.debug(CaseList);
    	for(Case c: CaseList){
           for (Attachment att : Trigger.new) {
               if(att.ParentId == c.id){
                            if(att.Name.contains('Réponse')){
                  			  c.testNumber__c = 1;
                }
               }
       
            } 
    }
update CaseList;
        
}