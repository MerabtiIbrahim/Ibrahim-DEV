public with sharing class MyControllerTest {


public PageReference redirect() {
        
        // récuperer l'identifaint du compte
        String Id = ApexPages.currentPage().getParameters().get('Id');
        // récuperer toutes les opportunités rattchées à ce compte
        if(Id == null || Id ==''){
            
            return null;
        }
        List<Account> accFetched = [select id from Account where id =:Id limit 1];
        List<Opportunity> OpportunityList = [select id,Name,CloseDate,AccountID from opportunity where AccountID =:Id];
        System.debug(id);
        
        // un compteur pour le total des opportunitées de chaque compte
           Integer Compteur = 0;  
        
        // pour chaque compte, si cette  opportunity lui est ratachée, on incremente le compteur
        for(opportunity op: OpportunityList){       
                Compteur++;
        }
   
        // configuerer les valeurs à passer dans URL
        Date d = Date.today() + 7*6;
        String dateString =d.day() + '/' + d.month() + '/' +d.year();
        
        // revenir à la page de création de l'opportunité.
        PageReference pr = new PageReference('/006/e?opp3=DOS-'+TestActionFunction.normalizeDigit(Compteur)+'&opp11=Premier%20Contact&opp9='+dateString+'&opp4_lkid='+Id);
        
        return pr;
    }
}