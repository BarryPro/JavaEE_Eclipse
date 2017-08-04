package com.sitech.acctmgr.atom.entity;

import static org.apache.commons.collections.MapUtils.safeAddToMap;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.cct.CctDynamicCreditInfoEntity;
import com.sitech.acctmgr.atom.domains.cct.CreditAdjEntity;
import com.sitech.acctmgr.atom.domains.cct.CreditChgHisEntity;
import com.sitech.acctmgr.atom.domains.cct.CreditDetailEntity;
import com.sitech.acctmgr.atom.domains.cct.CreditInfoEntity;
import com.sitech.acctmgr.atom.domains.cct.CreditListEntity;
import com.sitech.acctmgr.atom.domains.cct.GrpCreditEntity;
import com.sitech.acctmgr.atom.domains.cct.GrpRedEntity;
import com.sitech.acctmgr.atom.domains.cct.StopAwakeInfoEntity;
import com.sitech.acctmgr.atom.domains.cct.UnStopHolidayEntity;
import com.sitech.acctmgr.atom.domains.pub.PubCodeDictEntity;
import com.sitech.acctmgr.atom.entity.inter.ICredit;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.BaseBusi;
import com.sitech.acctmgr.common.constant.CommonConst;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;

/**
 * Created by wangyla on 2016/5/10. 用户星级实体
 */
public class Credit extends BaseBusi implements ICredit {

	@Override
	public CreditInfoEntity getCreditInfoByIdNo(long idNo, String cancelFlag) {
		Map<String, Object> inMap = new HashMap<String, Object>();
		if (cancelFlag != null) {
			if (cancelFlag.equals(CommonConst.CREDIT_VALID)) {
				safeAddToMap(inMap, "VALID_FLAG", CommonConst.CREDIT_VALID);
			} else if (cancelFlag.equals(CommonConst.CREDIT_VALID)) {
				safeAddToMap(inMap, "VALID_FLAG", CommonConst.CREDIT_INVALID);
			}
		}
		safeAddToMap(inMap, "ID_NO", idNo);
		CreditInfoEntity result = (CreditInfoEntity) baseDao.queryForObject("cct_credit_info.qCreditInfoById", inMap);

		return result;
	}

	@Override
	public GrpCreditEntity getGrpCredit(long unitId) {
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("UNIT_ID", unitId);
		GrpCreditEntity result = (GrpCreditEntity) baseDao.queryForObject("cct_grpcredit_info.qryHand", inMap);
		if (result == null) {
			GrpCreditEntity result1 = (GrpCreditEntity) baseDao.queryForObject("cct_grpcredit_info.qryAuto", inMap);
			return result1;
		}
		return result;
	}

	@Override
	public int getCntGrpCredit(long unitId) {
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("UNIT_ID", unitId);
		int cnt = (Integer) baseDao.queryForObject("cct_grpcredit_info.qryCount", inMap);
		return cnt;
	}

	@Override
	public void saveGrpCredit(GrpCreditEntity gce) {
		baseDao.insert("cct_grpcredit_info.iGrpCredit", gce);
	}

	@Override
	public void updateGrpCredit(GrpCreditEntity gce) {
		baseDao.update("cct_grpcredit_info.uGrpCredit", gce);
	}

	@Override
	public Map<String, Object> getCreditInfo(long idNo) {
		// TODO Auto-generated method stub

		Map<String, Object> outParam = new HashMap<String, Object>();
		Map<String, Object> inMap = null;
		Map<String, Object> outMap = null;

		String isCredit = "";

		inMap = new HashMap<String, Object>();
		inMap.put("ID_NO", idNo);

		CreditInfoEntity cie = (CreditInfoEntity) baseDao.queryForObject("cct_credit_info.qCreditInfoById", inMap);
		if (cie == null) {
			isCredit = "0";
			outParam.put("IS_CREDIT", isCredit);
			outParam.put("OVER_FEE", "0");
		} else {
			outParam.put("IS_CREDIT", "1");
			outParam.put("BEGIN_TIME", cie.getBeginTime());
			outParam.put("END_TIME", cie.getEndTime());
			outParam.put("CREDIT_CODE", cie.getCreditClass());

			// 查询信誉度等级
			inMap.put("CODE_CLASS", "1203");
			inMap.put("CODE_ID", cie.getCreditClass());
			PubCodeDictEntity pcde = (PubCodeDictEntity)baseDao.queryForObject("pub_codedef_dict.qVision", inMap);			
			outParam.put("CREDIT_NAME", pcde.getCodeName());
		}

		// 查询信誉度
		long overFee = 0;
		CctDynamicCreditInfoEntity cdcie = getDynamicCredit(idNo);
		if (cdcie == null) {
			safeAddToMap(inMap, "ID_NO", idNo);
			safeAddToMap(inMap, "VALID_FLAG", "1");
			CreditInfoEntity result = (CreditInfoEntity) baseDao.queryForObject("cct_credit_info.qCreditInfoById", inMap);
			if(result!=null) {
				//取星级信誉度
				String starCredit = result.getCreditClass();
				inMap = new HashMap<String,Object>();
				inMap.put("CREDIT_CLASS", starCredit);
				overFee = (long)baseDao.queryForObject("cct_creditclass_conf.qry", inMap);
				outParam.put("OVER_FEE", overFee);
			}else {
				outParam.put("OVER_FEE", "0");
			}

		} else {
			//人工授信信誉度
			outParam.put("OVER_FEE", cdcie.getLimitOwe());
		}

		return outParam;
	}

