package com.sitech.acctmgr.app.busiorder.cachecfg;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.sql.DataSource;

import org.eclipse.jetty.util.log.Log;

import com.sitech.acctmgr.app.common.InterBusiConst;
import com.sitech.acctmgr.app.common.JdbcConn;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.jcf.core.datasource.DataSourceHelper;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcf.ijdbc.SqlFind;
import com.sitech.jcf.ijdbc.util.DataSourceUtils;
import com.sitech.jcfx.context.JCFContext;

public class BusiKeyCache {

	/*缓存同步配置信息*/
	private static ConcurrentHashMap busiKeyCache = null;

	static {
		if (null == busiKeyCache) {
			busiKeyCache = new ConcurrentHashMap();
			getAllKeysCache(busiKeyCache);
		}
	}

	public void setBusiKeyCache(ConcurrentHashMap inCfgTable) {
		
		this.getAllKeysCache(inCfgTable);
		this.busiKeyCache = inCfgTable;
	}
	
	/**
	 * Title 取得对应业务标识的配置数据
	 * @param inBusiCode
	 * @return
	 */
	public static List<Map<String, Object>> getKeys(String inBusiCode) {
		return (List<Map<String, Object>>) busiKeyCache.get(inBusiCode);
	}
	
	/**
	 * Title 私有接口：获取所有表的配置放入静态Map变量
	 * Description 使用IBATIS缓存模式
	 * @param outCfgMap
	 */
	private static void getAllKeysCache(ConcurrentHashMap outBusiKeyCache) {
		
		String sSqlString = "";
		String sDistCode = "";
		List<Map<String, Object>> listTabDist = null;
		List<Map<String, Object>> listTabRst = null;
		
		/*执行 inQrySql 查询配置*/
		JCFContext.junitInit();
		DataSource dataSrc = (DataSource) JCFContext.getBean("dataSourceB1");//db.xml中配置的数据源
		Connection conn=DataSourceUtils.getConnection(dataSrc);
		JdbcConn jdbc = new JdbcConn(conn);
		
		jdbc.setSqlBuffer(InterBusiConst.BUSIKEY_DISTSQL);//EFF_FLAG='Y'
		jdbc.addParam("EFF_FLAG", "Y");
		listTabDist = jdbc.select();
		for (Map<String, Object> tmpMap : listTabDist) {
			listTabRst = null;
			sDistCode = tmpMap.get("BUSI_CODE").toString();
			
			/*取list中同步表In_BusiKey_Dict对应的配置信息*/
			jdbc.setSqlBuffer(InterBusiConst.BUSIKEY_CFGSQL);//BUSI_CODE = ? AND EFF_FLAG  = 'Y'
			jdbc.addParam("BUSI_CODE", sDistCode);
			jdbc.addParam("EFF_FLAG", "Y");
			
			listTabRst = jdbc.select();
			if (listTabRst == null || listTabRst.isEmpty())
				throw new BusiException(AcctMgrError.getErrorCode("0000","74032"),
						"busiodr查询缓存配置错误！"); 
			
			//放入静态Map缓存中
			outBusiKeyCache.put(sDistCode, listTabRst);
			
		}/*for end*/
		DataSourceHelper.closeConnection(conn);
		return ;
		
	}

	/**
	 * Title  执行Sql语句
	 * Description 执行拼装好的Sql语句，同步数据
	 * @param inQrySql
	 * @return
	 */
	public static List<Map> operJdbcSql(String inQrySql, Connection conn) {
		List<Map> list = new ArrayList<Map>();		
		try {

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
