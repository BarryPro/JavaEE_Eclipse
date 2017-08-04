package com.sitech.acctmgr.inter.pay;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 *
 * <p>Title: 第三方缴费签约关系设置  </p>
 * <p>Description: 包含第三方缴费签约、解约、变更等  </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public interface I8297 {

	/** 
	* 名称：签约	<br/>
	* 功能：根据传入不同业务类型确定不同类型的签约关系，银行卡、支付宝、手机支付等<br/>
	* @param
	* @return 
	 */
	OutDTO sign(InDTO inParam);
	
	/** 
	* 名称：解约	<br/>
	* 功能：根据传入不同业务类型确定不同类型的签约关系，银行卡、支付宝、手机支付等<br/>
	* @param
	* @return 
	 */
	OutDTO termination(InDTO inParam);
	
	/** 
	* 名称：支付宝解约	<br/>
	* 功能：BOSS发起解约流程后，支付宝节约成功以后调用该接口更新boss数据<br/>
	* @param
	* @return 
	 */
	OutDTO terminationZfb(InDTO inParam);
	
	
	/** 
	* 名称：签约关系查询	<br/>
	* 功能：查询用户办理了哪种类型的签约业务<br/>
	* @param
	* @return 
	 */
	OutDTO query(InDTO inParam);
	
	/** 
	* 名称：银行卡、支付宝签约关系查询自动缴费金额、阀值等明细信息	<br/>
	* 功能：查询用户办理了哪种类型的签约业务,已经明细自动充值情况<br/>
	* @param
	* @return 
	 */
	OutDTO bankOrZfbQueryDetail(InDTO inParam);
	
	/** 
	* 名称：手机支付签约信息查询	<br/>
	* 功能：查询手机支付签约用户自动缴话费等信息<br/>
	* @param
	* @return 
	 */
	OutDTO mobilePaySignQuery(InDTO inParam);
	
	/** 
	* 名称：修改自动缴费限额、阀值等信息	<br/>
	* 功能：<br/>
	* @param
	* @return 
	 */
	OutDTO updateAutoPayInfo(InDTO inParam);
	
	
}
