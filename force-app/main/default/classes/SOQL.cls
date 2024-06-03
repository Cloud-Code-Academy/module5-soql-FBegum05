/**
* The SOQL class serves as a primer into the Salesforce Object Query Language in Apex.
* It covers fundamental aspects such as SELECT statements, WHERE clauses, Relationship queries, and LIMIT keyword.
*
* This class introduces developers to the concept of retrieving data from Salesforce using SOQL. It provides
* a step-by-step guide on how to construct SOQL queries, filter results using WHERE clause, retrieve related
* records, and manage data volume using the LIMIT keyword.
* 
* Topics covered in this class include:
* - Understanding the structure of a SOQL query.
* - Crafting basic SELECT statements in SOQL.
* - Applying filters using the WHERE clause in SOQL.
* - Fetching related records using Relationship queries.
* - Controlling the amount of data retrieved using the LIMIT keyword.
* 
* Users of this class can expect to gain a solid understanding of SOQL in Apex and
* be prepared to handle data retrieval tasks in Salesforce development.
* 
* @author Fahmeeda Begum
*/

public with sharing class SOQL{
    
    /**
     * Question 1
     * Update/Uncomment the template code to create a method
     * Returns all leads from Salesforce Org
     * @return List of all leads with Id, LastName, Company, Phone, Email
     * Update the corresponding test class and testGetAllLeads method to cover this method
     */
    public static List<Lead> getAllLeads() {
        return [SELECT Id, LastName, Company, Phone, Email FROM Lead];
    }

    

        

        
         
    
    
    

    
      

     

    /**
     * Question 2
     * Update/Uncomment the template code to create a method
     * Returns all contacts with first name of John.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByFirstName method to cover this method
     */
    public static List<contact> testGetContactsByFirstName(String firstname) {
        List<contact> contactNames=new List<contact> ();
        contactNames=[
            SELECT Id,Name FROM Contact WHERE FirstName='John'
        ];
        return contactNames;
    }
    //  The body of the method
    //}

    /**
       * Question 3
     * Update/Uncomment the template code to create a method
     * Returns the Contact Id for all contacts with last name of Smith or Jones
     * @return A list of Contact Ids.
     * Update the corresponding test class and testGetContactIdsByLastName method to cover this method
     */
    //[public | private ] [static] data_type method_name (input parameters) {
    //  The body of the method
    //}
     public static List<Id> testgetContactIdsByLastName() {
    // Query to get Contact Ids with last name 'Smith' or 'Jones'
    List<Contact> contacts = [
        SELECT Id
        FROM Contact
        WHERE LastName IN ('Smith', 'Jones')
    ];
    
    // Extracting the Ids from the Contact records
    List<Id> contactIds = new List<Id>();
    for (Contact contact : contacts) {
        contactIds.add(contact.Id);
    }
    
    return contactIds;
}

     

    /**
     * Question 4
     * Update/Uncomment the template code to create a method
     * Returns List of closed won opportunities for a specific Account.
     * Example: yourMethodName('001XXXXXXXXXXXX') should return the list of closed won opportunities for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Opportunities with important opportunities fields
     * Update the corresponding test class and testGetClosedWonOpportunityCountByAccount method to cover this method
     */
    //[public | private ] [static] data_type method_name (input parameters) {
    //  The body of the method
    //
     public static List<Opportunity> getClosedWonOpportunitiesByAccount(Id accountId) {
        // Query to get closed won Opportunities for the given Account Id
        List<Opportunity> closedWonOpportunities = [
            SELECT Id, Name, CloseDate, Amount, StageName
            FROM Opportunity
            WHERE AccountId = :accountId AND StageName = 'Closed Won'
        ];
        return closedWonOpportunities;
    }

  /**
     * Question 5
     * Update/Uncomment the template code to create a method
     * Returns the total count of Account records.
     * @return The Integer count of Account records.
     * Update the corresponding test class and testGetAccountCount method to cover this method
     */

    

     public static Integer getAccountCount() {
     
         return [SELECT COUNT() FROM Account];
     }
    

    
  
    /**
     * Question 6
     * Update/Uncomment the template code to create a method
     * Return Key Value pair of Task Id and Task records for any tasks due date within the next 7 days.
     * @return A map of Task Ids to Task records.
     * Update the corresponding test class and testGetTasksDueNextWeek method to cover this method
     */
    //[public | private ] [static] data_type method_name (input parameters) {
    //  The body of the method
    //}
     public static Map<Id, Task> getTasksDueNextWeek() {
        Date today = Date.today();
        Date nextWeek = today.addDays(7);

        List<Task> tasks = [SELECT Id, Subject, ActivityDate FROM Task WHERE ActivityDate >= :today AND ActivityDate <= :nextWeek];

        Map<Id, Task> taskMap = new Map<Id, Task>();
        for (Task t : tasks) {
            taskMap.put(t.Id, t);
        }

        return taskMap;
    }


    /**
     * Question 7
     * Update/Uncomment the template code to create a method
     * Retrieves all Contacts that have a example.com domain in their Email.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByEmailDomain method to cover this method
     */
    //[public | private ] [static] data_type method_name (input parameters) {
    //  The body of the method
    //}
    public static List<Contact> getContactsByEmailDomain() {
        List<Contact> contacts = [SELECT Id, FirstName, LastName, Email FROM Contact WHERE Email LIKE '%@example.com'];
        return contacts;
    }


    /**
     * Question 8
     * Retrieves all Opportunities that have a specific keyword in their Name.
     * Example: getOpportunitiesByNameKeyword('keyword') should return all Opportunities that have 'keyword' in their Name.
     * @param keyword The keyword to search for in the Opportunity Name.
     * @return A list of Opportunity records.
     */

    //public static List<Opportunity> getOpportunitiesByNameKeyword(String keyword) {
       // return null; // Replace null with the variable you used to store the result

public static List<Opportunity> getOpportunitiesByNameKeyword(String keyword) {
        String searchPattern = '%' + keyword + '%';
        List<Opportunity> opportunities = [SELECT Id, Name, Amount, CloseDate FROM Opportunity WHERE Name LIKE :searchPattern];
        return opportunities;
    }


    /**
     * Question 9
     * Retrieves all Cases that Case Origin is not Web or Email or Blank
     * @return A list of Case records.
     */

    //public static List<Case> getFilterCaseOrigins() {
        //return null; // Replace null with the variable you used to store the result
    public static List<Case> getFilterCaseOrigins() {
        List<Case> cases = [
            SELECT Id, CaseNumber, Origin, Subject
            FROM Case
            WHERE Origin != 'Web' AND Origin != 'Email' AND Origin != null
        ];
        return cases;
    }


    /**
     * Question 10
     * Update/Uncomment the template code to create a method
     * Retrieves all Leads that have a specific Lead Source or contain a specific keyword in their Title.
     * Example: yourMethodName('Web', 'Engineer') should return all Leads that have 'Web' in their Lead Source or 'Engineer' in their Title.
     * @param leadSource The Lead Source to search for.
     * @param keyword The keyword to search for in the Lead Title.
     * @return A list of Lead records.
     * Update the corresponding test class and testGetLeadsBySourceOrTitle method to cover this method
     */
    //[public | private ] [static] data_type method_name (input parameters) {
    //  The body of the method
    //}  
       public static List<Lead> getLeadsBySourceOrTitle(String leadSource, String keyword) {
        String searchPattern = '%' + keyword + '%';
        List<Lead> leads = [
            SELECT Id, FirstName, LastName, LeadSource, Title
            FROM Lead
            WHERE LeadSource = :leadSource OR Title LIKE :searchPattern
        ];
        return leads;
    }


    /**
     * Question 11
     * Returns the names of all Contacts associated with an Account.
     * Example: getContactNamesByAccount('001XXXXXXXXXXXX') should return the list of Contact LastNames for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Contact LastName.
     */

    //public static List<String> getContactNamesByAccount(Id accountId) {
        // Create a list to hold the Contact LastNames

        // Query the Contacts
        // Loop through each Contact and add the LastName to the list
        //for () {
        //    
        //}

        // Return the list of Contact LastNames
        //return null; // Replace null with the variable you used to store the result
    
public static List<String> getContactNamesByAccount(String accountId) {
        List<Contact> contacts = [SELECT LastName FROM Contact WHERE AccountId = :accountId];
        List<String> contactNames = new List<String>();
        for (Contact contact : contacts) {
            contactNames.add(contact.LastName);
        }
        return contactNames;
    }


    /**
     * Question 12
     * Returns the total revenue for all Opportunities in a specific Stage or if the amount is greater than 10000.
     * Example: getTotalRevenueByStage('Closed Won') should return the total revenue for all Opportunities in the 'Closed Won' Stage.
     * @param stage The Stage value to filter Opportunities.
     * @return The total revenue.
     */

    //public static Decimal getTotalRevenueByStage(String stage) {
        // Use AggregateQuery to get the total revenue

        // Return the total revenue
        //return null; // Replace null with the variable you used to store the result
    public static Decimal getTotalRevenueByStage(String stage) {
        AggregateResult[] groupedResults = [
            SELECT SUM(Amount) totalRevenue
            FROM Opportunity
            WHERE StageName = :stage OR Amount > 10000
        ];

        if (groupedResults.isEmpty()) {
            return 0;
        }

        return (Decimal)groupedResults[0].get('totalRevenue');
    }

    /**
     * Question 13
     * Retrieves the first 10 Accounts ordered by Name.
     * @return A list of the first 10 Accounts ordered by Name.
     */

    //public static List<Account> getFirstTenAccounts() {
        //return null; // Replace null with the variable you used to store the result
    public static List<Account> getFirstTenAccounts() {
        List<Account> accounts = [
            SELECT Id, Name
            FROM Account
            ORDER BY Name
            LIMIT 10
        ];
        return accounts;
    }

    
    /**
     * Question 14
     * Retrieves the Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     * @return A list of Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     */

    //public static List<Opportunity> getHighValueOpportunities() {
        //return null; // Replace null with the variable you used to store the result
    public static List<Opportunity> getHighValueOpportunities() {
        List<Opportunity> opportunities = [
            SELECT Id, Name, Amount, CloseDate
            FROM Opportunity
            WHERE Amount > 100000
            ORDER BY CloseDate
            LIMIT 5
        ];
        return opportunities;
    }

    
    /**
     * Question 15
     * Retrieves the Contacts with the most recent Birthdate, ordered by Birthdate, and limited to 3 records.
     * @return A list of Contacts
     */

    //public static List<Contact> getBirthdateContacts() {
        //return null; // Replace null with the variable you used to store the result
    public static List<Contact> getBirthdateContacts() {
        List<Contact> contacts = [
            SELECT Id, FirstName, LastName, Birthdate
            FROM Contact
            ORDER BY Birthdate DESC
            LIMIT 3
        ];
        return contacts;
    }

    
    /**
     * Question 16
     * Retrieves the Cases in the Open Status, ordered by CreatedDate, and limited to 10 records with an offset of 5.
     * @return A list of Cases
     */

    public static List<Case> getCasesWithStatus() {
        List<Case> cases = [
        SELECT Id, CaseNumber, Status, CreatedDate
        FROM Case
        WHERE Status = 'Open'
        ORDER BY CreatedDate
        LIMIT 10
        OFFSET 5
    ];
    
        return cases; // Replace null with the variable you used to store the result
    }

    

    /**
     * Question 17
     * Returns Set of Case Ids for a specific Account.
     * Example: getCaseIdsByAccount('001XXXXXXXXXXXX') should return the set of Case Ids for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A set of Case Ids.
     */

    public static Set<Id> getCaseIdsByAccount(Id accountId) {
        // Create a set to hold the Case Ids
        Set<Id> caseIds = new Set<Id>();

        // Query the Cases
        // Loop through each Case and add the Id to the set
        //for () {
        //    
        //}
         List<Case> cases = [
        SELECT Id
        FROM Case
        WHERE AccountId = :accountId
    ];
        for (Case c : cases) {
        caseIds.add(c.Id);
    }

        return caseIds; // Replace null with the variable you used to store the result
    }


    /**
     * Question 18
     * Return Map of Account Ids to Account Names Not in a specific Country.
     * Example: getAccountIdsToNamesNotInCountry('United States') should return the map of Account Ids to Account Names for Accounts that are not in the United States.
     * @param country The country to filter Accounts.
     * @return A map of Account Ids to Account Names.
     */

    public static Map<Id, String> getAccountIdsToNamesNotInCountry(String country) {
        // Create a map to hold the Account Ids to Account Names
        Map<Id, String> accountIdsToNames = new Map<Id, String>();

        // Query the Accounts
         List<Account> accounts = [
        SELECT Id, Name
        FROM Account
        WHERE BillingCountry != :country
    ];
        // Loop through each Account and add the Id and Name to the map
        for (Account acc : accounts) {
        accountIdsToNames.put(acc.Id, acc.Name);
    }

        return accountIdsToNames; // Replace null with the variable you used to store the result
    }


    /**
     * Question 19
     * Retrieves the Account Name for a given Contact.
     * Example: getAccountNameForContact('003XXXXXXXXXXXX') should return the Account Name for the Contact with the Id
     * @param contactId The Id of the Contact.
     * @return The Account Name of the Contact.
     */

    public static String getAccountNameForContact(String contactId) {
         Contact contact = [
        SELECT Account.Name
        FROM Contact
        WHERE Id = :contactId
        LIMIT 1
    ];
        return (contact != null && contact.Account != null) ? contact.Account.Name : null; // Replace null with the variable you used to store the result
    } 


    /**
     * Question 20
     * Returns single Account that has related opportunities in the same query
     * Example: getAccountAndOpportunitiesFromAccountId('001XXXXXXXXXXXX') should return the Account Name for the Account with the Id and all related Opportunities
     * @param accountId The ID of the Account.
     * @return An Account record with related Opportunities.
     */

    public static Account getAccountAndOpportunitiesFromAccountId(Id accountId) {
         Account accountWithOpps = [
        SELECT Id, Name, (SELECT Id, Name, StageName, CloseDate FROM Opportunities)
        FROM Account
        WHERE Id = :accountId
        LIMIT 1
    ];
        return accountWithOpps; // Replace null with the variable you used to store the result
    }


    /**
     * Question 21
     * Retrieves all contacts that have the Mailing State similar to the Account Billing State.
     * Example: getAccountsWithContactsByState('001XXXXXXXXXXXX') should return a list of Contacts that have the same Mailing State as the Account with the Id
     * @param Account Id
     * @return List of contacts with the same Mailing State as the Account Billing State
     */

    public static List<Contact> getAccountsWithContactsByState(Id accountId) {
        // Query the Account
          Account account = [
        SELECT BillingState
        FROM Account
        WHERE Id = :accountId
        LIMIT 1
    ];
        // Store the Account's BillingState
        if (account == null || account.BillingState == null) {
        return new List<Contact>();
    }

    String accountBillingState = account.BillingState;
        // Query the Contacts
         List<Contact> contacts = [
        SELECT Id, FirstName, LastName, MailingState
        FROM Contact
        WHERE MailingState = :accountBillingState
    ];
        return contacts; // Replace null with the variable you used to store the result
    }


    /**
     * Question 22
     * Extracts email domains from them leads, then finds Accounts with matching website domains
     * If Lead Email = test@test.com return account with website = www.test.com
     * Example: findAccountsByLeadEmailDomains([set of lead ids]) should return a list of Accounts with matching email domains
     * @param A set of Lead Ids.
     * @return A list of Accounts with matching email domains.
     */

    public static List<Account> findAccountsByLeadEmailDomains(Set<Id> leadIds) {
        // Query the Leads
         List<Lead> leads = [
        SELECT Id, Email
        FROM Lead
        WHERE Id IN :leadIds
    ];

        // Create a set of email domains from the Leads
        Set<String> emailDomains = new Set<String>();


        // Loop through each Lead
         for (Lead lead : leads) {
        // Get the email from the Lead
         String email = lead.Email;
             
            

            // Check if the email is not null
            if (email != null && email.contains('@')) {
            // Extract the domain part from the email
            String emailDomain = email.substringAfter('@').toLowerCase();
            // Add the email domain to the set
            emailDomains.add(emailDomain);
        }
    }
               Set<String> websiteDomains = new Set<String>();
                // Add the email domain to the set
                 for (String emailDomain : emailDomains) {
        websiteDomains.add('www.' + emailDomain);
    }
        
               List<Account> accounts = [
        SELECT Id, Name, Website
        FROM Account
        WHERE Website IN :websiteDomains
    ];  

        
        // Query the Accounts
        return accounts; // Replace null with the variable you used to store the result
    }

    /**
     * Question 23
     * Clones and Inserts Opportunity Line Items from an original Opportunity to a list of cloned Opportunities.
     * Adds a randomized number between 1 to 3 to the quantity of each line item.
     * Example: cloneLineItems('001XXXXXXXXXXXX', [list of opportunity ids]) should clone the line items from the Opportunity with the Id to each Opportunity in the list
     * @param Original Opportunity Id
     * @param List of cloned Opportunity Ids
     */

    public static void cloneLineItems(Id origOppId, List<Id> cloneOppIds) {
        // Query the original Opportunity Line Items
        List<OpportunityLineItem> origLineItems = [SELECT Id, OpportunityId, PricebookEntryId, Quantity, UnitPrice, ServiceDate, Description 
                                                   FROM OpportunityLineItem 
                                                   WHERE OpportunityId = :origOppId];

        // Create a list to hold the new line items
          List<OpportunityLineItem> newLineItems = new List<OpportunityLineItem>();
        

        // Generate a random number between 1 and 3

        // Loop through each cloned Opportunity Id
         for (Id cloneOppId : cloneOppIds) {

            // Loop through each original line item
              for (OpportunityLineItem origItem : origLineItems) {

                // Clone the original line item and add the random number to the quantity
                OpportunityLineItem newItem = origItem.clone(false, true, false, false);
                newItem.OpportunityId = cloneOppId;

        // Insert the new line items
        // Generate a random number between 1 and 3
                Integer randomQuantity = 1 + (Math.random() * 3).intValue();
                
                // Add the random number to the quantity
                newItem.Quantity = origItem.Quantity + randomQuantity;
                
                // Add the new line item to the list
                newLineItems.add(newItem);
              }
         }
        insert newLineItems;
                  
    }

    
    /**
     * Question 24
     * Retrieves the Opportunity Name, Account Name, and Owner Name for Opportunities that have a Stage of 'Closed Won'.
     * Example: getOpportunityDetailsForClosedWon()
     * @return A list of filtered Opportunity
     */

    public static List<Opportunity> getOpportunityDetailsForClosedWon() {  
        List<Opportunity> closedWonOpportunities = [SELECT Id, Name, Account.Name, Owner.Name
                                                    FROM Opportunity 
                                                    WHERE StageName = 'Closed Won'];
        return closedWonOpportunities; // Replace null with the variable you used to store the result
    }


    /**
     * Question 25
     * Sets the 'Primary_Contact__c' field for all Closed Won Opportunities to first Contact on the Account.
     * Example: setPrimaryContact() should set the 'Primary_Contact__c' field for every Opportunity in the org
     */
     
    public static void setPrimaryContact() {
        //Use the getOpportunityDetailsForClosedWon() method to get the Opportunities
         List<Opportunity> closedWonOpportunities = getOpportunityDetailsForClosedWon();
         if (closedWonOpportunities.isEmpty()) {
            return; // No Closed Won Opportunities to process
        }
        

        // Create a set of Account Ids from the Opportunities
        Set<Id> accountIds = new Set<Id>();
        for (Opportunity opp : closedWonOpportunities) {
            accountIds.add(opp.AccountId);
        }
        

        // Query the Contacts
         List<Contact> contacts = [SELECT Id, AccountId FROM Contact WHERE AccountId IN :accountIds];
        

        // Loop through each Contact and add the Account Id and Contact to the map
         Map<Id, Contact> accountToContactMap = new Map<Id, Contact>();
        
        for (Contact contact : contacts) {
            if (!accountToContactMap.containsKey(contact.AccountId)) {
                accountToContactMap.put(contact.AccountId, contact);
            }
        }
        // Loop through each Opportunity

                // Update the Opportunity primary contact from accountToContactMap
                 List<Opportunity> opportunitiesToUpdate = new List<Opportunity>();
        for (Opportunity opp : closedWonOpportunities) {
            if (accountToContactMap.containsKey(opp.AccountId)) {
                opp.Primary_Contact__c = accountToContactMap.get(opp.AccountId).Id;
                opportunitiesToUpdate.add(opp);
            }
        }

        // Update the Opportunities
        if (!opportunitiesToUpdate.isEmpty()) {
            update opportunitiesToUpdate;
        }
    }
}