package com.sitech.acctmgr.atom.impl.query;

import com.sitech.acctmgr.atom.domains.user.UserDetailEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.query.SUserRunTimeQryInDTO;
import com.sitech.acctmgr.atom.dto.query.SUserRunTimeQryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBalance;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.inter.query.IUserRunTimeQry;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ @ParamType(m = "query", c = SUserRunTimeQryInDTO.class, oc = SUserRunTimeQryOutDTO.class)})
public class SUserRunTimeQry extends AcctMgrBaseService implements IUserRunTimeQry{

	protected IUser user;
	protected IBalance balance;
	
	@Override
	public OutDTO query(InDTO inParam) {
		// TODO Auto-generated method stub
		SUserRunTimeQryInDTO inDto = (SUserRunTimeQryInDTO)inParam;
		String phoneNo = inDto.getPhoneNo();
		
		UserInfoEntity uie = user.getUserInfo(phoneNo);
		long contractNo=uie.getContractNo();
		
		UserDetailEntity ude = user.getUserdetailEntity(uie.getIdNo());
		 
		String runTime = ude.getRunTime().substring(0, 8);
		String runCode = ude.getRunCode();
		if(!runCode.equals("J")&&!runCode.equals("B")){
			throw new BusiException(AcctMgrError.getErrorCode("0000", "00001"), "该用户不是冒高用户！" );
		}
		
		long prepayFee = balance.getAcctBookSum(contractNo, "");
		if(prepayFee>0) {
			throw new BusiException(AcctMgrError.getErrorCode("0000", "00002"), "该号码有专款无局拆时间！" );
		}
		
		int runDay = Integer.parseInt(runTime.substring(7, 8));
		int runYm = Integer.parseInt(runTime.substring(0, 6));
		
		String outDate = "";
		String stopTime = "";
		if(runCode.equals("J")){
			switch(runDay/5+1){
				case 1:
					outDate=String.valueOf(DateUtils.addMonth(runYm,1)*100+5);	
					break;
				case 2:
					outDate=String.valueOf(DateUtils.addMonth(runYm,1)*100+10);
					break;
				case 3:
					outDate=String.valueOf(DateUtils.addMonth(runYm,1)*100+15);
					break;
				case 4:
					outDate=String.valueOf(DateUtils.addMonth(runYm,1)*100+20);
					break;
				case 5:
					outDate=String.valueOf(DateUtils.addMonth(runYm,1)*100+25);
					break;
				default:
					outDate=String.valueOf(DateUtils.addMonth(runYm,2)*100+5);
					break;
			}
			stopTime=runTime;
		}else if(runCode.equals("B")){
			switch(runDay/5+1) {
				case 1:
					stopTime=String.valueOf(DateUtils.addMonth(runYm,1)*100+4);	
					break;
				case 2:
					stopTime=String.valueOf(DateUtils.addMonth(runYm,1)*100+9);
					break;
				case 3:
					stopTime=String.valueOf(DateUtils.addMonth(runYm,1)*100+14);
					break;
				case 4:
					stopTime=String.valueOf(DateUtils.addMonth(runYm,1)*100+19);
					break;
				case 5:
					stopTime=String.valueOf(DateUtils.addMonth(runYm,1)*100+24);
					break;
				default:
					stopTime=String.valueOf(DateUtils.addMonth(runYm,2)*100+4);
					break;
			}
			
			int tempYm = Integer.parseInt(stopTime.substring(0, 6));
			switch((Integer.parseInt(stopTime)%100)/5+1) {
				case 1:
					outDate=String.valueOf(DateUtils.addMonth(tempYm,1)*100+5);	
					break;
				case 2:
					outDate=String.valueOf(DateUtils.addMonth(tempYm,1)*100+10);
					break;
				case 3:
					outDate=String.valueOf(DateUtils.addMonth(tempYm,1)*100+15);
					break;
				case 4:
					outDate=String.valueOf(DateUtils.addMonth(tempYm,1)*100+20);
					break;
				case 5:
					outDate=String.valueOf(DateUtils.addMonth(tempYm,1)*100+25);
					break;
				default:
					outDate=String.valueOf(DateUtils.addMonth(tempYm,2)*100+5);
					break;
			}
			
		}
		
		SUserRunTimeQryOutDTO outDto = new SUserRunTimeQryOutDTO();
		outDto.setStopTime(stopTime);
		outDto.setOutDate(outDate);
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
	
}
