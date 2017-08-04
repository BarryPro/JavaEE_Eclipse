package com.sitech.acctmgr.inter.feeqry;
  
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 *
 * <p>Title:   外围系统调用查询费用接口</p>
 * <p>Description:   用于对外围系统提供费用查询接口</p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author yankma
 * @version 1.0
 */
public interface IFeeQry {

	/**
	* 名称：用户开户后是否缴费和消费判断，用于校验用户能否做开户冲正
	* @param 
	* @return 
	* @author qiaolin
	*/
	OutDTO isPayAndExpense(InDTO inParam);
}
