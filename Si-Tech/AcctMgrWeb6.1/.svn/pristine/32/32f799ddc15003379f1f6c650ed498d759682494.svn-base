package com.sitech.acctmgr.atom.impl.query;

import com.sitech.acctmgr.atom.domains.balance.SignAutoPayEntity;
import com.sitech.acctmgr.atom.domains.pay.UserSignInfoEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.query.S8421InitInDTO;
import com.sitech.acctmgr.atom.dto.query.S8421InitOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.atom.entity.inter.IUserSign;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.inter.query.I8421;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ 
	@ParamType(c = S8421InitInDTO.class,oc=S8421InitOutDTO.class, m = "query")
	})
public class S8421 extends AcctMgrBaseService implements I8421{

	protected IUser user;
	protected IUserSign userSign;
	
	@Override
	public OutDTO query(InDTO inParam) {
		
		S8421InitInDTO inDto = (S8421InitInDTO)inParam;
		String phoneNo = inDto.getPhoneNo();
		
		//查询用户信息
		UserInfoEntity uie = user.getUserInfo(phoneNo);
		long idNo =  uie.getIdNo();
		
		//判断签约用户
		String agreementFlag = "";
		String agreementTime = "";
		String bankType = "";
		String signId = "";
		//1002:联动优势用户，1003支付宝签约用户
		if(!userSign.isSign(idNo, "1002")){
			if(!userSign.isSign(idNo, "1003")){
				agreementFlag="0";
				throw new BusiException(AcctMgrError.getErrorCode("8421","00001"), "非签约用户");
			}else {
				UserSignInfoEntity usie = userSign.getUserSignInfo(idNo);
				agreementTime = usie.getSignTime().substring(0, 8);
				
				//如果是支付宝用户，需查询支付商编号、协议号
				bankType = userSign.getSignAddInfo(idNo, "1003", "10030001");
				signId = userSign.getSignAddInfo(idNo, "1003", "10030002");
			}
		}else {
			UserSignInfoEntity usie = userSign.getUserSignInfo(idNo);
			agreementTime = usie.getSignTime().substring(0, 8);
			bankType = "500xxx";
		}
		agreementFlag="1";
		
		long payMoney = 0;
		long balance = 0;
		String autoFlag = "";
		SignAutoPayEntity sape = userSign.getAutoPay(idNo);
		if(sape==null) {
			throw new BusiException(AcctMgrError.getErrorCode("8421","00002"), "用户未设置自动交费");
		}
		payMoney = sape.getPayMoney();
		balance = sape.getBalanceLimit();
		autoFlag = sape.getAutoFlag();
		
		S8421InitOutDTO outDto = new S8421InitOutDTO();
		outDto.setAgreementFlag(agreementFlag);
		outDto.setAgreementTime(agreementTime);
		outDto.setBalance(balance);		
		outDto.setPayMoney(payMoney);
		outDto.setAutoFlag(autoFlag);
		outDto.setSignId(signId);
		outDto.setBankType(bankType);
		outDto.setPhoneNo(phoneNo);
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
	 * @return the userSign
	 */
	public IUserSign getUserSign() {
		return userSign;
	}

	/**
	 * @param userSign the userSign to set
	 */
	public void setUserSign(IUserSign userSign) {
		this.userSign = userSign;
	}
	
}
