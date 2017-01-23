@isTest
private class test_OpportunityBeforeInsert{
    
    static testMethod void testOpportunityBeforeInsert()
    {
        
        // création de deux comptes de test.
        Account newAccount1 = new Account();
        newAccount1.Name ='Account For Testing1';
        insert newAccount1;
        Account newAccount2 = new Account();
        newAccount2.Name='Account For Testing2';
        insert newAccount2;
        
        // une liste qui contient 4 opportunities pour optimiser les DML
        List<opportunity> ListOpportunity = new list<Opportunity>();    
        
        
        // la création des 5 opportunities
        Opportunity op1 = new Opportunity();    
        op1.Name='Account1 opportunity';
        op1.StageName='Prospecting';
        op1.CloseDate=Date.today();
        op1.AccountId = newAccount1.id;
        
        Opportunity op2 = new Opportunity();    
        op2.Name='Account2 opportunity';
        op2.StageName='Prospecting';
        op2.CloseDate=Date.today();
        op2.AccountId = newAccount1.id;
        
        Opportunity op3 = new Opportunity();    
        op3.Name='Account3 opportunity';
        op3.StageName='Prospecting';
        op3.CloseDate=Date.today();
        op3.AccountId = newAccount1.id;
        
        Opportunity op4 = new Opportunity();    
        op4.Name='Account4 opportunity';
        op4.StageName='Prospecting';
        op4.CloseDate=Date.today();
        op4.AccountId = newAccount2.id;
        
        // ajouter les 4 opportunities Crées à la liste ListOpportunity
        ListOpportunity.add(op1);
        ListOpportunity.add(op2);
        ListOpportunity.add(op3);
        ListOpportunity.add(op4);
        
        // insertion de la liste ListOpportunity
        insert ListOpportunity;
        
        // création et insertion d'une 5 Opportunity pour optimiser le tester (100%)
        Opportunity op5 = new Opportunity();    
        op5.Name='Account1 opportunity';
        op5.StageName='Prospecting';
        op5.CloseDate=Date.today();
        op5.AccountId = newAccount1.id;
        insert op5;
        
        
    }
}