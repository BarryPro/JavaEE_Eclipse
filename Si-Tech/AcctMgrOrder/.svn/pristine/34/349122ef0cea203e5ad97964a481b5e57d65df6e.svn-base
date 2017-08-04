package com.sitech.acctmgr.app.dataorder.splicesql;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.sitech.jcf.ijdbc.SqlChange;

public interface ISpliceSql {
	/**
	 * insert语句处理
	 * @param inDataMap
	 * @param inLstDest
	 * @return
	 */
	public Map<String, Object>  spliceInsertSql(Map<String, Object> inDataMap, List<Map<String, Object>> inLstDest);

	/**
	 * update语句处理，暂废弃
	 * @param inDataMap
	 * @param inLstDest
	 * @return
	 */
	public Map<String, Object>  spliceUpdateSql(Map<String, Object> inDataMap, List<Map<String, Object>> inLstDest);
	/**
	 * Delete语句处理，暂废弃
	 * @param inDataMap
	 * @param inLstDest
	 * @return
	 */
	public Map<String, Object>  spliceDeleteSql(Map<String, Object> inDataMap, List<Map<String, Object>> inLstDest);
	/**
	 * update语句处理，暂废弃
	 * @param inDataMap
	 * @param inLstDest
	 * @return
	 */
	public Map<String, Object> spliceSpecialSql(Map<String, Object> inDataMap, List<Map<String, Object>> inLstDest);
	
	/**
	 * delete/update语句处理
	 * @param inDataMap
	 * @param inLstDest
	 * @param conn
	 * @return
	 */
	public Map<String, Object> spliceInstSqlToChg(Map<String, Object> inDataMap, List<Map<String, Object>> inLstDest, Connection conn);
}
