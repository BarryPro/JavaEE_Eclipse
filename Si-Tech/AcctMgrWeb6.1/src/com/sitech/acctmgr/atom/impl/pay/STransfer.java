package com.sitech.acctmgr.atom.impl.pay;

import com.sitech.acctmgr.atom.domains.record.LoginOprEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.pay.S8250CfmInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8250CfmOutDTO;
import com.sitech.acctmgr.atom.dto.pay.S8250DeleteRestMoneyInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8250DeleteRestMoneyOutDTO;
import com.sitech.acctmgr.atom.dto.pay.S8250QueryInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8250QueryOutDTO;
import com.sitech.acctmgr.atom.dto.pay.STransferInDTO;
import com.sitech.acctmgr.atom.dto.pay.STransferOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBalance;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.inter.pay.ITransfer;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 *
 * <p>
 * Title:
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2017
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author
 * @version 1.0
 */
@ParamTypes({ 
	@ParamType(m = "cfm", c = STransferInDTO.class, oc = STransferOutDTO.class)
})

public class STransfer implements ITransfer {

	private IBalance balance;
	private IControl control;
	private IRecord record;// 操作记录
	private IUser user;

	@Override
	public OutDTO cfm(InDTO inParam) {
		STransferInDTO inDto = (STransferInDTO) inParam;

		Long idNo = Long.parseLong(inDto.getIdNo());
		String groupId = inDto.getGroupId();
		String loginNo = inDto.getLoginNo();
		String opCode = inDto.getOpCode();

		// 获取日期
		String opTime = control.getSysDate().get("CUR_TIME").toString();
		int totalDate = Integer.parseInt(opTime.substring(0, 8));
		// 获取流水
		long loginAccept = control.getSequence("SEQ_SYSTEM_SN");
		// 通过idNo获取用户信息
		UserInfoEntity ue = user.getUserEntityByIdNo(idNo, true);

		Long contractNo = ue.getContractNo();
		// 判断该用户是否存在PAY_TYPE为"JQ"的帐本
		Boolean reuslt =  balance.isPayTypeExist(contractNo);

		if(reuslt){
			// 更新账本表中PAY_TYPE为"JQ"的记录
			int count = balance.updateAcctBookEndTime(contractNo);
			if (count == 0) {
				throw new BusiException(AcctMgrError.getErrorCode(inDto.getOpCode(), "00001"), "更新余额表出错! " + contractNo);
			}
		}

		// 记录营业员操作记录表
		LoginOprEntity loginOprEnt = new LoginOprEntity();
		loginOprEnt.setLoginGroup(groupId);
		loginOprEnt.setLoginNo(loginNo);
		loginOprEnt.setLoginSn(loginAccept);
		loginOprEnt.setOpCode(opCode);
		loginOprEnt.setOpTime(opTime);
		loginOprEnt.setRemark("过户");
		loginOprEnt.setPayType("0");
		loginOprEnt.setTotalDate(totalDate);
		loginOprEnt.setIdNo(idNo);
		loginOprEnt.setPhoneNo(ue.getPhoneNo());
		loginOprEnt.setBrandId(ue.getBrandId());
		record.saveLoginOpr(loginOprEnt);

		STransferOutDTO outDto = new STransferOutDTO();
		return outDto;
	}


	/**
	 * @return the balance
	 */
	public IBalance getBalance() {
		return balance;
	}

	/**
	 * @return the user
	 */
	public IUser getUser() {
		return user;
	}

	/**
	 * @param balance
	 *            the balance to set
	 */
	public void setBalance(IBalance balance) {
		this.balance = balance;
	}

	/**
	 * @param user
	 *            the user to set
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
	 * @param control
	 *            the control to set
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
	 * @param record
	 *            the record to set
	 */
	public void setRecord(IRecord record) {
		this.record = record;
	}

}
