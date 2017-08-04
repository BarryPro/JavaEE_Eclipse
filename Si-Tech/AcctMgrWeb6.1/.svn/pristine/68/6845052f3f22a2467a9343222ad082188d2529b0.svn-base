package com.sitech.acctmgr.atom.entity;

import static org.apache.commons.collections.MapUtils.safeAddToMap;

import java.io.IOException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.sitech.acctmgr.atom.domains.pub.PubBillCtrlEntity;
import com.sitech.acctmgr.atom.domains.pub.PubCodeDictEntity;
import com.sitech.acctmgr.atom.domains.pub.PubDbrouteConfEntity;
import com.sitech.acctmgr.atom.domains.pub.PubWrtoffCtrlEntity;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.BaseBusi;
import com.sitech.acctmgr.common.BlurSensitiveInfo;
import com.sitech.acctmgr.common.InterProperties;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.net.ServerInfo;
import com.sitech.common.utils.PrivacyUtil;
import com.sitech.common.utils.PwdUtil;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.util.CodecUtil;

/**
 * <p>
 * Title: 公共配置类
 * </p>
 * <p>
 * Description: 查询出帐标志、出帐日期等配置信息
 * </p>
 * <p>
 * Copyright: Copyright (c) 2014
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 *
 * @author yankma
 * @version 1.0
 */
@SuppressWarnings("unchecked")
public class Control extends BaseBusi implements IControl {
	
	private static final String WRITEOFFING_FLAG = "1";

	@Override
	public PubWrtoffCtrlEntity getWriteOffFlagAndMonth() {
		String sWrtoffFlag = "0";
		int iWrtoffMonth = 0;
		PubWrtoffCtrlEntity result = (PubWrtoffCtrlEntity) baseDao.queryForObject("pub_wrtoff_ctrl.qWriteOffFlagAndMonth");
		log.info("ResultMap => " + result);
		String wrtoffFlag = "0";

		if (result != null) {
			wrtoffFlag = result.getWrtoffFlag();
		}
		if (WRITEOFFING_FLAG.equals(wrtoffFlag)) {/* 销账期间 */
			iWrtoffMonth = Integer.valueOf(result.getWrtoffMonth());
			sWrtoffFlag = "1";
		}
		/* else{ throw new BaseException(AcctMgrError.getErrorCode("8010", "10004"),"取冲销标识出错"); } */
		PubWrtoffCtrlEntity ctlEntity = new PubWrtoffCtrlEntity();
		ctlEntity.setWrtoffFlag(sWrtoffFlag);
		ctlEntity.setWrtoffMonth(iWrtoffMonth);

		return ctlEntity;
	}

	/* (non-Javadoc)
	 * 
	 * @see com.sitech.acctmgr.atom.entity.inter.IControl#getPubCodeValue(long, java.lang.String, java.lang.String) */
	public String getPubCodeValue(long lCodeClass, String codeId, String groupId) {

		return this.getPubCodeValue(lCodeClass, codeId, groupId, true);
	}
	
	public String getPubCodeValue(long lCodeClass, String codeId, String groupId, boolean throwFlag){
		
		Map<String, Object> inMapTmp = new HashMap<String, Object>();
		inMapTmp.put("CODE_CLASS", lCodeClass);
		if (StringUtils.isNotEmptyOrNull(codeId)) {
			inMapTmp.put("CODE_ID", codeId);
		}

		if (StringUtils.isNotEmpty(groupId)) {
			inMapTmp.put("GROUP_ID", groupId);
		}
		PubCodeDictEntity result = (PubCodeDictEntity) baseDao.queryForObject("pub_codedef_dict.qVision", inMapTmp);
		if(throwFlag){
			if (result == null) {
				log.error("pub_codedef_dict表配置缺失，" + inMapTmp.toString());
				throw new BusiException(AcctMgrError.getErrorCode("0000", "00006"), "pub_codedef_dict表配置缺失 :" + inMapTmp.toString());
			}else{
				return result.getCodeValue();
			}
		}else{
			if (result == null) {
				return null;
			}else{
				return result.getCodeValue();
			}
		}
	}
	
