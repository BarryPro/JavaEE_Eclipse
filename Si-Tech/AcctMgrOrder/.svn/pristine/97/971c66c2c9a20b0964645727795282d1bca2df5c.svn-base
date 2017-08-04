package com.sitech.acctmgr.app.msgodrsend;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import javax.sql.DataSource;

import org.eclipse.jetty.util.log.Log;

import com.sitech.acctmgr.app.common.InterBusiConst;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.jcf.core.datasource.DataSourceHelper;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcf.ijdbc.SqlFind;
import com.sitech.jcf.ijdbc.util.DataSourceUtils;
import com.sitech.jcfx.context.JCFContext;

public class MsgCfgCache {

	/*缓存同步配置信息*/
	private static ConcurrentHashMap tabMsgCfgMap = null;

	static {
		System.out.print("-------get msgsend cfg--stt-----1\n");
		if (null == tabMsgCfgMap) {
			System.out.print("-------get msgsend cfg--stt-----2\n");
			tabMsgCfgMap = new ConcurrentHashMap();
			System.out.print("-------get msgsend cfg--stt-----3\n");
			getAllTabConfig(tabMsgCfgMap);
			if (null == tabMsgCfgMap)
				System.out.print("-------gettabconf end---tabsmap is null\n");
			System.out.print("-------get msgsend cfg--end-----4\n");
		}
	}

	public void settabMsgCfgMap(ConcurrentHashMap inCfgTable) {
		
		this.getAllTabConfig(inCfgTable);
		this.tabMsgCfgMap = inCfgTable;
	}
	
	/**
	 * Title 取得对应同步表的配置数据
	 * @param inTableName
	 * @return
	 */
	public static List<Map<String, Object>> getTabConfigData(String inTableName) {
		String sUpperName = inTableName.toUpperCase();
		return (List<Map<String, Object>>) tabMsgCfgMap.get(sUpperName);
	}
	
	/**
	 * Title 私有接口：获取所有表的配置放入静态Map变量
	 * Description 使用IBATIS缓存模式
	 * @param outCfgMap
	 */
	private static void getAllTabConfig(ConcurrentHashMap outTabMsgCfgMap) {
		
		String sSqlString = "";
		List<Map> listTabRst = null;

		/*取list中同步表对应的配置信息*/
		sSqlString = InterBusiConst.MSGSND_CFGSQL;
		Log.info("-----msgsend sql="+sSqlString);
		listTabRst = operJdbcSql(sSqlString);
		if (listTabRst == null)
			throw new BusiException(AcctMgrError.getErrorCode("0000","10032"),
					"msgsend查询缓存配置错误！sTabName="+InterBusiConst.MSGSND_TABNAME); 
		//放入静态Map缓存中
		outTabMsgCfgMap.put(InterBusiConst.MSGSND_TABNAME, listTabRst);
		Log.info("--------MSG SEND Cache------outTabMsgCfgMap="+outTabMsgCfgMap.toString());
		return ;
		
	}

	/**
	 * Title  执行Sql语句
	 * Description 执行拼装好的Sql语句，同步数据
	 * @param inSqlBuf
	 * @param inSqlChg
	 * @return
	 */
	public static List<Map> operJdbcSql(String inQrySql) {
		Connection conn = null;
		List<Map> list = new ArrayList<Map>();
		
		try {
			/*执行 inQrySql 查询配置*/
			JCFContext.junitInit();
			DataSource dataSrc = (DataSource) JCFContext.getBean("dataSourceB1");//db.xml中配置的数据源
			conn=DataSourceUtils.getConnection(dataSrc);
			conn.setAutoCommit(false);

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
	
}
