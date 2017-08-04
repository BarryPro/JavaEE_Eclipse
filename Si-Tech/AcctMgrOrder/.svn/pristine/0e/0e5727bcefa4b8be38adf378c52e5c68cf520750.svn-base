package com.sitech.acctmgr.app.dataorder;

import com.sitech.jcf.context.LocalContextFactory;
import com.sitech.jcf.core.SessionContext;
import com.sitech.jcf.core.util.XMLFileContext;

public class DataErrMain {
	
	/**
	 * 名称:数据异常工单处理
	 * 使用:./bin 0 create_accept 对指定流水的工单重发 
	 *     ./bin 1 0  提所有err_code=0000的工单，重发。
	 * 日期:2015/09/05
	 */
	public static void main(String[] args) {
		
		System.err.println("args.length="+args.length+"  "+args[0]);
		if (args.length < 2) {
			System.err.println("|------------------------------------------|");
			System.err.println("|处理提所有err_code=0000的工单，重发");
			System.err.println("|入参:args[0]-[A1/B1/A2/B2]数据库标签");
			System.err.println("|入参:args[1]-[Y/N]是否需要跨库处理");
			System.err.println("|使用:./DataErrMain A1[B1] Y[N]");
			System.err.println("|------------------------------------------|");
			return ;
		}
		String sDbId = args[0];
		String sBoth = args[1];
		
		// 添加spring的配置文件
		XMLFileContext.addXMLFile("applicationContext.xml");
		// 加载spring容器
		XMLFileContext.loadXMLFile();
		
		//切换数据库标签
		SessionContext.setDbLabel(sDbId);
		
		IDataOrder iDataOrder = LocalContextFactory.getInstance()
				.getBean("DataOrderSvc", IDataOrder.class);

		try {
			//切换数据库标签
			SessionContext.setDbLabel(sDbId);
			
			iDataOrder.dealDataOrderErr(sBoth);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
