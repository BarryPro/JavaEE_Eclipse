package com.sitech.acctmgr.atom.impl.cct;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.MapUtils;

import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.cct.CreditDetailEntity;
import com.sitech.acctmgr.atom.domains.cct.CreditInfoEntity;
import com.sitech.acctmgr.atom.domains.record.LoginOprEntity;
import com.sitech.acctmgr.atom.domains.user.GroupchgInfoEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.cct.SCreditCfmInDTO;
import com.sitech.acctmgr.atom.dto.cct.SCreditCfmOutDTO;
import com.sitech.acctmgr.atom.dto.cct.SCreditQryDetailInDTO;
import com.sitech.acctmgr.atom.dto.cct.SCreditQryDetailOutDTO;
import com.sitech.acctmgr.atom.dto.cct.SCreditQryInDTO;
import com.sitech.acctmgr.atom.dto.cct.SCreditQryOutDTO;
import com.sitech.acctmgr.atom.dto.cct.SCreditQueryForCrmInDTO;
import com.sitech.acctmgr.atom.dto.cct.SCreditQueryForCrmOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.ICredit;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.util.DateUtil;

@ParamTypes({ 
	@ParamType(m = "query", c = SCreditQryInDTO.class, oc = SCreditQryOutDTO.class),
	@ParamType(m = "queryDetail", c = SCreditQryDetailInDTO.class, oc = SCreditQryDetailOutDTO.class),
	@ParamType(m = "cfm", c = SCreditCfmInDTO.class, oc = SCreditCfmOutDTO.class),
	@ParamType(m = "queryForCrm", c = SCreditQueryForCrmInDTO.class, oc = SCreditQueryForCrmOutDTO.class)
})
public class SCredit extends AcctMgrBaseService implements com.sitech.acctmgr.inter.cct.ICredit{

	protected IUser user;
	protected ICredit credit;
	protected IGroup group;
	protected IControl control;
	protected IRecord record;
	
	@Override
	public OutDTO query(InDTO inParam) {

		SCreditQryInDTO sCreditQryInDTO = (SCreditQryInDTO) inParam;
		log.info("inDTO:" + sCreditQryInDTO.getMbean());
		
		long overFee = 0;
		long idNo = 0;
		String creditCode = "-1";
		String creditName = "未评级";
		// 获取信用度有效日期
		String beginTime = "";
		String endTime = "";
		long t1 = System.currentTimeMillis();
		
		String sPhoneNo=null;
		if (StringUtils.isNotEmpty(sCreditQryInDTO.getPhoneNo())){
			sPhoneNo = sCreditQryInDTO.getPhoneNo();
		}
		
		if (StringUtils.isNotEmpty(sCreditQryInDTO.getIdNo())) {
			idNo = Long.parseLong(sCreditQryInDTO.getIdNo());
		}

		//idNo 不为空时，获取默认phoneNo
		if (idNo != 0 && StringUtils.isEmpty(sPhoneNo)) {
			UserInfoEntity result = user.getUserEntity(idNo, null, null, true);
			sPhoneNo = result.getPhoneNo();
		}
		
		UserInfoEntity uie = user.getUserInfo(sPhoneNo);
		idNo = uie.getIdNo();

		Map<String, Object> creditMap = credit.getCreditInfo(idNo);
		if (creditMap == null || creditMap.isEmpty()) {
			throw new BusiException(AcctMgrError.getErrorCode("0000", "00020"),
					"查询信用度信息出错!");
		}

		if (creditMap.get("IS_CREDIT").equals("1")) {
			// 信用度有效时间
			beginTime = (String) creditMap.get("BEGIN_TIME");
			endTime = (String) creditMap.get("END_TIME");

			// 信用度等级
			if (creditMap.get("CREDIT_CODE") != null
					&& !creditMap.get("CREDIT_CODE").equals("")) {
				creditCode = creditMap.get("CREDIT_CODE").toString().trim();
			}
			// 信用度名称
			if ((String) creditMap.get("CREDIT_NAME") != null
					&& !creditMap.get("CREDIT_NAME").equals("")) {
				creditName = creditMap.get("CREDIT_NAME").toString().trim();
			}
		}
	
		// 可透支额度
		if (creditMap.get("OVER_FEE") != null
				&& !creditMap.get("OVER_FEE").equals("")) {
			overFee = Long.parseLong(creditMap.get("OVER_FEE").toString());
		}

		SCreditQryOutDTO sCreditQryOutDTO = new SCreditQryOutDTO();
		sCreditQryOutDTO.setPhoneNo(sPhoneNo);
		sCreditQryOutDTO.setCreditCode(creditCode);
		sCreditQryOutDTO.setCreditCode2(creditCode);
		// 信用度等级
		sCreditQryOutDTO.setCreditGrade(creditName);
		sCreditQryOutDTO.setOverFee(overFee);
		sCreditQryOutDTO.setBeginTime(beginTime);
		sCreditQryOutDTO.setEndTime(endTime);
		log.info("credit outdto" + sCreditQryOutDTO.toJson());
		
		long t2 = System.currentTimeMillis();
		System.out.println("耗时：" + (t2 - t1) + "ms");
		
		return sCreditQryOutDTO;
	}
	
