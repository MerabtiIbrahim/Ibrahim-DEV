//**************************************************************************************************************************************
// trigger name: OpportunityBeforeInsert
// Created: NBL - 19/12/2016
//
// Trigger decleclenché avant l'insertion de chaque opportunity pour mettre à jour les champs: StageName, CloseDate et Name
// 
//
//********************************************************************************************************************************

trigger OpportunityBeforeInsert on Opportunity (before insert) {
    // cette map sera utilisé pour calculer le nombre des opportunities par compte 
    MAP<Id,Integer> MapOpporPerCompte = new MAP<Id,Integer>();
    
    // récuperer la liste des comptes à aprtir des opportunities
    List<ID> IdCompte = new List<ID>();
    for (Opportunity op : Trigger.new) {
        IdCompte.add(op.AccountID);
        
    } 
    
    // Cette requete récupere toutes les opportunities qui sont rattachées à des comptes de la liste IdCompte
    List<Opportunity> OpportunityList = [select id,Name,CloseDate,AccountID from opportunity where AccountID In :IdCompte];
    
    // calculer par compte le nombre des opportunities 
    for(ID compteId: IdCompte ){
        
        // pour chaque compte, on remet le compteur à zero
        Integer Compteur = 0;  
        
        // pour chaque compte, si cette  opportunity lui est ratachée, on incremente le compteur
        for(opportunity op: OpportunityList){       
            if(op.AccountID == compteId){
                Compteur++;
            }     
        }
        // ajouter à chaque compte, le nombre des opportunities
        MapOpporPerCompte.put(compteId, Compteur);
    }
    // Pour chaque opportunity, mets à jour les champs spécifiés en haut
    for(Opportunity op: trigger.new){     
        
        //Si numéro entre 0 - 9, on met un 0 avant le chifre (exp - '09').
        op.name= 'DOS-RAISON SOCIALE-'+TestActionFunction.normalizeDigit(MapOpporPerCompte.get(op.AccountID));
        op.StageName = 'Premier Contact';
        op.CloseDate = Date.today()+ 6*7;
    }
    
}