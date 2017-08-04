package com.sitech.acctmgr.atom.busi.pay.inter;

import java.util.Map;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public interface IPreOrder {    
	
	/**
	 * 名称：缴费向外系统同步数据,目前包含CRM营业日报、BOSS报表库<br/>
	 * 功能: 缴费类业务  一个pay_sn对应一条payment数据情况
	 * @param	PAY_SN   	Long
	 * @param	LOGIN_NO
	 * @param	GROUP_ID	工号归属
	 * @param	OP_CODE
	 * @param	PHONE_NO	可空
	 * @param	BRAND_ID	可空
	 * @param	BACK_FLAG		冲正标识，0:未冲正  1:冲正
	 * @param	OLD_ACCEPT		Long 原有业务操作流水，冲正时传缴费流水，其他情况传操作流水
	 * @param	OP_TIME
	 * @param	OP_NOTE			 备注信息
	 * @param	CONTACT_ID		统一流水，可空
	 * @param   TOTAL_FEE       费用，可选入参
	 * @param Header         Map必传，调用侧透传(记录大区信息、路由、鹰眼流水等)
	 * @param ACTION_ID 必传，业务标识(String类型，如缴费业务：1001)
	 * @param CHECK_KEY 必传，是否校验是否包含全部索引值(boolean)
	 * @param KEY_DATA  必传，记录所有待同步表的所有主键信息(Map型，key:大写，同步表唯一、联合索引字段名称   value：对应索引字段值)
	
	 * @param	REGION_ID		:可空
	 * @param   CUST_ID_TYPE    :0客户ID;1-服务号码;2-用户ID;3-账户ID;
	 * @param	CUST_ID_VALUE	:要求是能够转换成数字的值，统一接触自己映射
	 * 
	 * @author qiaolin 
	 * */
	boolean sendData(Map<String, Object> inParam);
	
	/**
	 * 名称：缴费向外系统同步数据,目前包含CRM营业日报、BOSS报表库<br/>
	 * 功能: 转账类业务  一个pay_sn对应多条payment数据情况
	 * @param	PAY_SN   	Long
	 * @param	LOGIN_NO
	 * @param	GROUP_ID	工号归属
	 * @param	OP_CODE
	 * @param	PHONE_NO	可空
	 * @param	BRAND_ID	可空
	 * @param	BACK_FLAG		冲正标识，0:未冲正  1:冲正
	 * @param	OLD_ACCEPT		Long 原有业务操作流水，冲正时传缴费流水，其他情况传操作流水
	 * @param	OP_TIME
	 * @param	OP_NOTE			 备注信息
	 * @param	CONTACT_ID		统一流水，可空
	 * @param   TOTAL_FEE       费用，可选入参
	 * @param Header         Map必传，调用侧透传(记录大区信息、路由、鹰眼流水等)
	 * @param ACTION_ID 必传，业务标识(String类型，如缴费业务：1001)
	 * @param KEYS_LIST  必传，记录所有待同步表的所有主键信息((List型，存储Map参数 (Map中，TABLE_NAME/UPDATE_TYPE（D/U/I）必传，key:大写，同步表唯一、联合索引字段名称   value：对应索引字段值)))
						 如果为空，则自己去表中查询
	 * @param	REGION_ID		:可空
	 * @param   CUST_ID_TYPE    :0客户ID;1-服务号码;2-用户ID;3-账户ID;
	 * @param	CUST_ID_VALUE	:要求是能够转换成数字的值，统一接触自己映射
	 * 
	 * @author qiaolin 
	 * */
	boolean sendData2(Map<String, Object> inParam);

	/**
	 * 名称：向CRM发送营业日报<br/>
	 * @param	PAY_SN   	Long
	 * @param	LOGIN_NO
	 * @param	GROUP_ID	工号归属
	 * @param	OP_CODE
	 * @param	PHONE_NO	可空
	 * @param	BRAND_ID	可空
	 * @param	BACK_FLAG		冲正标识，0:未冲正  1:冲正
	 * @param	OLD_ACCEPT		Long 原有业务操作流水，冲正时传缴费流水，其他情况传操作流水
	 * @param	OP_TIME
	 * @param	OP_NOTE			 备注信息
	 * @param	CONTACT_ID		统一流水，可空
	
	 * @return
	 * @throws
	 * @author qiaolin 
	 * */
	boolean pSendBusiDaily(Map<String, Object> inParam);
	
	/**
	 * 名称：向报表库同步缴费数据<br/>
	 * @param Header         Map必传，调用侧透传(记录大区信息、路由、鹰眼流水等)
	 * @param ACTION_ID 必传，业务标识(String类型，如缴费业务：1001)
	 * @param CHECK_KEY 必传，是否校验是否包含全部索引值(boolean)
	 * @param KEY_DATA  必传，记录所有待同步表的所有主键信息(Map型，key:大写，同步表唯一、联合索引字段名称   value：对应索引字段值)
	 * @param LOGIN_SN  必传，统一流水或业务流水(String)
	 * @param LOGIN_NO
	 * @param OP_CODE
	
	 * @author qiaolin 
	 * */
	boolean sendReportData(Map<String, Object> header, Map<String, Object>inParam);
	
	void sendReportDataList(Map<String, Object> header, Map<String, Object>inParam);
	
	/**
	 * 名称：向统一接触发送受理类消息<br/>
	 * @param	Header		:map
	 * @param	PAY_SN   	Long
	 * @param	LOGIN_NO
	 * @param	GROUP_ID
	 * @param	OP_CODE
	 * @param	REGION_ID		:可空
	 * @param	OP_NOTE	        :备注信息
	 * @param   TOTAL_FEE       :费用，可选入参
	 * @param   CUST_ID_TYPE    :0客户ID;1-服务号码;2-用户ID;3-账户ID;
	 * @param	CUST_ID_VALUE	:要求是能够转换成数字的值，统一接触自己映射
	 * @param	OP_TIME			：操作时间
	 * @param	CONTACT_ID		统一流水，可空
	
	 * @author qiaolin 
	 * */
	void sendOprCntt(Map<String, Object> inParam);
	
	/**
	 * 名称：向统一接触发送查询类消息<br/>
	 * @param inParam
	 * @param	Header		:map
	 * @param	PAY_SN   	Long
	 * @param	LOGIN_NO
	 * @param	GROUP_ID
	 * @param	OP_CODE
	 * @param	REGION_ID		:可空
	 * @param	OP_NOTE	        :备注信息
	 * @param   CUST_ID_TYPE    :0客户ID;1-服务号码;2-用户ID;3-账户ID;
	 * @param	CUST_ID_VALUE	:要求是能够转换成数字的值，统一接触自己映射
	 * @param	OP_TIME			：操作时间
	 * @param	CONTACT_ID		统一流水，可空
	 * 
	 * @return
	 */
	void sendQueryCntt(Map<String, Object> inParam);
	
}
