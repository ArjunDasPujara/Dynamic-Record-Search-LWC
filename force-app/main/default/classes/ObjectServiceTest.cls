@IsTest
private class ObjectServiceTest {

	@IsTest
	static void testGetObjectLableByApiNameMapByAPINameList_sObjectApiName_sObjectLableByApiNameMap() {
		// Given
		final List<String> sobjectApiNameList = new List<String> {
			'Account'
		};

		// When
		Map<String, String> resultSObjectLableByApiNameMap = ObjectService.getObjectLableByApiNameMapByAPINameList(sobjectApiNameList);
		
		//Then
		System.assertEquals(1, resultSObjectLableByApiNameMap.size());
		System.assertEquals('Account', resultSObjectLableByApiNameMap.get('Account'));
	}
}