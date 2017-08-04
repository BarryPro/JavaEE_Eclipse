package com.sitech.acctmgr.inter.feeqry;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by wangyla on 2016/6/2.
 */
public interface IBalance {
	/**
	 * 余额查询接口 内容：账户离线余额或账户在线余额
	 *
	 * @param inDTO
	 * @return
	 */
	OutDTO query(InDTO inDTO);

	/**
	 * 名称：查询可退预存款和不可退预存款
	 * 
	 * @param inDto
	 * @return
	 */
	OutDTO queryBackFee(InDTO inDto);

	/**
	 * 名称：吉林版本的可退预存和不可退预存
	 * 
	 * @author liuhl
	 */
	OutDTO qryBackFee(InDTO inDto);
	
	public OutDTO qryRestPay(InDTO inParam);
}
