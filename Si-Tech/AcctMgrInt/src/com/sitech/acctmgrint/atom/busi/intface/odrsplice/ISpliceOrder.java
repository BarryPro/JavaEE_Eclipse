package com.sitech.acctmgrint.atom.busi.intface.odrsplice;

import java.util.List;
import java.util.Map;

import com.sitech.jcfx.dt.MBean;

public interface ISpliceOrder {
	
	public boolean sendCommandJson(Map<String, Object> inDataMap);
	
	public String getParaNameByMod(String inModPara, String inJudge, int indexHead, int indexTail);
	
	/**
	 * 拆解超过指定长度的报文
	 * @Note 根据报文中指定的List_key拆解
	 * @param in_bean
	 * @param list_key
	 * @param max_length
	 * @return 拆解后的List，失败返回null
	 */
	public List<MBean> disasOrder(MBean in_bean, String in_list_key, int max_length);
	
}
