package com.sitech.acctmgr.atom.impl.pay;

import com.sitech.acctmgr.atom.busi.pay.inter.ILimitFee;
import com.sitech.acctmgr.atom.busi.pay.inter.IPayManage;
import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.pay.DistrictLimitEntity;
import com.sitech.acctmgr.atom.domains.pay.RegionLimitEntity;
import com.sitech.acctmgr.atom.domains.record.LoginOprEntity;
import com.sitech.acctmgr.atom.dto.pay.S8203CfmInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8203CfmOutDTO;
import com.sitech.acctmgr.atom.dto.pay.S8203InitInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8203InitOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.inter.pay.I8203;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;


/**
 *
 * <p>
 * Title: 转账退费限额设置服务实现类
 * </p>
 * <p>
 * Description: 转账退费限额设置服务超类，定义转账退费限额设置模版
 * </p>
 * <p>
 * Copyright: Copyright (c) 2016
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author SUZJ
 * @version 1.0
 */

@ParamTypes({ @ParamType(m = "init", c = S8203InitInDTO.class, oc = S8203InitOutDTO.class),
			  @ParamType(m = "cfm", c = S8203CfmInDTO.class,oc = S8203CfmOutDTO.class)})
public class S8203 extends AcctMgrBaseService implements I8203 {
	
	protected IPayManage payManage;
	protected IControl control;
	protected IGroup group;
	protected IRecord record;
	protected ILimitFee limitFee;
	
	public OutDTO init(InDTO inParam){
		
		S8203InitInDTO inDto = (S8203InitInDTO)inParam;
		
		/*获取入参信息*/
		String groupId = inDto.getGroupId();
		String provinceId = inDto.getProvinceId();
		String limitArea = inDto.getLimitArea();
		String limitType = inDto.getLimitType();
		String regionGroup = inDto.getRegionGroup();
		String districtGroup = inDto.getDistrictGroup();
		
		//获取工号所在地市
		ChngroupRelEntity groupRelEntity = group.getRegionDistinct(groupId, "2", provinceId);
		String regionId = groupRelEntity.getRegionCode();
		ChngroupRelEntity groupRelEntity2 = group.getRegionDistinct(regionGroup, "2", provinceId);
		String regionId2 = groupRelEntity2.getRegionCode();
		log.info("1L:"+regionId+"2L:"+regionId2);
		if(!(regionId.equals(regionId2))){
			throw new BusiException(AcctMgrError.getErrorCode("8203","00001"), "前台工号只允许修改当前地市配置!");
		}
		
		/*获取限额信息*/
		RegionLimitEntity regionLimitEnt = limitFee.getRegionLimitConf(regionGroup, limitType);
		long regionMonthLimit = regionLimitEnt.getLimitMonthFee();
		long regionDayLimit = regionLimitEnt.getLimitDayFee();
		String regionMsgPhone = regionLimitEnt.getMsgPhone();
		
		/*出参*/
		S8203InitOutDTO outDto = new S8203InitOutDTO();
		
		outDto.setRegionMonthLimit(regionMonthLimit);
		outDto.setRegionDayLimit(regionDayLimit);
		outDto.setMsgPhone(regionMsgPhone);
		if(limitArea.equals("2")){
			DistrictLimitEntity districtLimitEnt = limitFee.getDistrictLimitConf(regionGroup, districtGroup, limitType);
			long districtMonthLimit = districtLimitEnt.getLimitMonthFee();
			long districtDayLimit = districtLimitEnt.getLimitDayFee();
			String districtMsgPhone = districtLimitEnt.getMsgPhone();
			outDto.setDistrictMonthLimit(districtMonthLimit);
			outDto.setDistrictDayLimit(districtDayLimit);
			outDto.setMsgPhone(districtMsgPhone);
		}
		
		return outDto;
	}
	
	public OutDTO cfm(InDTO inParam){
		
		S8203CfmInDTO inDto = (S8203CfmInDTO)inParam;
		
		/*获取入参信息*/
		String limitArea = inDto.getLimitArea();
		String limitType = inDto.getLimitType();
		String regionGroup = inDto.getRegionGroup();
		String districtGroup = inDto.getDistrictGroup();
		String regionMonthLimit = inDto.getRegionMonthLimit();
		String regionDayLimit = inDto.getRegionDayLimit();
		String districtMonthLimit = inDto.getDistrictMonthLimit();
		String districtDayLimit = inDto.getDistrictDayLimit();
		String msgPhone = inDto.getMsgPhone();
		String returnNothing = "0";
		String groupId = inDto.getGroupId();
		String provinceId = inDto.getProvinceId();
		
		//获取工号所在地市
		ChngroupRelEntity groupRelEntity = group.getRegionDistinct(groupId, "2", provinceId);
		String regionId = groupRelEntity.getRegionCode();
		ChngroupRelEntity groupRelEntity2 = group.getRegionDistinct(regionGroup, "2", provinceId);
		String regionId2 = groupRelEntity2.getRegionCode();
		log.info("1L:"+regionId+"2L:"+regionId2);
		if(!(regionId.equals(regionId2))){
			throw new BusiException(AcctMgrError.getErrorCode("8203","00001"), "前台工号只允许修改当前地市配置!");
		}
		
		/*更新限额信息*/
		if(limitArea.equals("1")){
			limitFee.updateRegionLimit(regionMonthLimit, regionDayLimit, regionGroup, limitType,msgPhone);
		}else{
			limitFee.updateDistrictLimit(districtGroup, districtMonthLimit, districtDayLimit, regionGroup, limitType,msgPhone);
		}
		
		long loginSn = control.getSequence("SEQ_PAY_SN");
		String curTime = control.getSysDate().get("CUR_TIME").toString();
		String totalDate = curTime.substring(0, 8);
		/* 记录营业员操作日志 */
		LoginOprEntity outTransOpr = new LoginOprEntity();
		outTransOpr.setBrandId("2330xx");
		outTransOpr.setIdNo(0);
		outTransOpr.setLoginGroup(groupId);
		outTransOpr.setLoginNo(inDto.getLoginNo());
		outTransOpr.setLoginSn(loginSn);
		outTransOpr.setOpCode(inDto.getOpCode());
		outTransOpr.setOpTime(curTime);
		outTransOpr.setPayFee(0);
		outTransOpr.setPhoneNo("");
		outTransOpr.setRemark("8203设置转账退费限额");
		outTransOpr.setPayType("");
		outTransOpr.setTotalDate(Integer.parseInt(totalDate));
		record.saveLoginOpr(outTransOpr);
		
		
		S8203CfmOutDTO outDto = new S8203CfmOutDTO();
		outDto.setReturnNothing(returnNothing);
		
		return outDto;
		
	}

	public IPayManage getPayManage() {
		return payManage;
	}

	public void setPayManage(IPayManage payManage) {
		this.payManage = payManage;
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

	/**
	 * @return the limitFee
	 */
	public ILimitFee getLimitFee() {
		return limitFee;
	}

	/**
	 * @param limitFee the limitFee to set
	 */
	public void setLimitFee(ILimitFee limitFee) {
		this.limitFee = limitFee;
	}
	
}
