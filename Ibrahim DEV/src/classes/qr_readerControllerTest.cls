@isTest
public class qr_readerControllerTest{

    public static testMethod void qr_readerController() 
        {
          
            //Creating instance of the controller 
            qr_readerController controller = new qr_readerController();
         // Verify that page fails without parameters
            ApexPages.currentPage().getParameters().put('code', 'Test');
        }
        
 }