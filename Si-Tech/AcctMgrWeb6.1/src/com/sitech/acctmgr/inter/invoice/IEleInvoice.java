package com.sitech.acctmgr.inter.invoice;
 
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
public interface IEleInvoice {
	/**
	 * 用户开具发票信息查询<br>
	 * 对应接口sInvInfoQryWS
	 * 
	 * @author liuhl_bj
	 * @param inParam
	 * @return
	 */
	OutDTO query(InDTO inParam);

	/**
	 * 电子发票下载 <br>
	 * 对应接口bs_EInvLoadWS
	 * 
	 * @param inParam
	 * @return
	 */
	OutDTO downLoad(InDTO inParam);

	/**
	 * 电子发票推送
	 * 
	 * @param inParam
	 * @return
	 */
	OutDTO invPush(InDTO inParam);

	/**
	 * 电子发票开具
	 * 
	 * @param inParam
	 * @return
	 */
	OutDTO issue(InDTO inParam);

}
