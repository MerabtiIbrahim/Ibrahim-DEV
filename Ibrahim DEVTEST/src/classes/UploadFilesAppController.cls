public class UploadFilesAppController {
    public Attachment attach1 {get;set;}
    public Attachment attach2 {get;set;}
    public attachment attach3 {get;set;}
    
    public UploadFilesAppController()
    {        
        attach1 = new Attachment();
        attach2 = new Attachment();
        attach3 = new Attachment();
    }
    
    public Pagereference UploadFiles(){
        //a0658000001USHu
        
        // verify if all the mondatory fields are entered 
        if(attach1.body ==  null || attach2.body == null|| attach2.body == null){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Merci de charger tous les documents nécessaires'));
                                 return null;                                          
                                 }
                                 // upload the files and attach them to a parent
                                 
                                 attach1.parentID = 'a0658000001USHu';
                                 attach2.ParentID = 'a0658000001USHu';
                                 attach3.ParentId = 'a0658000001USHu';
                                 
                                 insert attach1;
                                 insert attach2;
                                 insert attach3;
                                 
                                 return null;
                                 }
                                 }