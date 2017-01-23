public class Mytest {
  public candidat__c candidat {get; set;}

  public Mytest() {
    candidat = new candidat__c();
  }

  public PageReference saveObject() {
    insert candidat;
      return null;
  }
}