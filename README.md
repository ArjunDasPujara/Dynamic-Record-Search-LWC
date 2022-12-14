# Dynamic Record Search LWC

Salesforce SFDX-based project to search records of any object by simple configuration. Lightning Web Components are used to achieve visualization of data and images.  
This is a single-point solution to search records on standard and custom objects.  
For different users, different objects and fields can be configured for search.  
Object level, field level, and record level security will always be enforced.  

# Glance

![](Documents/DynamicRecordSearch1.jpg)

![](Documents/DynamicRecordSearch2.jpg)

![](Documents/DynamicRecordSearch3.jpg)

![](Documents/DynamicRecordSearch4.jpg)

# Post Deployment steps
* Assign **Dynamic Record Search LWC** permission set to user
* Create records of **Dynamic Record Search Config**  
**Example**  
User = Standard User SFDC  
Object API Name = Account  
Field List = Name, AccountNumber (Comma seperate list of field API Names of object mentioned in Object API Name)  
Above record will allow Standard User SFDC to search account records and user can filter based on Name and AccountNumber field and both field will be available in result table.  
* Create multiple records with different combination of User, Object API Name, Field List to provide access
* Make sure user have access on object and fields mentioned in Object API Name and Field List

# Built With
* Lightning Web Components - Salesforce based web framework
* Apex
* Custom object
