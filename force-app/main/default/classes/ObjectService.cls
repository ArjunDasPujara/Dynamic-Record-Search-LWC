public with sharing class ObjectService {

	public static Map<String, String> getObjectLableByApiNameMapByAPINameList(List<String> apiNameList) {
		Map<String, String> objectLableByApiNameMap = new Map<String, String>();
		Map<String, Schema.SObjectType> globalDescribe = Schema.getGlobalDescribe();
		for(String apiName : apiNameList) {
			Schema.SObjectType sobjectType = globalDescribe.get(apiName);
			if(sobjectType != null) {
				Schema.DescribeSObjectResult describeSObjectResult = SObjectType.getDescribe();
				if(describeSObjectResult.isAccessible())
					objectLableByApiNameMap.put(String.valueOf(sobjectType) , describeSObjectResult.getLabel());
			}
		}
		return objectLableByApiNameMap;
	}
}