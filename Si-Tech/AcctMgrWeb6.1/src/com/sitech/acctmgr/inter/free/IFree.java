package com.sitech.acctmgr.inter.free;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by wangyla on 2016/7/13.
 */
public interface IFree {
	/**
	 * 功能：4G共享流量不清零查询（结转流量查询）<br>
	 * 调用渠道：网厅、短厅、电视营业厅、手机客户端、和生活、飞信、中兴综合网关、IVR、wap、
	 * 自助终端、集团客户流量支撑平台、华为流量经营平台、统一支付管理平台、微信平台、微信服务号 <br>
	 * 对应旧接口：sCarryFavMsgWS
	 * 
	 * @param inParam
	 * @return
	 */
	OutDTO carryOverQuery(InDTO inParam);

	/**
	 * 功能：统付流量明细查询 <br>
	 * 调用渠道：网厅、短厅、电视营业厅、手机客户端,和生活,飞信,中兴综合网关,集团客户流量支撑平台,IVR,wap,
	 * 自助缴费机,流量经营平台（华为）,统一支付物流管理平台,新业务微信平台,微信营业厅服务号 <br>
	 * 对应旧接口：sFlowFavMsgWS
	 * 
	 * @param inParam
	 * @return
	 */
	OutDTO flowDetailQuery(InDTO inParam);

	/**
	 * 功能；wlan使用明细查询 <br>
	 * 调用渠道：网厅、短厅、IVR、wap、手机客户端、新业务微信平台 <br>
	 * 对应旧接口：sWlanFavOpr1 、sWlanFavOprWS
	 * 
	 * @param inParam
	 * @return
	 */
	OutDTO wlanDetailQuery(InDTO inParam);

	/**
	 * 功能：用户优惠信息查询 <br>
	 * 调用渠道：网上营业厅、短信营业厅、飞信营业厅、微信营业厅、IVR、自助缴费机、手机客户端、新业务微信平台、外呼系统 <br>
	 * 对应旧接口：sGetUserFavMsgN
	 * 
	 * @param inParam
	 * @return
	 */
	OutDTO userFreeQuery(InDTO inParam);

	/**
	 * 功能：用户流量信息查询 <br>
	 * 对应旧接口：s5186FavMsg <br>
	 * 
	 * @param inParam
	 * @return
	 */
	OutDTO gprsQuery(InDTO inParam);

	/**
	 * 功能：vpmn流量查询 <br>
	 * 对应旧接口：sVpmnSelect <br>
	 * 调用渠道：短信营业厅，IVR
	 * 
	 * @param inParam
	 * @return
	 */
	OutDTO vpmnQuery(InDTO inParam);

	/**
	 * 功能：4G共享流量套餐使用情况查询 <br>
	 * 对应旧接口：sSharingFlow 4G共享流量套餐使用 <br>
	 * 调用渠道：网上营业厅,短信营业厅,电视营业厅,手机客户端,和生活,飞信营业厅,中兴综合网关,
	 * 黑龙江集团客户流量支撑平台,IVR,wap,自助缴费机,流量经营平台（华为）,统一支付物流管理平台,新业务微信平台,微信营业厅服务号
	 * 
	 * @param inParam
	 * @return
	 */
	OutDTO shareQuery(InDTO inParam);

	/**
	 * 功能：可选套餐明细查询 <br>
	 * 对应接口：ChoiceFavQry 可选套餐明细和GPRS流量查询<br>
	 * 
	 * @param inParam
	 * @return
	 */
	OutDTO choiceQuery(InDTO inParam);

	/**
	 * 功能：用户所有的优惠信息查询<br>
	 * 注：不包括共享流量
	 * 对应旧接口：sGetUserFavAll
	 * @param inParam
	 * @return
     */
	OutDTO allQuery(InDTO inParam);

	/**
	 * 功能：用户近5月（含当月）流量使用平均值
	 * @param inParam
	 * @return
     */
	OutDTO averageGprsQuery(InDTO inParam);
	
	/**
	 * 功能：用户优惠分类查询
	 * 对应旧接口：sClassFavMsg
	 * @param inParam
	 * @return
	 */
	OutDTO classQuery(InDTO inParam);
	
	/**
	 * 功能：日套餐流量优惠查询
	 * 对应旧接口：sDayOfferFav
	 * @param inParam
	 * @return
	 */
	OutDTO dayQuery(InDTO inParam);
	
	/**
	 * 功能：套餐优惠信息查询，并下发短信
	 * 对应旧接口：sGetUserSms
	 * @param inParam
	 * @return
	 */
	OutDTO smsQuery(InDTO inParam);
}
