package com.sitech.acctmgr.inter.bill;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * 
 * @author wangyla
 * 
 * 营业前台新帐单打印8143
 * com.sitech.acctmgr.inter.bill.I8143
 */
public interface I8143 {
	/**
	 * 帐单主页
	 * @param inParam
	 * @return
	 */
	OutDTO qryBillHome(InDTO inParam);

	/**
	 * 功能：查询用户近六月消费
	 * @param inParam
	 * <li>PHONE_NO 服务号码</li>
	 * <li>YEAR_MONTH 查询月份，此月份作为基准往前推</li>
	 * <li>QUERY_TYPE 家庭帐单打印时才会用到</li>
	 * @return
	 */
	OutDTO qrySixBill(InDTO inParam);

	/**
	 * 功能：获取用户资费推荐信息
	 * @param inParam
	 * @return
	 */
	OutDTO qryBillScheme(InDTO inParam);

	/**
	 * 功能：帐单附录页查询
	 * @param inParam
	 * @return
	 */
	OutDTO qryBillApx(InDTO inParam);

	/**
	 * 功能：短信帐单随时查
	 * 对应旧接口：se610SQ 实时查询的短信账单
	 * @param inParam
	 * @return
     */
	OutDTO smsBillQuery(InDTO inParam);
}
