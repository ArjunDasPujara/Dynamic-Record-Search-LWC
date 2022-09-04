@IsTest
private class ListUtilityTest {

	@IsTest
	static void testStripNulls_listWithNullData_returnListWithoutNullData() {
		// Given
		final List<String> fieldNameList = new List<String> {
			'Name',
			null
		};

		// When
		List<String> resultFieldNameList = ListUtility.stripNulls(fieldNameList);

		// Then
		System.assertEquals(1, resultFieldNameList.size());
		System.assertEquals(fieldNameList[0], resultFieldNameList[0]);
	}

	@IsTest
	static void testStripNulls_emptyLsit_returnEmptyList() {
		// Given
		final List<String> fieldNameList = new List<String>();

		// When
		List<String> resultFieldNameList = ListUtility.stripNulls(fieldNameList);

		// Then
		System.assertEquals(0, resultFieldNameList.size());
	}
}