package com.sitech.acctmgr.inter.cct;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * @description:动态信誉度的查询和修改
 * @author liuhl
 *
 */
public interface IDnyCreditOpr {

	/**
	 * @description:查询动态信誉度信息
	 * @param inParam
	 * @return limit_owe：信用额度 credit_code:信用等级 expire_time:失效日期
	 */
	public OutDTO query(InDTO inParam);

	/**
	 * @description:申请，取消，修改动态信誉度
	 * @param inParam
	 * @return
	 */
	public OutDTO cfm(InDTO inParam);
}
