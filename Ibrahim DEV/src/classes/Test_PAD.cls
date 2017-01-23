@IsTest
public class Test_PAD {
    static testMethod void PAD_Main_TestMethod(){
        PAD.log('','');PAD.log('',1);PAD.log(1,'');PAD.log(1,1);PAD.log(1);PAD.log('');PAD.startTimer();PAD.stopTimer();
        PAD myPAD=new PAD();myPAD.getPAD_logs();
        PAD.canTrigger('AP123');
    }
}