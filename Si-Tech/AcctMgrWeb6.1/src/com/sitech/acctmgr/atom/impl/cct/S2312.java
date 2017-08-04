package com.sitech.acctmgr.atom.impl.cct;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.cct.UnStopHolidayEntity;
import com.sitech.acctmgr.atom.domains.record.LoginOprEntity;
import com.sitech.acctmgr.atom.dto.cct.S2312CfmInDTO;
import com.sitech.acctmgr.atom.dto.cct.S2312CfmOutDTO;
import com.sitech.acctmgr.atom.dto.cct.S2312QryInDTO;
import com.sitech.acctmgr.atom.dto.cct.S2312QryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.ICredit;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.inter.cct.I2312;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.util.DateUtil;

@ParamTypes({ 
	@ParamType(c=S2312QryInDTO.class,m="query",oc=S2312QryOutDTO.class),
	@ParamType(c=S2312CfmInDTO.class,m="cfm",oc=S2312CfmOutDTO.class)
})
public class S2312 extends AcctMgrBaseService implements I2312{

	private IGroup group;
	private ICredit credit;
	private IControl control;
	private IRecord record;
	
	@Override
	public OutDTO query(InDTO inParam) {
		// TODO Auto-generated method stub
		S2312QryInDTO inDto = (S2312QryInDTO)inParam;
		String groupId = inDto.getGroupId();
		
		ChngroupRelEntity crge = group.getRegionDistinct(groupId, "2", inDto.getProvinceId());
		String regionCode = crge.getRegionCode();
		String regionName = regionCode+"-"+crge.getRegionName();
		
		List<UnStopHolidayEntity> resultList = credit.getUnStopHoliday(regionCode);
		
		S2312QryOutDTO outDto = new S2312QryOutDTO();
		outDto.setRegionCode(regionCode);
		outDto.setRegionName(regionName);
		outDto.setResultList(resultList);
		return outDto;
	}

	@Override
	public OutDTO cfm(InDTO inParam) {
		// TODO Auto-generated method stub
		S2312CfmInDTO inDto = (S2312CfmInDTO)inParam;
		String opType = inDto.getOpType();
		String regionCode = inDto.getRegionCode();
		String level = inDto.getLevel();
		String beginTime = inDto.getBeginTime()+"00";
		String endTime = inDto.getEndTime()+"23";
		String holidayName = inDto.getHolidayName();
		String  opNote= inDto.getOpNote();
		String oldRegionCode = inDto.getOldRegionCode();
		String oldLevel = inDto.getOldLevel();
		String oldBeginTime = inDto.getOldBeginTime();
		String oldEndTime = inDto.getOldEndTime();
		
		long loginAccept=control.getSequence("SEQ_SYSTEM_SN");
		
		if(opType.equals("1")) {
			Map<String,Object> inMap = new HashMap<String,Object>();
			inMap.put("LOGIN_ACCEPT", loginAccept);
			inMap.put("REGION_CODE", regionCode);
			inMap.put("ILEVEL", level);
			inMap.put("BEGIN_YMDH", beginTime);
			inMap.put("END_YMDH", endTime);
			inMap.put("HOLIDAY_NAME", holidayName);
			inMap.put("OP_NOTE", opNote);
			inMap.put("LOGIN_NO", inDto.getLoginNo());
			credit.oprHolidayUnstop(inMap, opType);
		}else if(opType.equals("2")) {
			Map<String,Object> inMap = new HashMap<String,Object>();
			inMap.put("REGION_CODE", regionCode);
			inMap.put("ILEVEL", level);
			inMap.put("BEGIN_YMDH", beginTime);
			inMap.put("END_YMDH", endTime);
			inMap.put("HOLIDAY_NAME", holidayName);
			inMap.put("OP_NOTE", opNote);
			inMap.put("LOGIN_NO", inDto.getLoginNo());
			inMap.put("OLD_REGION_CODE", oldRegionCode);
			inMap.put("OLD_ILEVEL", oldLevel);
			inMap.put("OLD_BEGIN_YMDH", oldBeginTime);
			inMap.put("OLD_END_YMDH", oldEndTime);
			credit.oprHolidayUnstop(inMap, opType);
		}else if(opType.equals("3")) {
			Map<String,Object> inMap = new HashMap<String,Object>();
			inMap.put("OLD_REGION_CODE", oldRegionCode);
			inMap.put("OLD_ILEVEL", oldLevel);
			inMap.put("OLD_BEGIN_YMDH", oldBeginTime);
			inMap.put("OLD_END_YMDH", oldEndTime);
			credit.oprHolidayUnstop(inMap, opType);
		}
		
		//取系统时间
		String sCurDate = DateUtil.format(new Date(), "yyyyMMdd");
		
		LoginOprEntity loe = new LoginOprEntity();
		loe.setLoginGroup(inDto.getGroupId());
		loe.setLoginNo(inDto.getLoginNo());
		loe.setLoginSn(loginAccept);
		loe.setTotalDate(Long.parseLong(sCurDate));
		loe.setIdNo(0);
		loe.setPhoneNo("");
		loe.setBrandId("xx");
		loe.setPayType("00");
		loe.setPayFee(0);
		loe.setOpCode("2312");
		loe.setRemark("节假日配置");
		record.saveLoginOpr(loe);
		
		S2312CfmOutDTO outDto =  new S2312CfmOutDTO();
		return outDto;
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
