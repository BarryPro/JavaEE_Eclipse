package com.sitech.acctmgr.app.msgodrsend;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.HashMap;
import java.util.Map;

import com.sitech.acctmgr.app.common.InterBusiConst;
import com.sitech.jcf.context.LocalContextFactory;
import com.sitech.jcf.core.SessionContext;
import com.sitech.jcf.core.util.XMLFileContext;
import com.sitech.jcfx.dt.MBean;

public class MsgFileErrMain {
	
	/**
	 * 名称:业务异常工单处理
	 * 使用:./BusiErrMain 0 create_accept 对指定流水的工单重发 
	 *     ./BusiErrMain 1 0  提所有err_code=0000的工单，重发
	 * 日期:2015/09/05
	 */
	public static void main(String[] args) {
		
		System.err.println("args.length="+args.length+"  "+args[0]);
		if (args.length < 1) {
			System.err.println("|------------------------------------------|");
			System.err.println("|使用:./BusiFileErrMain ./path_file");
			System.err.println("|使用:./BusiFileErrMain ./path_file");
			System.err.println("|------------------------------------------|");
			return ;
		}
		String path_name = args[0];
		
		// 添加spring的配置文件
		XMLFileContext.addXMLFile("applicationContext.xml");
		// 加载spring容器
		XMLFileContext.loadXMLFile();		
		
		IMsgSend imsgsend = LocalContextFactory.getInstance().getBean("MsgSendSvc", IMsgSend.class);
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
			while ((tmp_str = reader.readLine()) != null) {
				if (tmp_str.trim().equals("")) {
					System.out.println("第 "+line+" 行数据:"+tmp_str+"为空，忽略...");
					continue;
				}
				System.out.println("处理第 "+line+" 行，号码:"+tmp_str);
				line ++;
				try {
					Map<String, Object> inTopicMap = new HashMap<String, Object>();
					imsgsend.dealErrOrder(inTopicMap, "Y");
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}
			reader.close();

			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
