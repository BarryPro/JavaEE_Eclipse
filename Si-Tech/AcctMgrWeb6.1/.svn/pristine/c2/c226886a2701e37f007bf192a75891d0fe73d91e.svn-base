package com.sitech.acctmgr.atom.impl.billAccount;

import java.util.ArrayList;
import java.util.List;

import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.query.TellCodeEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.acctmng.S8556InDTO;
import com.sitech.acctmgr.atom.dto.acctmng.S8556OutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBillAccount;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.inter.billAccount.I8556;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ @ParamType(m = "query", c = S8556InDTO.class, oc = S8556OutDTO.class)})
public class S8556 extends AcctMgrBaseService implements I8556{

	private IBillAccount billAccount;
	private IUser user;
	private IGroup group;
	
	@Override
	public OutDTO query(InDTO inParam) {
		List<TellCodeEntity> resultList = new ArrayList<TellCodeEntity>();
		S8556InDTO inDto = (S8556InDTO)inParam;
		String beginTime = inDto.getBeginTime();
		String endTime = inDto.getEndTime();
		
		List<TellCodeEntity> tempList = billAccount.getTellCodeDelList(beginTime, endTime);
		for(TellCodeEntity tce:tempList) {
			String phoneNo = tce.getPhoneNo().trim();
			String operCode = tce.getOperCode().trim();
			UserInfoEntity uie = user.getUserInfo(phoneNo);
			String groupId = uie.getGroupId();
			ChngroupRelEntity cgre = group.getRegionDistinct(groupId, "2", inDto.getProvinceId());
			String regionName = cgre.getRegionName();
			tce.setRegionName(regionName);
			tce.setPhoneNo(phoneNo);
			tce.setOperCode(operCode);
			resultList.add(tce);
		}
		
		S8556OutDTO outDto = new S8556OutDTO();
		outDto.setResultList(resultList);
		return outDto;
	}

	/**
	 * @return the billAccount
	 */
	public IBillAccount getBillAccount() {
		return billAccount;
	}

	/**
	 * @param billAccount the billAccount to set
	 */
	public void setBillAccount(IBillAccount billAccount) {
		this.billAccount = billAccount;
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
