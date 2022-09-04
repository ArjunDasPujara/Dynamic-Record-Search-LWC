@IsTest
private class DynamicRecordSearchConfigSelectorTest {

	private static final Id USER_ID = UserInfo.getUserId();

	@TestSetup
	static void createTestData() {
		final String fieldListForAccount = 'Name';
		final String fieldListForContact = 'Name';

		List<Dynamic_Record_Search_Config__c> dynamicRecordSearchConfigList = new List<Dynamic_Record_Search_Config__c> {
			new Dynamic_Record_Search_Config__c(
				User__c = USER_ID,
				Object_API_Name__c = 'Account',
				Field_List__c = fieldListForAccount
			),new Dynamic_Record_Search_Config__c(
				User__c = USER_ID,
				Object_API_Name__c = 'Contact',
				Field_List__c = fieldListForContact
			)
		};
		insert dynamicRecordSearchConfigList;
	}

	@IsTest
	static void testGetRecordsByUserIdAndObjectapiName_currentUserId_returndynamicRecordSearchConfigRecord() {
		//When
		List<Dynamic_Record_Search_Config__c> dynamicRecordSearchConfigList = DynamicRecordSearchConfigSelector.getRecordsByUserId(USER_ID);

		//Then
		System.assertEquals(2, dynamicRecordSearchConfigList.size());
	}

	@IsTest
	static void testGetRecordsByUserIdAndObjectapiName_currentUserIdasNull_returndynamicRecordSearchConfigRecordbalnkList() {
		//Given
		final Id userId = null;
		//When
		List<Dynamic_Record_Search_Config__c> dynamicRecordSearchConfigList = DynamicRecordSearchConfigSelector.getRecordsByUserId(userId);

		//Then
		System.assertEquals(0, dynamicRecordSearchConfigList.size());
	}

	@IsTest
	static void testGetRecordsByUserId_currentUserIdAndObjectAPIName_returndynamicRecordSearchConfigRecord() {
		//Given
		final String objectAPIName = 'Contact';
		final String fieldAPINameList = 'Name';

		//When
		List<Dynamic_Record_Search_Config__c> dynamicRecordSearchConfigList = DynamicRecordSearchConfigSelector.getRecordsByUserIdAndObjectapiName(
			USER_ID,
			objectAPIName
		);

		//Then
		System.assertEquals(1, dynamicRecordSearchConfigList.size());
		System.assertEquals(objectAPIName, dynamicRecordSearchConfigList[0].Object_API_Name__c);
		System.assertEquals(fieldAPINameList, dynamicRecordSearchConfigList[0].Field_List__c);
	}

	@IsTest
	static void testGetRecordsByUserId_currentUserIdAsNullAndObjectAPIName_returndynamicRecordSearchConfigRecordBlankList() {
		//Given
		final String objectAPIName = 'Contact';
		final Id userId = null;

		//When
		List<Dynamic_Record_Search_Config__c> dynamicRecordSearchConfigList = DynamicRecordSearchConfigSelector.getRecordsByUserIdAndObjectapiName(
			userId,
			objectAPIName
		);

		//Then
		System.assertEquals(0, dynamicRecordSearchConfigList.size());
	}

	@IsTest
	static void testGetRecordsByUserId_currentUserIdAndObjectAPINameAsNull_returndynamicRecordSearchConfigRecordBlankList() {
		//Given
		final String objectAPIName = null;
		final String fieldAPINameList = 'Name';

		//When
		List<Dynamic_Record_Search_Config__c> dynamicRecordSearchConfigList = DynamicRecordSearchConfigSelector.getRecordsByUserIdAndObjectapiName(
			USER_ID,
			objectAPIName
		);

		//Then
		System.assertEquals(0, dynamicRecordSearchConfigList.size());
	}

	@IsTest
	static void testGenerateQuery_blankWhereClause_returnQueryWithoutWhereClause() {

		//Given
		final String emptyWhereClause = '';

		//When
		String query = DynamicRecordSearchConfigSelector.generateQuery(emptyWhereClause);

		//Then
		System.assertEquals(false, query.contains('WHERE'));
	}
}