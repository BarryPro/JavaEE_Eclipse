package com.sitech.acctmgrint.common;

import com.sitech.jcfx.log.e2e.ILog;
import com.sitech.jcfx.log.e2e.LogVo;

public class AccFlumeLog implements ILog {

	@Override
	public void writeLog(LogVo arg0) {
		System.out.println("acctFlumeLog.getServiceName="+arg0.getServiceName());
	}

}
