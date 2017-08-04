package com.sitech.acctmgr.atom.impl.pay;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.busi.pay.inter.IPreOrder;
import com.sitech.acctmgr.atom.domains.balance.SignPayEntity;
import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.base.LoginEntity;
import com.sitech.acctmgr.atom.domains.record.LoginOprEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.pay.S8014GrpCfmInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8069CfmInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8069CfmOutDTO;
import com.sitech.acctmgr.atom.dto.pay.S8069alipayCfmInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8069alipayCfmOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.ILogin;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.atom.entity.inter.IUserSign;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.constant.PayBusiConst;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.acctmgr.inter.pay.I8069;
import com.sitech.acctmgrint.atom.busi.intface.IShortMessage;
import com.sitech.common.CrossEntity;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.util.DateUtil;

/**
 *
 * <p>Title: 银行卡签约用户主动缴费  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
@ParamTypes({ 
	@ParamType(m="cfm",c= S8069CfmInDTO.class,oc=S8069CfmOutDTO.class, 
			routeKey ="10",routeValue = "phone_no",busiComId = "构件id", 
			srvCat = "缴费",srvCnName = "银行卡签约用户主动缴费",srvVer = "V10.8.126.0", 
			srvDesc = "银行卡签约用户主动缴费",srcAttr = "核心",srvLocal = "否",srvGroup = "否"),
	@ParamType(m = "alipayCfm", c = S8069alipayCfmInDTO.class)
			})
public class S8069 extends AcctMgrBaseService implements I8069 {
	
	private ILogin 		  login;
	private IUser		  user;
	private IControl	  control;
	private IRecord		  record;
	private IUserSign	  userSign;
	private IPreOrder	  preOrder;
	private IGroup		  group;
	private IShortMessage shortMessage;
	
	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.inter.pay.I8069#cfm(com.sitech.jcfx.dt.in.InDTO)
	 */
	@Override
	public OutDTO cfm(InDTO inParam) {
		
		S8069CfmInDTO inDto = (S8069CfmInDTO)inParam;
		log.info("S8069 cfm begin" + inDto.getMbean());
		if( StringUtils.isEmptyOrNull(inDto.getGroupId()) ){
			LoginEntity  loginEntity = login.getLoginInfo(inDto.getLoginNo(), inDto.getProvinceId());
			inDto.setGroupId(loginEntity.getGroupId());
		}
		
		String sCurDate = DateUtil.format(new Date(), "yyyyMMddHHmmss");
		String sCurYm = sCurDate.substring(0, 6);
		String totalDate = sCurDate.substring(0, 8);
		String time = sCurDate.substring(8, 14);
		
		//1、获取用户信息
		UserInfoEntity signUser = user.getUserInfo(inDto.getPhoneNoSign());
		UserInfoEntity payUser = user.getUserEntity(null, inDto.getPhoneNoPay(), null, true);
		
		if(!userSign.isSign(signUser.getIdNo(), PayBusiConst.SIGN_BUSI_TYPE_YHK)){
			
			log.info("用户没有办理银行卡签约业务");
			throw new BusiException(AcctMgrError.getErrorCode("8069","00001"), "该用户非银行卡签约用户" + signUser.getIdNo());
		}
		
		//2、获取签约信息
		String agreementId = getSignInfo(signUser.getIdNo());
		
		long loginAccept = control.getSequence("SEQ_PAY_SN");
		//3、调用平台接口
		//sprintf(s_RPID,"%s%06d%06d%010ld", s_SPID,i_TotalDate,i_time,l_LoginAccept%10000000000);
		String rpid =  totalDate + time + loginAccept; //需要确定拼几位
		String spid = getSpid(inDto.getLoginNo());     //渠道号ID
		MBean inBean = new MBean();
		inBean.setBody("FUNCODE", "344002");	
		inBean.setBody("MOBILENO", inDto.getPhoneNoSign());			//签约号码
		inBean.setBody("REQDATE", totalDate);
		inBean.setBody("REQTIME", time);
		inBean.setBody("RPID", rpid);
		inBean.setBody("SPID", spid);		//渠道号
		inBean.setBody("PICKUPMOBILEID", inDto.getPhoneNoPay());   //缴费号码
		inBean.setBody("AMT", inDto.getPayMoney());				//缴费金额，单位：分?
		inBean.setBody("AGREEMENTID", agreementId);
		//Map<String, String> result = CrossEntity.callService("EAI_BankCard_Pay", inBean);
		
		//4、记录交易信息
		SignPayEntity signPay = new SignPayEntity();
		signPay.setPhoneNoSign(inDto.getPhoneNoSign());
		signPay.setIdNoSign(signUser.getIdNo());
		signPay.setPhoneNoPay(inDto.getPhoneNoPay());
		signPay.setIdNoPay(payUser.getIdNo());
		signPay.setPayMoney(Long.parseLong(inDto.getPayMoney()));
		signPay.setBusiType(PayBusiConst.SIGN_BUSI_TYPE_YHK);
		signPay.setLoginNo(inDto.getLoginNo());
		signPay.setOpTime(sCurDate);
		signPay.setLoginAccept(loginAccept);
		signPay.setYearMonth(Long.parseLong(sCurYm));
		record.iSignPay(signPay);
		log.info("signPa表记录插入完成");
		
		//记录营业员操作日志
		LoginOprEntity in = new LoginOprEntity();
		in.setIdNo(signUser.getIdNo());
		in.setBrandId(signUser.getBrandId());
		in.setPhoneNo(inDto.getPhoneNoPay());
		in.setPayType("");
		in.setPayFee(Long.parseLong(inDto.getPayMoney()));
		in.setLoginSn(loginAccept);
		in.setLoginNo(inDto.getLoginNo());
		in.setLoginGroup(inDto.getGroupId());
		in.setOpCode(inDto.getOpCode());
		in.setTotalDate(Long.parseLong(totalDate));
		in.setRemark("银行卡签约用户主动缴费");
		record.saveLoginOpr(in);
		
		
		//同步CRM统一接触
		ChngroupRelEntity groupEntity = group.getRegionDistinct(signUser.getGroupId(), "2", inDto.getProvinceId());
		Map<String, Object> oprCnttMap = new HashMap<String, Object>();
		oprCnttMap.put("Header", inDto.getHeader());
		oprCnttMap.put("PAY_SN", loginAccept);
		oprCnttMap.put("LOGIN_NO", inDto.getLoginNo());
		oprCnttMap.put("GROUP_ID", inDto.getGroupId());
		oprCnttMap.put("OP_CODE", inDto.getOpCode());
		oprCnttMap.put("REGION_ID", groupEntity.getRegionCode());
		oprCnttMap.put("OP_NOTE", "银行卡签约用户主动缴费");
		oprCnttMap.put("TOTAL_FEE", Long.parseLong(inDto.getPayMoney()));
		oprCnttMap.put("CUST_ID_TYPE", "1");
		oprCnttMap.put("CUST_ID_VALUE", inDto.getPhoneNoPay());
		oprCnttMap.put("OP_TIME", sCurDate);
		preOrder.sendOprCntt(oprCnttMap);
		
		//5、发送短信
		sendpayMsg(inDto.getPhoneNoSign(), inDto.getPhoneNoPay(), Long.parseLong(inDto.getPayMoney()), inDto.getLoginNo(), inDto.getOpCode());
		
		S8069CfmOutDTO outDto = new S8069CfmOutDTO();
		outDto.setTotalDate(totalDate);
		outDto.setLoginAccept(String.valueOf(loginAccept));
		
		return outDto;
	}
	
	public OutDTO alipayCfm(InDTO inParam){
		
		S8069alipayCfmInDTO inDto = (S8069alipayCfmInDTO)inParam;
		
		String s_in_PhoneNo = inDto.getPhoneNo();
		String s_in_PassWD = inDto.getPassWD();
		String s_in_LoginNo = inDto.getLoginNo();
		String s_in_LoginPass = inDto.getLoginPassWD();
		String s_in_PhoneNoPay = inDto.getPhoneNoPay();
		String s_in_quantity = inDto.getQuantity();
		double d_in_PayMoney = ValueUtils.transFenToYuan(inDto.getPayMoney());
		String s_in_pay_other_info = inDto.getPayOtherInfo();
		String s_in_memo = inDto.getMemo();
		String s_in_extend_1= inDto.getExtendOne();
		String s_in_extend_2 = inDto.getExtendTwo();
		String s_in_busi_type = inDto.getBusiType();
		String s_in_busi_parameter = inDto.getBusiParameter();
		String s_in_goods_info = inDto.getGoodsInfo();
		String s_in_discount_rate = inDto.getDiscountRate();
		long s_in_payMoney = inDto.getDiscountPayMoney();
		long loginAccept = 0;//操作记录流水
		
		String bank_type = "";//实体支付商编号
		String partner = "";//商户编号
		String notify_url = "http://10.111.67.140:8090/trade";//后台通知URL
		String external_user_id = "";//商户渠道用户标识
		String item_code = "";//代扣项代码
		String bill_id = "";//支付订单号
		String order_desc = "IVR";//订单描述
		String order_time = "";//订单生成时间
		long amount = inDto.getPayMoney();//付款金额 分
		String recharge_price = "";
		String amt_type = "01";//货币类型 01
		String ret_url = "";//前台跳转URL
		String sign_id = "";//签约号
		String quantity = "";//商品数量    -------------待确认)
		String pay_other_info = "";//支付时需要的其它信息
		String memo = s_in_memo;//付款备注
		String client_ip = "127.0.0.1";//安全字段
		String extend_1 = s_in_extend_1;//扩展字段1
		String extend_2 = s_in_extend_2;//扩展字段2
		String sign_type = "MD5";//加密方式
		String sign = "";//数字签名
		String sign_key = "";
		String busi_type = "1003";//业务类型
		String busi_parameter = s_in_busi_parameter;//业务参数
		String goods_info = "";//商品信息   ---------------待补充)
		String vTrasCode = "";
		String ret_code = "";
		String error_message = "";
		String s_OpTime = "";
		String sRegionCode = "";
		String seller_id = "";//被交商户编号，充值号码partner
		
		String s_vTrasCode = "2";
		
		if(s_in_quantity == "" || s_in_quantity == null){
			quantity = "1";
		}else{
			quantity = s_in_quantity;
		}
		
		if(extend_1 == "" || extend_1 == null){
			extend_1 = "op_user"+s_in_LoginNo+"op_password"+s_in_LoginPass;
		}
		
		if(s_in_busi_type == "" || s_in_busi_type == null){
			busi_type = "90112";
		}else{
			busi_type = s_in_busi_type;
		}
		log.info("电话号码："+s_in_LoginNo);
		//获取用户信息
		UserInfoEntity userInfo = user.getUserEntityByPhoneNo(s_in_PhoneNo, true);
		long idNo = userInfo.getIdNo();
		String groupId = userInfo.getGroupId();
		String brandId = userInfo.getBrandId();
		ChngroupRelEntity regionInfo = group.getRegionDistinct(groupId, "2", "230000");
		String regionId = regionInfo.getRegionCode();//用户归属地市
		String regionGroupId = regionInfo.getParentGroupId();
		
		//获取用户信息
		UserInfoEntity userInfo2 = user.getUserEntityByPhoneNo(s_in_PhoneNo, true);
		long idNo2 = userInfo2.getIdNo();
		String groupId2 = userInfo2.getGroupId();
		ChngroupRelEntity regionInfo2 = group.getRegionDistinct(groupId, "2", "230000");
		String regionId2 = regionInfo2.getRegionCode();//用户归属地市
		String regionGroupId2 = regionInfo2.getParentGroupId();
		
		seller_id = "10000"+regionId2.substring(3,4);
		
		boolean isAlipay = userSign.isAlipay(idNo);
		//判断是否为支付宝用户
		if(!isAlipay){
			throw new BusiException(AcctMgrError.getErrorCode("8069","00002"), "该用户非支付宝签约用户" + idNo);
		}
		
		//创建订单	
		Map<String,Object> createMap = new HashMap<String,Object>();
		DateUtils dateUtil = new DateUtils();
		createMap.put("ORDER_TIME", dateUtil.getCurDate("yyyyMMddHHmmss"));
		createMap.put("TOTAL_PAY_MONEY", inDto.getPayMoney());
		createMap.put("PHONE_NO", inDto.getPhoneNo());
		createMap.put("PHONE_NO_PAY", inDto.getPhoneNoPay());
		createMap.put("TOTAL_RECHARGE_PRICE", inDto.getPayMoney());
		createMap.put("DISCOUNT_RATE", inDto.getDiscountRate());
		createMap.put("DISCOUNT_PAY_MONEY", inDto.getDiscountPayMoney());
		createOrder(createMap);
		
		//获取签约用户信息
		bank_type = userSign.getSignAddInfo(idNo, busi_type, "10030001");
		sign_id = userSign.getSignAddInfo(idNo, busi_type, "10030002");
		external_user_id = userSign.getSignAddInfo(idNo, busi_type, "10030005");
		item_code = userSign.getSignAddInfo(idNo, busi_type, "10030003");
//		Map<String,Object> partnerMap = userSign.getAlipaySign(regionGroupId, s_in_LoginNo);
//		partner = (String)partnerMap.get("PARTNER");
//		sign_key = (String) partnerMap.get("SECRET");
		
		MBean inBean = new MBean();
		inBean.setBody("amount",amount);
		inBean.setBody("amt_type",amt_type);
		inBean.setBody("bank_type",bank_type);
		inBean.setBody("busi_type",busi_type);
		inBean.setBody("client_ip",client_ip);
		inBean.setBody("extend_1",extend_1);
		inBean.setBody("external_user_id",external_user_id);
		inBean.setBody("notify_url",notify_url);
		inBean.setBody("order_desc",order_desc);
		inBean.setBody("order_id",bill_id);
		inBean.setBody("partner",partner);
		inBean.setBody("pay_other_info","seller_id"+bill_id);
		inBean.setBody("quantity",quantity);
		inBean.setBody("sign_id",sign_id);
		inBean.setBody("sign_type",sign_type);
		inBean.setBody("time",order_time);
		inBean.setBody("key",sign_key);
		Map<String, String> result =CrossEntity.callService("EAI_ZHIFUBAO_PAY", inBean);
		log.info("缴费结果"+result.toString());
		String returnCode = result.get("RETN");
		if(!returnCode.equals("0")){
			throw new BusiException(AcctMgrError.getErrorCode("8069","00003"), "CRMPD充值接口调用失败");
		}
		
		loginAccept = control.getSequence("SEQ_PAY_SN");
		String loginGroupId = login.getLoginInfo(s_in_LoginNo, "230000").getGroupId();
		LoginOprEntity oprEnt = new LoginOprEntity();
		oprEnt.setBrandId(brandId);
		oprEnt.setIdNo(idNo);
		oprEnt.setLoginGroup(loginGroupId);
		oprEnt.setLoginNo(s_in_LoginNo);
		oprEnt.setLoginSn(loginAccept);
		oprEnt.setOpCode("8069");
		oprEnt.setOpTime(DateUtils.getCurDate("yyyyMMddHHmmss"));
		oprEnt.setPayFee((-1) * s_in_payMoney);
		oprEnt.setPayType("0");
		oprEnt.setPhoneNo(s_in_PhoneNo);
		oprEnt.setRemark("IVR支付宝主动交费");
		oprEnt.setTotalDate(DateUtils.getCurDay());
		record.saveLoginOpr(oprEnt);
		
		S8069alipayCfmOutDTO outDto = new S8069alipayCfmOutDTO();
		return outDto;
	}
	
	private void createOrder(Map<String,Object> inParam){
		
		String method = "createOrder";//接口名称
		String session_key = "1";//分配给用户的sessionkey
		String timestamp = (String)inParam.get("ORDER_TIME");//时间戳
		String format = "json";//制定响应格式 默认为jiso
		String app_key = "C1C858BB37F48180A39D0247476747AB";//分配给应用的AppKey
		String v = "3";//API协议版本，可选值:1、2、3
		String sign = "";//数字签名
		String sign_method = "";//数字签名方式
		String channel_id = "1022";//调用者渠道
		String staff_code = "186100";//调用者编号(session_key支持之后，从session_key里面获取)
		String shop_id = "1";//商户编号session_key支持之后，从session_key里面获取)（2.0版本必须传入）
		String staff_id = "";//调用者id(session_key支持之后，从session_key里面获取)
		String external_order_id = "0001";//外部系统订单流水号
		String region_id = "";//地市流水号
		String ifdeal = "0";//是否需要商城进行工作流订单处理:0：不需要商城进行订单处理1:需要商城进行订单处理默认0不需要
		String status = "0";//订单状态
		String move_st = "0000";//订单流转状态
		String pay_status = "3";//支付状态 0、未支付1、已支付2、支付中
		String total_price = String.valueOf(inParam.get("TOTAL_PAY_MONEY"));//总金额，单位分
		String amount_paid_done = "0";//已支付金额
		String order_type = "0";//0：WEB；1：IVR；2：短信；3：WAP；4：JAVA
		String create_time = (String)inParam.get("ORDER_TIME");//创建订单时间
		String confirm_time = (String)inParam.get("ORDER_TIME");//确认订单时间
		String tran_time = "";//支付完成通知时间
		String remark = "";//订单备注
		String pay_num = "";//手机号码
		String sms_phone = "";//接受短信手机号码
		String type = "90112";//支付类型
		String login_num = (String)inParam.get("PHONE_NO");//签约号码
		String login_type = "2";
		String pay_channel_id = "1";//支付方式
		String if_pay_all = "";//是否一次性支付
		String invoice_info = "";//发票信息
		String logistics_info = "";//物流信息
		String total_recharge_price = String.valueOf(inParam.get("TOTAL_PAY_MONEY"));//充值缴费业务类型的时候必传，默认0，单位分
		String other_info = "";//其他信息
		String order_item_list = "";//订单商品类表
		String order_id = "";
		String s_region_id = "";
		
		MBean inBean = new MBean();
		inBean.setBody("method",method);
		inBean.setBody("session_key",session_key);
		inBean.setBody("timestamp",timestamp);
		inBean.setBody("format",format);
		inBean.setBody("app_key",app_key);
		inBean.setBody("v",v);
		inBean.setBody("sign",sign);
		inBean.setBody("sign_method",sign_method);
		inBean.setBody("channel_id",channel_id);
		inBean.setBody("staff_code",staff_code);
		inBean.setBody("shop_id",shop_id);
		inBean.setBody("staff_id",staff_id);
		inBean.setBody("external_order_id",external_order_id);
		inBean.setBody("region_id",region_id);
		inBean.setBody("ifdeal",ifdeal);
		inBean.setBody("status",status);
		inBean.setBody("move_st",move_st);
		inBean.setBody("pay_status",pay_status);
		inBean.setBody("total_price",total_price);
		inBean.setBody("amount_paid_done",amount_paid_done);
		inBean.setBody("order_type",order_type);
		inBean.setBody("create_time",create_time);
		inBean.setBody("confirm_time",confirm_time);
		inBean.setBody("tran_time",tran_time);
		inBean.setBody("remark",remark);
		inBean.setBody("pay_num",pay_num);
		inBean.setBody("sms_phone",sms_phone);
		inBean.setBody("type",type);
		inBean.setBody("pay_channel_id",pay_channel_id);
		inBean.setBody("if_pay_all",if_pay_all);
		inBean.setBody("invoice_info",invoice_info);
		inBean.setBody("logistics_info",logistics_info);
		inBean.setBody("total_recharge_price",total_recharge_price);
		inBean.setBody("other_info",other_info);
		inBean.setBody("user_type","2");
		inBean.setBody("login_type","2");
		inBean.setBody("login_num",login_num);
		inBean.setBody("session_id","4VzhRttBBntJXYvt1n6pn72dxyJ278JZwTTMY0J2Q1YnHqy3R8XP!-1303715780!1374547393908");
		inBean.setBody("product_id","1");
		inBean.setBody("product_name","充值缴费类商品");
		inBean.setBody("order_num","1");
		inBean.setBody("price",total_price);
		inBean.setBody("recharge_status","0");
		inBean.setBody("status1","0");
		inBean.setBody("remark1","充值缴费");
		inBean.setBody("offsetprice","");
		inBean.setBody("package_stall_id","");
		inBean.setBody("phone_num",(String)inParam.get("PHONE_NO"));
		inBean.setBody("phone_num_old",(String)inParam.get("PHONE_NO_PAY"));
		inBean.setBody("assortment_id","");
		inBean.setBody("split_info","");
		inBean.setBody("recharge_price",String.valueOf(inParam.get("TOTAL_RECHARGE_PRICE")));
		inBean.setBody("recharge_status","0");
		inBean.setBody("auxiliary_info","");
		inBean.setBody("network_info","");
		inBean.setBody("discount_rate",String.valueOf(inParam.get("DISCOUNT_RATE")));
		inBean.setBody("pay_money",String.valueOf(inParam.get("DISCOUNT_PAY_MONEY")));
		Map<String, String> result =CrossEntity.callService("EAI_CreateOrder_PAY", inBean);
		log.info("创建订单"+result.toString());
		String returnCode = result.get("RETN");
		if(!returnCode.equals("0")){
			throw new BusiException(AcctMgrError.getErrorCode("8069","00004"), "创建订单调用接口失败");
		}

	}
	
	private String getSignInfo(long idNo){
		
		String agreementId = "";
		
		List<Map<String, Object>> signAddInfoList = userSign.getUserSignAddInfo(idNo, PayBusiConst.SIGN_BUSI_TYPE_YHK, null);
		for(Map<String, Object> tmpMap : signAddInfoList){
			if(tmpMap.get("FIELD_CODE").toString().equals("10020001")){
				
				agreementId = tmpMap.get("FIELD_VALUE").toString();
			}
		}
		
		return agreementId;
	}
	
	private void sendpayMsg(String phoneNoSign, String phoneNoPay, long payMoney, String loginNo, String opCode){
		
		String sCurTime = DateUtil.format(new Date(), "yyyyMMddHHmmss");
		
		Map<String, Object> mapTmp = new HashMap<String, Object>();
		Map<String, Object> mapTmp2 = new HashMap<String, Object>();
		MBean inMessage = new MBean();
		
		if(phoneNoSign.equals(phoneNoPay)){
			//BOSS_6014: 尊敬的客户，您本次使用“易充值”成功充值${pay_money}元。中国移动${sms_release}
			mapTmp.put("pay_money", ValueUtils.transFenToYuan(payMoney));
			mapTmp.put("sms_release", "");
			inMessage.addBody("TEMPLATE_ID", "311200806901");
			
		}else{
			//BOSS_6016: 尊敬的客户，您于${year}年${month}月${day}日${hour}时${minute}分，使用“易充值”成功为手机号码${phone_no}充值${pay_money}元。【中国移动】
			mapTmp.put("year", sCurTime.substring(0, 4));
			mapTmp.put("month", sCurTime.substring(4, 6));
			mapTmp.put("day", sCurTime.substring(6, 8));
			mapTmp.put("hour", sCurTime.substring(8, 10));
			mapTmp.put("minute", sCurTime.substring(10, 12));
			mapTmp.put("phone_no", phoneNoPay);
			mapTmp.put("pay_money", ValueUtils.transFenToYuan(payMoney));
			inMessage.addBody("TEMPLATE_ID", "311200806902");
			
			//BOSS_6017: 尊敬的客户，手机号码${phone_no}于${year}年${month}月${day}日${hour}时${minute}分，使用“易充值”为您充值${pay_money}元。【中国移动】
			mapTmp2.put("phone_no", phoneNoSign);
			mapTmp2.put("year", sCurTime.substring(0, 4));
			mapTmp2.put("month", sCurTime.substring(4, 6));
			mapTmp2.put("day", sCurTime.substring(6, 8));
			mapTmp2.put("hour", sCurTime.substring(8, 10));
			mapTmp2.put("minute", sCurTime.substring(10, 12));
			mapTmp2.put("pay_money", ValueUtils.transFenToYuan(payMoney));
		}
		
		inMessage.addBody("PHONE_NO", phoneNoSign);
		inMessage.addBody("LOGIN_NO", loginNo);;
		inMessage.addBody("OP_CODE", opCode);
		inMessage.addBody("CHECK_FLAG", true);
		inMessage.addBody("DATA", mapTmp);
		
		String flag = control.getPubCodeValue(2011, "DXFS", null);         // 0:直接发送 1:插入短信接口临时表 2：外系统有问题，直接不发送短信
		if(flag.equals("0")){
			inMessage.addBody("SEND_FLAG", 0);
		}else if(flag.equals("1")){
			inMessage.addBody("SEND_FLAG", 1);
		}else if(flag.equals("2")){
			return;
		}
		log.info("发送短信内容：" + inMessage.toString());
		shortMessage.sendSmsMsg(inMessage, 1);
		
		if(!phoneNoSign.equals(phoneNoPay)){
			inMessage.setBody("PHONE_NO", phoneNoPay);
			inMessage.setBody("TEMPLATE_ID", "311200806903");
			inMessage.setBody("DATA", mapTmp2);
			log.info("发送短信内容2：" + inMessage.toString());
			shortMessage.sendSmsMsg(inMessage, 1);
		}
		
	}
	
	private String getSpid(String loginNo){
		
		if(loginNo.substring(0, 6).equals("newweb")){	//网厅
			return "M0451002";
		}else if(loginNo.substring(0, 6).equals("newsms")){	//短厅
			return "Z3451001";
		}else if(loginNo.substring(0, 6).equals("186100")){	//IVR
			return "Z5451001";
		}else{
			return "Z6451000";
		}
	}

	public IGroup getGroup() {
		return group;
	}

	public void setGroup(IGroup group) {
		this.group = group;
	}

	public IPreOrder getPreOrder() {
		return preOrder;
	}

	public void setPreOrder(IPreOrder preOrder) {
		this.preOrder = preOrder;
	}

	public ILogin getLogin() {
		return login;
	}

	public void setLogin(ILogin login) {
		this.login = login;
	}

	public IUser getUser() {
		return user;
	}

	public void setUser(IUser user) {
		this.user = user;
	}

	public IControl getControl() {
		return control;
	}

	public void setControl(IControl control) {
		this.control = control;
	}

	public IRecord getRecord() {
		return record;
	}

	public void setRecord(IRecord record) {
		this.record = record;
	}

	public IUserSign getUserSign() {
		return userSign;
	}

	public void setUserSign(IUserSign userSign) {
		this.userSign = userSign;
	}

	public IShortMessage getShortMessage() {
		return shortMessage;
	}

	public void setShortMessage(IShortMessage shortMessage) {
		this.shortMessage = shortMessage;
	}
	
}
