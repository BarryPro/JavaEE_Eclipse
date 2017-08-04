package com.sitech.acctmgr.atom.entity;

import static org.apache.commons.collections.MapUtils.safeAddToMap;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.sitech.acctmgr.atom.domains.adj.AdjBIllEntity;
import com.sitech.acctmgr.atom.domains.adj.AdjExtendEntity;
import com.sitech.acctmgr.atom.domains.adj.BalCustRefundEntity;
import com.sitech.acctmgr.atom.domains.adj.BatchAdjErrEntity;
import com.sitech.acctmgr.atom.domains.adj.BatchAdjInfoEntity;
import com.sitech.acctmgr.atom.domains.adj.ComplainAdjReasonEntity;
import com.sitech.acctmgr.atom.domains.adj.MicroPayEntity;
import com.sitech.acctmgr.atom.domains.adj.SpInfoEntity;
import com.sitech.acctmgr.atom.domains.bill.ItemEntity;
import com.sitech.acctmgr.atom.domains.pub.PubCodeDictEntity;
import com.sitech.acctmgr.atom.domains.query.RefundEntity;
import com.sitech.acctmgr.atom.entity.inter.IAdj;
import com.sitech.acctmgr.atom.entity.inter.IBillAccount;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.BaseBusi;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;

/**
 *
 * <p>
 * Title:
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2016
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author
 * @version 1.0
 */
public class Adj extends BaseBusi implements IAdj {

	private IControl control;
	private IBillAccount billAccount;

	/* (non-Javadoc)
	 * 
	 * @see com.sitech.acctmgr.atom.entity.inter.IAdj#getBillDay(java.lang.Long, java.lang.Long, java.lang.String) */
	@Override
	public long getBillDay(Long contractNo, Long idNo, String yearMonth) {
		Map<String, Object> inMap = new HashMap<String, Object>();

		inMap.put("CONTRACT_NO", contractNo);
		inMap.put("ID_NO", idNo);
		inMap.put("YEAR_MONTH", yearMonth);
		long result = (Long) baseDao.queryForObject("act_adjowe_info.qBillDay", inMap);

		return result;
	}

	@SuppressWarnings("unchecked")
	@Override
	public void saveAcctAdjOweInfo(AdjBIllEntity billEnt, AdjExtendEntity adjEntendEnt) {

		Map<String, Object> inMap = new HashMap<>();
		Map<String, Object> adjBillMap = JSON.parseObject(JSON.toJSONString(billEnt), Map.class);
		Map<String, Object> adjBillExtendMap = JSON.parseObject(JSON.toJSONString(adjEntendEnt), Map.class);
		inMap.putAll(adjBillMap);
		inMap.putAll(adjBillExtendMap);
		baseDao.insert("act_adjowe_info.iAdjOweInfo", inMap);
	}

