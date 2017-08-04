package com.sitech.acctmgr.atom.impl.billAccount;

import java.util.HashMap;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.acctmng.SChargeFeeCfmInDTO;
import com.sitech.acctmgr.atom.dto.acctmng.SChargeFeeCfmOutDTO;
import com.sitech.acctmgr.atom.dto.acctmng.SChargeFeeQryInDTO;
import com.sitech.acctmgr.atom.dto.acctmng.SChargeFeeQryOutDTO;
import com.sitech.acctmgr.atom.dto.acctmng.STellCodeInDTO;
import com.sitech.acctmgr.atom.dto.acctmng.STellCodeOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBillAccount;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.inter.billAccount.IChargeFee;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ 
	@ParamType(m = "query", c = SChargeFeeQryInDTO.class, oc = SChargeFeeQryOutDTO.class),
	@ParamType(m = "cfm", c = SChargeFeeCfmInDTO.class, oc = SChargeFeeCfmOutDTO.class),
	@ParamType(m = "uTellCodeA", c = STellCodeInDTO.class, oc = STellCodeOutDTO.class),
	@ParamType(m = "uTellCodeB", c = STellCodeInDTO.class, oc = STellCodeOutDTO.class)
})
public class SChargeFee extends AcctMgrBaseService implements IChargeFee{

	private IBillAccount billAccount;
	private IUser user;
	private IControl control;
	
	@Override
	public OutDTO query(InDTO inParam) {
		// TODO Auto-generated method stub
		SChargeFeeQryInDTO inDto = (SChargeFeeQryInDTO)inParam;
		String phoneNo = inDto.getPhoneNo();
		
		int cnt=0;
		String offOnType = "";
		cnt = billAccount.getCntTellShort(phoneNo);
		if(cnt==1){
			offOnType = billAccount.getTypeTellShort(phoneNo);
		}else {
			offOnType = "1";
		}
		
		SChargeFeeQryOutDTO outDto = new SChargeFeeQryOutDTO();
		outDto.setOffType(offOnType);
		return outDto;
	}

	@Override
	public OutDTO cfm(InDTO inParam) {
		// TODO Auto-generated method stub
		SChargeFeeCfmInDTO inDto = (SChargeFeeCfmInDTO)inParam;
		Map<String, Object> outMap = new HashMap<String, Object>();
		String phoneNo = inDto.getPhoneNo();
		String opType = inDto.getOpType();		
		
		String kqOpType = "";
		if(opType.equals("KTKFTX")){
			kqOpType="1";
		}
		if(opType.equals("QXKFTX")){
			kqOpType="0";
		}		
		
		long loginAccept=control.getSequence("SEQ_SYSTEM_SN");
		
		UserInfoEntity uie = user.getUserInfo(phoneNo);
		long idNo = uie.getIdNo();
		
		outMap =billAccount.saveTellShortMsgOffOn(kqOpType,phoneNo,idNo,inDto.getLoginNo(),loginAccept);
		String returnCode = outMap.get("RETURN_CODE").toString();
		String returnMsg = outMap.get("RETURN_MSG").toString();
		
		SChargeFeeCfmOutDTO outDto = new SChargeFeeCfmOutDTO();
		outDto.setLoginAccept(loginAccept);
		outDto.setReturnCode(returnCode);
		outDto.setReturnMsg(returnMsg);
		return outDto;
	}
	
	@Override
	public OutDTO uTellCodeA(InDTO inParam) {
		// TODO Auto-generated method stub
		Map<String,Object> outMap = new HashMap<String,Object>();
		STellCodeInDTO inDto = (STellCodeInDTO)inParam;
		String phoneNo=inDto.getPhoneNo();
		String loginAccept = inDto.getLoginAccept();
		
		int cnt = billAccount.getCntTellCodeInc(phoneNo, loginAccept);
		if(cnt==0){
			throw new BusiException(AcctMgrError.getErrorCode("0000","90010"), "用户回复超时!" );
		}else {
			outMap = billAccount.getTellCodeA(loginAccept, phoneNo);
		}
		
		if(outMap.get("SP_CODE").equals("gggggg")) {
			//TODO 调用CRM服务sJTUnifyCfm
		}else {
			//TODO 调用CRM退订服务
		}
		
		STellCodeOutDTO outDto = new STellCodeOutDTO();
		outDto.setServName(outMap.get("SERV_NAME").toString());
		outDto.setSpName(outMap.get("SP_NAME").toString());
		return outDto;
	}

	@Override
	public OutDTO uTellCodeB(InDTO inParam) {
		// TODO Auto-generated method stub
		Map<String,Object> outMap = new HashMap<String,Object>();
		STellCodeInDTO inDto = (STellCodeInDTO)inParam;
		String phoneNo=inDto.getPhoneNo();
		String loginAccept = inDto.getLoginAccept();
		outMap = billAccount.getTellCodeB(loginAccept, phoneNo);
		
		STellCodeOutDTO outDto = new STellCodeOutDTO();
		outDto.setServName(outMap.get("SERV_NAME").toString());
		outDto.setSpName(outMap.get("SP_NAME").toString());
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
	
}
