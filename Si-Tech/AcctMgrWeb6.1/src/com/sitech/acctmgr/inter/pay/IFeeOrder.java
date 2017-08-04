package com.sitech.acctmgr.inter.pay;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public interface IFeeOrder {
	
	/** 
	* 名称：交预存款	<br/>
	* 功能：实现CRM业务工单缴费功能，目前调用方：积分兑换预存款、开户交预存、实体卡<br/>
	* @return 
	 */
	OutDTO payFee (InDTO inParam);


	/** 
	* 名称：费用冲正接口	<br/>
	* 功能：走业务工单过来冲正费用，主要用于 开户缴费冲正 、 营销活动冲正等<br/>
	* @return 
	 */
	OutDTO payBackOpr (InDTO inParam);
	
	/** 
	* 名称：营销分月划拨	<br/>
	* 功能：<br/>
	* @return 
	 */
	OutDTO payMoneyForMr (InDTO inParam);
	
	/** 
	* 名称：营销分月划拨订购校验<br/>
	* 功能：<br/>
	* @return 
	 */
	OutDTO payMoneyForMrLimit(InDTO inParam);
	
	/** 
	* 名称：宽带竣工，更新账本生失效时间<br/>
	* 功能：<br/>
	* @return 
	 */
	OutDTO upBeginEndTime(InDTO inParam);
	
	
}
