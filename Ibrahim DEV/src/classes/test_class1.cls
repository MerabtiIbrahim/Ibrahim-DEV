global class test_class1 { 
    
    static void test(){
		Map<Double, Map<String,String[]>> contrat_mois = new Map<Double, Map<String,String[]>>();
		list<ligne_de_paie__c> lstlpaie = [select id,semaine__c,mois__c, Heure_r__c,heure_soire_maj_1_5__c,Heure_nuit_r__c,X1__c,Name__c from ligne_de_paie__c 
                                                                                                           where annee__c =: '2015'];
		Set<String> semaines = new Set<String>();
        Set<Double> nbcontrat  =new Set<Double>();
		Set<String[]> semaine_chevauche_deux_contrats = new Set<String[]>();
        Set<String> semaine_chevauche_deux_contrats2 = new Set<String>();
		Map<String, List<ligne_de_paie__c>> maping1 = new Map<String, List<ligne_de_paie__c>>(); // liste des fiche de paies de chaque semaine
		Map<String, List<ligne_de_paie__c>> maping_mois1 = new Map<String, List<ligne_de_paie__c>>(); // liste des fiches de paies de chaque mois
        for (ligne_de_paie__c liste: lstlpaie){ // calculer le nombre des contrats
         nbcontrat.add(liste.X1__c); 
        }

         for (ligne_de_paie__c liste: lstlpaie){
		 List<ligne_de_paie__c> values = maping1.get(liste.semaine__c);
		 List<ligne_de_paie__c> values_mois = maping_mois1.get(liste.mois__c);
		 if (values==null) {
 	     values = new List<ligne_de_paie__c>();
	     maping1.put(liste.semaine__c, values);
}

	    if(values_mois == null) {
        values_mois = new List<ligne_de_paie__c>();
        maping_mois1.put(liste.mois__c, values_mois);
}


        values.add(liste);
        values_mois.add(liste);
}

       
if(nbcontrat.size() > 1){
    
    					for (String key : maping1.keySet()) {    // ici , on va detecter les semaines qui chevauchent entre les contrats
   						Double mm = null; // pour comparer les semaines
						for(ligne_de_paie__c paie: maping1.get(key)){
     				  	if(mm == null){
        				mm = paie.X1__c;
    					}else{
        				if(mm != paie.X1__c){
            			String [] s = new String[]{key, String.valueof(mm),String.valueof(paie.X1__c) };
            			semaine_chevauche_deux_contrats.add(s);
                        semaine_chevauche_deux_contrats2.add(key);
            
        					}
    							}
						}			
                        }//
  for(String[] s: semaine_chevauche_deux_contrats){
 system.debug('la semaine  = '+s[0]+' est chevauche entre le contrat '+s[1]+' et le contrat '+s[2]);
  }
    for(Double contrat: nbcontrat) {  
            system.debug('le contrat = '+contrat);
     
       lstlpaie = [select id,semaine__c,mois__c, Heure_r__c,heure_soire_maj_1_5__c,Heure_nuit_r__c,X1__c from ligne_de_paie__c 
                                               where annee__c =: '2015' and X1__c =: contrat];
            
         Map<String, List<ligne_de_paie__c>> maping = new Map<String, List<ligne_de_paie__c>>(); // liste des fiche de paies de chaque semaine
		 Map<String, List<ligne_de_paie__c>> maping_mois = new Map<String, List<ligne_de_paie__c>>(); // liste des fiches de paies de chaque mois  
         Map<String,Set<String>> mois_semaines_map = new Map<String,Set<String>>();
		 Map<String,String[]> semainehs = new Map<String,String[]>(); // la liste des semaines et les heurs normales , spulementaires        
		 Map<String,String>semaineChevauche = new Map<String,String>(); // la listes des semaines chevauchées et mois qui suive	
	   	 Map<String,String[]> moishs = new Map<String,String[]>(); // la liste des mois et les heurs normales , spulementaires
        
         for (ligne_de_paie__c liste: lstlpaie){
		 List<ligne_de_paie__c> values = maping.get(liste.semaine__c);
		 List<ligne_de_paie__c> values_mois = maping_mois.get(liste.mois__c);
		 if (values==null) {
 	     values = new List<ligne_de_paie__c>();
	     maping.put(liste.semaine__c, values);
}

	    if(values_mois == null) {
        values_mois = new List<ligne_de_paie__c>();
        maping_mois.put(liste.mois__c, values_mois);
}


        values.add(liste);
        values_mois.add(liste);
}

for(String key: maping_mois.keySet()){
Set<String> mois_semaines = new Set<String>(); // set des mois et les semaines correspondantes.
for(ligne_de_paie__c paie: maping_mois.get(key)){
mois_semaines.add(paie.semaine__c);
}
mois_semaines_map.put(key, mois_semaines);
}

for (String key : maping.keySet()) {    // ici , on va récuperer les semaines chevauchées et les correpondants. le mois on prend le plus grand
Integer mois = 0;
for(ligne_de_paie__c paie: maping.get(key)){
if (mois == 0)
mois =  integer.valueof(paie.mois__c);
else{
if (integer.valueof(paie.mois__c) != mois ){
if(integer.valueof(paie.mois__c) > mois)
semaineChevauche.put(paie.mois__c,paie.semaine__c );
}
}
}  
}


  for(String key: maping.keySet()){ // calculer les heures supplementaires de chaque semaine
Double Ht = 0.0, Hs25 = 0.0,Hs50 = 0.0, Hn=0.0;
for(ligne_de_paie__c F: maping.get(key)){
    if(!pattern.matches('[a-zA-Z]+',F.Heure_r__c)){
    //if(!F.getHs().matches("[a-zA-Z]+")){ 
Ht= Ht+ double.valueof(F.Heure_r__c);   // if les heures supplmementaires sont des chifre : des joures repos on calcules pas les heures .
} 
}
if(Ht <= 35){
Hn = Ht;
} else if(Ht >35 && Ht<43){
Hn = 35.0;	
Hs25 = Ht-35;
}else {
    if(!semaine_chevauche_deux_contrats2.contains(key)){ // si cette semaine est une semaine chevauché n'ajoute pas des heures supplementaires
Hs50 = Ht - 43;
Hs25 = 43.0-35.0;
    }
    Hn = 35.0;
}
String[] s = new String[]{String.valueof(Hn),String.valueof(Hs25),String.valueof(Hs50)};
semainehs.put(key,s);  // on stock chaque semaine et les heures supplementaires
}


        
        
for(String key: mois_semaines_map.keySet()){
String semaine_flag = null;  // calculer les heures supplémentaires de chaque mois
boolean flag= false; 
Double Hs25 = 0.0, Hs50 =0.0,Hn=0.0, Ht=0.0, HNuit = 0.0, Hsoir=0.0;
    for(ligne_de_paie__c l:maping_mois.get(key)){
        HNuit = HNuit + Double.valueof(l.Heure_nuit_r__c); // calculer les heures de nuits de chaque mois
        Hsoir = Hsoir + Double.valueof(l.heure_soire_maj_1_5__c); // calculer les heures de soir de chaque mois
    }
for(String s: mois_semaines_map.get(key)){
	for(String sss: semaineChevauche.values()){
		if(sss == s){
			flag = true;
			break;
		}
		if(flag)
			break;
	}
	
	if(flag){              //
        Ht =0.0;
        	for(ligne_de_paie__c paie: maping.get(s))
	{
		if(paie.mois__c == key || pattern.matches('[a-zA-Z]+',paie.Heure_r__c)){ 
		 Ht = Ht + Double.valueof(paie.Heure_r__c);
		}
	}
	if( Ht> 35){ // si les  heures réalisé > 35 , mes les heures normales egale à 35.
		Ht = 35.0;
	}
Hn = Hn+Ht;
if(semaineChevauche.get(key) == s){
	if(semaine_flag != s){	
		Hs25 = Hs25 + double.valueof(semainehs.get(s)[1]);
		Hs50 = Hs50 + double.valueof(semainehs.get(s)[2]);
		semaine_flag = s;
	}
}
}else{                                             //
Hs25 = Hs25 + double.valueof(semainehs.get(s)[1]);
Hs50 = Hs50 + double.valueof(semainehs.get(s)[2]);
Hn =   Hn+double.valueof(semainehs.get(s)[0]);
}
}
String[] s = new String[]{String.valueof(Hs25),String.valueof(Hs50),String.valueof(Hn), String.valueof(HNuit), String.valueof(Hsoir)};
moishs.put(key, s);
}
contrat_mois.put(contrat,moishs);

for(String key: moishs.keySet()){
    system.debug('le mois ='+key+' a  '+moishs.get(key)[0]+' Hs25 et '+moishs.get(key)[1]+' Hs50 et '+moishs.get(key)[2]+' Hn et '+moishs.get(key)[3]+' Hnuit et '+moishs.get(key)[4]+' Hsoir');
}
    }
}


// affectation d heures supplemenatires de contrat non principal au conract principal

for(String[] s: semaine_chevauche_deux_contrats){
Double Ht =0.0;   
   list<ligne_de_paie__c> semaine_entre_deux_contrat = [select id,semaine__c,mois__c, Heure_r__c,heure_soire_maj_1_5__c,Heure_nuit_r__c,X1__c,Name__c from ligne_de_paie__c 
                                                                                                           where annee__c =: '2015' and semaine__c =: s[0]];
    
for(ligne_de_paie__c F: semaine_entre_deux_contrat){ // calculer les heures sups pour les semaine chevauchées 
    if(!pattern.matches('[a-zA-Z]+',F.Heure_r__c)){
    //if(!F.getHs().matches("[a-zA-Z]+")){ 
Ht= Ht+ double.valueof(F.Heure_r__c);   // if les heures supplmementaires sont des chifre : des joures repos on calcules pas les heures .
} 
    
}

    if(Ht> 35){ // on va tester lequel des contrats est principal ou non (ca se peut que les deux soient des principaux ou des non principaux)
       ligne_de_paie__c l1 = [select Name__c, X1__c,mois__c from ligne_de_paie__c  where annee__c =: '2015' and X1__c =: Double.valueof(s[0]) ];
       ligne_de_paie__c l2 = [select Name__c,X1__c,mois__c from ligne_de_paie__c  where annee__c =: '2015' and X1__c =: Double.valueof(s[1]) ];
        if((l1.Name__c == 'P' && l2.Name__c == 'N') ||(l1.Name__c == 'P' && l2.Name__c == 'P') || (l1.Name__c == 'N' && l2.Name__c == 'N') ){
           (contrat_mois.get(l1.X1__c)).get(l1.mois__c)[0] = String.valueof(Double.valueof((contrat_mois.get(l1.X1__c)).get(l1.mois__c)[0]) + (Ht-35) );
            if(Ht>43)
           (contrat_mois.get(l1.X1__c)).get(l1.mois__c)[1] = String.valueof(Double.valueof((contrat_mois.get(l1.X1__c)).get(l1.mois__c)[1]) + (Ht-43) );
        } else if(l1.Name__c == 'N' && l2.Name__c == 'P'){
            (contrat_mois.get(l2.X1__c)).get(l2.mois__c)[0] = String.valueof(Double.valueof((contrat_mois.get(l2.X1__c)).get(l2.mois__c)[0]) + (Ht-35) );
            if(Ht>43)
           (contrat_mois.get(l2.X1__c)).get(l2.mois__c)[1] = String.valueof(Double.valueof((contrat_mois.get(l2.X1__c)).get(l2.mois__c)[1]) + (Ht-43) );
        } 

    }
    
    
 system.debug('la semaine  = '+s[0]+' est chevauche entre le contrat '+s[1]+' et le contrat '+s[2]);
}

        
 }
}