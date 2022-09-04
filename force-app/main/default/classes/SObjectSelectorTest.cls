@IsTest
private class SObjectSelectorTest {

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
	static void testSelectBySearchTearmAndSearchField_allCorrectData_accountRecordList() {

		// Given
		final List<String> fieldApiNameList = new List<String> {
			'Name'
		};
		final String sObjectName = 'Account';
		final String searchField = 'Name';
		final String searchTerm = 'Test';

		// When
		List<SObject> resultDataList = SObjectSelector.selectBySearchTearmAndSearchField(
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

	@IsTest
	static void testSelectBySearchTearmAndSearchField_allCorrectDataWithSearchTerm_accountRecordList() {

		// Given
		final List<String> fieldApiNameList = new List<String> {
			'Name'
		};
		final String sObjectName = 'Account';
		final String searchField = 'Name';
		final String searchTerm = null;

		// When
		List<SObject> resultDataList = SObjectSelector.selectBySearchTearmAndSearchField(
			sObjectName,
			searchTerm,
			searchField,
			fieldApiNameList
		);

		// Then
		System.assertEquals(2, resultDataList.size());
	}

	@IsTest
	static void testSelectBySearchTearmAndSearchField_limitSizeMoreThanFiftyThousand_thorwError() {

		// Given
		final List<String> fieldApiNameList = new List<String> {
			'Name'
		};
		final String sObjectName = 'Account';
		final String searchField = 'Name';
		final String searchTerm = 'Test';
		final Integer limitsize = 60000;

		// When - Then
		try {
			List<SObject> resultDataList = SObjectSelector.selectBySearchTearmAndSearchField(
				sObjectName,
				searchTerm,
				searchField,
				fieldApiNameList,
				limitsize
			);
			System.assert(false, 'Exception Expected');
		} catch(Exception exp) {
			System.assertEquals(Label.Query_Limit_Error, exp.getMessage());
		}
	}

	@IsTest
	static void testSelectBySearchTearmAndSearchField_searchFieldNullSearchTermExist_thorwError() {

		// Given
		final List<String> fieldApiNameList = new List<String> {
			'Name'
		};
		final String sObjectName = 'Account';
		final String searchField = null;
		final String searchTerm = 'Test';

		// When - Then
		try {
			List<SObject> resultDataList = SObjectSelector.selectBySearchTearmAndSearchField(
				sObjectName,
				searchTerm,
				searchField,
				fieldApiNameList
			);
			System.assert(false, 'Exception Expected');
		} catch(Exception exp) {
			System.assertEquals(Label.SearchField_can_not_be_null_Error, exp.getMessage());
		}
	}

	@IsTest
	static void testSelectBySearchTearmAndSearchField_sobjectNameNull_emptyList() {

		// Given
		final List<String> fieldApiNameList = new List<String> {
			'Name'
		};
		final String sObjectName = null;
		final String searchField = 'Name';
		final String searchTerm = 'Test';

		// When
		List<SObject> resultDataList = SObjectSelector.selectBySearchTearmAndSearchField(
			sObjectName,
			searchTerm,
			searchField,
			fieldApiNameList
		);

		// Then
		System.assertEquals(0, resultDataList.size());
	}

	@IsTest
	static void testSelectBySearchTearmAndSearchField_searchFieldWhichNotBelongsToObject_thorwError() {

		// Given
		final List<String> fieldApiNameList = new List<String> {
			'Name'
		};
		final String sObjectName = 'Account';
		final String searchField = 'Test';
		final String searchTerm = 'Test';

		// When - Then
		try {
			List<SObject> resultDataList = SObjectSelector.selectBySearchTearmAndSearchField(
				sObjectName,
				searchTerm,
				searchField,
				fieldApiNameList
			);
			System.assert(false, 'Exception Expected');
		} catch(Exception exp) {
			System.assertEquals(Label.Search_field_not_belongs_to_object_Error, exp.getMessage());
		}
	}
}