	@Override
	public void uDnyCredit(CreditAdjEntity creditAdjEntity) {
		log.debug(">>>>>>>>>>>>>" + creditAdjEntity);
		long idNo = creditAdjEntity.getIdNo();
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("ID_NO", idNo);
		
		// 智能网神州行用户判断，暂时判断
		long znwCnt = (long)baseDao.queryForObject("ur_user_info.qryZnwCnt", inMap);
		if(znwCnt>0) {
			throw new BusiException(AcctMgrError.getErrorCode("0000", "90021"), "智能网神州行移植用户不允许办理此业务！");
		}

		int cnt = (int) baseDao.queryForObject("cct_dynamiccredit_info.qCnt", idNo);
		if (cnt == 0) {
			// 向cct_dynamiccredit_info表中插入一条新记录
			CctDynamicCreditInfoEntity dynamicCredit = new CctDynamicCreditInfoEntity();
			dynamicCredit.setPhoneNo(creditAdjEntity.getPhoneNo());
			dynamicCredit.setExpTime(creditAdjEntity.getExpireTime());
			dynamicCredit.setLimitOwe(creditAdjEntity.getNewLimitOwe());
			dynamicCredit.setIdNo(idNo);
			dynamicCredit.setNotes(creditAdjEntity.getOpNote());

			baseDao.insert("cct_dynamiccredit_info.iDynamicCredit", dynamicCredit);
		}

		//入历史表
		baseDao.insert("cct_creditadj_his.iCreidtAdjHis", creditAdjEntity);

		//取消星级信誉度
		inMap.put("ID_NO", idNo);
		inMap.put("VALID_FLAG", "0");
		baseDao.update("cct_credit_info.uCreditInfo", inMap);
		
		// 更新limit_owe,expire_time
		CctDynamicCreditInfoEntity dynamicCredit = new CctDynamicCreditInfoEntity();
		// 增加limit_owe属性
		dynamicCredit.setExpTime(creditAdjEntity.getExpireTime());
		dynamicCredit.setIdNo(idNo);
		dynamicCredit.setLimitOwe(creditAdjEntity.getNewLimitOwe());
		dynamicCredit.setNotes(creditAdjEntity.getOpNote());
		
		log.debug("creditEnt is 》》》" + creditAdjEntity.getExpireTime());
		int ret = baseDao.update("cct_dynamiccredit_info.uDnyCredit", dynamicCredit);

		// + 删除dCustCreditAdj表中的数据
		//baseDao.delete("cct_creditadj_info.delCreditAdj", idNo);
	}

