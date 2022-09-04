public class ListUtility {
	public static List<String> stripNulls(List<String> stringList) {
		List<String> stringListvar = new List<String>();
		if(stringList.isEmpty()) {
			return stringListvar;
		} else {
			for(String str : stringList) {
				if(String.isNotBlank(str)) {
					stringListvar.add(str);
				}
			}
			return stringListvar;
		}
	}
}