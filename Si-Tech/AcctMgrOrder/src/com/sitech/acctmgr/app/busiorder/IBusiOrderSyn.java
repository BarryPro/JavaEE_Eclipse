package com.sitech.acctmgr.app.busiorder;

import java.util.Map;

import com.sitech.jcfx.dt.MBean;

public interface IBusiOrderSyn {
	
	public boolean dealBusiOrderData(String inBusiOrder, String inBusiCode, String sMsgId) throws Exception;
	public boolean inputBusiErr(MBean mb, Map<String, Object> errMap);
	public boolean dealBusiOrderErr(String sFlag,String sCreateAccept) throws Exception;
	public String getBusiCode(MBean mb);
}
