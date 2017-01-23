public class PAD{
    private static final Set<String> requiredOnce=new Set<String>{'AP123','AP432'};//List of Apex codes that should run only once. Add any code to the list
    private static Set<String>hasRun=new Set<String>();//List of Apex code that has already been run. Keep this list empty.
    public static final String PAD_BypassTrigger;//List of triggers that can be bypassed
    public static final Boolean PAD_DebugMode {get;set;}
    public static final String userRoleName;  //User Role Name
    public static final String userProfileName;//User Profile Name
    public static Set<String> ApexForcedBypass=new Set<String>();//ex: 'AP123','AP432'//List of Apex codes that need to be bypassed, dynamically and temporaryly managed by Apex Code
    static{
        System.Debug('## >>> PAD constructor :BEGIN <<< run by ' + UserInfo.getName());
        User user=[SELECT UserRole.Name,Profile.Name,UserPreferencesApexPagesDeveloperMode,PAD_BypassTrigger__c FROM User WHERE Id =:UserInfo.getUserId() LIMIT 1];
        PAD_BypassTrigger=';'+user.PAD_BypassTrigger__c+';';
         System.Debug(PAD_BypassTrigger);
        PAD_DebugMode=user.UserPreferencesApexPagesDeveloperMode;
        userRoleName= user.UserRole.Name;
        userProfileName = user.Profile.Name;
        System.Debug('## >>> PAD constructor : END <<<');
    }
    public static boolean canTrigger(String ApexName){//If no bypass
        if(requiredOnce.contains(ApexName)){//If it should run Once
            if(hasRun.contains(ApexName))return false;//Already run, should not run
            hasRun.add(ApexName);//Never run, can run only if not bypassed
        }
        return(PAD_BypassTrigger.indexOf(';'+ApexName+';')==-1 && !ApexForcedBypass.contains(ApexName));
    }
    /*Uncomment if you have activated multiple currency
public static Double convertToCorporateCurrency(String currencyIsoCode, Double amount){
if(!currencyRate.containsKey(currencyIsoCode))
for(CurrencyType curType: [SELECT IsoCode, ConversionRate FROM CurrencyType WHERE IsActive=true])
currencyRate.put(curType.IsoCode, curType.ConversionRate);
return amount/currencyRate.get(currencyIsoCode);
}*/
    /**********************
Visual Force part below
***********************/
    public class PAD_log{//One log entry
        public String timer{get;set;}
        public String reason{get;set;}
        public String message{get;set;}
        public String rowCSS{get;set;}
        public PAD_log(String message,String reason){
            this.timer=DateTime.now().format('HH:mm:ss , SS\'ms\'');
            this.reason=reason;
            this.message=message;
        }
        public PAD_log(String message,String reason,String rowCSS){
            this.timer=DateTime.now().format('HH:mm:ss , SS\'ms\'');
            this.reason=reason;
            this.message=message;
            this.rowCSS=rowCSS;
        }
    }
    public static Long starter;
    public static List<PAD_log>PAD_logs=new List<PAD_log>();
    public static void startTimer(){
        starter=DateTime.now().getTime();
        log('<img src="/img/icon/custom51_100/stopwatch16.gif" width="16px" height="16px"');
    }
    public static void stopTimer(){if(starter!=null)log('<img src="/img/icon/custom51_100/stopwatch16.gif" width="16px" height="16px" /><i> '+String.ValueOf(DateTime.now().getTime()-starter)+' ms</i>');}
    public static void log(String message,String reason,String rowColor){if(PAD_logs.size()<1000)PAD_logs.add(new PAD_log(message,reason,rowColor));}
    public static void log(String message,String reason){if(PAD_logs.size()<1000)PAD_logs.add(new PAD_log(message,reason));}
    public static void log(String message){if(PAD_logs.size()<1000)PAD_logs.add(new PAD_log(message,''));}
    public static void log(Integer message){if(PAD_logs.size()<1000)PAD_logs.add(new PAD_log(String.valueOf(message),''));}
    public static void log(Integer message,String reason){if(PAD_logs.size()<1000)PAD_logs.add(new PAD_log(String.valueOf(message),reason));}
    public static void log(Integer message,Integer reason){if(PAD_logs.size()<1000)PAD_logs.add(new PAD_log(String.valueOf(message),String.valueOf(reason)));}
    public static void log(String message,Integer reason){if(PAD_logs.size()<1000)PAD_logs.add(new PAD_log(message,String.valueOf(reason)));}
    
    public List<PAD_log>getPAD_logs(){return PAD_logs;}
    public static boolean isEmpty(String s){
        return s==null||s=='';
    }
}