	@Override
	public List<PubCodeDictEntity> getPubCodeList(Long codeClass, String codeId, String groupId, String status) {
		/* Map<String, Object> inMap = new HashMap<String, Object>();
		 * 
		 * inMap.put("CODE_CLASS", codeClass); if (StringUtils.isNotEmpty(codeId)) { inMap.put("CODE_ID", codeId); } if (StringUtils.isNotEmpty(groupId)) { inMap.put("GROUP_ID", groupId); } if (StringUtils.isNotEmpty(status)) { inMap.put("STATUS", status); } List<PubCodeDictEntity> publist = baseDao.queryForList("pub_codedef_dict.qVision", inMap); return publist; */

		return getPubCodeList(codeClass, codeId, groupId, status, null);
	}

	@Override
	public List<PubCodeDictEntity> getPubCodeList(Long codeClass, String codeId, String groupId, String status, String codeValue) {

		Map<String, Object> inMap = new HashMap<String, Object>();

		inMap.put("CODE_CLASS", codeClass);
		if (StringUtils.isNotEmpty(codeId)) {
			inMap.put("CODE_ID", codeId);
		}
		if (StringUtils.isNotEmpty(groupId)) {
			inMap.put("GROUP_ID", groupId);
		}
		if (StringUtils.isNotEmpty(status)) {
			inMap.put("STATUS", status);
		}
		if (StringUtils.isNotEmpty(codeValue)) {
			inMap.put("CODE_VALUE", codeValue);
		}
		List<PubCodeDictEntity> publist = baseDao.queryForList("pub_codedef_dict.qVision", inMap);

		return publist;
	}
	
	@Override
	public Set<String> getCodeId(long codeClass, String codeValue){
		
		Set<String> outParam = new HashSet<String>();
		
		List<PubCodeDictEntity> tmpList = this.getPubCodeList(codeClass, null, null, null, codeValue);
		for(PubCodeDictEntity tmp : tmpList){
			
			outParam.add(tmp.getCodeId());
		}
		
		log.debug("getCodeId结果：" + outParam.toString());
		return outParam;
	}

	/* (non-Javadoc)
	 * 
	 * @see com.sitech.acctmgr.atom.entity.inter.IControl#getCctCtrlFlag(java.lang .String, java.lang.String, java.lang.String) */
	public String getCctCtrlFlag(String ctrlNo, String opCode, String regionId) {

		Map<String, Object> inMapTmp = new HashMap<String, Object>();
		inMapTmp.put("CTRL_NO", ctrlNo);
		inMapTmp.put("OP_CODE", opCode);
		if (regionId != null) {
			inMapTmp.put("REGION_ID", regionId);
		}
		Map<String, Object> result = (Map<String, Object>) baseDao.queryForObject("cct_business_ctrl.qCtrlFlag", inMapTmp);
		if (result == null) {
			log.error("cct_business_ctrl表配置缺失，CTRL_NO: " + ctrlNo + " OP_CODE: " + opCode);
			throw new BusiException(AcctMgrError.getErrorCode("0000", "00011"), "cct_business_ctrl表配置缺失，CTRL_NO: " + ctrlNo + " OP_CODE: " + opCode);
		}
		return (result.get("CTRL_FLAG")).toString().trim();

	}

	/* (non-Javadoc)
	 * 
	 * @see com.sitech.acctmgr.atom.entity.IControl#pubEncryptData(java.util.Map) */
	@Override
	public String pubEncryptData(String inName, int inType) {
		String out_data = "";
		String inName_tmp = "";
		if (inType == 0) {
			out_data = PrivacyUtil.encode(inName);
			out_data = "++" + out_data;

		} else if (inType == 1) {
			try {
				inName = inName.substring(2);
				// out_data=PrivacyUtil.decode(inName);
				log.debug("inName=" + inName);
				byte[] tmpByte = CodecUtil.decodeBASE64(inName);
				String bufTmp = new String(tmpByte, "GBK");
				out_data = bufTmp;

			} catch (IOException e) {
				e.printStackTrace();
			}

		} else if (inType == 2) {
			// 涉及到客户姓名，只显示姓，名用*替代；
			inName = inName.substring(2);
			try {
				// inName_tmp=PrivacyUtil.decode(inName);

				byte[] tmpByte = CodecUtil.decodeBASE64(inName);
				String bufTmp = new String(tmpByte, "GBK");
				inName_tmp = bufTmp;

			} catch (IOException e) {
				e.printStackTrace();
			}

			/* String n = repNull(inName_tmp); if ("".equals(n)) return ""; int len = n.length();
			 * 
			 * // 默认全*处理 StringBuffer sb = new StringBuffer(); for (int i = 0; i < len; i++) { sb.append("*"); } out_data = sb.toString(); StringBuffer tmp = new StringBuffer(); for (int i = 0; i < n.length() - 1; i++) tmp.append("*"); out_data = tmp.toString() + n.substring(n.length() - 1, n.length()); */

			/* 调用客户管理统一提供的静态类进行客户名称模糊化,这里调用客户管理提供的静态类中的BlurSensitiveInfo. formatName方法， 后续如果模糊化方式，直接从CRM拿到这个类文件覆盖咱们工程下的就可以 */
			out_data = BlurSensitiveInfo.formatName(inName_tmp, "1");
		}

		return out_data;
	}

