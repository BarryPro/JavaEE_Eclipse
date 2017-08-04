package com.sitech.acctmgr.app.dataorder.configcache;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.sql.DataSource;

import org.eclipse.jetty.util.log.Log;

import com.sitech.acctmgr.app.common.InterBusiConst;
import com.sitech.acctmgr.app.common.JdbcConn;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.BaseBusi;
import com.sitech.jcf.core.dao.BaseDao;
import com.sitech.jcf.core.datasource.DataSourceHelper;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcf.ijdbc.SqlFind;
import com.sitech.jcf.ijdbc.util.DataSourceUtils;
import com.sitech.jcfx.context.JCFContext;

public class DataBaseCache extends BaseBusi {

	/*缓存数据工单同步配置信息*/
	private static ConcurrentHashMap tabsConfigMap = null;
	/*20151106 缓存跨库同步配置*/
	private static ConcurrentHashMap tabsBothSyncMap = null;

	static {
		if (null == tabsConfigMap || null == tabsBothSyncMap) {
			tabsConfigMap = new ConcurrentHashMap();
			tabsBothSyncMap =  new ConcurrentHashMap();
			getAllTabConfig(tabsConfigMap, tabsBothSyncMap);
			if (null == tabsConfigMap)
				System.out.print("-------gettabconf end---tabsmap is null\n");
		}
	}

	public void setTabsConfigMap(ConcurrentHashMap inCfgTable) {
		DataBaseCache.tabsConfigMap = inCfgTable;
	}

	public static void setTabsBothSyncMap(ConcurrentHashMap tabsBothSyncMap) {
		DataBaseCache.tabsBothSyncMap = tabsBothSyncMap;
	}


	/**
	 * Title 取得对应同步表的配置数据
	 * @param inTableName
	 * @return
	 */
	public static List<Map<String, Object>> getTabConfigData(String inTableName) {
		String sUpperName = inTableName.toUpperCase();
		return (List<Map<String, Object>>) tabsConfigMap.get(sUpperName);
	}
	
	/**
	 * Title 取得跨库配置表的配置数据
	 * @param inTableName
	 * @return
	 */
	public static Map<String, Object> getBothSyncFlag(String inTableName) {
		String sUpperName = inTableName.toUpperCase();
		Map<String, Object> out_chg_map = (Map<String, Object>) tabsBothSyncMap.get(sUpperName);
		return out_chg_map;
	}
	
	/**
	 * Title 私有接口：获取所有表的配置放入静态Map变量
	 * Description 使用IBATIS缓存模式
	 * @param outCfgMap
	 */
	@SuppressWarnings("unchecked")
	private static void getAllTabConfig(ConcurrentHashMap outTabsConfigMap,ConcurrentHashMap out_both_sync_map) {
		
		String sTabName = "";
		List<Map<String, Object>> listTabRst = null;
		Log.debug("------------GETALLTABCFG---stt-----");

		JCFContext.junitInit();
		DataSource dataSrc = (DataSource) JCFContext.getBean("dataSourceB1");//db.xml中配置的数据源
		Connection conn = DataSourceUtils.getConnection(dataSrc);
		//JdbcConn动态配置语句
		JdbcConn jdbc = new JdbcConn(conn);
		
		//取得全部的配置表名
		List<Map<String, Object>> listTabs = new ArrayList<Map<String, Object>>();
		jdbc.setSqlBuffer(InterBusiConst.DATAODR_DISTTAB);
		listTabs = jdbc.select();
		if (listTabs == null)
			throw new BusiException(AcctMgrError.getErrorCode("0000","10031"), "数据同步查询缓存配置错误！");

		for (Map<String, Object> tmpMap : listTabs) {
			/*取list中同步表对应的配置信息*/
			sTabName = tmpMap.get("SOURCE_TABLE").toString();
			//动态语句拼接
			jdbc.setSqlBuffer(InterBusiConst.DATAODR_DESTTAB);
			jdbc.addParam("SOURCE_TABLE", sTabName);
			listTabRst = jdbc.select();
			if (listTabRst == null)
				throw new BusiException(AcctMgrError.getErrorCode("0000","10032"),
						"cbSYNC查询缓存配置错误！sTabName="+sTabName); 
			//放入静态Map缓存中
			outTabsConfigMap.put(sTabName, listTabRst);
			
			//取跨库配置 20151106
			jdbc.setSqlBuffer(InterBusiConst.DATAODR_BOTHSYNC);
			jdbc.addParam("SOURCE_TABLE", sTabName);
			listTabRst = jdbc.select();
			//String result_sync = new String();
			Map<String, Object> chg_map = new HashMap<String, Object>();
			if (listTabRst == null || listTabRst.size() == 0) {
				//result_sync = "N";
				chg_map.put("SYNC_FLAG", "N");
				chg_map.put("CHG_BOTH_FLAG", "N");
			} else {
				if (null != listTabRst.get(0))
					//result_sync = listTabRst.get(0).get("SYNC_FLAG").toString();
					chg_map.putAll(listTabRst.get(0));
			}
			out_both_sync_map.put(sTabName, chg_map);
		}
		
		closeConn(conn);
		return ;
		
	}
	
	private static void closeConn(Connection conn) {
		try {
			if (!conn.isClosed())
				System.out.println("--DATASYN--closeconnection-----");
				DataSourceHelper.closeConnection(conn);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	

	/**
	 * Title  执行Sql语句
	 * Description 执行拼装好的Sql语句，同步数据
	 * @param inSqlBuf
	 * @param inSqlChg
	 * @return
	 */
	public static List<Map> operJdbcSql(String inQrySql, Connection conn) {
		//Connection conn = null;
		List<Map> list = new ArrayList<Map>();
		
		try {
			/*执行 inQrySql 查询配置*/
//			JCFContext.junitInit();
//			DataSource dataSrc = (DataSource) JCFContext.getBean("dataSourceB1");//db.xml中配置的数据源
//			conn=DataSourceUtils.getConnection(dataSrc);
//			conn.setAutoCommit(false);

			SqlFind sqlFind = new SqlFind();
			sqlFind.setListElementAsMap(true);
			list = sqlFind.findList(conn, inQrySql);
			
		} catch(Exception e){
			DataSourceHelper.rollback(conn);
			
			e.printStackTrace();
		}
		
		return list;
	}
	
}
