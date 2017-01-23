public class acomptre_compte {
   /* public Double Montant {get; set;}
    public String Type {get; set;}
    public Id id_poste {get; set;}
    public rubrique__c rubrique_a_inserer; */
    public String Type {get; set;}
    public String poste {get; set;}
    public Double montant {get; set;}
    public List<ligne_de_paie__c> listlp;
    public ligne_de_paie__c ligne_test;
   // public rubrique__c rubrique_a_inserer {get; set;} dsfsdfsdfsfs
    public rubrique__c rubrique_a_inserer {get; set;}
    public acomptre_compte(){
   rubrique_a_inserer =  new rubrique__c ();
   system.debug('This is just to try git');
   system.debug('This working actually');
    }

    public void save(){
        Double HeureR =0.0;
if(rubrique_a_inserer.montant__c != null && rubrique_a_inserer.Type__c != null && rubrique_a_inserer.poste__c!= null){
listlp = [select id, Heure_r__c from Ligne_de_paie__c where poste__c =: rubrique_a_inserer.poste__c];
    System.debug(' i am here and post id = '+rubrique_a_inserer.poste__c+' et montant '+rubrique_a_inserer.montant__c+' et la taille = '+listlp.size());
            if(listlp.size() > 0){
                for(ligne_de_paie__c lp: listlp){
                    HeureR = HeureR + double.valueof(lp.Heure_r__c);
                }
                System.debug('  les heures travaileés = '+HeureR);
	 ligne_test = [select id, Heure_r__c, poste__r.Taux_horaire_via_ech__c from Ligne_de_paie__c where poste__c =: rubrique_a_inserer.poste__c limit 1];

                if(HeureR*double.valueof(ligne_test.poste__r.Taux_horaire_via_ech__c) >=  rubrique_a_inserer.montant__c ){
                       //              rubrique_a_inserer = new rubrique__c (base2__c= ligne_test.poste__r.taux_horaire_via_ech__c, poste__c = id_poste, Contact__c = ligne_test.poste__r.annee_actuelleR__c, Type__c =Type, Taux__c=100, Semaine__c=ligne_test.semaine__c, mois__c =ligne_test.mois__c, Montant__c= HeureR*ligne_test.poste__r.Taux_horaire_via_ech__c, heures__c =HeureR);
                 System.debug('  les heures travaileés = '+HeureR);
                      //  rubrique_a_inserer = new rubrique__c (base2__c= ligne_test.poste__r.taux_horaire_via_ech__c);
                   rubrique_a_inserer.base2__c = ligne_test.poste__r.Taux_horaire_via_ech__c;
                    insert rubrique_a_inserer;
                    }
            }
    }

    /*  Double HeureR =0.0;
        if(Montant != null && Type != null && id_poste!= null){
          listlp = [select id, Heure_r__c from Ligne_de_paie__c where id =: id_poste];
            if(listlp.size() > 0){
                for(ligne_de_paie__c lp: listlp){
                    HeureR = HeureR + double.valueof(lp.Heure_r__c);
                }
                ligne_test = [select id, Heure_r__c, poste__r.Taux_horaire_via_ech__c from Ligne_de_paie__c where id =: id_poste];
                    if(HeureR*double.valueof(ligne_test.poste__r.Taux_horaire_via_ech__c) <= Montant ){
                       //              rubrique_a_inserer = new rubrique__c (base2__c= ligne_test.poste__r.taux_horaire_via_ech__c, poste__c = id_poste, Contact__c = ligne_test.poste__r.annee_actuelleR__c, Type__c =Type, Taux__c=100, Semaine__c=ligne_test.semaine__c, mois__c =ligne_test.mois__c, Montant__c= HeureR*ligne_test.poste__r.Taux_horaire_via_ech__c, heures__c =HeureR);

                        rubrique_a_inserer = new rubrique__c (base2__c= ligne_test.poste__r.taux_horaire_via_ech__c);
                    }
            }
        } */
    }

}