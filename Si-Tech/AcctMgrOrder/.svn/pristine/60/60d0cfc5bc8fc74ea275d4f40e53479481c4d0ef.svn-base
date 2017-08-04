package com.sitech.acctmgr.app.task;

import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.sitech.fortress.cluster.IWorkerEnv;
import com.sitech.jcf.core.util.XMLFileContext;

/**
 *
 * <p>Title: 账务管理分布式后台调度任务启动程序  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author zhangjp
 * @version 1.0
 */
public class AcctmgrWorker implements IWorkerEnv {
	private static Log log = LogFactory.getLog(AcctmgrWorker.class);
	
	@Override
	public void cleanup() {
		// TODO Auto-generated method stub
		
	}


	@Override
	public void prepare(Map<Object, Object> conf, String jobId, String arg) {
		log.info("prepare, arg='" + arg + "'");
		log.info("开始加载spring配置文件");
		
		XMLFileContext.addXMLFile("applicationContext-app.xml");
		XMLFileContext.loadXMLFile();

		log.info("spring配置文件加载完成");
	}
	
	public static void main(String[] args) throws Exception{
		AcctmgrWorker aw = new AcctmgrWorker();
		aw.prepare(null,"AcctmgrJobId",null);
		DataOrderTask dot = new DataOrderTask();
		dot.prepare(null);
		dot.execute(dot.fetchData());
	}

}
