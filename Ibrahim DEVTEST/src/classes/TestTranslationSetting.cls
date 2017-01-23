public class TestTranslationSetting {

    public Poste__c p {get;set;}
    
    public TestTranslationSetting(){
      p = [select PicklistTest__c from poste__c limit 1];
        
    }
    public void testPoste(){
          
        p.PicklistTest__c = 'Hand';
        update p;
        //return null;
    }
}