package com.sitech.acctmgr.app.busiorder;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.jms.JMSException;

import com.sitech.acctmgr.app.common.AppProperties;
import com.sitech.jcf.context.LocalContextFactory;

public class BusiOrderErrDeal implements Runnable {

	private IBusiOrderSyn iBusiOrderSyn = LocalContextFactory.getInstance().getBean("BusiOrderSynEnt", IBusiOrderSyn.class);

	private static Logger log = LoggerFactory.getLogger(BusiOrderErrDeal.class);
	
	@Override
	public void run() {
		// 处理错误工单
		try {
			iBusiOrderSyn.dealBusiOrderErr("1","0");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
