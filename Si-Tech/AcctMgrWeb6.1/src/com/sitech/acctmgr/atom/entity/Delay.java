package com.sitech.acctmgr.atom.entity;

import com.sitech.acctmgr.atom.domains.account.ContractDeadInfoEntity;
import com.sitech.acctmgr.atom.domains.account.ContractInfoEntity;
import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.entity.inter.IAccount;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.IDelay;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.BaseBusi;
import com.sitech.acctmgr.common.constant.CommonConst;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.util.DateUtil;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import static org.apache.commons.collections.MapUtils.getString;

/**
 *
 * <p>Title: 公共滞纳金相关类</p>
 * <p>Description:  存放查取、计算滞纳金等方法</p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author yankma
 * @version 1.0
 */
public class Delay extends BaseBusi implements IDelay {
	
	private IAccount	account;
	private IGroup		group;
	private IControl	control;
	
	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.atom.entity.IDelay#pGetDelayRate(java.util.Map)
	 */
	@Override
	public Map<String, Object> getDelayRate(Map<String, Object> inParam) {
		
		Map<String, Object> inMapTmp = null;
		Map<String, Object> outMapTmp = null;
		
		long contractNo = (Long) inParam.get("CONTRACT_NO");
		int iNetFlag = 0;	/*在离网标识*/
		if(StringUtils.isNotEmptyOrNull(inParam.get("NET_FLAG"))) {
			iNetFlag = Integer.parseInt(inParam.get("NET_FLAG").toString());
		}
		String provinceId = getString(inParam,"PROVINCE_ID");
		if(provinceId == null){
			provinceId = control.getProvinceId(contractNo);
		}
		
		/*取滞纳金标志*/
		String sPayCode = "";	/*帐户类型*/
		String sGroupId = "";	/*组织代码*/
		inMapTmp = new HashMap<String, Object>();
		inMapTmp.put("CONTRACT_NO", contractNo);
		if(iNetFlag == CommonConst.IN_NET) {
			ContractInfoEntity conEntity = account.getConInfo(contractNo);
			sPayCode = conEntity.getPayCode();
			sGroupId = conEntity.getGroupId();
		} else {
			ContractDeadInfoEntity conDeadEntity = (ContractDeadInfoEntity)this.baseDao.queryForObject("ac_contractdead_info.qConDeadInfoByConNo",inMapTmp);
			if(conDeadEntity == null) {
				log.debug("RETURN_CODE:xxxxxx(请指示),取账户信息不存在");
				throw new BusiException(AcctMgrError.getErrorCode("0000","00054"),"账户信息不存在");
			}
			sPayCode = "#";
			sGroupId = conDeadEntity.getGroupId();
		}
		
		/*取地市代码*/
		ChngroupRelEntity  groupEntity = group.getRegionDistinct(sGroupId, "2", provinceId);
		String sRegionCode = groupEntity.getRegionCode();
		
		/*取滞纳金比率和滞纳金开始时间*/
		inMapTmp = new HashMap<String, Object>();
		inMapTmp.put("PAY_CODE", sPayCode);
		inMapTmp.put("REGION_CODE", sRegionCode);
		inMapTmp.put("RUN_FLAG", iNetFlag);
		outMapTmp = (Map<String, Object>)baseDao.queryForObject("bal_delayrule_conf.qDelayruleConf",inMapTmp);
		if(outMapTmp == null) {
			log.debug("RETURN_CODE:xxxxxx(请指示),取滞纳金比率出错");
			throw new BusiException(AcctMgrError.getErrorCode("0000","10028"),"取滞纳金比率出错");
		}
		double dDelayRate = Double.valueOf(outMapTmp.get("DELAY_RATE").toString());
		int iDelayBeginDate = Integer.valueOf(outMapTmp.get("DELAY_BEGIN").toString());
		
		Map<String, Object> outParam = new HashMap<String, Object>();
		outParam.put("DELAY_RATE", dDelayRate);
		outParam.put("DELAY_BEGIN", iDelayBeginDate);
		
		return outParam;
	}

	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.atom.entity.IDelay#pGetDelayFee(java.util.Map)
	 */
	@Override
	public long getDelayFee(Map<String, Object> inParam) {
		
		int iBillBegin = 0;
		long lOweFee = 0;
		int iDelayBegin = 0;
		double dDelayRate = 0;
		int iBillCycle = 0;
		int iTotalDate = 0;
		
		iBillBegin = Integer.parseInt(inParam.get("BILL_BEGIN").toString());
		lOweFee = Long.parseLong(inParam.get("OWE_FEE").toString());
		iDelayBegin = Integer.parseInt(inParam.get("DELAY_BEGIN").toString());
		dDelayRate = Double.parseDouble(inParam.get("DELAY_RATE").toString());
		iBillCycle = Integer.parseInt(inParam.get("BILL_CYCLE").toString());
		iTotalDate = Integer.parseInt(inParam.get("TOTAL_DATE").toString());
		
		/*欠费不足两个账期，不取滞纳金*/
		int iStartDate = 0;
		iStartDate = Integer.valueOf(DateUtil.toStringPlusMonths(String.valueOf(iBillCycle), 2, "yyyyMM"))
				* 100 + iBillBegin%10;
		
		if(iStartDate > iTotalDate) {
			log.debug("欠费不足两个账期，不取滞纳金");
			
			return 0;
		}
		
		/*取两个日期之间的天数*/
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
		
		Date daTotalDate = null;
		Date daStartDate = null;
		try {
			daTotalDate = df.parse(String.valueOf(iTotalDate));
			daStartDate = df.parse(String.valueOf(iStartDate));
		} catch (ParseException e) {
			throw new BusiException("00000", "时间格式不正确");
		}
		
		long lDelayDay = 0;
		
		lDelayDay = (daTotalDate.getTime() - daStartDate.getTime()) / (1000 * 60 * 60 * 24) - iDelayBegin;
		
		log.debug("DELAY_DAY = " + lDelayDay);
		
		if(lDelayDay < 0) {
			lDelayDay = 0;
		}
		
		//计算滞纳金
		BigDecimal bOweFee = new BigDecimal(lOweFee);
		BigDecimal bDelayRate = new BigDecimal(dDelayRate);
		BigDecimal bDelayDay = new BigDecimal(lDelayDay);
		
		BigDecimal bDelayFee = bOweFee.multiply(bDelayRate).multiply(bDelayDay);
		
		long lDelayFee = 0L;
		//将BigDecimal转化为long前四舍五入
		lDelayFee = bDelayFee.setScale(0, BigDecimal.ROUND_HALF_UP).longValue();
		
		log.debug("bOweFee = " + bOweFee.toString() 
				+ ",bDelayRate = " + bDelayRate.toString() 
				+ ",bDelayDay = " + bDelayDay.toString()
				+ ",bDelayFee = " + bDelayFee.toString()
				+ ",lDelayFee = " + lDelayFee
				+ ",iStartDate = " + iStartDate);
		
		lDelayFee = specialDelayFee(lDelayFee, lOweFee);
		
		return lDelayFee;
	}
	
	
	protected long specialDelayFee(long lDelayFee, long lOweFee) {
		
		//若滞纳金大于欠费金额的2倍，则滞纳金为欠费金额的2倍，否则为算出的滞纳金
		if(lDelayFee >= lOweFee * 2) {
			lDelayFee = lOweFee * 2;
		}
		return lDelayFee;
	}

	
	/**
	 * @return the group
	 */
	public IGroup getGroup() {
		return group;
	}

	/**
	 * @param group the group to set
	 */
	public void setGroup(IGroup group) {
		this.group = group;
	}

	/**
	 * @return the account
	 */
	public IAccount getAccount() {
		return account;
	}

	/**
	 * @param account the account to set
	 */
	public void setAccount(IAccount account) {
		this.account = account;
	}

	/**
	 * @return the control
	 */
	public IControl getControl() {
		return control;
	}

	/**
	 * @param control the control to set
	 */
	public void setControl(IControl control) {
		this.control = control;
	}
	
	
}
