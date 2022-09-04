@IsTest
private class FieldServiceTest {

	@IsTest
	static void testGetFieldLableByApiNameBySobjectNameAndFieldAPIList_sObjectNameAndFieldAPIList_fieldLableByApiNameMap() {
		//Given
		final String sObjectVar = 'Account';
		final List<String> fieldAPINameList = new List<String> {
			'Name'
		};

		//When
		Map<String, String> fieldLableByApiName = FieldService.getFieldLableByApiNameBySobjectNameAndFieldAPIList(sObjectVar, fieldAPINameList);

		//Then
		final String accountNameFieldLabel = 'Account Name';
		System.assertEquals(accountNameFieldLabel, fieldLableByApiName.get(fieldAPINameList[0]));
	}

	@IsTest
	static void testStripApisWhichNotBlongsToObjectByObjectNameAndFieldAPINameList_sObjectNameAndFieldAPIList_stripedApiNameList() {
		//Given
		final String sObjectVar = 'Account';
		final List<String> fieldAPINameList = new List<String> {
			'Name',
			'Test'
		};

		//When
		List<String> fieldApiNameResultList = FieldService.stripApisWhichNotBlongsToObjectByObjectNameAndFieldAPINameList(sObjectVar, fieldAPINameList);

		//Then
		System.assertEquals(1, fieldApiNameResultList.size());
		System.assertEquals('Name', fieldApiNameResultList[0]);
	}

	@IsTest
	static void testGetFieldLableByApiNameBySobjectNameAndFieldAPIList_sObjectNameAsNullAndFieldAPIList_throwError() {
		//Given
		final String sObjectVar = null;
		final List<String> fieldAPINameList = new List<String> {
			'Name'
		};

		//When - Then
		try {
			Map<String, String> fieldLableByApiName = FieldService.getFieldLableByApiNameBySobjectNameAndFieldAPIList(sObjectVar, fieldAPINameList);
			System.assert(false, 'Exception Expected');
		}catch(Exception exp) {
			System.assertEquals(Label.SObject_Name_can_not_be_null_Error, exp.getMessage());  
		}
	}

	@IsTest
	static void testGetFieldLableByApiNameBySobjectNameAndFieldAPIList_sObjectNameAndFieldAPIListAsNull_throwError() {
		//Given
		final String sObjectVar = 'Account';
		final List<String> fieldAPINameList = null;

		//When - Then
		try {
			Map<String, String> fieldLableByApiName = FieldService.getFieldLableByApiNameBySobjectNameAndFieldAPIList(sObjectVar, fieldAPINameList);
			System.assert(false, 'Exception Expected');
		}catch(Exception exp) {
			System.assertEquals(Label.FieldApiNameList_can_not_be_null_or_empty_Error, exp.getMessage());
		}
	}
}