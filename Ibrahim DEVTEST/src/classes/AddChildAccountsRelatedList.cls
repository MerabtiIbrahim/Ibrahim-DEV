public class AddChildAccountsRelatedList {
    
    public List<Account> ChildAccounts {get;set;}
    
    public AddChildAccountsRelatedList(ApexPages.StandardController stdController){
        String queryFields = '';
        for(Schema.FieldSetMember f : SObjectType.Account.FieldSets.Account_Field_set.getFields()) {
                 if(queryFields.length() > 0) {
                queryFields += ', ';
            }
            
            queryFields += f.getFieldPath();
        }
        
system.debug(queryFields);
        Account acc = (Account)stdController.getRecord();
        Id idAccount = acc.id;
         this.ChildAccounts = Database.query(
            ' SELECT ' +
                queryFields + 
            ' FROM ' +
                ' Account ' +
            ' WHERE ' +
                ' Parentid =: idAccount');
 system.debug(ChildAccounts.size());       
        
       // ChildAccounts = [select id from Account where Parentid =: acc.id];
    }
}