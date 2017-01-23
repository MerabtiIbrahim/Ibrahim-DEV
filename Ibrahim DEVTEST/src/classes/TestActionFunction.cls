public class TestActionFunction {
    
    public static String generateRandomString(Integer len) {
    final String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz';
    String randStr = '';
    while (randStr.length() < len) {
       Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
       randStr += chars.substring(idx, idx+1);
    }
    return randStr; 
}
    
    
    public static Map<Event,List<Contract>> DuplicateEvents(List<Event> ListEvents, List<Contract> ListContracts){
        // récuperer les groupes des contracts
        List<String> GroupClient = new List<String>();
        for(Contract cont: ListContracts){
            GroupClient.add(cont.group__c);
        }
        
        // Cette Map contient à la fin les actions et les contrats sur lesquels on fait le clonage
        MAP<Event,List<Contract>> MAPContrcatsPerEvent = new MAP<Event,List<Contract>>();
        
        // cette liste contient tous les contrats qui ont le meme group que les contrats sur lesquels on a fait l'action
        List<Contract> ContractsMemeGroup = new List<Contract>();
        if(GroupClient.size() != 0){
            ContractsMemeGroup = [select id, group__c from Contract where group__c IN:GroupClient and id not in:ListContracts];
            system.debug('La taille des contract  par group = '+ContractsMemeGroup.size());
        }
        
        // une liste temporaire utilisée pour contenir les contrats à ajouter au MAP "MAPContrcatsPerEvent"
        List<Contract> ListContractsPerEvent = new List<Contract>();
        
        // pour chaque action, recupere tous les contrats sur lequels on doit cloner laction
        for(Event ev: ListEvents){
            for(Contract cont: ListContracts){
                ListContractsPerEvent = new List<Contract>();
                if(ev.whatID == cont.id){
                    for(Contract cont2: ContractsMemeGroup){
                        if(cont2.group__c == cont.group__c){
                            ListContractsPerEvent.add(cont2);
                        }
                }
                }
            }
            if(ListContractsPerEvent.size() != 0)
            MAPContrcatsPerEvent.put(ev,ListContractsPerEvent);
        }
        
        // la MAP finaleS
        return MAPContrcatsPerEvent;
        
    }
    public static String normalizeDigit(integer i){
        if(i < 10){
            String s = '0'+String.valueof(i+1);
            return s;
        }
        else{
            return String.valueof(i+1);
        }
    }
     public String Selected {get;set;}
     
        public List<SelectOption> getOptionValues(){
        List<SelectOption> ListOfObjects = new List<SelectOption>();

        ListOfObjects.add(new selectOption('-None-','-None-'));
        ListOfObjects.add(new SelectOption('A','A'));
        ListOfObjects.add(new SelectOption('B','B'));
        return ListOfObjects;
        }    
     
     public TestActionFunction(){
         
     }
     public Void FunctionToExecute(){
         system.debug('The value of Selected is = '+ Selected);
         
     } 

    
}