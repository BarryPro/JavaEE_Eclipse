package com.sitech.acctmgr.inter.feeqry;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

public interface IPayQuery {
	OutDTO qryPayInfo(InDTO inParam);
	
	/**
	* <p>Title:客服交费信息查询接口  </p>
	*/
	OutDTO phonePayNew(InDTO inParam);
	
	/**
	* <p>Title:客服30、50、80缴费标志  </p>
	*/
	OutDTO payFlagQry(InDTO inParam);
	
	/**
	* <p>Title:对应老系统s1500_wPayQry接口  </p>
	*/
	OutDTO pay1500Qry(InDTO inParam);
	
	/**
	* <p>Title:对应老系统bs_PayInfoQryy接口  </p>
	* <p>Description: 移动商城缴费记录查询  </p>
	*/
	OutDTO mallPayQry(InDTO inParam);
	
	/**
	* <p>Title:对应老系统sQueryBcakPay接口  </p>
	* <p>Description: 查询后台返还记录  </p>
	*/
	OutDTO backPayQry(InDTO inParam);
	
	/**
	* <p>Title:充值卡缴费记录查询  </p>
	*/
	OutDTO payCardQry(InDTO inParam);
	
	/**
	* <p>Title:微信支付交费状态查询  </p>
	*/
	OutDTO wxPayQry(InDTO inParam);
}
