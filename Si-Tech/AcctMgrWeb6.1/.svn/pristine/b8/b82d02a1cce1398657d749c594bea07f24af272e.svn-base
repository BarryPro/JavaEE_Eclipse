package com.sitech.acctmgr.atom.entity;


import static org.apache.commons.collections.MapUtils.safeAddToMap;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.adj.SpInfoEntity;
import com.sitech.acctmgr.atom.domains.prod.PdPrcInfoEntity;
import com.sitech.acctmgr.atom.domains.prod.UserPdPrcDetailInfoEntity;
import com.sitech.acctmgr.atom.domains.prod.UserPdPrcInfoEntity;
import com.sitech.acctmgr.atom.domains.query.ProductOfferUpEntity;
import com.sitech.acctmgr.atom.domains.user.UserPrcEntity;
import com.sitech.acctmgr.atom.entity.inter.IProd;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.BaseBusi;
import com.sitech.acctmgr.common.constant.CommonConst;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;

/**
 * 
 * <p>
 * Title: 订购资料类
 * </p>
 * <p>
 * Description: 查询订购资料的属性信息
 * </p>
 * <p>
 * Copyright: Copyright (c) 2016
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author zhangbine
 * @version 1.0
 */
@SuppressWarnings({ "unchecked" })
public class Prod extends BaseBusi implements IProd {

	@Override
	public UserPrcEntity getUserPrcidInfo(Long inIdNo, boolean throwsFlag) {
		long lIdNo = inIdNo; /* 入参用户标识 */

		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("ID_NO", lIdNo);
		inMap.put("GOODS_MAIN_FLAG", CommonConst.BASE_PRC_FLAG);
		inMap.put("CUR_VALID", "TRUE");
		UserPrcEntity result = (UserPrcEntity) baseDao.queryForObject("ur_usergoods_info.qUserprcInfo", inMap);

		if (result == null && throwsFlag) {
			throw new BusiException(AcctMgrError.getErrorCode("0000", "00004"), "查询用户主订价信息错误！inParam:[ " + inMap.toString() + " ]");
		}

		return result;
	}

	@Override
	public UserPrcEntity getUserPrcidInfo(Long inIdNo) {
		return this.getUserPrcidInfo(inIdNo, true);
	}

	@Override
	public PdPrcInfoEntity getPdPrcInfo(String prodPrcId) {
		Map<String, Object> inMap = new HashMap<String, Object>();
		safeAddToMap(inMap, "PRC_ID", prodPrcId);
		PdPrcInfoEntity result = (PdPrcInfoEntity) baseDao.queryForObject("pd_goodsprc_dict.qPrcDictInfo", inMap);
		return result;
	}

	@Override
	public List<UserPrcEntity> getPdPrcId(long idNo, boolean valid) {
		String validFlag = null;
		if (valid) {
			validFlag = "true";
		}

		return this.getPdPrcId(idNo, null, null, validFlag);
	}

	@Override
	public List<UserPrcEntity> getPdPrcId(long idNo, String prcType, String prcId, String validFlag) {
		return getPdPrcId(idNo, prcType, prcId, validFlag, "false");
	}

	@Override
	public List<UserPrcEntity> getPdPrcId(long idNo, String prcType, String prcId, String validFlag, String includeOrder) {
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("ID_NO", idNo);
		if (StringUtils.isNotEmpty(prcType)) {
			inMap.put("PRC_TYPE", prcType);
		}
		if (StringUtils.isNotEmpty(prcId)) {
			inMap.put("PRC_ID", prcId);
		}
		if (StringUtils.isNotEmpty(validFlag) && validFlag.equalsIgnoreCase("true")) {
			inMap.put("CUR_VALID", "TRUE");
		}
		if (StringUtils.isNotEmpty(includeOrder) && includeOrder.equalsIgnoreCase("true")) {
			inMap.put("VALID", "TRUE");
		}
		List<UserPrcEntity> prcInfoList = baseDao.queryForList("ur_usergoods_info.qUserprcInfo", inMap);
		return prcInfoList;
	}

	@Override
	public List<UserPrcEntity> getPdPrcId(long idNo, String prcType) {
		return this.getPdPrcId(idNo, prcType, null, "true");
	}

	@Override
	public List<UserPdPrcInfoEntity> getPdPrcInfo(Map<String, Object> inMap) {
		List<UserPdPrcInfoEntity> prcInfoList = baseDao.queryForList("ur_usergoods_info.getUserPrcInfo", inMap);
		return prcInfoList;
	}

	@Override
	public List<UserPdPrcDetailInfoEntity> getPdPrcDetailInfo(Map<String, Object> inMap) {
		List<UserPdPrcDetailInfoEntity> pdPrcDetailList = baseDao.queryForList("ur_usergoods_info.getUserPrcDetailInfo", inMap);
		return pdPrcDetailList;
	}
	
