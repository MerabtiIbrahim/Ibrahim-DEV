public class LeadCollectorController {
     // STERN LECTURE ABOUT WHAT'S MISSING HERE COMING SOON
    
    @AuraEnabled
    public static void saveLead(Lead lead) {
        // Perform isUpdatable() checking first, then
        upsert lead;
        //return lead;
    }
}