	@SuppressWarnings("unchecked")
	@Override
	public void updateAcctAdjOweInfo(AdjBIllEntity billEnt, AdjExtendEntity adjEntendEnt, long opSn) {
		Map<String, Object> inMap = new HashMap<>();
		Map<String, Object> adjBillMap = JSON.parseObject(JSON.toJSONString(billEnt), Map.class);
		Map<String, Object> adjBillExtendMap = JSON.parseObject(JSON.toJSONString(adjEntendEnt), Map.class);
		inMap.putAll(adjBillMap);
		inMap.putAll(adjBillExtendMap);
		inMap.put("STATUS", adjEntendEnt.getAdjFlag());
		inMap.put("OP_SN", opSn);
		baseDao.update("act_adjowe_info.uAdjOweInfo", inMap);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<SpInfoEntity> getSpList(String spId, String servName) {
		// TODO Auto-generated method stub
		Map<String, Object> inMap = new HashMap<String, Object>();
		safeAddToMap(inMap, "SPID", spId);
		safeAddToMap(inMap, "SERVNAME", "%" + servName.trim() + "%");
		List<SpInfoEntity> spList = baseDao.queryForList("cfg_sp_oper_info.getBizCode", inMap);

		return spList;
	}

	@Override
	public void saveSpInfo(Map<String, Object> inParam) {
		// TODO Auto-generated method stub
		baseDao.insert("act_obbizback_info.iObbizbackInfo", inParam);

	}

	@SuppressWarnings("unchecked")
	@Override
	public List<AdjExtendEntity> getBackAdjOweInfo(long opSn, long idNo, String adjFlag) {

		Map<String, Object> inMap = new HashMap<>();
		safeAddToMap(inMap, "OP_SN", opSn);
		safeAddToMap(inMap, "ID_NO", idNo);
		safeAddToMap(inMap, "ADJ_FLAG", adjFlag);

		List<AdjExtendEntity> backAdjList = (List<AdjExtendEntity>) baseDao.queryForList("act_adjowe_info.qAdjInfo", inMap);

		return backAdjList;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<AdjExtendEntity> getAdjOweInfo(Map<String, Object> inParam) {

		Map<String, Object> inMap = new HashMap<>();

		if (StringUtils.isNotEmptyOrNull(inParam.get("ID_NO"))) {
			safeAddToMap(inMap, "ID_NO", inParam.get("ID_NO"));
		}
		if (StringUtils.isNotEmptyOrNull(inParam.get("LOGIN_NO"))) {
			safeAddToMap(inMap, "LOGIN_NO", inParam.get("LOGIN_NO"));
		}
		if (StringUtils.isNotEmptyOrNull(inParam.get("YEAR_MONTH"))) {
			safeAddToMap(inMap, "YEAR_MONTH", inParam.get("YEAR_MONTH"));
		}
		if (StringUtils.isNotEmptyOrNull(inParam.get("STATUS"))) {
			safeAddToMap(inMap, "STATUS", inParam.get("STATUS"));
		}
		
		if (StringUtils.isNotEmptyOrNull(inParam.get("BEGIN_TIME"))) {
			safeAddToMap(inMap, "BEGIN_TIME", inParam.get("BEGIN_TIME"));
		}
		if (StringUtils.isNotEmptyOrNull(inParam.get("END_TIME"))) {
			safeAddToMap(inMap, "END_TIME", inParam.get("END_TIME"));
		}
		
		safeAddToMap(inMap, "ADJ_TYPE", (String[])inParam.get("ADJ_TYPE"));
		List<AdjExtendEntity> adjList = (List<AdjExtendEntity>) baseDao.queryForList("act_adjowe_info.qAdjInfo", inMap);

		return adjList;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, Object>> getBatchAdjOweInfo(Map<String, Object> inParam) {

		Map<String, Object> inMap = new HashMap<>();
		if (StringUtils.isNotEmptyOrNull(inParam.get("ID_NO"))) {
			safeAddToMap(inMap, "ID_NO", inParam.get("ID_NO"));
		}
		if (StringUtils.isNotEmptyOrNull(inParam.get("ADJ_FLAG"))) {
			safeAddToMap(inMap, "ADJ_FLAG", inParam.get("ADJ_FLAG"));
			safeAddToMap(inMap, "STATUS", inParam.get("STATUS"));
		}
		if (StringUtils.isNotEmptyOrNull(inParam.get("OP_CODE"))) {
			safeAddToMap(inMap, "OP_CODE", inParam.get("OP_CODE"));
		}
		safeAddToMap(inMap, "REGION_ID", inParam.get("REGION_ID"));
		safeAddToMap(inMap, "PROVINCE_ID", inParam.get("PROVINCE_ID"));
		safeAddToMap(inMap, "BEGIN_TIME", inParam.get("BEGIN_TIME"));
		safeAddToMap(inMap, "END_TIME", inParam.get("END_TIME"));

		List<Map<String, Object>> batchAdjList = (List<Map<String, Object>>) baseDao.queryForList("act_adjowe_info.qBatchAdjInfo", inMap);

		return batchAdjList;
	}

	@Override
	public int getCntSpByOpSn(long opSn, String phoneNo) {

		Map<String, Object> inMap = new HashMap<>();
		safeAddToMap(inMap, "LOGIN_ACCEPT", opSn);
		safeAddToMap(inMap, "PHONE_NO", phoneNo);

		return (Integer) baseDao.queryForObject("act_obbizback_info.qryCnt", inMap);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ComplainAdjReasonEntity> getAdjReasonInfo(String firstCode, String secondCode, String[] status, String regionCode) {
		Map<String, Object> inMap = new HashMap<>();
		safeAddToMap(inMap, "STATUS", status);
		safeAddToMap(inMap, "REGION_CODE", regionCode);
		safeAddToMap(inMap, "FIRST_CODE", firstCode);
		if (StringUtils.isNotEmptyOrNull(secondCode)) {
			safeAddToMap(inMap, "SECOND_CODE", secondCode);
		}
		List<ComplainAdjReasonEntity> resultList = (List<ComplainAdjReasonEntity>) baseDao.queryForList("pub_codedef_dict.qryAdjReason", inMap);
		return resultList;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PubCodeDictEntity> getReaosnCodeList(Long codeClass, String codeValue, String groupId, 
			String[] status, String codeId,String loginNo) {
		Map<String, Object> inMap = new HashMap<String, Object>();

		inMap.put("CODE_CLASS", codeClass);
		if (StringUtils.isNotEmpty(codeValue)) {
			inMap.put("CODE_VALUE", codeValue);
		}
		if (StringUtils.isNotEmpty(groupId)) {
			inMap.put("GROUP_ID", groupId);
		}
		if (StringUtils.isNotEmptyOrNull(status)) {
			inMap.put("ADJSTATUS", status);
		}
		if (StringUtils.isNotEmpty(codeId)) {
			inMap.put("CODE_ID", codeId);
		}
		if (StringUtils.isNotEmpty(loginNo)) {
			inMap.put("LOGIN_NO", loginNo);
		}

		List<PubCodeDictEntity> publist = baseDao.queryForList("pub_codedef_dict.qVision", inMap);
		return publist;
	}

	@Override
	public String getMaxCodeId(Long codeClass, String groupId) {
		Map<String, Object> inMap = new HashMap<String, Object>();

		inMap.put("CODE_CLASS", codeClass);
		inMap.put("GROUP_ID", groupId);

		String codeId = (String) baseDao.queryForObject("pub_codedef_dict.qryMaxCodeId", inMap);

		return codeId;
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean isReasonInfo(Long codeClass, String regionCode, String codeName, String status) {
		Map<String, Object> inMap = new HashMap<String, Object>();

		inMap.put("CODE_CLASS", codeClass);
		inMap.put("GROUP_ID", regionCode);
		inMap.put("CODE_NAME", codeName);
		inMap.put("STATUS", status);

		Map<String, Object> result = (Map<String, Object>) baseDao.queryForObject("pub_codedef_dict.qCntPubCodeDict", inMap);
		int cnt = Integer.parseInt(result.get("CNT").toString());
		if (cnt > 0) {
			return true;
		} else {
			return false;
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean isLowerReason(int codeClass, String regionCode, String codeValue, String status, String[] spStatus) {
		Map<String, Object> inMap = new HashMap<String, Object>();

		inMap.put("CODE_CLASS", codeClass);
		inMap.put("GROUP_ID", regionCode);
		inMap.put("CODE_VALUE", codeValue);
		inMap.put("STATUS", status);
		inMap.put("SPSTATUS", spStatus);

		Map<String, Object> result = (Map<String, Object>) baseDao.queryForObject("pub_codedef_dict.qCntPubCodeDict", inMap);
		int cnt = Integer.parseInt(result.get("CNT").toString());
		if (cnt > 0) {
			return true;
		} else {
			return false;
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public void insReason(PubCodeDictEntity adjReasonEnt) {
		Map<String, Object> inMap = JSON.parseObject(JSON.toJSONString(adjReasonEnt), Map.class);
		baseDao.insert("pub_codedef_dict.instPubCodeDict", inMap);
	}

	@Override
	public int updateReasonStatus(int codeClass, String regionCode, String codeId, String status) {
		Map<String, Object> inMap = new HashMap<String, Object>();

		inMap.put("CODE_CLASS", codeClass);
		inMap.put("CODE_ID", codeId);
		inMap.put("GROUP_ID", regionCode);
		inMap.put("STATUS", status);

		int result = baseDao.update("pub_codedef_dict.updPubCodeDict", inMap);
		return result;
	}

	/**
	 * @Description 飞豆信息查询
	 * @param phoneNo
	 * @return
	 */
	@Override
	public Map<String, Object> getFDBusiRecd(Map<String, Object> inMap) {
		Map<String, Object> result = (Map<String, Object>) baseDao.queryForObject("bal_grpfdbusi_recd.qGrpfdbusiByBusiSn", inMap);
		if (result == null) {
			log.info("飞豆记录信息不存在");
			throw new BusiException(AcctMgrError.getErrorCode("C239", "00003"), "飞豆记录信息不存在");
		}
		return result;
	}

	/**
	 * @Description 飞豆订购信息记录飞豆信息记录表
	 * @param Map
	 * @return
	 */
	@Override
	public void insertFDBusiRecd(Map<String, Object> inMap) {
		baseDao.insert("bal_grpfdbusi_recd.iGrpfdbusi", inMap);
	}

	/**
	 * @Description 更新飞豆信息表状态
	 * @param phoneNo
	 * @return
	 */
	@Override
	public void updateFDBusiRecd(Map<String, Object> inMap) {
		baseDao.update("bal_grpfdbusi_recd.uGrpfdbusi", inMap);
	}
	
	/**
	 * @Description 飞豆充值记录查询
	 * @param phoneNo
	 * @return
	 */
	@Override
	public List<Map<String, Object>> queryFDBusiRecd(Map<String, Object> inMap) {
		List<Map<String, Object>> resultList =  baseDao.queryForList("bal_grpfdbusi_recd.qGrpfdbusiByBusiSn", inMap);
		return resultList;
	}

	@Override
	public List<RefundEntity> getRefundList1(Map<String, Object> inParam) {
		String groupId = (String) inParam.get("GROUP_ID");

		Map<String, Object> inMap = new HashMap<String, Object>();
		List<RefundEntity> refundList = new ArrayList<RefundEntity>();

		String beginYm = (String) inParam.get("BEGIN_YM");
		String endYm = (String) inParam.get("END_YM");
		String beginTime = (String) inParam.get("BEGIN_TIME");
		String endTime = (String) inParam.get("END_TIME");
		if (StringUtils.isNotEmpty(beginTime) || StringUtils.isNotEmpty(endTime)) {
			beginYm = beginTime.substring(0, 6);
			endYm = endTime.substring(0, 6);

			inMap.put("BEGIN_TIME", beginTime);
			inMap.put("END_TIME", endTime);
		}
		long contractNo = 0;
		log.debug((inParam.get("CONTRACT_NO") == null) + "");

		if (inParam.get("CONTRACT_NO") != null) {
			contractNo = (long) inParam.get("CONTRACT_NO");

		}

		if (inParam.get("QUERY_TYPE").toString().equals("1")) {
			// GPRS退费
			// TODO:codeId待定
			String codeId = "1201";
			// 查询二级退费原因代码
			String secReason = control.getPubCodeValue(2412, codeId, groupId);

			// 查询一级退费原因代码
			String firstReason = control.getPubCodeValue(2411, secReason, groupId);

			// 退费原因拼串
			String reason = firstReason + "|" + secReason + "|" + codeId;
			inMap.put("REASON", reason);

		}

		if (contractNo != 0) {
			inMap.put("CONTRACT_NO", contractNo);
		}

		log.debug("查询参数：" + inMap + ">>>>>beginYM:" + beginYm + ">>>" + endYm);

		for (int yearMonth = Integer.parseInt(beginYm); yearMonth <= Integer.parseInt(endYm); yearMonth = DateUtils.addMonth(yearMonth, 1)) {
			log.debug("i>>>>>>>" + yearMonth);
			inMap.put("YEAR_MONTH", yearMonth);
			List<RefundEntity> refundListTmp = baseDao.queryForList("act_adjowe_info.qryRefundInfo", inMap);
			for (RefundEntity refund : refundListTmp) {
				System.err.println(refund.getRefundType() + ">>>>>>>>>>>>>>>>>>>>>>>");
				if (refund.getRefundType().trim().equals("00")) {
					refund.setRefundTypeName("单倍退预存款");
				} else if (refund.getRefundType().trim().equals("01")) {
					refund.setRefundTypeName("单倍退预存款");
				} else if (refund.getRefundType().trim().equals("02")) {
					refund.setRefundTypeName("双倍退预存退现金");
				}
				refund.setOpTypeName("GPRS退费");
				refund.setSpCode("无");
				refund.setSpName("无");
				refund.setOperCode("无");
				refund.setOperName("无");
				refund.setBillName("无");
				refund.setBillType("无");
				refundList.add(refund);
			}
		}
		log.debug("refundList:" + refundList);

		return refundList;
	}

	public List<RefundEntity> getSpRefund1(Map<String, Object> inParam) {

		String queryType = (String) inParam.get("QUERY_TYPE");
		String groupId = (String) inParam.get("GROUP_ID");
		String phoneNo = (String) inParam.get("PHONE_NO");

		String beginTime = (String) inParam.get("BEGIN_TIME");
		String endTime = (String) inParam.get("END_TIME");
		String beginYm = beginTime.substring(0, 6);
		String endYm = endTime.substring(0, 6);

		Map<String, Object> inMap = new HashMap<String, Object>();
		List<RefundEntity> refundList = new ArrayList<RefundEntity>();
		inMap.put("BEGIN_TIME", beginTime);
		inMap.put("END_TIME", endTime);

		// 梦网及自有业务退费的first_code=1，即BACK_RSLT中的first_code=1

		if (queryType.equals("3")) {
			// 根据退费原因代码查询梦网及自有业务退费列表
			// TODO:codeId待定
			// 查询退费梦网自有业务的三级原因代码Pub_Codedef_Dict code_class=2412 and status=4
			// code_id(三级退费原因代码) code_value(二级退费原因代码)
			List<PubCodeDictEntity> pubList = control.getPubCodeList(2412l, "", "", "4");

			for (PubCodeDictEntity pubCodeDict : pubList) {
				String secReason = pubCodeDict.getCodeValue();
				// 根据退费梦网自有业务的二级原因代码从pub_codedef_dict code_class=2411
			}

			// 根据退费梦网自有业务的二级原因代码从pub_codedef_dict code_class=2411
			// 查询code_value（一级退费原因代码）

			String codeId = "1201";
			// 查询二级退费原因代码
			String secReason = control.getPubCodeValue(2412, codeId, groupId);

			// 查询一级退费原因代码
			String firstReason = control.getPubCodeValue(2411, secReason, groupId);

			// 退费原因拼串
			String reason = firstReason + "|" + secReason + "|" + codeId;
			inMap.put("REASON", reason);
		}

		// inMap.put("PHONE_NO", )
		inMap.put("PHONE_NO", phoneNo);

		log.debug("查询参数：" + inMap + "***" + beginYm + "*****" + endYm);

		for (int yearMonth = Integer.parseInt(beginYm); yearMonth <= Integer.parseInt(endYm); yearMonth = DateUtils.addMonth(yearMonth, 1)) {

			inMap.put("YEAR_MONTH", yearMonth);
			List<RefundEntity> refundListTmp = baseDao.queryForList("act_obbizback_info.qryRefundInfo", inMap);
			for (RefundEntity refund : refundListTmp) {
				refund.setSpName("无");
				refund.setOpTypeName("梦网及自有业务退费");
				refund.setOperName("无");
				refund.setBillName("无");
				System.err.println(refund.getRefundType() + ">>>>>>>>>>>>>>>>>>>>>>>");
				if (refund.getRefundType().trim().equals("00")) {
					refund.setRefundTypeName("单倍退预存款");
				} else if (refund.getRefundType().trim().equals("01")) {
					refund.setRefundTypeName("单倍退预存款");
				} else if (refund.getRefundType().trim().equals("02")) {
					refund.setRefundTypeName("双倍退预存退现金");
				}
				// TODO:查询sp名称，企业名称，计费类型名称
				if (StringUtils.isNotEmpty(refund.getSpCode())) {
					String spCode = refund.getSpCode();
					String spName = billAccount.getSpName(spCode);
					if (StringUtils.isNotEmpty(spName)) {
						refund.setSpName(spName);
					}

				}
				if (StringUtils.isNotEmpty(refund.getSpCode()) && StringUtils.isNotEmpty(refund.getOperCode())) {
					String operCode = refund.getOperCode();
					String spCode = refund.getSpCode();
					String operName = billAccount.getOperName(spCode, operCode);
					if (StringUtils.isNotEmpty(operName)) {
						refund.setOperName(operName);
					}

				}
				if (StringUtils.isNotEmpty(refund.getBillType())) {
					String billType = refund.getBillType();
					String billTypeName = billAccount.getbillTypeName(billType);
					if (StringUtils.isNotEmpty(billTypeName)) {
						refund.setBillName(billTypeName);
					}

				}
				// refund.
				refundList.add(refund);
			}
			// refundList.addAll(refundListTmp);
		}
		log.debug("refundList:" + refundList);

		return refundList;
	}

	@Override
	public List<RefundEntity> getRefundList(Map<String, Object> inParam) {
		List<RefundEntity> refundList = new ArrayList<RefundEntity>();

		// 从表act_adjowe_info中取值，索引op_time和contract_no
		String beginTime = inParam.get("BEGIN_TIME").toString();
		String endTime = inParam.get("END_TIME").toString();

		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("BEGIN_TIME", beginTime);
		inMap.put("END_TIME", endTime);

		if (StringUtils.isNotEmptyOrNull(inParam.get("CONTRACT_NO"))) {
			inMap.put("CONTRACT_NO", inParam.get("CONTRACT_NO"));
		}

		inMap.put("YEAR_MONTH", inParam.get("YEAR_MONTH").toString());
		log.debug("查询表act_adjowe_info全部的退费记录参数：" + inMap);
		List<RefundEntity> refundListTmp1 = baseDao.queryForList("act_adjowe_info.qryRefundInfo", inMap);

		// 查询act_obbizback_info表中记录，索引YEAR_MONTH, MSISDN
		inMap = new HashMap<String, Object>();
		inMap.put("BEGIN_TIME", beginTime);
		inMap.put("END_TIME", endTime);
		inMap.put("PHONE_NO", inParam.get("PHONE_NO"));

		inMap.put("YEAR_MONTH", inParam.get("YEAR_MONTH"));
		log.debug("查询表act_obbizback_info全部的退费记录参数：" + inMap);
		List<RefundEntity> refundListTmp2 = baseDao.queryForList("act_obbizback_info.qryRefundInfo", inMap);

		log.debug("refundListTmp2:" + refundListTmp2);

		refundList.addAll(refundListTmp1);
		refundList.addAll(refundListTmp2);

		log.debug("@@@@@@@@@@@@@@@@" + refundList);
		// 排序

		Collections.sort(refundList, new Comparator<RefundEntity>() {

			@Override
			public int compare(RefundEntity o1, RefundEntity o2) {
				return o1.getOpTime().compareTo(o2.getOpTime());
			}

		});

		return refundList;
	}

	@Override
	public List<RefundEntity> getSPBack(Map<String, Object> inParam) {

		List<RefundEntity> refundList = new ArrayList<RefundEntity>();
		Map<String, Object> inMap = new HashMap<String, Object>();
		if (StringUtils.isNotEmptyOrNull(inParam.get("STATUS"))) {
			inMap.put("STATUS", inParam.get("STATUS"));
		}
		if (StringUtils.isNotEmptyOrNull(inParam.get("LOGIN_ACCEPT"))) {
			inMap.put("LOGIN_ACCEPT", inParam.get("LOGIN_ACCEPT"));
		}
		if (StringUtils.isNotEmptyOrNull(inParam.get("PHONE_NO"))) {
			inMap.put("PHONE_NO", inParam.get("PHONE_NO"));
		}
		refundList = baseDao.queryForList("act_obbizback_info.qrySPBackInfo", inMap);

		return refundList;
	}
	
	@Override
	public List<BalCustRefundEntity> listSPInfo(Map<String, Object> inParam) {

		List<BalCustRefundEntity> refundList = new ArrayList<BalCustRefundEntity>();
		Map<String, Object> inMap = new HashMap<String, Object>();
		if (StringUtils.isNotEmptyOrNull(inParam.get("LOGIN_ACCEPT"))) {
			inMap.put("LOGIN_ACCEPT", inParam.get("LOGIN_ACCEPT"));
		}
		if (StringUtils.isNotEmptyOrNull(inParam.get("PHONE_NO"))) {
			inMap.put("PHONE_NO", inParam.get("PHONE_NO"));
		}
		refundList = baseDao.queryForList("bal_custrefund_info.qBalCustRefundInfo", inMap);

		return refundList;
	}
	
	@Override
	public void insertSPInfo(List<Map<String, Object>> iList){
		
		baseDao.batchInsert("bal_custrefund_info.iBalCustRefundInfo", iList);

	}

	@Override
	public List<RefundEntity> getGprsOrMonternetRefund(Map<String, Object> inParam) {
		// 查询gprs流量退费从表act_obbizback_info中查询，first_code=1的，EXT3=4
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("REASON", inParam.get("REASON"));
		inMap.put("FLAG", "4");
		inMap.put("PHONE_NO", inParam.get("PHONE_NO"));
		inMap.put("YEAR_MONTH", inParam.get("YEAR_MONTH"));
		inMap.put("BEGIN_TIME", inParam.get("BEGIN_TIME"));
		inMap.put("END_TIME", inParam.get("END_TIME"));
		List<RefundEntity> refundList = baseDao.queryForList("act_obbizback_info.qryRefundInfo", inMap);

		return refundList;
	}

	@Override
	public String reasonName(String codeClass, String reasonCode, String status) {
		String reasonName = "无";
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("CODE_CLASS", codeClass);
		inMap.put("CODE_ID", reasonCode);
		if (StringUtils.isNotEmptyOrNull(status)) {
			inMap.put("STATUS", status);
		}
		PubCodeDictEntity pubCode = (PubCodeDictEntity) baseDao.queryForObject("pub_codedef_dict.qVision", inMap);
		if (pubCode != null) {
			reasonName = pubCode.getCodeName();
		}

		return reasonName;
	}

	@Override
	public void saveBatchadjErr(BatchAdjInfoEntity batchAdjInfoEntity, String errType, String errCode, String errMsg) {

		BatchAdjErrEntity object = new BatchAdjErrEntity();
		object.setBatchSn(batchAdjInfoEntity.getBatchSn());
		object.setLoginAccept(batchAdjInfoEntity.getLoginAccept());
		object.setContractNo(batchAdjInfoEntity.getContractNo());
		object.setIdNo(batchAdjInfoEntity.getIdNo());
		object.setPhoneNo(batchAdjInfoEntity.getPhoneNo());
		object.setBillCycle(batchAdjInfoEntity.getBillCycle());
		object.setAcctItemCode(batchAdjInfoEntity.getAcctItemCode());
		object.setPayType(batchAdjInfoEntity.getPayType());
		object.setShouldPay(batchAdjInfoEntity.getShouldPay());
		object.setFavourFee(batchAdjInfoEntity.getFavourFee());
		object.setLoginNo(batchAdjInfoEntity.getLoginNo());
		object.setRemark(batchAdjInfoEntity.getRemark());
		object.setDealType(batchAdjInfoEntity.getDealType());
		object.setBalanceType(batchAdjInfoEntity.getBalanceType());
		object.setErrType(errType);
		object.setErrCode(errCode);
		object.setErrMsg(errMsg);
		baseDao.insert("bal_batchadj.iBatchAdjErr", object);
	}

	@Override
	public void saveBatchadjInfo(BatchAdjInfoEntity object) {

		baseDao.insert("bal_batchadj.iBatchAdj", object);
	}

	/* 获取某月累计补收金额 */
	@Override
	public long getMonthFee(Map<String, Object> inParm) {

		long monthFee = (long) baseDao.queryForObject("act_adjowe_info.qryMonthFee", inParm);

		return monthFee;
	}
	
	/* 获取某月累计负补收金额 */
	@Override
	public long getMinusMonthFee(Map<String, Object> inParm) {

		long monthFee = (long) baseDao.queryForObject("act_adjowe_info.qryMinusMonthFee", inParm);

		return monthFee;
	}

	@Override
	public List<ItemEntity> getAdjItemList() {

		List<ItemEntity> result = baseDao.queryForList("act_item_conf.qAdjItemList");

		return result;
	}

	@Override
	public List<ItemEntity> getAdjItemByBrandId(Map<String, Object> inParm) {

		List<ItemEntity> result = baseDao.queryForList("act_item_conf.qItemByBrandId", inParm);
		return result;
	}

	@Override
	public void saveMicroPayInfo(Map<String, Object> inParam) {
		// TODO Auto-generated method stub
		baseDao.insert("bal_micropay_info.iMicroPayRecd", inParam);
	}
	
	@Override
	public void updateMicroPayInfo(Map<String, Object> inParam) {
		// TODO Auto-generated method stub
		baseDao.update("bal_micropay_info.uMicroPayRecd", inParam);
	}
	
	@Override
	public List<MicroPayEntity> queryMicroPayInfo(Map<String, Object> inParam){
		
		List<MicroPayEntity> result = baseDao.queryForList("bal_micropay_info.qMicroPayRecd",inParam);
		return result;
	}

	public IControl getControl() {
		return control;
	}

	public void setControl(IControl control) {
		this.control = control;
	}

	public IBillAccount getBillAccount() {
		return billAccount;
	}

	public void setBillAccount(IBillAccount billAccount) {
		this.billAccount = billAccount;
	}

}