	@Override
	public void applyDnyCredit(CreditAdjEntity creditAdjEntity) {

		Map<String, Object> inMap = new HashMap<String, Object>();

		long idNo = creditAdjEntity.getIdNo();

		inMap.put("ID_NO", idNo);

		int cnt = (int) baseDao.queryForObject("cct_dynamiccredit_info.qCnt", idNo);

		if (cnt != 0) {
			// 1.更新limit_owe=0
			CctDynamicCreditInfoEntity creditEnt = new CctDynamicCreditInfoEntity();

			creditEnt.setExpTime(creditAdjEntity.getExpireTime());
			creditEnt.setIdNo(idNo);
			creditEnt.setLimitOwe(0);

			log.debug("失效日期：" + creditEnt.getExpTime());
			baseDao.update("cct_dynamiccredit_info.uDnyCredit", creditEnt);
		} else {
			// cct_credit_info表中插入一条记录
			CctDynamicCreditInfoEntity creditInfoEnt = new CctDynamicCreditInfoEntity();
			creditInfoEnt.setPhoneNo(creditAdjEntity.getPhoneNo());
			creditInfoEnt.setExpTime(creditAdjEntity.getExpireTime());
			creditInfoEnt.setLimitOwe(0);
			creditInfoEnt.setIdNo(idNo);
			creditInfoEnt.setNotes(creditAdjEntity.getOpNote());
			baseDao.insert("cct_dynamiccredit_info.iDynamicCredit", creditInfoEnt);
		}

		// 如果有数据dCustCreditAdj备份到历史表中，没数据，更新插入一条数据
		int isFlag = (int) baseDao.queryForObject("cct_creditadj_info.qCnt", idNo);

		if (isFlag == 0) {
			// dCustCreditAdj录新值
			baseDao.insert("cct_creditadj_info.iCreditAdj", creditAdjEntity);
		} else {
			// 如果dCustCreditAdj没有数据，插入一条数据dCustCreditAdj，否则更新数据
			baseDao.insert("cct_creditadj_his.iCreidtAdjHis", creditAdjEntity);
			baseDao.update("cct_creditadj_info.uCreditAdj", creditAdjEntity);
		}

	}

	@Override
	public void cancleDnyCredit(CreditAdjEntity creditAdjEntity) {

		long idNo = creditAdjEntity.getIdNo();
		// 1.更新limit_owe=0
		CctDynamicCreditInfoEntity creditEnt = new CctDynamicCreditInfoEntity();
		// 获取当前日期，将当前日期作为失效日期

		creditEnt.setIdNo(idNo);
		creditEnt.setLimitOwe(0);
		creditEnt.setExpTime(creditAdjEntity.getExpireTime());
		creditAdjEntity.setNewLimitOwe(0);

		int ret = baseDao.update("cct_dynamiccredit_info.uDnyCredit", creditEnt);

		// 备份dCustCreditAdj到历史表，删除表中数据
		baseDao.insert("cct_creditadj_his.iCreidtAdjHis", creditAdjEntity);
		baseDao.update("cct_creditadj_info.uCreditAdj", creditAdjEntity);
	}

	@Override
	public String getClass(Map<String, Object> inParam) {
		Map<String, Object> result = (Map<String, Object>) baseDao.queryForObject("cct_creditchg_his.qForCrmClass", inParam);
		if (result == null || result.size() == 0) {
			String level = "h";
			return level;
		} else {
			return String.valueOf(result.get("CREDIT_CLASS").toString());
		}
	}

	@Override
	public String getClassName(Map<String, Object> inParam) {
		Map<String, Object> result = (Map<String, Object>) baseDao.queryForObject("cct_creditchg_his.qForCrmClassName", inParam);
		return String.valueOf(result.get("CREDIT_NAME").toString());
	}

	@Override
	public Map<String, Object> qNoDateCreditInfo(Map<String, Object> inParam) {
		Map<String, Object> result = (Map<String, Object>) baseDao.queryForObject("cct_credit_info.qNoDateCreditInfoById", inParam);
		if (result == null) {
			result = new HashMap<String, Object>();
			result.put("CNT", 0);
		} else {
			result.put("CNT", 1);
		}
		return result;
	}

	@Override
	public List<CreditDetailEntity> qCreditDetail(Map<String, Object> inParam) {
		// TODO Auto-generated method stub
		List<CreditDetailEntity> resultList = baseDao.queryForList("cct_creditchg_detail.qCreditChgDetail", inParam);
		return resultList;
	}

	@Override
	public List<CreditChgHisEntity> qCreditchgHis(Long idNo) {
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("ID_NO", idNo);
		List<CreditChgHisEntity> result = new ArrayList<CreditChgHisEntity>();
		result = baseDao.queryForList("cct_creditchg_his.qCreditchgHis", inMap);
		return result;
	}

	@Override
	public void saveCreditInfo(Map<String, Object> inParam) {
		baseDao.insert("cct_credit_info.iCreditInfo1", inParam);
	}

	@Override
	public void saveCreditChgHis(Map<String, Object> inParam) {
		baseDao.insert("cct_creditchg_his.iCreditchgHis1", inParam);
	}

	@Override
	public void saveCreditInfoChg(Map<String, Object> inParam) {
		// TODO Auto-generated method stub
		baseDao.insert("cct_credit_info_chg.ins", inParam);
	}

