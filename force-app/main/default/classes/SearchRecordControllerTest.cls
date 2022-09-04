@IsTest
private class SearchRecordControllerTest {

	@TestSetup
	static void createTestData(){
		List<Account> accountList = new List<Account> {
			new Account(
				Name = 'Test'
			),
			new Account(
				Name = 'R.R. Tax'
			)
		};
		insert accountList;
	}

	@IsTest
	static void testGetSearchableObjectList_withCreatingData_listOfDetailForObject() {
		//Given
		final String sobjectApiNames = 'Account';
		final String fieldApiNames = 'Name';
		insert new Dynamic_Record_Search_Config__c(
			Object_API_Name__c = sobjectApiNames,
			Field_List__c = fieldApiNames,
			User__c = UserInfo.getUserId()
		);

		// When
		List<SearchRecordController.Detail> detailList = SearchRecordController.getSearchableObjectList();

		// Then
		System.assertEquals(1, detailList.size());
		System.assertEquals('Account', detailList[0].label);
		System.assertEquals('Account', detailList[0].value);
	}

	@IsTest
	static void testGetFieldListBySObjectApiName_withoutCreatingData_throwException() {
		//Gien
		final String sobjectApiNames = 'Account';

		// When - Then
		try {
			List<SearchRecordController.Detail> detailList = SearchRecordController.getFieldListBySObjectApiName(sobjectApiNames);
			System.assert(false, 'Exception Expected');
		} catch(Exception exp) {

		}
	}

	@IsTest
	static void testGetFieldListBySObjectApiName_listOfDetailForField() {
		// Given
		final String sobjectApiName = 'Account';
		final String fieldApiNames = 'Name';
		insert new Dynamic_Record_Search_Config__c(
			Object_API_Name__c = sobjectApiName,
			Field_List__c = fieldApiNames,
			User__c = UserInfo.getUserId()
		);

		// When
		List<SearchRecordController.Detail> detailList = SearchRecordController.getFieldListBySObjectApiName(sobjectApiName);

		// Then
		System.assertEquals(1, detailList.size());
		System.assertEquals('Account Name', detailList[0].label);
		System.assertEquals('Name', detailList[0].value);
	}

	@IsTest
	static void testSelectBySearchTearmAndSearchField_allCorrectData_accountRecordList() {

		// Given
		final List<String> fieldApiNameList = new List<String> {
			'Name'
		};
		final String sObjectName = 'Account';
		final String searchField = 'Name';
		final String searchTerm = 'Test';

		// When
		List<SObject> resultDataList = SearchRecordController.selectBySearchTearmAndSearchField(
			sObjectName,
			searchTerm,
			searchField,
			fieldApiNameList
		);

		// Then
		List<Account> resultaccountDataList = (List<Account>)resultDataList;
		System.assertEquals(1, resultaccountDataList.size());
		System.assertEquals(searchTerm, resultaccountDataList[0].Name);
	}
}