	@Override
	public OutDTO queryDetail(InDTO inParam) {
		/*
		 * 05 亲情号码标识 04 双停(即全停)次数 13 缴费回馈时长 14 银行卡绑定缴费次数 02 网龄 03 月均ARPU 06
		 * 集团V网标识 11 通信用户标识 10 实名制标识 12 终端捆绑时长 15 集团托收客户标识 07 幸福家庭标识 08 合约捆绑得分
		 * 09 是否绑定付费得分
		 */

		Map<String, Object> inMap = new HashMap<String, Object>();
		Map<String, Object> outMap = new HashMap<String, Object>();
		Map<String, Object> userMap = new HashMap<String, Object>();
		List<CreditDetailEntity> detailList= new ArrayList<CreditDetailEntity>();

		long baseScore=0;//基础得分
		long addScore=0;//加分值
		long lessScore=0;//减分值
		long allScore=0;//总分
		String creditClass="";//客户星级
		String beginTime = "";
		String endTime = "";
		String adjFlag="";
		int cnt=0;
		
		SCreditQryDetailInDTO inDto = (SCreditQryDetailInDTO) inParam;
		String phoneNo = inDto.getPhoneNo();
		//String chnCode = inDto.getChnCode();

		UserInfoEntity uie = user.getUserInfo(phoneNo);
		long lIdNo = uie.getIdNo();
		
		inMap.put("ID_NO", lIdNo);
		cnt = credit.getCreditInfoCnt(inMap);
		if(cnt==0) {
			throw new BusiException(AcctMgrError.getErrorCode("0000","10035"), "您是暂未获得星级用户，无法进行此项操作");
		}
		
		//取明细
		//tempList = credit.qCreditDetail(inMap);
		inMap.put("SUFFIX", "<= '50'");
		detailList = credit.qCreditDetail(inMap);
		
		String sCreditName = "";
		Map<String, Object> creditMap = credit.getCreditInfo(lIdNo);
		if (creditMap == null || creditMap.isEmpty()) {
			throw new BusiException(AcctMgrError.getErrorCode("0000", "00020"),
					"查询信用度信息出错!");
		}

		if (creditMap.get("IS_CREDIT").equals("1")) {
			// 信用度有效时间
			beginTime = (String) creditMap.get("BEGIN_TIME");
			endTime = (String) creditMap.get("END_TIME");

			// 信用度等级
			if (creditMap.get("CREDIT_CODE") != null
					&& !creditMap.get("CREDIT_CODE").equals("")) {
				creditClass = creditMap.get("CREDIT_CODE").toString().trim();
			}
			// 信用度名称
			if ((String) creditMap.get("CREDIT_NAME") != null
					&& !creditMap.get("CREDIT_NAME").equals("")) {
				sCreditName = creditMap.get("CREDIT_NAME").toString().trim();
			}

		}
		
		SCreditQryDetailOutDTO outDTO =new SCreditQryDetailOutDTO();
		outDTO.setCreditClass(creditClass);
		outDTO.setCreditName(sCreditName);
		outDTO.setStartTime(beginTime);
		outDTO.setEndTime(endTime);
		outDTO.setBaseScore(baseScore);
		outDTO.setAddScore(addScore);
		outDTO.setLessScore(lessScore);
		outDTO.setAllScore(allScore);
		outDTO.setDetailList(detailList);
		
		return outDTO;

	}
	