	@Override
	public List<SpInfoEntity> qUserSPPdPrcInfo(Map<String, Object> inMap){
		List<SpInfoEntity> userSPpdPrcList = baseDao.queryForList("ur_userprcsp_info.qUserSPBusi", inMap);
		return userSPpdPrcList;
	}

	@Override
	public int getIsPointPrc(Map<String, Object> inMap) {
		int cnt = (int) baseDao.queryForObject("pd_goodsprc_dict.qCnt", inMap);
		return cnt;
	}
	
	@Override
	public String getExpenses(String phoneNo){
		Map<String,Object> inMap = new HashMap<String,Object>();
		inMap.put("PHONE_NO", phoneNo);
		String expenses = (String) baseDao.queryForObject("pd_goodsprcattr_dict.qExpenses", inMap);
		if(StringUtils.isEmpty(expenses)){
			expenses = "NO";
		}
		
		return expenses;
	}

	@Override
	public boolean hasPrcid(Long idNo, String prcId) {
		boolean hasPrcFlag = false;

		List<UserPrcEntity> prcInfoList = this.getPdPrcId(idNo, null, prcId, "true");
		if (prcInfoList == null || prcInfoList.isEmpty()) {
			hasPrcFlag = false;
		} else {
			hasPrcFlag = true;
		}

		return hasPrcFlag;
	}

	@Override
	public List<String> getGprsPrcNameList(Long idNo) {
		if (idNo == null || idNo <= 0) {
			return null;
		}

		List<String> prcNameList = baseDao.queryForList("ur_usergoods_info.qUserGprsPrcList", idNo);

		return prcNameList;
	}

	@Override
	public String getPrcAttrValue(String prcId, String attrId) {
		Map<String, Object> inMap = new HashMap<>();
		safeAddToMap(inMap, "PRC_ID", prcId);
		safeAddToMap(inMap, "ATTR_ID", attrId);

		String attrValue = (String) baseDao.queryForObject("pd_goodsprcattr_dict.qPrcAttrValue", inMap);

		return attrValue;

	}

	@Override
	public List<UserPrcEntity> getValidPrcList(Long idNo) {
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("ID_NO", idNo);

		inMap.put("VALID", "TRUE"); // 生效含预约生效
		List<UserPrcEntity> prcInfoList = baseDao.queryForList("ur_usergoods_info.qUserprcInfo", inMap);
		return prcInfoList;
	}

	@Override
	public boolean isClassPrcId(String classId, String prcId) {
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("CLASS_ID", classId);
		inMap.put("PRC_ID", prcId);
		int cnt = (Integer) baseDao.queryForObject("pd_goodsclass_rel.qCnt", inMap);

		return cnt > 0 ? true : false;
	}

	@Override
	public int getFavCount(Long idNo, String status) {
		Map<String, Object> inMapTmp = new HashMap<String, Object>();
		inMapTmp.put("ID_NO", idNo);
		inMapTmp.put("STATUS", status);
		int count = (Integer) baseDao.queryForObject("ur_usergoods_info.qryFavCnt", inMapTmp);
		return count;
	}
	@Override
	public String getPdById(String prcId){
		Map inMap=new HashMap();
		inMap.put("GOODS_ID", prcId);
		Map outMap = new HashMap();
		outMap =  (Map) baseDao.queryForObject("pd_goods_dict.qPdGoods", inMap);
		String pdName =(String) outMap.get("GOODS_NAME");
		return pdName;
	}

	@Override
	public ProductOfferUpEntity getProductUpInfo(String upId, String phoneNo, int totalDate) {
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("UP_ID", upId);
		inMap.put("PHONE_NO", phoneNo);
		inMap.put("TOTAL_DATE", totalDate);
		ProductOfferUpEntity result = (ProductOfferUpEntity) baseDao.queryForObject("product_offer_up.qProductUpInfo", inMap);
		return result;
	}

	@Override
	public void delProductOfferUpInfo(String upId, String phoneNo, int totalDate) {
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("UP_ID", upId);
		inMap.put("PHONE_NO", phoneNo);
		inMap.put("TOTAL_DATE", totalDate);
		baseDao.delete("product_offer_up.dProductInfo", inMap);
		
	}

	@Override
	public void saveProductOfferUpInfo(String upId, String phoneNo, int totalDate) {
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("UP_ID", upId);
		inMap.put("PHONE_NO", phoneNo);
		inMap.put("TOTAL_DATE", totalDate);
		baseDao.insert("product_offer_up.insertHis", inMap);
	}

	@Override
	public Map<String, String> getPrcValidInfo(long goodsInsId) {
		Map<String, Object> inMap = new HashMap<String, Object>();
		safeAddToMap(inMap, "GOODSINS_ID", goodsInsId);
		return (Map<String, String>) baseDao.queryForObject("ur_usergoods_info.qryPrcValidInfo", inMap);
	}

}
