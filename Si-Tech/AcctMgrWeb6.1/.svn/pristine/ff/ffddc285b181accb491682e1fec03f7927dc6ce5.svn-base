package com.sitech.acctmgr.atom.impl.query;

import java.util.List;

import com.sitech.acctmgr.atom.domains.base.GroupEntity;
import com.sitech.acctmgr.atom.domains.bill.AdjOweEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.query.S8124InitInDTO;
import com.sitech.acctmgr.atom.dto.query.S8124InitOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBill;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.inter.query.I8124;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
*
* <p>Title: query adjoweinfo查询实现类</p>
* <p>Copyright: Copyright (c) 2016</p>
* <p>Company: SI-TECH </p>
* @version 1.0
*/
@ParamTypes({ 
	@ParamType(c = S8124InitInDTO.class,oc=S8124InitOutDTO.class, m = "query")
	})
public class S8124 extends AcctMgrBaseService implements I8124{

	private IUser user;
	private IBill bill;
	private IRecord record;
	private IGroup group;
	@Override
	public OutDTO query(InDTO inParam) {
		// TODO Auto-generated method stub
		S8124InitInDTO inDto = (S8124InitInDTO)inParam;
		String phoneNo = inDto.getPhoneNo();
		String beginTime = inDto.getBeginTime();
		String endTime = inDto.getEndTime();
		String refundFlag = inDto.getRefundFlag();
		String loginGroupId = inDto.getGroupId();
		
		UserInfoEntity uie = user.getUserInfo(phoneNo);
		long idNo = uie.getIdNo();
		String userGroupId = uie.getGroupId();

		
		GroupEntity ge = group.getGroupInfo(loginGroupId, userGroupId, inDto.getProvinceId());
		if(ge.getRegionFlag().equals("N")){
	           throw new BusiException(AcctMgrError.getErrorCode("8124", "00001"),"不能跨地市操作" );
		}
		
		List<AdjOweEntity> aoeList = bill.getAdjOweInfo(idNo, beginTime, endTime,refundFlag);
		
		S8124InitOutDTO outDto = new S8124InitOutDTO();
		outDto.setAdjOweInfo(aoeList);
		return outDto;
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
	 * @return the bill
	 */
	public IBill getBill() {
		return bill;
	}
	/**
	 * @param bill the bill to set
	 */
	public void setBill(IBill bill) {
		this.bill = bill;
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

	/*
	@Override
	public OutDTO refundQuery(InDTO inParam) {
		// TODO Auto-generated method stub
		
		S8124InitInDTO inDto = (S8124InitInDTO)inParam;
		String phoneNo = inDto.getPhoneNo();
		int beginTime = Integer.valueOf(inDto.getBeginTime());
		int endTime = Integer.valueOf(inDto.getEndTime());
		
		UserInfoEntity uie = user.getUserInfo(phoneNo);
		long idNo = uie.getIdNo();
		
		S8124RefundInitOutDTO outDto = new S8124RefundInitOutDTO();
		for(int yearMonth=beginTime;yearMonth<=endTime;DateUtils.addMonth(yearMonth, 1)) {
			List<RefundLoginEntity> loeList = record.getLoginOprList(idNo, yearMonth);
			outDto.setRefundInfo(loeList);
		}
		return outDto;
	}
*/
}
