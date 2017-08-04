package com.sitech.acctmgr.atom.entity;

import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.account.ContractEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.entity.inter.IAccount;
import com.sitech.acctmgr.atom.entity.inter.IAgent;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.BaseBusi;
import com.sitech.acctmgr.common.constant.PayBusiConst;
import com.sitech.jcf.core.exception.BusiException;

/**
 *
 * <p>
 * Title: 代理商实现类
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2014
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author qiaolin
 * @version 1.0
 */
public class Agent extends BaseBusi implements IAgent{
	
	private IAccount	account;
	private IUser		user;
	

	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.atom.entity.inter.IAgent#getAgentPhone(java.lang.String)
	 */
	@Override
	public String getAgentPhone(String loginNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean isKcAgentPhone(Long idNo) {
		// TODO Auto-generated method stub
		return false;
	}
	
	@Override
	public boolean isKcAgentPhone(String PhoneNo) {
		// TODO Auto-generated method stub
		return true;
	}
	
	public boolean isKcAgentPhone(String phoneNo, String contractNo){
		
		return false;
	}
	

	public Map<String, Object> getAgentInfo(long IdNo) {
		// TODO Auto-generated method stub
		return null;
	}
	
	public Map<String, Object> getAgentInfo(String phoneNo) {
		// TODO Auto-generated method stub
		return null;
	}

	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.atom.entity.inter.IAgent#isLdysAgentPhone(java.lang.String)
	 */
	@Override
	public boolean isLdysAgentPhone(String phoneNo) {
		// TODO Auto-generated method stub
		return false;
	}

	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.atom.entity.inter.IAgent#getSumKcPayfee(java.lang.String)
	 */
	@Override
	public long getSumKcPayfee(String agentPhone) {
		// TODO Auto-generated method stub
		return 0;
	}

	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.atom.entity.inter.IAgent#getAgentCon(java.lang.String)
	 */
	@Override
	public long getAgentCon(String phoneNo) {
		
		long agentCon = 0;
		UserInfoEntity userEntity = user.getUserEntity(null, phoneNo, null, true);
		
		List<ContractEntity> outList = account.getConList(userEntity.getIdNo());
		int cnt = 0;
		for(ContractEntity con : outList){
			if(con.getAttType().equals(PayBusiConst.AIR_RECHARGE_CONTYPE)){
				agentCon = con.getCon();
				cnt++;
			}
		}
		if(cnt > 1){
			
			log.debug("存在多个空中充值账户，请核查！" + phoneNo);
			throw new BusiException(AcctMgrError.getErrorCode("0000", "00003"), "存在多个空中充值账户，请核查 " + phoneNo);
		}
		
		return agentCon;
	}
	
	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.atom.entity.inter.IAgent#getDistrictAgentList(java.lang.String, int, java.lang.String, java.lang.String)
	 */
	@Override
	public Map<String, Object> getDistrictAgentList(String districtGroupId, int pageNum, String provinceId, String flag) {
		// TODO Auto-generated method stub
		return null;
	}

	
	public IAccount getAccount() {
		return account;
	}

	public void setAccount(IAccount account) {
		this.account = account;
	}

	public IUser getUser() {
		return user;
	}

	public void setUser(IUser user) {
		this.user = user;
	}



}
