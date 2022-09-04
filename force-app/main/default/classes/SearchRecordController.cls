public with sharing class SearchRecordController {

	private static final integer QUERY_LIMIT_FOR_SEARCH = 200;
	
	@AuraEnabled
	public static List<SearchRecordController.Detail> getSearchableObjectList(){
		try {
			List<String> apiNameList = new List<String>();
			List<SearchRecordController.Detail> fieldDetailList = new List<SearchRecordController.Detail>();
			List<Dynamic_Record_Search_Config__c> dynamicRecordSearchConfigList = DynamicRecordSearchConfigSelector.getRecordsByUserId(UserInfo.getUserId());
			for(Dynamic_Record_Search_Config__c dynamicRecordSearchConfig : dynamicRecordSearchConfigList) {
				if(dynamicRecordSearchConfig.Object_API_Name__c != null) {
					apiNameList.add(dynamicRecordSearchConfig.Object_API_Name__c);
				}
			}
			Map<String, String> objectLableByApiNameMap = ObjectService.getObjectLableByApiNameMapByAPINameList(apiNameList);
			for(String apiName : objectLableByApiNameMap.keyset()) {
				fieldDetailList.add(
					new SearchRecordController.Detail(
						objectLableByApiNameMap.get(apiName),
						apiName
					)
				);
			}
			return fieldDetailList;
		} catch (Exception e) {
			throw new AuraHandledException(e.getMessage());
		}
	}

	@AuraEnabled
	public static List<SearchRecordController.Detail> getFieldListBySObjectApiName(String sobjectApiName){
		try {
			List<String> apiNameList;
			List<SearchRecordController.Detail> fieldDetailList = new List<SearchRecordController.Detail>();
			List<Dynamic_Record_Search_Config__c> dynamicRecordSearchConfigList = DynamicRecordSearchConfigSelector.getRecordsByUserIdAndObjectapiName(UserInfo.getUserId(), sobjectApiName);
			apiNameList = dynamicRecordSearchConfigList[0].Field_List__c.split(',');
			Map<String, String> fieldLabelByApiNameMap = FieldService.getFieldLableByApiNameBySobjectNameAndFieldAPIList(sobjectApiName, apiNameList);
			fieldLabelByApiNameMap.remove('Id');
			for(String apiName : fieldLabelByApiNameMap.keyset()) {
				fieldDetailList.add(
					new SearchRecordController.Detail(
						fieldLabelByApiNameMap.get(apiName),
						apiName
					)
				);
			}
			return fieldDetailList;
		} catch (Exception e) {
			throw new AuraHandledException(e.getMessage());
		}
	}

	@AuraEnabled
	public static List<SObject> selectBySearchTearmAndSearchField(
		String sobjectName,
		String searchTerm,
		String searchField,
		List<String> fieldList
	) {
		return SObjectSelector.selectBySearchTearmAndSearchField(
			sobjectName,
			searchTerm,
			searchField,
			fieldList,
			QUERY_LIMIT_FOR_SEARCH
		);
	}

	public class Detail {

		public Detail(String label, String value) {
			this.label = label;
			this.value = value;
		}

		@AuraEnabled
		public String label {get; set;}

		@AuraEnabled
		public String value {get; set;}
	}
}