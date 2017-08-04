package com.sitech.acctmgr.app.dataorder;

import java.util.Map;

import com.sitech.jcfx.dt.MBean;

public interface IDataOrder {
	
	/**
	 * Title: Crm To Boss 数据同步接口实现
	 * Description 数据同步提供外部使用接口
	 * @param sInParamJson
	 * @param both_sync_flag 跨库标识:Y-跨库 N-不跨库
	 * @return boolean
	 * @throws Exception 
	 */
	public boolean dataOrderSyn(MBean inbean, String in_sync_flag) throws Exception;
	public boolean inputErrOrderDeal(MBean inbean, Map<String, Object> opr_info, String inErrMsg);
	
	/**
	 * 取得工单中LOGIN_ACCEPT返回
	 * 若没有，则返回ID_NO或空
	 * @param inJsonStr
	 * @return
	 */
	public Map<String, Object> getOrderAccept(MBean mInParam);
	
	public boolean dealDataOrderErr(String both_syn_flag);
	
	/**
	 * 错单处理程序
	 * @param mInParam
	 * @param in_sync_flag 
	 * 		Y:跨库同步数据工单；处理业务工单 
	 * 		N:只同步当前库数据工单；不处理业务工单
	 * @date 20151120
	 * @return
	 */
	public boolean errOrderSyn(MBean mInParam, String in_sync_flag);
}
