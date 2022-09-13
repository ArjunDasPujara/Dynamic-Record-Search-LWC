public with sharing class FieldService {

	public static Map<String, String> getFieldLableByApiNamWithStripedApisWhichNotBlongsToObjectAndNotAccessibleToUserByObjectNameAndFieldAPINameList(String sObjectName, List<String> fieldApiNameList) {
		Map<String, String> fieldLabelByApiNameMap = new Map<String, String>();
		if(String.isBlank(sObjectName)) {
			throw new IllegalArgumentException(Label.SObject_Name_can_not_be_null_Error);
		} else if(fieldApiNameList == null || fieldApiNameList.isEmpty()) {
			throw new IllegalArgumentException(Label.FieldApiNameList_can_not_be_null_or_empty_Error);
		} else {
			List<String> stripedFieldApiNameList = (List<String>)ListUtility.stripNulls(fieldApiNameList);
			Map<String, String> apiNameByApiNameInCapLetter = new Map<String, String>();
			Schema.SObjectType sObjectType = Schema.getGlobalDescribe().get(sObjectName);
			Map<String, Schema.SObjectField> sObjectFieldByFieldApiNameMap = sObjectType.getDescribe().fields.getMap();

			for(String fieldApiName : sObjectFieldByFieldApiNameMap.keySet()) {
				apiNameByApiNameInCapLetter.put(
					fieldApiName.toUpperCase(),
					String.valueof(sObjectFieldByFieldApiNameMap.get(fieldApiName)
				));
			}

			for(String fieldApiName : stripedFieldApiNameList) {
				String sObjectFieldAPIName = apiNameByApiNameInCapLetter.get(fieldApiName.toUpperCase());
				if(sObjectFieldAPIName != null) {
					Schema.SObjectField SObjectField = sObjectFieldByFieldApiNameMap.get(sObjectFieldAPIName);
					Schema.DescribeFieldResult describeFieldResult = SObjectField.getDescribe();
					if(describeFieldResult.isAccessible() && describeFieldResult.isFilterable()) {
						fieldLabelByApiNameMap.put(sObjectFieldAPIName, describeFieldResult.getLabel());
					}
				}
			}
		}
		return fieldLabelByApiNameMap;
	}
}