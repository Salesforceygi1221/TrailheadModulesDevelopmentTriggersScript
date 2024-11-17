public class PropertyUtility {
    public static void newListedProperties() {
        List<Property__c> newPropList = [SELECT Name, Broker__r.Email__c, Days_On_Market__c FROM Property__c WHERE Days_On_Market__c <= 30];
        for (Property__c prop : newPropList) {
            string propEmail = prop.Name + ' : ' + (prop.Broker__r != null ? prop.Broker__r.Email__c : 'No Email');
            system.debug(propEmail);
        }
    }
}