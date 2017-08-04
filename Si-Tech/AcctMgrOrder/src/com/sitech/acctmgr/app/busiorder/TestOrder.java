package com.sitech.acctmgr.app.busiorder;

import java.util.Map;

import com.sitech.acctmgr.common.BaseBusi;
import com.sitech.jcfx.dt.MBean;

public class TestOrder extends BaseBusi {
	public Map<String, Object> feeOrderMain(MBean inParaBean) {
		System.out.println("------test konglj invoke--feeOrderMain-");
		log.info("-只是用来测试打印信息，及传入参数---inParaBean="+inParaBean.toString());
		
		System.out.println("------test kongljtest invoke--end---");
		return null;
	}
}
