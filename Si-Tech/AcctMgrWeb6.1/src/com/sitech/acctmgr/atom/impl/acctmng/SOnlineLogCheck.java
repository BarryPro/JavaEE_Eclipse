package com.sitech.acctmgr.atom.impl.acctmng;

import com.sitech.acctmgr.atom.domains.record.ActQueryOprEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.acctmng.SOnlineLogCheckInDTO;
import com.sitech.acctmgr.atom.dto.acctmng.SOnlineLogCheckOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.inter.acctmng.IOnlineLogCheck;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamType(c = SOnlineLogCheckInDTO.class, oc = SOnlineLogCheckOutDTO.class, m = "check")
public class SOnlineLogCheck extends AcctMgrBaseService implements IOnlineLogCheck {

	private IGroup group;
	private IRecord record;
	private IUser user;

	@Override
	public OutDTO check(InDTO inParam) {

		SOnlineLogCheckInDTO inDto = (SOnlineLogCheckInDTO) inParam;
		String phoneNo = inDto.getPhoneNo();
		String beginTime = inDto.getBeginTime();
		String loginNo = inDto.getLoginNo();
		
		UserInfoEntity uie = user.getUserEntityByPhoneNo(phoneNo, true);
		long idNo = uie.getIdNo();
		String openTime = uie.getOpenTime();
		long contractNo = uie.getContractNo();

		//查询开始时间>=入网时间(openime)
		int result = beginTime.compareTo(openTime);
		
		if(result < 0){
			throw new BusiException(AcctMgrError.getErrorCode("8181", "20011"),"不能查询用户入网时间以前的记录!当前用户入网时间为 ： " + openTime);
		}

		// 入操作记录表
		ActQueryOprEntity actQryOprEntity = new ActQueryOprEntity();
		actQryOprEntity.setBrandId("");
		actQryOprEntity.setIdNo(idNo);
		actQryOprEntity.setContactId(String.format("%d", contractNo));
		actQryOprEntity.setLoginGroup(inDto.getGroupId());
		actQryOprEntity.setLoginNo(inDto.getLoginNo());
		actQryOprEntity.setProvinceId(inDto.getProvinceId());
		actQryOprEntity.setOpCode(inDto.getOpCode());
		actQryOprEntity.setPhoneNo(phoneNo);
		actQryOprEntity.setQueryType("swrz");
		actQryOprEntity.setRemark("工号"+ loginNo +"对用户"+ phoneNo +"操作查询了敏感信息!");
		actQryOprEntity.setHeader(inDto.getHeader());

		record.saveQueryOpr(actQryOprEntity, true);

		SOnlineLogCheckOutDTO outDto = new SOnlineLogCheckOutDTO();
		return outDto;
	}

	public IGroup getGroup() {
		return group;
	}

	public void setGroup(IGroup group) {
		this.group = group;
	}

	public IRecord getRecord() {
		return record;
	}

	public void setRecord(IRecord record) {
		this.record = record;
	}


	public IUser getUser() {
		return user;
	}

	public void setUser(IUser user) {
		this.user = user;
	}


}
