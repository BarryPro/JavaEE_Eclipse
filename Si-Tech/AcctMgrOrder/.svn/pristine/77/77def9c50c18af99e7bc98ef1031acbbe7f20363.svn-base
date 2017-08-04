package com.sitech.acctmgr.app.busiorder;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.sql.DataSource;

import com.sitech.acctmgr.app.common.InterBusiConst;
import com.sitech.acctmgr.app.common.JdbcConn;
import com.sitech.jcf.context.LocalContextFactory;
import com.sitech.jcf.core.SessionContext;
import com.sitech.jcf.core.dao.BaseDao;
import com.sitech.jcf.core.util.XMLFileContext;
import com.sitech.jcf.ijdbc.sql.SqlTypes;
import com.sitech.jcfx.dt.MBean;

public class BusiFileErrMain {
	
	/**
	 * 名称:业务异常工单处理
	 * 使用:./BusiErrMain 0 create_accept 对指定流水的工单重发 
	 *     ./BusiErrMain 1 0  提所有err_code=0000的工单，重发
	 * 日期:2015/09/05
	 */
	public static void main(String[] args) {
		
		System.err.println("args.length="+args.length+"  "+args[0]);
		if (args.length < 2) {
			System.err.println("|------------------------------------------|");
			System.err.println("|使用:./BusiFileErrMain A1/B1 ./path_file");
			System.err.println("|使用:./BusiFileErrMain A1/B1 ./path_file");
			System.err.println("|注意：第一列流水使用CREATE_ACCEPT,否则删除错单失败！！！");
			System.err.println("|------------------------------------------|");
			return ;
		}
		String in_db_id = args[0];
		String path_name = args[1];
		
		
		// 添加spring的配置文件
		XMLFileContext.addXMLFile("applicationContext.xml");
		// 加载spring容器
		XMLFileContext.loadXMLFile();		
		
		IBusiOrderSyn iBusiOrderSyn = LocalContextFactory.getInstance().getBean("BusiOrderSynSvc", IBusiOrderSyn.class);
		Connection conn = null;
		try {
			conn = ((DataSource)LocalContextFactory.getInstance()
					.getBean("dataSource"+in_db_id, DataSource.class)).getConnection();
		} catch (SQLException e1) {e1.printStackTrace();}
		
		File file = null;
		try {
			file = new File(path_name);
		} catch (Exception e) {
			System.err.println("打开文件失败!!!文件名:["+file+"]");
		}
		BufferedReader reader = null;
		MBean mb = null;
		JdbcConn jc = null;
		String create_accpet = "";
		try {
			System.out.println("以行为单位，每次读取一行:");
			FileReader fr = null;
			fr = new FileReader(file);
			reader = new BufferedReader(fr);
			int line = 1;
			String tmp_str = null;
			String content = "";
			while ((tmp_str = reader.readLine()) != null) {
				if (tmp_str.trim().equals("")) {
					System.out.println("第 "+line+" 行数据:"+tmp_str+"为空，忽略...");
					continue;
				}
				System.out.println("处理第 "+line+" 行，内容:"+tmp_str);
				
				String[] arr = tmp_str.split("\t");
				if (1 < arr.length) {
					create_accpet = arr[0];
					content = arr[1];
				} else if (1 == arr.length) {
					content = arr[0];
					create_accpet = "";
				}
				mb = new MBean(content);
				
				line ++;
				String busi_code = iBusiOrderSyn.getBusiCode(mb);
				try {
					
					String db_id = mb.getHeaderStr(InterBusiConst.DATAODR_DBID);
					if ((null != db_id && !db_id.equals("") && !db_id.equalsIgnoreCase("null"))
							|| null != mb.getHeaderStr("ROUTING.ROUTE_KEY")) {
						if ((null == db_id || db_id.equals("") || db_id.equalsIgnoreCase("null"))
								&& null != mb.getHeaderStr("ROUTING.ROUTE_KEY")) {
							Map<String, Object> db_map = getDbIdInfo(conn, (Map<String, Object>)mb.getHeader().get("ROUTING"));
							db_id = db_map.get("DB_CODE").toString();
							mb.setDbId(db_id);
						}
						
						SessionContext.setDbLabel(db_id);
						if (iBusiOrderSyn.dealBusiOrderData(content, busi_code, "")) {
							if ("".equals(create_accpet)) {
								System.out.println("处理成功，但是未传入create_accept(每行第一列，分隔符:'	'), 因此未删除错误表！！！继续下一条...");
							} else {
								if (jc == null) {
									conn = ((DataSource)LocalContextFactory.getInstance()
											.getBean("dataSource"+in_db_id, DataSource.class)).getConnection();
									jc = new JdbcConn(conn);
								}
								int ret = delRcvErr(create_accpet, jc);
								System.out.println("处理成功，create_accept:["+create_accpet+"],删除错误表 ["+ret+"] 条！！！继续下一条...");
							}
							
						} else {
							System.err.println("处理失败，继续处理下一条...");
						}
					} else {
						System.err.println("DB_ID and ROUTING is null,continue处理下一条...");
					}
				} catch (Exception e) {
					if (!"".equals(create_accpet)) {
						if (jc == null) {
							conn = ((DataSource)LocalContextFactory.getInstance()
									.getBean("dataSource"+mb.getHeaderStr(InterBusiConst.DATAODR_DBID), DataSource.class)).getConnection();
							jc = new JdbcConn(conn);
						}
						int ret = dealErrCode(create_accpet, jc);
						System.out.println("处理异常，置ERR_CODE=4444,ret="+ret+",create_accept:["+create_accpet+"],继续下一条...");
					}
					e.printStackTrace();
				}
			}
			reader.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static int delRcvErr(String create_accpet, JdbcConn jdbc) {
		jdbc.setSqlBuffer("delete from in_msgrcv_err where CREATE_ACCEPT = ?");
		jdbc.addParam("CREATE_ACCPET", SqlTypes.JSTRING, create_accpet);
		return jdbc.execAndComm();
	}
	public static int dealErrCode(String create_accpet, JdbcConn jdbc) {
		jdbc.setSqlBuffer("update in_msgrcv_err set ERR_CODE= '4444' where CREATE_ACCEPT = ?");
		jdbc.addParam("CREATE_ACCPET", SqlTypes.JSTRING, create_accpet);
		return jdbc.execAndComm();
	}
	public static Map<String, Object> getDbIdInfo(Connection conn, Map<String, Object> route_map) {
		//没传取ROUTE_KEY ROUTE_VALUE
		JdbcConn jdbc = new JdbcConn(conn);
		String route_key = route_map.get("ROUTE_KEY").toString();
		String route_val = route_map.get("ROUTE_VALUE").toString();
		//没有ROUTE信息则插入错表
		if (null == route_val || route_val.equals("")) {
			System.out.println("DB_ID and ROUTE key's Value is NULL, Please Check.mInParam="+route_map.toString());
			return null;
		}
		
		String sql_head = "SELECT decode(REGION_CODE, '2201','A', '2207','A', '2208','A', 'B')||PORT_CODE DB_CODE, " +
						"decode(REGION_CODE, '2201','B', '2207','B', '2208','B', 'A')||PORT_CODE       DB_RE_CODE " +
						"FROM RS_NOHLR_REL WHERE "; 
		String sql_tail = "";
		String tail_val = "";
		if (route_key.equals("10")) {
			tail_val = route_val.substring(0, 7);
			sql_tail = "PHONE_HEAD";
		}
		else if (route_key.equals("11") || route_key.equals("12") || route_key.equals("15")) {
			tail_val = route_val.substring(0, 4);
			sql_tail = "REGION_CODE";
		}
		jdbc.setSqlBuffer(sql_head + sql_tail + " = ? and rownum < 2");
		jdbc.addParam(sql_tail, tail_val);
		Map<String, Object> db_map = jdbc.select().get(0);
		if (null != db_map) {
			return db_map;
		}
		
		return null;
	}
}
