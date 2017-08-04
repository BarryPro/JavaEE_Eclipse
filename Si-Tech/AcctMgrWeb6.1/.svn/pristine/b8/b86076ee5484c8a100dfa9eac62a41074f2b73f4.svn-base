package com.sitech.acctmgr.atom.impl.jl.pay;

import com.sitech.acctmgr.atom.dto.pay.*;
import com.sitech.acctmgr.atom.entity.inter.*;
import com.sitech.acctmgr.atom.impl.pay.S8000;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.constant.PayBusiConst;
import com.sitech.acctmgr.common.domains.LoginPdomEntity;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@ParamTypes({ 
	@ParamType(m="init",c= S8000InitInDTO.class,oc=S8000InitOutDTO.class, 
			routeKey ="10",routeValue = "phone_no",busiComId = "构件id", 
			srvCat = "缴费",srvCnName = "缴费校验服务",srvVer = "V10.8.126.0", 
			srvDesc = "缴费校验服务",srcAttr = "核心",srvLocal = "否",srvGroup = "否"),
			
	@ParamType(m="cfm",c= S8000CfmInDTO.class,oc=S8000CfmOutDTO.class, 
			routeKey ="10",routeValue = "phone_no",busiComId = "构件id", 
			srvCat = "缴费",srvCnName = "缴费确认服务",srvVer = "V10.8.126.0", 
			srvDesc = "缴费确认服务",srcAttr = "核心",srvLocal = "否",srvGroup = "否")

			})

public class S8000JL extends S8000 {
	

