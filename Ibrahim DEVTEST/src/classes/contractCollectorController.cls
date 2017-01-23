public class contractCollectorController {
    
    @AuraEnabled
    public static void saveContract(Contract contract) {
        // Perform isUpdatable() checking first, then
        upsert contract;
        //return lead;
    }
        @AuraEnabled
    public static List<Contract> getContracts(Id accountId) {
        system.debug(accountId);
        // recuperer le contract en cours
        List<Contract> Contrat = [select Id, Status,Group__c,GroupAction__c from Contract where Id =: accountId];
       
        if(Contrat.size() >0){
            Contrat.get(0).GroupAction__c = true;
        }
        update Contrat;
        return [SELECT Id, AccountId, ContractNumber,Account.Name, Status, ContractTerm 
                FROM Contract where Group__c =: Contrat.get(0).group__c and id !=: accountId  and GroupAction__c != true ];
    }
}