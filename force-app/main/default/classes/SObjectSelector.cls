public with sharing class SObjectSelector {

	public static List<SObject> selectBySearchTearmAndSearchField(
		String sobjectName,
		String searchTerm,
		String searchField,
		List<String> fieldList
	) {
		return selectBySearchTearmAndSearchField(
			sobjectName,
			searchTerm,
			searchField,
			fieldList,
			50000
		);
	}

	public static List<SObject> selectBySearchTearmAndSearchField(
		String sobjectName,
		String searchTerm,
		String searchField,
		List<String> fieldList,
		Integer qureyLimit
	) {
		if(qureyLimit == null | qureyLimit < 1 | qureyLimit > 50000) {
			throw new CustomException(Label.Query_Limit_Error);
		} else if(String.isBlank(searchField) && String.isNotBlank(searchTerm)) {
			throw new IllegalArgumentException(Label.SearchField_can_not_be_null_Error);
		} else if(String.isBlank(sobjectName)) {
			return new List<SObject>();
		} else {
			String allFieldForQuery;
			String finalQuery;
			String qureyEnd = ' FROM ' + sobjectName;
			String queryLimit = ' LIMIT ' + qureyLimit;
			String qureyStart = 'SELECT Id, ';
			String whereClause;

			Map<String, String> fieldLabelByApiNameMap = FieldService.getFieldLableByApiNameBySobjectNameAndFieldAPIList(sobjectName, fieldList);
			if(String.isNotBlank(searchField) & fieldLabelByApiNameMap.get(searchField) == null) {
				throw new CustomException(Label.Search_field_not_belongs_to_object_Error);
			} else {
				whereClause = ' WHERE ' + searchField + ' like ' +  '\'%' + searchTerm + '%\'';
			}

			allFieldForQuery = String.join(new List<String>(fieldLabelByApiNameMap.keySet()), ',');
			if(String.isBlank(searchTerm)) {
				finalQuery = qureyStart + allFieldForQuery + qureyEnd + queryLimit;
			} else {
				finalQuery = qureyStart + allFieldForQuery + qureyEnd + whereClause + queryLimit;
			}
			
			List<SObject> dataList = Database.query(finalQuery);
			return dataList;
		}
	}
}