	/* (non-Javadoc)
	 * 
	 * @see com.sitech.acctmgr.atom.entity.IControl#pubEncryptData(java.util.Map) */
	@Override
	public String pubNomalEncryptData(String inName, int inType, int blurType) {
		String out_data = "";
		if (inType == 0) {
			try {
				out_data = PwdUtil.encodeDES(inName);
			} catch (Exception e) {
				e.printStackTrace();
			}

		} else if (inType == 1) {
			try {
				out_data = PwdUtil.decodeDES(inName);
			} catch (Exception e) {
				e.printStackTrace();
			}

		} else if (inType == 2) {
			// 涉及到客户姓名，只显示姓，名用*替代；
			String n = repNull(inName);
			if ("".equals(n))
				return "";
			int len = n.length();

			// 默认全*处理
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < len; i++) {
				sb.append("*");
			}
			out_data = sb.toString();
			if (blurType == 2) {// 客户号码显示前3位和末3位，其他数字用*代替；
				out_data = formatDataFuzzy(inName, 3, 3);
			} else if (blurType == 3) {// 主教位置、通信时间、时常与流量均用*代替；
				out_data = sb.toString();
			} else if (blurType == 4) {// 客户身份证号码显示前3位和末四位，其他数字用*代替；
				out_data = formatDataFuzzy(inName, 3, 4);
			} else if (blurType == 5) {// 集团客户编号显示前两位和末三位，其他数字用*代替；
				out_data = formatDataFuzzy(inName, 2, 3);
			} else if (blurType == 6) {// 集团客户名称显示前3个字符和最后3个字符，其他字符用*代替；
				out_data = formatDataFuzzy(inName, 3, 3);
			} else if (blurType == 7) {// 客户居住地址、联系地址显示到市一级别，剩余字符用*代替；?????
				out_data = sb.toString();
			} else if (blurType == 8) {// 联系电话（不包括区号）显示前2位与末2位，其他数字用*代替；
				out_data = formatDataFuzzy(inName, 2, 2);
			} else if (blurType == 9) {// 客户兴趣爱好全部用*代替；
				out_data = sb.toString();
			} else if (blurType == 10) {// 客户积分、预存款、信用等级、信用额度、交费历史均用*代替；
				out_data = sb.toString();
			} else if (blurType == 11) {// 各类固定费用、通信费用、数据费用均用*代替。
				out_data = sb.toString();
			} else if (blurType == 12) {// 涉及到客户姓名,保留第一个，其他*替代。
				StringBuffer tmp = new StringBuffer();
				for (int i = 1; i < n.length(); i++)
					tmp.append("*");
				out_data = n.substring(0, 1) + tmp.toString();
			}

		}

