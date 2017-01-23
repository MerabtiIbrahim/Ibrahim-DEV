@isTest
private class TestAttachment{

static testMethod void testAttachments()
    {
    	Case cse=new Case();
        insert cse;
 
        Attachment attach=new Attachment();   	
    	attach.Name='Réponse';
    	Blob bodyBlob=Blob.valueOf('This is just to test le trigger');
    	attach.body=bodyBlob;
        attach.parentId=cse.id;
        insert attach;
    	
    	List<Attachment> attachments=[select id, name from Attachment where parent.id=:cse.id];
    	System.assertEquals(1, attachments.size());
    }
}