	@Override
	public OutDTO cfm(InDTO inParam) {
		// TODO Auto-generated method stub
		SCreditCfmInDTO inDto = (SCreditCfmInDTO)inParam;
		String phoneNo = inDto.getPhoneNo();
		String custName = inDto.getCustName();
		String custIcid = inDto.getCustIcid();
		String remindPhone = inDto.getRemindPhone();
		
		//TODO 非实名制用户不能办理 
		//dTrueNameMsg模型待定
		long idNo=0;
		
		//TODO 信誉度黑名单不能办理 
		//dLimitOwe_BlackList模型待定
		
		//TODO 人工受信不能办理
		//wCreditCfgOpr模型待定
		
		//已申请动态信誉度的不能办理
		int cnt = credit.cntCreditAdj(idNo);
		if(cnt>0){
			throw new BusiException(AcctMgrError.getErrorCode("0000","00004"), "已参与过动态信誉度的不得申请本服务！");
		}
		
		//TODO 核实输入 姓名与登记姓名是否一致
		
		//TODO核实输入 证件号与登记证件号是否一致
		
		//取用户星级
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("ID_NO",idNo);
		inMap.put("VALID_FLAG", "1");
		CreditInfoEntity cie = credit.pQCreditInfoById(inMap);
		if(cie==null) {
			throw new BusiException(AcctMgrError.getErrorCode("0000","00004"), "非星级用户或评级已失效！");
		}
		String creditClass = cie.getCreditClass();
		int regionCode = cie.getRegionId();
		
		//取星级对应信誉度
		Map<String, Object> outMap = new HashMap<String, Object>();
		inMap.put("CREDIT_CODE", creditClass);
		inMap.put("REGION_CODE", regionCode);
		//outMap=credit.pQCreditDayByCreditCode(inMap);
		long limitOwe = Long.parseLong(outMap.get("OVER_FEE").toString());
		
		//TODO 入星级客户信誉度申请表
		//dCustLevelOwe模型待定
		
		//TODO 更新用户信誉度
		
		
		//TODO send ShortMsg
		
		//入操作记录表
		LoginOprEntity loe = new LoginOprEntity();
		loe.setLoginSn(control.getSequence("SEQ_SYSTEM_SN"));
		loe.setLoginNo(inDto.getLoginNo());
		loe.setLoginGroup(inDto.getGroupId());
		loe.setTotalDate(Long.parseLong(DateUtil.format(new Date(), "yyyyMMdd")));
		loe.setIdNo(idNo);
		loe.setPhoneNo(phoneNo);
		loe.setBrandId("00");
		loe.setPayType("0");
		loe.setPayFee(0);
		loe.setOpCode("xxxx");
		loe.setRemark(creditClass+"级客户信誉度申请");
		record.saveLoginOpr(loe);
		
		SCreditCfmOutDTO outDto = new SCreditCfmOutDTO();
		return outDto;
	}
	
	@Override
	public  OutDTO queryForCrm(InDTO inParam){
		SCreditQueryForCrmInDTO inArg =  (SCreditQueryForCrmInDTO)inParam;
		SCreditQueryForCrmOutDTO outArg = new SCreditQueryForCrmOutDTO();
		Map<String,Object> inMap = new HashMap<String,Object>();
		MapUtils.safeAddToMap(inMap, "ID_NO", inArg.getIdNo());
		MapUtils.safeAddToMap(inMap, "OP_TIME", inArg.getOpTime());
		String outClass = credit.getClass(inMap);
		Map<String,Object> inChangeMap = new HashMap<String,Object>();
		MapUtils.safeAddToMap(inChangeMap, "REGION_CODE", inArg.getIdNo().substring(0, 4));//地市编码
		MapUtils.safeAddToMap(inChangeMap, "CREDIT_CODE", outClass);										//星级类型
		String outClassName = credit.getClassName(inChangeMap);
		outArg.setCreditClass(outClassName);
		return outArg;
	}

	/**
	 * @return the user
	 */
	public IUser getUser() {
		return user;
	}

	/**
	 * @param user the user to set
	 */
	public void setUser(IUser user) {
		this.user = user;
	}

	/**
	 * @return the credit
	 */
	public ICredit getCredit() {
		return credit;
	}

	/**
	 * @param credit the credit to set
	 */
	public void setCredit(ICredit credit) {
		this.credit = credit;
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

	/**
	 * @return the record
	 */
	public IRecord getRecord() {
		return record;
	}

	/**
	 * @param record the record to set
	 */
	public void setRecord(IRecord record) {
		this.record = record;
	}


	
}
