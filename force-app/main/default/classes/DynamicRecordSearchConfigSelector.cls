public with sharing class DynamicRecordSearchConfigSelector {
	
	private static final String OBJECT_API_NAME = 'Dynamic_Record_Search_Config__c';
	private static final String QUERY_FROM_KEY = ' FROM ';
	private static final String QUERY_SELECT_KEY = 'SELECT ';
	private static final String QUERY_WHERE_KEY = ' WHERE ';

	private static final List<String> FILED_LIST = new List<String> {
		'Id',
		'Object_API_Name__c',
		'Field_List__c'
	};

	public static List<Dynamic_Record_Search_Config__c> getRecordsByUserId(Id userId) {
		if(userId == null) {
			return new List<Dynamic_Record_Search_Config__c>();
		}
		String whereClause = QUERY_WHERE_KEY + 'User__c =:userId';
		return Database.query(generateQuery(whereClause));
	}

	public static List<Dynamic_Record_Search_Config__c> getRecordsByUserIdAndObjectapiName(Id userId, String objectAPIName) {
		if(userId == null | String.isBlank(objectAPIName)) {
			return new List<Dynamic_Record_Search_Config__c>();
		}
		String whereClause = QUERY_WHERE_KEY + 'User__c =:userId AND Object_API_Name__c =:objectAPIName';
		return Database.query(generateQuery(whereClause));
	}

	@TestVisible
	private static String generateQuery(String whereClause) {
		String query = QUERY_SELECT_KEY + String.join(FILED_LIST, ',') + QUERY_FROM_KEY + OBJECT_API_NAME;
		if(String.isBlank(whereClause)) {
			return query;
		} else {
			return query + ' ' + whereClause;
		}
	}
}