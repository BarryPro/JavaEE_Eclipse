package com.sitech.acctmgr.atom.impl.cct;

import java.util.Date;

import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.record.LoginOprEntity;
import com.sitech.acctmgr.atom.dto.cct.S2315InDTO;
import com.sitech.acctmgr.atom.dto.cct.S2315OutDTO;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.ICredit;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.inter.cct.I2315;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.util.DateUtil;

@ParamTypes({ 
	@ParamType(c=S2315InDTO.class,m="query",oc=S2315OutDTO.class),
	@ParamType(c=S2315InDTO.class,m="cfm",oc=S2315OutDTO.class)
})
public class S2315 extends AcctMgrBaseService implements I2315{

	private ICredit credit;
	private IRecord record;
	private IControl control;
	private IGroup group;
	
	@Override
	public OutDTO query(InDTO inParam) {
		S2315InDTO inDto = (S2315InDTO)inParam;
		
		ChngroupRelEntity cgre = group.getRegionDistinct(inDto.getGroupId(), "2", inDto.getProvinceId());
		String regionCode = cgre.getRegionCode();
		String regionName = cgre.getRegionName();
		
		String opType = "";
		opType = credit.getKeyWordMap(regionCode, inDto.getOpCode());
		
		S2315OutDTO outDto = new S2315OutDTO();
		outDto.setOpType(opType);
		outDto.setRegionCode(regionCode);
		outDto.setRegionName(regionName);
		return outDto;
	}

	@Override
	public OutDTO cfm(InDTO inParam) {
		S2315InDTO inDto = (S2315InDTO)inParam;
		String regionCode = inDto.getRegionCode();
		String opType = inDto.getOpType();
		
		String note = "";
		if(opType.equals("OFF")) {			
			note="禁用模式";
		}else if(opType.equals("HRB")) {
			note="哈尔滨个性模式";
		}else if(opType.equals("HLJ")) {
			note="全省统一模式";
		}	
		credit.saveKeyWordMap(regionCode, opType,note);
		
		// 记录操作日志
		long lLoginSn = control.getSequence("SEQ_SYSTEM_SN");
		String sCurDate = DateUtil.format(new Date(), "yyyyMMdd");

		LoginOprEntity loe = new LoginOprEntity();
		loe.setLoginSn(lLoginSn);
		loe.setLoginNo(inDto.getLoginNo());
		loe.setLoginGroup(inDto.getGroupId());
		loe.setTotalDate(Long.parseLong(sCurDate));
		loe.setBrandId("00");
		loe.setPayType("0");
		loe.setPayFee(0);
		loe.setOpCode("2315");
		loe.setRemark("修改为:"+note);
		record.saveLoginOpr(loe);
		
		S2315OutDTO outDto = new S2315OutDTO();
		return outDto;
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
	
}
