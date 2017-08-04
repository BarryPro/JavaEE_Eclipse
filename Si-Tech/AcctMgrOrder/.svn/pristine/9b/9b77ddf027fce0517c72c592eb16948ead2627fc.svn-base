package com.sitech.acctmgr.app.test;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.sql.DataSource;

import com.sitech.acctmgr.app.common.InterBusiConst;
import com.sitech.acctmgr.app.common.JdbcConn;
import com.sitech.jcf.context.LocalContextFactory;
import com.sitech.jcf.core.util.XMLFileContext;
import com.sitech.jcf.ijdbc.SqlChange;
import com.sitech.jcf.ijdbc.sql.SqlParameter;
import com.sitech.jcf.ijdbc.sql.SqlTypes;

public class TestJdbcSqlChg {
	
	   public static void inputErrAndDel(Map<String, Object> indatamap, Connection conn) throws SQLException {
	        SqlChange sqlChg = new SqlChange();
	        StringBuffer buffer = new StringBuffer(InterBusiConst.MSGSND_INSTERR);
	        

	        //注意顺序 #ERR_MSG# ,#ERR_CODE# FROM ... TOPIC_ID=#TOPIC_ID# AND CREATE_ACCEPT=#CREATE_ACCEPT#"
	        sqlChg.addParam(new SqlParameter("ERR_MSG", SqlTypes.VARCHAR, indatamap.get("ERR_MSG").toString()));
	        sqlChg.addParam(new SqlParameter("ERR_CODE", SqlTypes.VARCHAR, indatamap.get("ERR_CODE").toString()));
	        sqlChg.addParam(new SqlParameter("TOPIC_ID", SqlTypes.VARCHAR, indatamap.get("TOPIC_ID").toString()));
	        sqlChg.addParam(new SqlParameter("CREATE_ACCEPT", SqlTypes.NUMERIC, indatamap.get("CREATE_ACCEPT")));
	        try {
	            int i = sqlChg.execute(conn, buffer.toString());
	            System.out.println("插入完成:"+i);
			} catch (Exception e) {
				System.out.println("插入错误表失败,继续删除正表数据！！！该条数据信息:"+indatamap.toString());
				
				System.out.println("插入错误表失败,报错信息："+e.toString());
				StackTraceElement[] error = e.getStackTrace();
	            for (StackTraceElement stackTraceElement : error){
	                System.out.println(stackTraceElement.toString());
	            }
			}
	        sqlChg.reset();
	        //执行删除INFO正表操作
	        StringBuffer buffer1 = new StringBuffer(InterBusiConst.MSGSND_DELETE);
	        sqlChg.addParam(new SqlParameter("TOPIC_ID", SqlTypes.VARCHAR, indatamap.get("TOPIC_ID").toString()));
	        sqlChg.addParam(new SqlParameter("CREATE_ACCEPT", SqlTypes.NUMERIC, indatamap.get("CREATE_ACCEPT")));
	        try {
	            int i = sqlChg.execute(conn, buffer1.toString());
	            System.out.println("删除完成:"+i);
			} catch (Exception e) {
				System.out.println("删除正表失败,报错信息："+e.toString());
				StackTraceElement[] error = e.getStackTrace();
	            for (StackTraceElement stackTraceElement : error){
	                System.out.println(stackTraceElement.toString());
	            }
			}

	    }
	   
	   public static void inputErrAndDelByJdbcConn(Map<String, Object> indatamap, Connection conn) throws SQLException {
	       JdbcConn jdbc = new JdbcConn(conn);
	       jdbc.setSqlBuffer(InterBusiConst.MSGSND_INSTERR);

	        //注意顺序 #ERR_MSG# ,#ERR_CODE# FROM ... TOPIC_ID=#TOPIC_ID# AND CREATE_ACCEPT=#CREATE_ACCEPT#"
	       jdbc.addParam("ERR_MSG", SqlTypes.VARCHAR, indatamap.get("ERR_MSG").toString());
	       jdbc.addParam("ERR_CODE", SqlTypes.VARCHAR, indatamap.get("ERR_CODE").toString());
	       jdbc.addParam("TOPIC_ID", SqlTypes.VARCHAR, indatamap.get("TOPIC_ID").toString());
	       jdbc.addParam("CREATE_ACCEPT", SqlTypes.NUMERIC, indatamap.get("CREATE_ACCEPT"));
	        try {
	            int i = jdbc.execuse();
	            System.out.println("JdbcConn插入完成:"+i);
			} catch (Exception e) {
				System.out.println("插入错误表失败,继续删除正表数据！！！该条数据信息:"+indatamap.toString());
				
				System.out.println("插入错误表失败,报错信息："+e.toString());
				StackTraceElement[] error = e.getStackTrace();
	            for (StackTraceElement stackTraceElement : error){
	                System.out.println(stackTraceElement.toString());
	            }
			}

	        //执行删除INFO正表操作
	        jdbc.setSqlBuffer(InterBusiConst.MSGSND_DELETE);
	        jdbc.addParam("TOPIC_ID", SqlTypes.VARCHAR, indatamap.get("TOPIC_ID").toString());
	        jdbc.addParam("CREATE_ACCEPT", SqlTypes.NUMERIC, indatamap.get("CREATE_ACCEPT"));
	        try {
	        	int i = jdbc.execuse();
	        	System.out.println("JdbcConn删除完成:"+i);
			} catch (Exception e) {
				System.out.println("删除正表失败,报错信息："+e.toString());
				StackTraceElement[] error = e.getStackTrace();
	            for (StackTraceElement stackTraceElement : error){
	                System.out.println(stackTraceElement.toString());
	            }
			}

	    }
	   
	public static void main(String[] args) {
		// 添加spring的配置文件
		XMLFileContext.addXMLFile("applicationContext.xml");
		// 加载spring容器
		XMLFileContext.loadXMLFile();
		
		Connection conn = null;
		try {
			conn = ((DataSource)LocalContextFactory.getInstance().getBean("dataSourceB1", DataSource.class)).getConnection();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		Map<String, Object> data_map = new HashMap<String, Object>();
		data_map.put("ERR_MSG", "测试");
		data_map.put("ERR_CODE", "1234");
		data_map.put("TOPIC_ID", "T109Smsp");
		data_map.put("CREATE_ACCEPT", "151103195317513658");
		try {
			inputErrAndDel(data_map, conn);
			//inputErrAndDelByJdbcConn(data_map,conn);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

 
}
