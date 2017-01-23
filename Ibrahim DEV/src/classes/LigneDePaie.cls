public class LigneDePaie {
    public list<ligne_de_paie__c> listPaie {get;set;}
    
    public LigneDePaie(){
        listPaie = [select annee__c,Name__c,mois__c,Heure_r__c,semaine__c from ligne_de_paie__c];
    }
}