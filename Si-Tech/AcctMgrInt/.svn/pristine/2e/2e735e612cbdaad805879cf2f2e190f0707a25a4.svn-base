package com.sitech.acctmgrint.atom.busi.intface;

import com.sitech.jcfx.dt.MBean;

public interface IDataSyn {
	
	/*
	 * @Description Boss库向其他库同步接口(消息中间件发送，无法回退)
	 * @param inActionId		业务标识
	 * @param inCheckkeyFlag	是否校验是否包含全部索引值(boolean)
	 * @param inMapKeyVals		记录所有待同步表的所有主键信息，其中
	 * @param		key:大写，同步表唯一、联合索引字段名称    value：对应索引字段值
	 * @author konglj
	 * @date 2015/03/17
	 * @return
	 */
	/*public boolean sendDataInter(long inActionId, boolean inCheckKeyFlag, Map<String, Object> inMapKeyVals,
			String inLoginAccept);*/
	
	/**
	 * @Title BOSS库数据同步接口
	 * @Description Boss库向其他库同步数据工单接口(入接口表发送，可回退)，以一次用户相关操作为单位调用接口
	 * @param inBean.Header         必传，调用侧透传(记录大区信息、路由、鹰眼流水等)
	 * @param inBean.Body.ACTION_ID 必传，业务标识(String类型，如缴费业务：1001)
	 * @param inBean.Body.CHECK_KEY 必传，是否校验是否包含全部索引值(boolean)
	 * @param inBean.Body.KEY_DATA  必传，记录所有待同步表的所有主键信息(Map型，key:大写，同步表唯一、联合索引字段名称   value：对应索引字段值)
	 * @param inBean.Body.LOGIN_SN  必传，统一流水或业务流水(String)
	 * @param inBean.Body.OP_CODE   必传，操作标识(String)
	 * @param inBean.Body.LOGIN_NO  必传，操作编号(String)
	 * @author KONGLJ
	 * @date   2015/04/23
	 * @return
	 */
	public boolean sendSynInter(MBean inBean);
	
	/**
	 * @Title BOSS库数据同步接口
	 * @Description 1.Boss库向其他库同步数据 业务接口(入接口表发送，可回退)，以一次业务操作为单位调用接口。
	 * 				2.注意，此接口 不检查 待同步表的索引参数列，请知晓。
	 * @param inBusiBean.Header         必传，调用侧透传(记录大区信息、路由、鹰眼流水等)
	 * @param inBusiBean.Body.ACTION_ID 必传，业务标识(String类型，如缴费业务：1001)
	 * @param inBusiBean.Body.LOGIN_SN  必传，统一流水或业务流水(String)
	 * @param inBusiBean.Body.OP_CODE   必传，操作标识(String)
	 * @param inBusiBean.Body.LOGIN_NO  必传，操作编号(String)
	 * @param inBusiBean.Body.KEYS_LIST 必传，按照action_id对应的表操作顺序，依次记录待同步表的主键信息，顺序需相同，请注意。
	 * 						  			(List型，存储Map参数 (Map中，TABLE_NAME/UPDATE_TYPE必传，
	 * 										key:大写，同步表唯一、联合索引字段名称   value：对应索引字段值))
	 * @author KONGLJ
	 * @date   2015/04/24
	 * @return
	 */
	public boolean sendBusiDataInter(MBean inBusiBean);
	
}