		return out_data;
	}

	private static String formatDataFuzzy(Object name, int before, int after) {
		String result = "";
		String _reStr = "*";
		String n = repNull(name);
		if ("".equals(n))
			return "";

		int len = n.length();
		int reqLen = after - before + 1;

		StringBuffer sb = new StringBuffer();
		if (len > reqLen) {
			for (int i = 0; i < reqLen; i++) {
				sb.append(_reStr);
			}
			result = n.substring(0, before - 1) + sb.toString() + n.substring(after);
		}
		return result;
	}

	private static String repNull(Object param) {
		if (param == null) {
			return "";
		}
		return param.toString().trim();
	}

	/* (non-Javadoc)
	 * 
	 * @see com.sitech.acctmgr.atom.entity.inter.IControl#getSequence(java.lang.String ) */
	public long getSequence(String seqName) {
		Map<String, Object> inParamMap = new HashMap<String, Object>();
		inParamMap.put("SEQ_NAME", seqName);
		Map<String, Object> result = (Map<String, Object>) baseDao.queryForObject("dual.qSequence", inParamMap);
		return Long.parseLong(result.get("NEXTVAL").toString());
	}



	@Override
	public long getLimitFee(String opCode, Long reginId, String opType) {

		Map<String, Object> inMapTmp = null;

		inMapTmp = new HashMap<String, Object>();
		inMapTmp.put("OP_CODE", opCode);
		inMapTmp.put("REGION_CODE", reginId);
		inMapTmp.put("OP_TYPE", opType);
		Map<String, Object> result = (Map<String, Object>) baseDao.queryForObject("bal_paylimit_conf.qLimitMoney", inMapTmp);
		long limitFee = Long.parseLong(result.get("FEE").toString());

		return limitFee;
	}

	@Override
	public PubBillCtrlEntity getPubBillCtrl() {
		Map<String, Object> inMapTmp = new HashMap<String, Object>();

		PubBillCtrlEntity result = (PubBillCtrlEntity) baseDao.queryForObject("pub_bill_ctrl.qPubBillCtrl", inMapTmp);

		if (result == null) {
			result = new PubBillCtrlEntity();
			result.setBillFlag("0");
			result.setQryFlag("0");
			result.setStopFlag("0");
			result.setWrtoffFlag("0");
		}

		return result;
	}

	public String getParaTypeName(String paraId, Integer paraTypeId) {
		Map<String, Object> inMap = new HashMap<String, Object>();

		inMap.put("PARA_ID", paraId);
		inMap.put("PARA_TYPE_ID", paraTypeId);

		String sPayCodeName = (String) baseDao.queryForObject("ct_para_type_value.qParaName", inMap);
		if (sPayCodeName == null || "".equals(sPayCodeName)) {
			log.error("ct_para_type_value表配置缺失，para_type_id: " + inMap.toString());
			throw new BusiException(AcctMgrError.getErrorCode("0000", "00014"), "ct_para_type_value表配置缺失，para_type_id: " + inMap.toString());
		}

		return sPayCodeName;
	}

	@Override
	public boolean isOnLineBill(long id) {
		return isOnLineBill(id, "BILLQRY");
	}

	@Override
	public boolean isOnLineBill(long id, String sAppName) {

		Map<String, Object> inMap = new HashMap<String, Object>();
		safeAddToMap(inMap, "ID", id);
		safeAddToMap(inMap, "ID_TAIL", String.valueOf(id % 10));
		safeAddToMap(inMap, "APP_NAME", sAppName);
		String sFlag = (String) baseDao.queryForObject("pub_idroute_conf.getOnlineFlag", inMap);

		if (StringUtils.isEmptyOrNull(sFlag) || sFlag.equals("1")) {
			return false;
		}

		return true;
	}

	@Override
	public String pubDesForChannel(String inData, String inType, String channel) {

		String outString = "";

		// 根据渠道获取配置的秘钥对应的渠道标识
		String in = channel + "_CHANNEL";
		log.debug("qiaolin: " + in);
		log.debug("aaaaaaa: " + InterProperties.getConfigByMap(in));
		String sch = InterProperties.getConfigByMap(in).toString();

		if (inType.equals("0")) {

			try {
				outString = CodecUtil.encodeDESForChannel(inData, sch); // 加密
			} catch (Exception e) {

				System.out.println("加密失败");
			}

		} else if (inType.equals("1")) {

			try {
				outString = CodecUtil.decodeDESForChannel(inData, sch); // 解密
			} catch (Exception e) {

				System.out.println("加密失败");
			}
		}

		log.info("渠道解密后： inData: " + inData + "outString: " + outString);

		return outString;
	}

	@Override
	public String getPaypathName(String sPaypath) {

		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("PAY_PATH", sPaypath);

		String sPaypathName = baseDao.queryForObject("bal_paypath_conf.qPayPathName", inMap).toString();
		return sPaypathName;

	}

	@Override
	public String getPayMethodName(String payMethod) {
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("PAY_METHOD", payMethod);
		Map<String, Object> payMethodMap = (Map<String, Object>) baseDao.queryForObject("bal_paymethod_conf.qryMethod", inMap);
		String payMethodName = payMethodMap.get("PAY_METHOD_NAME").toString();
		return payMethodName;
	}

	public Map<String, Object> getSysDate() {

		Map<String, Object> inMapTmp = new HashMap<String, Object>();

		Map<String, Object> result = (Map<String, Object>) baseDao.queryForObject("dual.qSysTime", inMapTmp);

		return result;
	}

	public PubDbrouteConfEntity getConOrUserDb(String idType, long id) {

		Map<String, Object> inMap = new HashMap<String, Object>();
		safeAddToMap(inMap, "ID_TYPE", idType);
		safeAddToMap(inMap, "ID", id);
		PubDbrouteConfEntity outEntity = (PubDbrouteConfEntity) baseDao.queryForObject("pub_dbroute_conf.getRouteDb", inMap);

		outEntity.setDbId(outEntity.getPartId());
		outEntity.setPartId(outEntity.getPartId().substring(0, 1));

		return outEntity;
	}

	@Override
	public ServerInfo getPhoneRouteConf(String phoneHead, String appType) {
		final String sql_stmt = "pub_phoneroute_conf.getRouteConf";

		Map<String, Object> paramMap = new HashMap<String, Object>();
		safeAddToMap(paramMap, "ROUTE_NAME", phoneHead);
		safeAddToMap(paramMap, "APP_NAME", appType);

		ServerInfo si = (ServerInfo) baseDao.queryForObject(sql_stmt, paramMap);

		if (null == si) {
			throw new BusiException(AcctMgrError.getErrorCode("0000", "50001"), "账务计费主机信息不存在，请检查配置");
		}

		return si;

	}

	@Override
	public ServerInfo getIdRouteConf(String qryType, long id, String appType) {
		Map<String, Object> inMap = new HashMap<String,Object>();
		safeAddToMap(inMap, "QRY_TYPE", qryType);
		safeAddToMap(inMap, "ID", id);
		safeAddToMap(inMap, "ID_TAIL", String.valueOf(id%10));
		safeAddToMap(inMap, "APP_NAME", appType);

		ServerInfo si = ( ServerInfo ) baseDao.queryForObject("pub_idroute_conf.getRouteConf", inMap);

		if (null == si) {
			throw new BusiException(AcctMgrError.getErrorCode("0000", "50001"), "账务计费主机信息不存在，请检查配置");
		}

		return si;
	}

	public String getProvinceId(long id) {

		String provinceId;
		if (String.valueOf(id).substring(0, 2).equals("22")) {
			provinceId = "220000";
		} else {
			provinceId = "230000";
		}

		return provinceId;
	}

	public int getCntPubCodeDict(Map<String, Object> inMap) {

		Map<String, Object> outMap = (Map<String, Object>) baseDao.queryForObject("pub_codedef_dict.qCntPubCodeDict", inMap);

		return Integer.parseInt(outMap.get("CNT").toString());

	}
	
	@Override
	public List<Map<String, Object>> getReturnrel(String sRuleId) {
		Map<String, Object> inMapTmp = null;
		
		inMapTmp = new HashMap<String, Object>();
		inMapTmp.put("RULE_ID", sRuleId);
		List<Map<String, Object>> returnrelList = baseDao.queryForList("bal_returnrel_conf.qByRuleId", inMapTmp);
		
		return returnrelList;
	}

	@Override
	public Map<String, Object> getChildrule(String sChildRel) {
		Map<String, Object> inMapTmp = null;
		
		inMapTmp = new HashMap<String, Object>();
		inMapTmp.put("CHILD_RULE", Long.parseLong(sChildRel));
		Map<String, Object> childRelMap = (Map<String, Object>)baseDao.queryForObject("bal_childrule_conf.qByChildRule", inMapTmp);
		
		return childRelMap;
	}
	
	@Override
	public String getLastDay(String curMonth, int addMonth) {
		
		Map<String, Object> inMapTmp = new HashMap<String, Object>();
		inMapTmp.put("CUR_MONTH", curMonth);
		inMapTmp.put("ADD_MONTH", addMonth);
		Map<String, Object> result = (Map<String, Object>)baseDao.queryForObject("dual.qLastDay", inMapTmp);
		String lastDay = result.get("LAST_DAY").toString();
		
		return lastDay;
	}

	@Override
	public String getRequestSn() {
		long accept = getSequence("SEQ_EINVOICE_SN");
		String sn = String.valueOf(accept).substring(7, 9);
		String requestSn = "DZFP" + DateUtils.getCurDate("yyyyMMddHHmmss") + sn;
		return requestSn;
	}
}
