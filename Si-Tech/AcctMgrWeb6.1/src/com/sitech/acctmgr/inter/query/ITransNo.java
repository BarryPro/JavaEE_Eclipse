package com.sitech.acctmgr.inter.query;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;


/**
 * 名称: 实现物联网，宽带号码转换为服务号码接口
 */
public interface ITransNo {

	/**
	 * 名称: 
	 * @param IN_NO:接入号码
	 * 
	 * @return CONTRACT_NO:账户
	 * @return PHONE_NO:传出号码
	 */
	OutDTO conversion (InDTO inParam);
}