	/**
	 *吉林个性化缴费限制 
	 */
	protected void querySepBusiInfo(Map<String, Object>inParam) {
		
		log.debug("缴费业务个性化限制querySepBusiInfo begin: " + inParam.toString());
		
		IUser  		user =  getUser();
		ILogin 		login = getLogin();
		IAgent 		agent = getAgent();
		IGroup 		group = getGroup();
		IRecord 	record = getRecord();
		
		long idNo = Long.parseLong(inParam.get("ID_NO").toString());
		String loginNo = inParam.get("LOGIN_NO").toString();
		String bradId = inParam.get("BRAND_ID").toString();
		String sPayPath = inParam.get("PAY_PATH").toString();
		
		//1.长白行、神州行且不是有效期用户限制前台缴费
		if(sPayPath.equals(PayBusiConst.OWNPATH) && 
				(bradId.equals("223bz0") || bradId.equals("2230cb"))){
			if(!user.isUserExpire(idNo,0)){   //不是有效期用户

					throw new BusiException(AcctMgrError.getErrorCode("8000","10001"), "长白行、神州行且不是有效期用户限制前台缴费!");
			}
			
		}
		
		//2.营业前台限制 ，空中充值代理商号码不允许办理缴费，提示：“此号码是空中充值代理商号码，请到自办自营营业厅缴费!”
/*		if(sPayPath.equals(PayBusiConst.OWNPATH) && agent.isKcAgentPhone(idNo)){
			
			if(!login.isOneselfLogin(loginNo)){
				
				//判断 缴费号码跟缴费营业厅是否做过绑定
				if(!record.isTransBind(inParam.get("LOGIN_GROUPID").toString(), inParam.get("PHONE_NO").toString())){
					
					throw new BusiException(AcctMgrError.getErrorCode("8000","10005"), "此号码是空中充值代理商号码且没有做过营业厅绑定，请到自办自营营业厅缴费!");
				}
			}
			
		}*/
		
		//3.状态不正常不许缴费 (预拆、预消不允许外围渠道缴费)
		String sRunCode = inParam.get("RUN_CODE").toString();
		if (!sPayPath.equals(PayBusiConst.OWNPATH)) {
			if (sRunCode.equals("I") || sRunCode.equals("J")) {
				throw new BusiException(AcctMgrError.getErrorCode("8000",
						"10002"), "预拆、预消状态不允许外围渠道缴费!");
			}
		}
		
		//普通工号缴费验证权限(非银行、缴费卡等工号)
		//String loginType = login.getLoginType(loginNo);
		String loginType = "";
		if (loginType.equals("0")
				&& !sPayPath.equals(PayBusiConst.SELFHELPPATH)) {

			/**
			 * 判断跨地市缴费和跨区县缴费权限
			 */
			List<LoginPdomEntity> loginPdomList = (List<LoginPdomEntity>) inParam.get("LOGIN_PDOM");
			if (loginPdomList != null) {
				String regionPdomFlag = "Y"; // 跨地市缴费权限标识
				String countyPdomFlag = "Y"; // 跨区县缴费权限标识
				for (LoginPdomEntity loginPdom : loginPdomList) {

					if (loginPdom.getBusiCode().equals("a030")) { // 跨地市缴费小权限

						regionPdomFlag = loginPdom.getCheckFlag();

					} else if (loginPdom.getBusiCode().equals("a034")) { // 跨区县缴费小权限

						countyPdomFlag = loginPdom.getCheckFlag();
					}

				}

				Map<String, Object> inMapTmp = null;
				Map<String, Object> outMapTmp = null;

				String conCountyGroup = "0";
				String flag = "0";

				inMapTmp = new HashMap<String, Object>();
				inMapTmp.put("GROUP_ID", inParam.get("LOGIN_GROUPID"));
				//outMapTmp = group.getRegionDistinct(inMapTmp);
				String loginReginId = (String) outMapTmp.get("REGION_CODE");

				inMapTmp = new HashMap<String, Object>();
				inMapTmp.put("GROUP_ID", inParam.get("LOGIN_GROUPID"));
				inMapTmp.put("PARENT_LEVEL", "3");
				//outMapTmp = group.getRegionDistinct(inMapTmp);
				String loginCountyGroup = (String) outMapTmp.get("PARENT_GROUP_ID");

				inMapTmp = new HashMap<String, Object>();
				inMapTmp.put("GROUP_ID", inParam.get("CON_GROUPID"));
				inMapTmp.put("PARENT_LEVEL", "3");
				// 出现异常不判断跨区县的缴费限制flag
				try {
					//outMapTmp = group.getRegionDistinct(inMapTmp);
					conCountyGroup = (String) outMapTmp.get("PARENT_GROUP_ID");
				} catch (BusiException e) {

					log.debug("取区县异常，不判断跨区县权限！");
					flag = "1";
				}

				if (!inParam.get("CON_REGIONID").equals(loginReginId)) {

					if (regionPdomFlag.equals("N")) {

						throw new BusiException(AcctMgrError.getErrorCode(
								"8000", "10003"), "该工号无权限跨地市缴费!");
					}
				} else if (!loginCountyGroup.equals(conCountyGroup)
						&& flag.equals("0")) {

					if (countyPdomFlag.equals("N")) {

						throw new BusiException(AcctMgrError.getErrorCode(
								"8000", "10004"), "该工号无权限跨区县缴费!");
					}
				}

			}

		}

	}
	
	
	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.atom.impl.pay.S8000#cfmSepBusiInfo(java.util.Map)
	 */
	/**
	 *吉林缴费个性化业务，联动优势空中充值需要记录联动优势代理商号码
	 */
	protected void cfmSepBusiInfo(Map<String, Object>inParam){
		
		if (inParam.get("PAY_PATH").toString().equals("91")) {
			Map<String, Object> inMapTmp = new HashMap<String, Object>();
			inMapTmp.put("PAY_SN", inParam.get("PAY_SN"));
			inMapTmp.put("CONTRACT_NO", inParam.get("CONTRACT_NO"));
			inMapTmp.put("ID_NO", inParam.get("ID_NO"));
			inMapTmp.put("FOREIGN_SN", inParam.get("FOREIGN_SN"));
			inMapTmp.put("FIELD_CODE", "AGENT_PNO");
			inMapTmp.put("FIELD_VALUE", inParam.get("AGENT_PHONE"));
			inMapTmp.put("FIELD_ORDER", "0");
			inMapTmp.put("OP_TIME", inParam.get("OP_TIME"));
			inMapTmp.put("OP_CODE", inParam.get("OP_CODE"));
			inMapTmp.put("LOGIN_NO", inParam.get("LOGIN_NO"));

			//getBalance().savePayextend(inMapTmp);
		}
	}
	
	/**
	 *功能：获取缴费号码，如果传入缴费号码，则按照入参中返回，否则根据账户获取，通用规则，获取账户下优先级最高的号码
	 */
	protected String getPayPhone(String phoneNo, Long contractNo){
		
		if(phoneNo != null && !phoneNo.equals("")){
			
			return phoneNo;
		}else{
			
			//String defPhone = getAccount().getDefPayPhoneByCon(contractNo);
			String defPhone = "";
			if (defPhone.equals("")) {
				defPhone = "99999999999";
			}
			
			return defPhone;
		}
		
		//如果是家庭公共账户，则取 家庭主卡号码做为缴费号码记录
		
	}
	
}
