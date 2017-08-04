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

public class BusiOdrCfgCache {

	/*缓存同步配置信息*/
	private static ConcurrentHashMap busiOdrCfgMap = null;

	static {
		if (null == busiOdrCfgMap) {
			busiOdrCfgMap = new ConcurrentHashMap();
			//getAllTabConfig(busiOdrCfgMap);//使用硬解语句
			getAllCfg(busiOdrCfgMap);//使用动态绑定
			if (null == busiOdrCfgMap)
				System.out.print("-error-busiOdrCfgMap is null\n");
		}
	}

	public void setbusiOdrCfgMap(ConcurrentHashMap inCfgTable) {
		
		this.getAllTabConfig(inCfgTable);
		this.busiOdrCfgMap = inCfgTable;
	}
	
	/**
	 * Title 取得对应业务标识的配置数据
	 * @param inBusiCode
	 * @return
	 */
	public static Map<String, Object> getConfigMapByCode(String inBusiCode) {
		return (Map<String, Object>) busiOdrCfgMap.get(inBusiCode);
	}
	
	/**
	 * Title 私有接口：获取所有表的配置放入静态Map变量
	 * Description 使用IBATIS缓存模式
	 * @param outCfgMap
	 */
	private static void getAllTabConfig(ConcurrentHashMap outbusiOdrCfgMap) {
		
		String sSqlString = "";
		String sDistCode = "";
		List<Map<String, Object>> listBusiCode = null;
		List<Map<String, Object>> listTabRst = null;
		/*执行 inQrySql 查询配置*/
		JCFContext.junitInit();
		DataSource dataSrc = (DataSource) JCFContext.getBean("dataSourceB1");//db.xml中配置的数据源
		Connection conn=DataSourceUtils.getConnection(dataSrc);
		JdbcConn jdbc = new JdbcConn(conn);
		
		jdbc.setSqlBuffer(InterBusiConst.BUSIODR_DISTSQL);;
		listBusiCode = jdbc.select();
		for (Map<String, Object> tmpMap:listBusiCode) {
			listTabRst = null;
			
			sDistCode = tmpMap.get("BUSI_CODE").toString();
			
			/*取list中同步表In_Busiorder_Conf对应的配置信息*/
			//sSqlString = InterBusiConst.BUSIODR_CFGSQL+"'"+sDistCode+"'";
			//listTabRst = operJdbcSql(sSqlString, conn);
			jdbc.setSqlBuffer(InterBusiConst.BUSIODR_CFGSQL);//TRIG_FLAG=? and BUSI_CODE=?
			jdbc.addParam("TRIG_FLAG", "Y");
			jdbc.addParam("BUSI_CODE", sDistCode);
			listTabRst = jdbc.select();
			if (listTabRst == null)
				throw new BusiException(AcctMgrError.getErrorCode("0000","10032"),
						"busiodr查询缓存配置错误！"); 
			
			//放入静态Map缓存中
			for (Map<String, Object> tmp2Map:listTabRst) {
				if (tmp2Map.size() != 0) {
					outbusiOdrCfgMap.put(sDistCode, tmp2Map);
					break;
				}/*只有一层*/
			}
			
		}/*for end*/
			
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
		} finally{
			DataSourceHelper.closeConnection(conn);
		}
		
		return list;
	}
	
	/**
	 * Title 私有接口：获取所有表的配置放入静态Map变量
	 * Description 使用JdbcConn动态绑定接口
	 * @param outCfgMap
	 */
	private static void getAllCfg(ConcurrentHashMap outbusiOdrCfgMap) {
		
		String sSqlString = "";
		String sDistCode = "";
		List<Map<String, Object>> listBusiCode = null;
		List<Map<String, Object>> listTabRst = null;
		/*执行 inQrySql 查询配置*/
		JCFContext.junitInit();
		DataSource dataSrc = (DataSource) JCFContext.getBean("dataSourceB1");//db.xml中配置的数据源
		Connection conn=DataSourceUtils.getConnection(dataSrc);
		
		JdbcConn jdbcConn = new JdbcConn(conn);
		jdbcConn.setSqlBuffer(InterBusiConst.BUSIODR_DISTSQL);
		listBusiCode = jdbcConn.select();

		for (Map<String, Object> tmpMap:listBusiCode) {
			listTabRst = null;
			sDistCode = tmpMap.get("BUSI_CODE").toString();

			jdbcConn.setSqlBuffer(InterBusiConst.BUSIODR_CFGSQL);
			jdbcConn.addParam("TRIG_FLAG", "Y");
			jdbcConn.addParam("BUSI_CODE", sDistCode);
			listTabRst = jdbcConn.select();
			/*取list中同步表In_Busiorder_Conf对应的配置信息*/
			if (listTabRst == null)
				throw new BusiException(AcctMgrError.getErrorCode("0000","10032"),
						"busiodr查询缓存配置错误！"); 
			
			//放入静态Map缓存中
			for (Map<String, Object> tmp2Map:listTabRst) {
				if (tmp2Map.size() != 0) {
					outbusiOdrCfgMap.put(sDistCode, tmp2Map);
					break;
				}/*只有一层*/
			}
			
		}/*for end*/
			
		return ;
		
	}
	
}