	@Override
	public void uCreditGrade(Map<String, Object> inParam) {
		// TODO Auto-generated method stub
		baseDao.update("cct_credit_info.uCreditInfo", inParam);

	}

	@Override
	public int getCreditInfoCnt(Map<String, Object> inParam) {

		int result = (int) baseDao.queryForObject("cct_credit_info.qCnt", inParam);

		return result;
	}

	@Override
	public CreditInfoEntity pQCreditInfoById(Map<String, Object> inParam) {

		CreditInfoEntity result = (CreditInfoEntity) baseDao.queryForObject("cct_credit_info.qCreditInfoById", inParam);

		return result;
	}

	@Override
	public long qCodePointByCardType(Map<String, Object> inParam) {
		// TODO Auto-generated method stub
		Map<String, Object> outMap = (Map<String, Object>) baseDao.queryForObject("cct_creditchg_detail.qryByCodeType", inParam);
		return Long.parseLong(outMap.get("CODE_POINT").toString());
	}

	@Override
	public int cntCreditAdj(Long idNo) {

		// 判断是否为动态信誉度用户
		int cnt = (int) baseDao.queryForObject("cct_creditadj_info.qCnt", idNo);
		return cnt;
	}

	@Override
	public CctDynamicCreditInfoEntity getDynamicCredit(long idNo) {
		// TODO Auto-generated method stub
		CctDynamicCreditInfoEntity dynamicCredit = (CctDynamicCreditInfoEntity) baseDao.queryForObject("cct_dynamiccredit_info.qDynamicCredit", idNo);
		return dynamicCredit;
	}
	
	@Override
	public void saveGrpRedList(Map<String, Object> inParam) {

		if(inParam.get("CREDIT_CODE").equals("0")) {
			baseDao.delete("dgrpredlist_inter.delete", inParam);
		}else {
			int cnt = (int) baseDao.queryForObject("dgrpredlist_inter.qryCnt", inParam);
			if(cnt<1) {
				baseDao.insert("dgrpredlist_inter.insert", inParam);
			}else {
				baseDao.update("dgrpredlist_inter.update", inParam);
			}
		}
		
	}
	
	@Override
	public GrpRedEntity getGrpRedList(Long unitId,Long idNo) {

		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("UNIT_ID", unitId);
		inMap.put("ID_NO", idNo);		
		GrpRedEntity gre = (GrpRedEntity) baseDao.queryForObject("dgrpredlist_inter.qry", inMap);

		return gre;
	}
	
	@Override
	public void oprHolidayUnstop(Map<String, Object> inParam,String opType) {

		int cnt = (int) baseDao.queryForObject("choliday_unstop.qryCnt", inParam);
		if(opType.equals("1")) {			
			if(cnt<1) {
				baseDao.insert("choliday_unstop.insert", inParam);
			}else {
				throw new BusiException(AcctMgrError.getErrorCode("0000", "90020"),"此配置已存在！");
			}
		}else if(opType.equals("2")) {
			baseDao.update("choliday_unstop.update", inParam);
		}else if(opType.equals("3")) {
			baseDao.delete("choliday_unstop.delete", inParam);
		}

	}
	
	@Override
	public List<UnStopHolidayEntity> getUnStopHoliday(String regionCode) {
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("REGION_CODE", regionCode);
		List<UnStopHolidayEntity> result = new ArrayList<UnStopHolidayEntity>();
		result = baseDao.queryForList("choliday_unstop.qry", inMap);
		return result;
	}

	@Override
	public CreditAdjEntity getCreditAdj(Map<String, Object> inMap) {
		CreditAdjEntity creditInfo = (CreditAdjEntity) baseDao.queryForObject("cct_creditadj_his.qCreditAdjInfo", inMap);
		return creditInfo;
	}
	
	@Override
	public void saveKeyWordMap(String regionCode,String opType,String note) {
		
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("REGION_CODE", regionCode);
		inMap.put("OP_TYPE", opType);
		inMap.put("NOTE", note);
		inMap.put("OP_CODE", "2315");
		
		baseDao.delete("cKeyWordMap.delete", inMap);
		baseDao.insert("cKeyWordMap.insert", inMap);
	}
	
	@Override
	public String getKeyWordMap(String regionCode,String opCode) {
		
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("REGION_CODE", regionCode);
		inMap.put("OP_CODE", opCode);
		
		String opType = (String)baseDao.queryForObject("cKeyWordMap.qry", inMap);
		return opType;
	}

}
