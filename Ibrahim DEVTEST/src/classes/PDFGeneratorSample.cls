global class PDFGeneratorSample {
 webservice static String GeneratePDF(ID recordID){
        list<ligne_de_paie__c> listp = [select id,semaine__c,poste__c from ligne_de_paie__c
                                        where poste__c =:recordID and Heure_r__c =: 'R' ];
        for(ligne_de_paie__c cc : listp){
        Attachment attach = new Attachment();
        Blob body = Blob.valueOf('');
        attach.Body = body;
        attach.Name = 'sample2.pdf';
        attach.IsPrivate = false;
        attach.ParentId = recordID;
        insert attach;
        }
     list<Attachment> lista = [select id,name from Attachment 
                                        where name =: 'sample.pdf' ];
     String taille = ' la taille est = '+lista.size();
     return taille;
    }

}