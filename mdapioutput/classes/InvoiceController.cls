public class InvoiceController {
    public List<InvoiceWrapper> invoices {get;set;}
    public InvoiceController() { 
        invoices = new List<InvoiceWrapper>();
        for (Invoice__c i : [SELECT ID, Name, State__c, Price_before_tax__c FROM Invoice__c]) { //query for the details of the records you want to display
            invoices.add(new InvoiceWrapper(i)); //add the invoice
        }
    }


    public class InvoiceWrapper {
        public Invoice__c invoice {get;set;}
        public Decimal afterTaxPrice {get;set;}
        
        public InvoiceWrapper(Invoice__c i) {
                this.invoice = i; //assign Invoice
                String state = invoice.State__c;
                
                State_Sales_Tax__mdt taxRate = [SELECT DeveloperName, Tax_Rate__c FROM State_Sales_Tax__mdt WHERE DeveloperName = :state];
                
                this.afterTaxPrice = (taxRate.Tax_Rate__c + 1) * i.Price_before_tax__c; // calculate after tax price
            }
    }
}