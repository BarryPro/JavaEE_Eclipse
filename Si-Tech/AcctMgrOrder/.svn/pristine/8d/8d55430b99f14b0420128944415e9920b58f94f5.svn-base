package com.sitech.acctmgr.app.dataorder;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Map;

import javax.sql.DataSource;

import com.sitech.acctmgr.app.common.InterBusiConst;
import com.sitech.acctmgr.app.common.JdbcConn;
import com.sitech.jcf.context.LocalContextFactory;
import com.sitech.jcf.core.SessionContext;
import com.sitech.jcf.core.util.XMLFileContext;
import com.sitech.jcf.ijdbc.sql.SqlTypes;
import com.sitech.jcfx.dt.MBean;

public class DataFileErrMain {
	
	/**
	 * 名称:数据异常工单处理
	 * 使用:./DataErrMain 文件名
	 *     ./DataErrMain path_file
	 * 日期:2015/09/19
	 */
	public static void main(String[] args) {
		
		System.err.println("args.length="+args.length+"  "+args[0]);
		if (args.length < 3) {
			System.err.println("|------------------------------------------|");
			System.err.println("|使用:./BusiFileErrMain db_id ./path_file 跨库标识（Y:跨 N:单库同步）");
			System.err.println("|使用:./BusiFileErrMain db_id ./path_file N");
			System.err.println("|使用:./BusiFileErrMain db_id ./path_file Y");
			System.err.println("|------------------------------------------|");
			return ;
		}
		String in_db_id = args[0];
		String path_name = args[1];
		String both_flag = args[2];
		if (-1 == "YN".indexOf(both_flag)) {
			System.err.println("|跨库标识（Y:跨 N:单库同步）,传入错值:["+both_flag+"],返回！！！");
			return ;
		}
		
		// 添加spring的配置文件
		XMLFileContext.addXMLFile("applicationContext.xml");
		// 加载spring容器
		XMLFileContext.loadXMLFile();
		
		IDataOrder iDataOrder = LocalContextFactory.getInstance().getBean("DataOrderSvc", IDataOrder.class);

		
		Connection conn = null;
		try {
			conn = ((DataSource)LocalContextFactory.getInstance()
					.getBean("dataSource"+in_db_id, DataSource.class)).getConnection();
		} catch (SQLException e1) {e1.printStackTrace();}
		JdbcConn jc = new JdbcConn(conn);
		
		File file = null;
		try {
			file = new File(path_name);
		} catch (Exception e) {
			System.err.println("打开文件失败!!!文件名:["+file+"]");
		}
		BufferedReader reader = null;
		try {
			System.out.println("以行为单位，每次读取一行:");
			FileReader fr = null;
			fr = new FileReader(file);
			reader = new BufferedReader(fr);
			int line = 1;
			String tmp_str = null;
			String create_accpet = "";
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
				line ++;

				MBean mb = null;
				try {
					mb = new MBean(content);
					//设置A,B库
					String db_id = mb.getHeaderStr(InterBusiConst.DATAODR_DBID);
					if (null != db_id
							|| null != mb.getHeaderStr("ROUTING.ROUTE_KEY")) {
						if (null == db_id
								&& null != mb.getHeaderStr("ROUTING.ROUTE_KEY")) {
							Map<String, Object> db_map = getDbIdInfo(conn, (Map<String, Object>)mb.getHeader().get("ROUTING"));
							db_id = db_map.get("DB_CODE").toString();
							mb.setDbId(db_id);
						}
					}
					SessionContext.setDbLabel(db_id);

					if (iDataOrder.errOrderSyn(mb, both_flag) == false)
						System.out.println("-------返回False 报错！已计入历史。------");
					else {
						if (jc == null) {
							conn = ((DataSource)LocalContextFactory.getInstance()
									.getBean("dataSource"+in_db_id, DataSource.class)).getConnection();
							jc = new JdbcConn(conn);
						}
						int ret = delRcvErr(create_accpet, jc);
						System.out.println("处理成功，create_accept:["+create_accpet+"],删除错误表 ["+ret+"] 条！！！继续下一条...");
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			reader.close();

			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static int delRcvErr(String create_accpet, JdbcConn jdbc) {
		jdbc.setSqlBuffer("delete from in_msgrcv_err where CREATE_ACCEPT = ?");
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
