package com.sitech.acctmgr.comp.impl.pay;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import com.alibaba.fastjson.JSON;
import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.base.LoginEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.pay.SCreateOrderInDTO;
import com.sitech.acctmgr.atom.dto.pay.SCreateOrderOutDTO;
import com.sitech.acctmgr.atom.dto.pay.SOrderPayInDTO;
import com.sitech.acctmgr.atom.dto.pay.SOrderPayOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.ILogin;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.inter.pay.IWeChatPay;
import com.sitech.common.CrossEntity;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.service.client.ServiceUtil;

/**
 *
 * <p>
 * Title:
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2014
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author
 * @version 1.0
 */

@ParamTypes({ @ParamType(c = SCreateOrderInDTO.class, oc = SCreateOrderOutDTO.class, m = "sCreateOrder"),
		@ParamType(c = SOrderPayInDTO.class, oc = SOrderPayOutDTO.class, m = "sOrderPay") })
public class SWeChatPay extends AcctMgrBaseService implements IWeChatPay {

	private IUser user;
	private IControl control;
	private IGroup group;
	private ILogin login;

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.sitech.acctmgr.inter.pay.IWeChatPay#sCreateOrder(com.sitech.jcfx.dt.
	 * in.InDTO)
	 */
	@Override
	public OutDTO sCreateOrder(InDTO inParam) {

		SCreateOrderInDTO inDto = (SCreateOrderInDTO) inParam;
		log.info("------> inDto :" + inDto.getMbean());

		String phoneNo = inDto.getPhoneNo();

		UserInfoEntity userEnt = user.getUserInfo(phoneNo);

		if (userEnt == null) {
			log.info("查询用户信息错误!"); // TODO 是否需要抛出异常
		}

		log.info("hanfule测试：开始拼装入参报文");
		MBean inMbean = new MBean();

		log.info("hanfule测试：拼接OPR_INFO部分报文开始");
		// 入参第一个节点 OPR_INFO 部分
		Map<String, Object> oprInfoMap = new HashMap<String, Object>();
		oprInfoMap.put("CUST_ID_TYPE", "1"); // 传固定值1,必传
		// CUST_ID_VALUE:手机号码,必传，如果是宽带账号（yd开头），需要电子渠道调用行业部的服务，转换成虚拟用户号码，然后传虚拟用户号码
		// SERVICE_NO:手机号码,必传，如果是宽带账号（yd开头），需要电子渠道调用行业部的服务，转换成虚拟用户号码，然后传虚拟用户号码
		oprInfoMap.put("CUST_ID_VALUE", inDto.getPhoneNo());
		oprInfoMap.put("SERVICE_NO", inDto.getPhoneNo());
		oprInfoMap.put("CONTACT_ID", "1111111111111111111");// 接触ID 暂定
		oprInfoMap.put("LOGIN_NO", inDto.getLoginNo());
		oprInfoMap.put("GROUP_ID", inDto.getGroupId());
		oprInfoMap.put("REGION_ID", 230000);// 暂定
		oprInfoMap.put("CHANNEL_TYPE", "1");// 渠道类型 暂定
		oprInfoMap.put("BUSI_TYPE", "45101"); // 业务类型,必传
		oprInfoMap.put("REMARK", inDto.getOpNote());
		// OUT_ORDER_ID :对于来找本省电子渠道的订单，传空，对于来自集团或者第三方电商平台的订单，传集团订单ID或者第三方电商订单ID
		oprInfoMap.put("OUT_ORDER_ID", "");

		inMbean.addBody("OPR_INFO", oprInfoMap);

		// 处理报文中body下的PAY_INFO节点
		Map<String, Object> payInfoMap = new HashMap<String, Object>();
		payInfoMap.put("OPT_CODE", "pay");

		inMbean.addBody("PAY_INFO", payInfoMap);

		// 处理报文中body下的ORDERITEM_LIST节点
		Map<String, Object> orderMap = new HashMap<String, Object>();
		MBean tmp = new MBean();
		tmp.setHeader(inDto.getHeader());

		orderMap.put("CHANNEL_TYPE", "02");// 渠道类型 暂定
		orderMap.put("BUSI_TYPE", "45101");// 业务类型,必传
		orderMap.put("CUST_ID_TYPE", "1");// 传固定值1,必传
		orderMap.put("CUST_ID_VALUE", inDto.getPhoneNo());

		// 处理缴费报文
		// PAY_LIST节点
		List<Map<String, Object>> payList = new ArrayList<Map<String, Object>>();
		Map<String, Object> payMap = new HashMap<String, Object>();
		payMap.put("PAY_MONEY", inDto.getPayMoney());
		payMap.put("PAY_TYPE", 0);
		payList.add(payMap);

		Map<String, Object> payOprMap = new HashMap<String, Object>();
		Map<String, Object> payBusiMap = new HashMap<String, Object>();
		payOprMap.put("LOGIN_NO", inDto.getLoginNo());
		payOprMap.put("OP_CODE", "8000");
		payOprMap.put("PROVINCE_ID", inDto.getProvinceId());
		tmp.setBody("OPR_INFO", payOprMap);

		payBusiMap.put("PHONE_NO", phoneNo);
		payBusiMap.put("CONTRACT_NO", userEnt.getContractNo());
		payBusiMap.put("PAY_LIST", payList);
		payBusiMap.put("PAY_PATH", "02");
		payBusiMap.put("PAY_METHOD", "8");
		payBusiMap.put("CTRL_FLAG", "11");
		payBusiMap.put("PAY_NOTE", inDto.getOpNote());

		tmp.setBody("BUSI_INFO", payBusiMap);

		// TODO 缺少pospay_info
		log.info("缴费处报文" + tmp.toString());

		orderMap.put("GOODS_INFO", JSON.parseObject(tmp.toString(), Map.class));

		// 处理报文中ORDERITEM_LIST下的pay_item_info节点
		Map<String, Object> payItemMap = new HashMap<String, Object>();
		payItemMap.put("PAY_TYPE", "1");
		payItemMap.put("PAY_WAY", "4");
		payItemMap.put("SERVICE_CHARGE", "0");
		payItemMap.put("SERVICE_CHARGE_TYPE", "RMB");
		payItemMap.put("FAVOURABLE_CHARGE", "1");
		payItemMap.put("FAVOURABLE_CHARGE_TYPE", "RMB");
		payItemMap.put("SHOULD_PAY_CHARGE", "100");
		payItemMap.put("SHOULD_PAY_CHARGE_TYPE", "RMB");
		payItemMap.put("ACTUAL_PAY_CHARGE", "99");
		payItemMap.put("ACTUAL_PAY_CHARGE_TYPE", "RMB");

		orderMap.put("PAY_ITEM_INFO", payItemMap);

		// 处理报文中ORDERITEM_LIST下的DELIVER_INFO节点
		Map<String, Object> deliverMap = new HashMap<String, Object>();
		deliverMap.put("IS_DELIVER", "2");

		orderMap.put("DELIVER_INFO", deliverMap);

		List<Map<String, Object>> orderItemlist = new ArrayList<Map<String, Object>>();
		orderItemlist.add(orderMap);

		// 将拼接好的节点放入到MBean中的ORDERITEM_LIST 下
		inMbean.addBody("ORDERITEM_LIST", orderItemlist);
		/*
		 * Map<String ,Object> map = JSON.parseObject(inMbean.toString(),
		 * Map.class);
		 * 
		 * log.info(map.toString());
		 * 
		 * map.remove("ROOT.HEADER"); log.info(map.toString());
		 */

		String interfaceName = "com_sitech_crm_order_inter_service_UniOrderInfoService_createOrderInfoPubService";

		String outString = ServiceUtil.callService(interfaceName, inMbean.toString());

		log.info(outString);

		SCreateOrderOutDTO outParamDto = new SCreateOrderOutDTO();
		return outParamDto;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.sitech.acctmgr.inter.pay.IWxzf#sOrderPay(com.sitech.jcfx.dt.in.InDTO)
	 */
	@Override
	public OutDTO sOrderPay(InDTO inParam) {
		SOrderPayInDTO inDto = (SOrderPayInDTO) inParam;

		LoginEntity  loginEntity = login.getLoginInfo(inDto.getLoginNo(), inDto.getProvinceId());
		if( StringUtils.isEmptyOrNull(inDto.getGroupId()) ){
			inDto.setGroupId(loginEntity.getGroupId());
		}
		ChngroupRelEntity chngroupRelInfo = group.getRegionDistinct(inDto.getGroupId(), "2", inDto.getProvinceId());

		String sCurTime = control.getSysDate().get("CUR_TIME").toString();

		MBean inMbean = new MBean();
		Map<String, Object> oprInfoMap = new HashMap<String, Object>();
		oprInfoMap.put("ORDER_ID", inDto.getOrderId());
		oprInfoMap.put("PAY_CHANNEL", null);
		inMbean.setBody("OPR_INFO", oprInfoMap);
		inMbean.setHeader(inDto.getHeader());

		log.info("调用crm接口入参:"+inMbean.toString());
		String interfaceName = "com_sitech_crm_order_inter_service_PayInfoService_CreatePayOrderService";

		/*String outString = ServiceUtil.callService(interfaceName, inMbean.toString());

		log.info("调用crm接口创建支付订单返回值：" + outString);

		MBean mb = new MBean(outString);
		String jsonStr = JSON.toJSONString(mb.getBodyObject("DIV_DETAILS_LIST"));
		JSONObject bodyJson = (JSONObject) JSONObject.parse(jsonStr);*/

		// Map<String ,Object> actMap = bodyJson; List<Map<String,Object>>
		// list = (List<Map<String, Object>>) bodyJson.get("ACT_LIST");

		
		
		/*
		 * sprintf(inmsg,"amount=%d,amt_type=%s,bank_type=%s,busi_type=%s,
		 * client_ip=%s, \
		 * busi_parameter=[{\"auth_code\":\"%s\"}],notify_url=%s,order_desc=%s,
		 * order_id=%s,partner=%s,ret_url=%s, \ sign_type=%s,time=%s"
		 * ,amount,amt_type,bank_type,busi_type,client_ip,
		 * busi_parameter,notify_url,iOrderDesc,billId,partner,ret_url,
		 * sign_type,time);
		 */
		MBean inBean = new MBean();
		inBean.setBody("PAY_MONEY", inDto.getPayMoney());
		inBean.setBody("AMT_TYPE", "01");
		inBean.setBody("BANK_TYPE", "211004");
		inBean.setBody("BUSI_TYPE", "9999");
		inBean.setBody("CLIENT_IP", inDto.getClientIp());
		inBean.setBody("BUSI_PARAMETER", inDto.getBusiParameter());
		inBean.setBody("NOTIFY_URL", null);
		inBean.setBody("ORDER_DESC", inDto.getOrderDesc());
		// inBean.setBody("BILL_ID", ); 取订单出参中的ORDER_ITEM_ID
		inBean.setBody("PARTNER", chngroupRelInfo.getRegionCode());// 地市 老系统
																	// 从DCUSTMSG表中取出SUBSTR(BELONG_CODE,1,2)
																	// 后在前面拼接"40000"
		inBean.setBody("RET_URL", "");
		inBean.setBody("SIGN_TYPE", "MD5");

		inBean.setBody("TIME", sCurTime);

		log.info("调用miso接口入参："+inBean.toString());

		// 调用miso接口
		 Map<String, String> result = CrossEntity.callService("EAI_sOrderPay",inBean);//未定义调用的接口
		log.info("调用PD充值接口返回： " + result);

		SOrderPayOutDTO outDto = new SOrderPayOutDTO();
		return outDto;
	}

	/**
	 * @return the user
	 */
	public IUser getUser() {
		return user;
	}

	/**
	 * @param user
	 *            the user to set
	 */
	public void setUser(IUser user) {
		this.user = user;
	}

	/**
	 * @return the control
	 */
	public IControl getControl() {
		return control;
	}

	/**
	 * @param control
	 *            the control to set
	 */
	public void setControl(IControl control) {
		this.control = control;
	}

	/**
	 * @return the group
	 */
	public IGroup getGroup() {
		return group;
	}

	/**
	 * @param group
	 *            the group to set
	 */
	public void setGroup(IGroup group) {
		this.group = group;
	}

	/**
	 * @return the login
	 */
	public ILogin getLogin() {
		return login;
	}

	/**
	 * @param login the login to set
	 */
	public void setLogin(ILogin login) {
		this.login = login;
	}

}
