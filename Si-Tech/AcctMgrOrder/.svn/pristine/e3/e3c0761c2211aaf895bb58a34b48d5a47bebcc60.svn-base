package com.sitech.acctmgr.app.test;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import com.alibaba.fastjson.JSON;
import com.sitech.acctmgr.app.common.InterBusiConst;
import com.sitech.acctmgr.app.common.JdbcConn;
import com.sitech.acctmgr.common.BaseBusi;
import com.sitech.jcf.context.LocalContextFactory;
import com.sitech.jcf.core.SessionContext;
import com.sitech.jcf.core.dao.BaseDao;
import com.sitech.jcf.core.util.XMLFileContext;
import com.sitech.jcf.ijdbc.SqlFind;
import com.sitech.jcf.ijdbc.util.DataSourceUtils;
import com.sitech.jcfx.context.JCFContext;


public class TestMain extends BaseBusi {
	
	private static int iStartRealNum = 0;

	public static void testBaseDao() {
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("ID_NO", "220410120016084100");
		//设置A,B库
		String sDbLabel = "dataSourceA";
		SessionContext.setDbLabel(sDbLabel);
//		baseDao.update("in_msgrcv_info.updateTest", inMap);
		
		//jdbc 自取连接
		DataSource dataSrcA = null;
//		
//		LocalContextFactory lcf = LocalContextFactory.getInstance();
//		DataSource ds = (DataSource) lcf.getBean("");
		
		JCFContext.junitInit();
		String sDbid = "";
		dataSrcA = (DataSource) JCFContext.getBean("dataSourceA");//db.xml中配置的数据源
		Connection conn = DataSourceUtils.getConnection(dataSrcA);	
	}
	public static void testBaseDao(int i) {
		System.out.println("ttest reLoad Function:"+i);
	}
	
	static int s = 2;
	final int f = 1;
	final static int f_s = 10;
	
	public static void main(String[] args) {
		System.out.println("计算：" + Double.valueOf("5")*1/24/60);
		testBaseDao(101);
		
//		for (int i = 0; i < 10; i ++)
//			System.out.println(i+"-当前值+1："+iStartRealNum ++);
//		System.out.println("当前值："+iStartRealNum);
//		for (int i = 0; i < 10; i ++)
//			System.out.println(i+"-当前值-1："+iStartRealNum --);
		
		
//		String sDbLabel[] = "B1".split("\\|");//demo:A1|B1
//        for (String sDbLabelString : sDbLabel) 
//		System.out.println("sss="+ sDbLabelString);
//        
//        System.out.println("A,B,C,F,G,M,J,b".indexOf("A"));
//        System.out.println("B".indexOf("A,B,C,F,G,M,J,b"));
//
//        System.out.println("L".indexOf("A,B,C,F,G,M,J,b"));
//        System.out.println("A,B,C,F,G,M,J,b".indexOf("L"));
        
        
//		String konglj = "konglj12345";
//		System.out.println("substr="+konglj.substring(0,100));
//		
//		String sub_id = "22041".substring(3, 4);
//		if (sub_id.equals("1")||sub_id.equals("7")||sub_id.equals("8"))
//			System.out.println(sub_id+"=A1");
//		else {
//			System.out.println(sub_id+"=V1");
//		}
//		System.out.println("totaldate="+"20150806101256".substring(0, 8));
//		try {
//			System.out.println("try...");
//			final int f1 = 11;
//			for (int i = 0; i < 10; i++) {
//				//f = i;  //ERROR:Cannot make a static reference to the non-static field f
//				//f_s = i;//ERROR:The final field TestMain.f_s cannot be assigned
//				s = i;
//				final int j = s;
//				System.out.println(i+" "+s+" "+j+" f1="+f1);
//			}
//		} catch (Exception e) {
//			System.out.println("catch...");
//		} finally {
//			System.out.println("finally");
//		}
//		
//		
	}

}
