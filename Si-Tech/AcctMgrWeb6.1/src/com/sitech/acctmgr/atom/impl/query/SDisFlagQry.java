package com.sitech.acctmgr.atom.impl.query;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.sitech.acctmgr.atom.domains.query.DisFlagEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.query.SDisFlagQryInDTO;
import com.sitech.acctmgr.atom.dto.query.SDisFlagQryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBalance;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.inter.query.IDisFlagQry;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.util.DateUtil;

@ParamTypes({ 
	@ParamType(c = SDisFlagQryInDTO.class,oc=SDisFlagQryOutDTO.class, m = "query")
	})
public class SDisFlagQry extends AcctMgrBaseService implements IDisFlagQry{

	protected IBalance balance;
	protected IUser user;
	
	@Override
	public OutDTO query(InDTO inParam) {
		// TODO Auto-generated method stub
		List<DisFlagEntity> resultList = new ArrayList<DisFlagEntity>();
		
		SDisFlagQryInDTO inDto = (SDisFlagQryInDTO)inParam;
		String phoneNo = inDto.getPhoneNo();
		String queryMonth = inDto.getQueryMonth();
		
		String curYm = DateUtil.format(new Date(), "yyyyMM");
		int lastYm = DateUtils.addMonth(Integer.parseInt(curYm),-1);
		
		UserInfoEntity uie = user.getUserInfo(phoneNo);	
		long idNo = uie.getIdNo();
		
		int beginYm=Integer.parseInt(queryMonth);
		while(beginYm<=lastYm) {
			DisFlagEntity dfe = new DisFlagEntity();
			String flag="";
			flag=balance.getDisassembleFlag(idNo, beginYm);
			dfe.setFlag(flag);
			dfe.setYearMonth(String.valueOf(beginYm));
			resultList.add(dfe);
			beginYm = DateUtils.addMonth(beginYm, 1);
		}
		
		SDisFlagQryOutDTO outDto = new SDisFlagQryOutDTO();
		outDto.setResultList(resultList);	
		return outDto;
	}

	/**
	 * @return the balance
	 */
	public IBalance getBalance() {
		return balance;
	}

	/**
	 * @param balance the balance to set
	 */
	public void setBalance(IBalance balance) {
		this.balance = balance;
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
	
}
