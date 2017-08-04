package com.sitech.acctmgrint.atom.busi.intface.sqldeal;

import java.util.List;
import java.util.Map;

public interface ISqlDeal {
	
	public String predealSqlStatement(String inPreSql, Map<String, Object> inSqlMap, Map<String, Object> inData);
	public Map<String, Object> getDBdataValue(Map<String, Object> inParamExpMap, Map<String, Object> inSqlMap,
			 Map<String, Object> inDataMap);//Map<String, Object> outDBdataMap,
	public String getDataValueBySourceId(Map<String, Object> inData, String sInDataSourceId, Map<String, Object> inSqlMap);
	public List<Map<String, Object>> getSvcAttrBySvcIdAndActionId(Map<String, Object> inDataMap, 
			Map<String, Object> inSqlMap,  Map<String, Object> inPubData);
			
	public Map<String, Object> getOtherNodeParam(Map<String, Object> inDataMap, 
			Map<String, Object> inSqlMap,  Map<String, Object> inPubData);
	
	
}
