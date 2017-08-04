package com.sitech.acctmgrint.atom.busi.intface.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgrint.common.BaseBusi;

public class DataSynDAO extends BaseBusi {
	
	/**
	 * 1.查询配置时，使用缓存，缓存没有则从数据库取
	 */
	
	/**
	 * @Description 根据action_id查询配置的表
	 * @param inMap
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, String>> qryTables(Map<String, Object> inMap){

		List<Map<String, String>> listRst = baseDao.queryForList("qryDataSyn_INT.qryTabsByActionId", inMap);
		return listRst;
	}
	
	/**
	 * @Description 根据action_id查询配置的表+操作类型
	 * @param inMap
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Map<String, String>> qryTableOptypesMap(Map<String, Object> inMap){
		
		String tableName = "";
		String updateType = "";
		Map<String, Map<String, String>> outMap = new HashMap<String, Map<String, String>>();
		
		List<Map<String, String>> listRst = baseDao.queryForList("qryDataSyn_INT.qryTabsByActionId", inMap);
		for (Map<String, String> tmpMap:listRst) {
			tableName = tmpMap.get("TABLE_NAME");
			updateType = tmpMap.get("UPDATE_TYPE");
			outMap.put(tableName+updateType, tmpMap);
		}
		return outMap;
	}
	
	/**
	 * @Description 根据action_id查询配置的字段
	 * @param inMap
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, String>> qryCols(Map<String, Object> inMap){
		
		return baseDao.queryForList("qryDataSyn_INT.qryColsByActionId", inMap);//in_tablecols_dict
	}

	/**
	 * @Description 根据action_id查询配置的字段
	 * @param inMap
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Map<String, String>> qryColsMap(Map<String, Object> inMap){
		
		Map<String, Map<String, String>> outMap = new HashMap<String, Map<String, String>>();
		List<Map<String, String>> listRst =  baseDao.queryForList("qryDataSyn_INT.qryColsByActionId", inMap);//in_tablecols_dict
		for (Map<String, String> tmpMap:listRst) {
			outMap.put(tmpMap.get("TABLE_NAME"), tmpMap);
		}
		return outMap;
	}

	
	/**
	 * @Description 根据action_id查询配置的索引字段
	 * @param inMap
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, String>> qryIdxs(Map<String, Object> inMap){
		
		return baseDao.queryForList("in_acttabrel_dict.qryIndexsByActId", inMap);
	}
	
	
	/**
	 * @Description 最终查询数据的方法
	 * @param inMap
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> qryByList(Map<String, Object> inMap){
		
		return baseDao.queryForList("qryDataSyn_INT.qryByList", inMap);
	}
	
}
