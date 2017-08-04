package com.sitech.acctmgr.atom.impl.billAccount;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.record.LoginOprEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.acctmng.S50MRoofedInDTO;
import com.sitech.acctmgr.atom.dto.acctmng.S50MRoofedOutDTO;
import com.sitech.acctmgr.atom.dto.acctmng.SGprsRemindInDTO;
import com.sitech.acctmgr.atom.dto.acctmng.SGprsRemindOutDTO;
import com.sitech.acctmgr.atom.dto.acctmng.SGprsTimeRemindInDTO;
import com.sitech.acctmgr.atom.dto.acctmng.SIntegratedRemindInDTO;
import com.sitech.acctmgr.atom.entity.inter.IBillAccount;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.acctmgr.inter.billAccount.IGprsRemind;
import com.sitech.acctmgrint.atom.busi.intface.IShortMessage;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.util.DateUtil;

@ParamTypes({ 
	@ParamType(m = "gprsRemind", c = SGprsRemindInDTO.class, oc = SGprsRemindOutDTO.class),
	@ParamType(m = "gprsRemindNew", c = SGprsRemindInDTO.class, oc = SGprsRemindOutDTO.class),
	@ParamType(m = "gprsInterRemind", c = SGprsRemindInDTO.class, oc = SGprsRemindOutDTO.class),
	@ParamType(m = "integratedRemind", c = SIntegratedRemindInDTO.class, oc = SGprsRemindOutDTO.class),
	@ParamType(m = "gprsTimeRemind", c = SGprsTimeRemindInDTO.class, oc = SGprsRemindOutDTO.class),
	@ParamType(m = "familyOffOn", c = SGprsRemindInDTO.class, oc = SGprsRemindOutDTO.class)
})
public class SGprsRemind extends AcctMgrBaseService implements IGprsRemind{

	protected IUser user;
	protected IControl control;
	protected IBillAccount billAccount;
	protected IRecord record;
	private IShortMessage shortMessage;
	
	@Override
	public OutDTO gprsRemind(InDTO inParam) {
		
		Map<String, Object> inMap = new HashMap<String, Object>();
		
		SGprsRemindInDTO inDto = (SGprsRemindInDTO)inParam;
		String loginNo = inDto.getLoginNo();
		String opCode = inDto.getOpCode();
		String phoneNo = inDto.getPhoneNo();
		String offOnType = inDto.getOpType();
		
		if(!opCode.equals("6335")){
			throw new BusiException(AcctMgrError.getErrorCode("0000", "90022"), "输入的操作代码不正确!");
		}
		
		if(!offOnType.equals("A")&&!offOnType.equals("D")) {
			throw new BusiException(AcctMgrError.getErrorCode("0000", "90023"), "输入的开通关闭标志不正确，既不是A，也不是D!");
		}
		
		UserInfoEntity uie = user.getUserInfo(phoneNo);
		long idNo = uie.getIdNo();
		if(!uie.getRunCode().equals("A")){
			throw new BusiException(AcctMgrError.getErrorCode("0000", "90024"), "用户运行状态不正常!");
		}
		
		//取当前时间
		String sCurDate = DateUtil.format(new Date(), "yyyyMMdd");
		
		//取系统流水
		long loginAccept=control.getSequence("SEQ_SYSTEM_SN");
		
		if(offOnType.equals("A")) {
			inMap.put("PHONE_NO", phoneNo);
			inMap.put("OP_CODE", opCode);
			inMap.put("LOGIN_NO", inDto.getLoginNo());
			inMap.put("LOGIN_ACCEPT", loginAccept);
			inMap.put("OFFON_TYPE", offOnType);
			billAccount.delGprsShortMsgOffOn(inMap);		
		}else if(offOnType.equals("D")){
			inMap.put("PHONE_NO", phoneNo);
			inMap.put("ID_NO", idNo);
			inMap.put("OP_CODE", opCode);
			inMap.put("LOGIN_NO", inDto.getLoginNo());
			inMap.put("LOGIN_ACCEPT", loginAccept);
			inMap.put("OFFON_TYPE", offOnType);
			billAccount.saveGprsShortMsgOffOn(inMap);
		}
		
		LoginOprEntity loe = new LoginOprEntity();
		loe.setLoginSn(loginAccept);
		loe.setLoginNo(loginNo);
		loe.setLoginGroup(inDto.getGroupId());
		loe.setTotalDate(Long.parseLong(sCurDate));
		loe.setIdNo(idNo);
		loe.setPhoneNo(phoneNo);
		loe.setBrandId("00");
		loe.setPayType("0");
		loe.setPayFee(0);
		loe.setOpCode(opCode);
		record.saveLoginOpr(loe);
		
		SGprsRemindOutDTO outDto = new SGprsRemindOutDTO();
		return outDto;
	}

	@Override
	public OutDTO gprsRemindNew(InDTO inParam) {
		Map<String, Object> inMap = new HashMap<String, Object>();
		
		SGprsRemindInDTO inDto = (SGprsRemindInDTO)inParam;
		String loginNo = inDto.getLoginNo();
		String opCode = inDto.getOpCode();
		String phoneNo = inDto.getPhoneNo();
		String offOnType = inDto.getOpType();
		
		if(!loginNo.equals("newsms")){
			throw new BusiException(AcctMgrError.getErrorCode("0000", "90025"), "输入的操作工号不正确。本业务只能通过短信营业厅办理.");
		}
		
		if(!opCode.equals("6336")){
			throw new BusiException(AcctMgrError.getErrorCode("0000", "90022"), "输入的操作代码不正确!");
		}
		
		if(!offOnType.equals("A")&&!offOnType.equals("D")) {
			throw new BusiException(AcctMgrError.getErrorCode("0000", "90023"), "输入的开通关闭标志不正确，既不是A，也不是D!");
		}
		
		UserInfoEntity uie = user.getUserInfo(phoneNo);
		long idNo = uie.getIdNo();
		if(!uie.getRunCode().equals("A")){
			throw new BusiException(AcctMgrError.getErrorCode("0000", "90024"), "用户运行状态不正常!");
		}
		
		//取当前时间
		String sCurDate = DateUtil.format(new Date(), "yyyyMMdd");
		
		//取系统流水
		long loginAccept=control.getSequence("SEQ_SYSTEM_SN");
		
		if(offOnType.equals("D")) {
			inMap.put("PHONE_NO", phoneNo);
			inMap.put("OP_CODE", opCode);
			inMap.put("LOGIN_NO", inDto.getLoginNo());
			inMap.put("LOGIN_ACCEPT", loginAccept);
			inMap.put("OFFON_TYPE", offOnType);
			billAccount.delGprsShortMsgOffOnNew(inMap);		
		}else if(offOnType.equals("A")){
			inMap.put("PHONE_NO", phoneNo);
			inMap.put("ID_NO", idNo);
			inMap.put("OP_CODE", opCode);
			inMap.put("LOGIN_NO", inDto.getLoginNo());
			inMap.put("LOGIN_ACCEPT", loginAccept);
			inMap.put("OFFON_TYPE", offOnType);
			billAccount.saveGprsShortMsgOffOnNew(inMap);
		}
		
		LoginOprEntity loe = new LoginOprEntity();
		loe.setLoginSn(loginAccept);
		loe.setLoginNo(loginNo);
		loe.setLoginGroup(inDto.getGroupId());
		loe.setTotalDate(Long.parseLong(sCurDate));
		loe.setIdNo(idNo);
		loe.setPhoneNo(phoneNo);
		loe.setBrandId("00");
		loe.setPayType("0");
		loe.setPayFee(0);
		loe.setOpCode(opCode);
		record.saveLoginOpr(loe);
		
		SGprsRemindOutDTO outDto = new SGprsRemindOutDTO();
		return outDto;
	}

	@Override
	public OutDTO gprsInterRemind(InDTO inParam) {
		Map<String, Object> inMap = new HashMap<String, Object>();
		
		SGprsRemindInDTO inDto = (SGprsRemindInDTO)inParam;
		String loginNo = inDto.getLoginNo();
		String opCode = inDto.getOpCode();
		String phoneNo = inDto.getPhoneNo();
		String offOnType = inDto.getOpType();
		
		if(!loginNo.equals("newsms")){
			throw new BusiException(AcctMgrError.getErrorCode("0000", "90025"), "输入的操作工号不正确。本业务只能通过短信营业厅办理.");
		}
		
		if(!opCode.equals("6337")){
			throw new BusiException(AcctMgrError.getErrorCode("0000", "90022"), "输入的操作代码不正确!");
		}
		
		if(!offOnType.equals("A")&&!offOnType.equals("D")) {
			throw new BusiException(AcctMgrError.getErrorCode("0000", "90023"), "输入的开通关闭标志不正确，既不是A，也不是D!");
		}
		
		UserInfoEntity uie = user.getUserInfo(phoneNo);
		long idNo = uie.getIdNo();
		if(!uie.getRunCode().equals("A")){
			throw new BusiException(AcctMgrError.getErrorCode("0000", "90024"), "用户运行状态不正常");
		}
		
		//取当前时间
		String sCurDate = DateUtil.format(new Date(), "yyyyMMdd");
		
		//取系统流水
		long loginAccept=control.getSequence("SEQ_SYSTEM_SN");
		
		String oper = "";
		if(offOnType.equals("D")) {
			inMap.put("PHONE_NO", phoneNo);
			inMap.put("OP_CODE", opCode);
			inMap.put("ID_NO", idNo);
			inMap.put("LOGIN_NO", inDto.getLoginNo());
			inMap.put("LOGIN_ACCEPT", loginAccept);
			inMap.put("OFFON_TYPE", offOnType);
			billAccount.saveGprsInterMsgOffOn(inMap);
			oper = "取消";
		}else if(offOnType.equals("A")){
			inMap.put("PHONE_NO", phoneNo);			
			inMap.put("OP_CODE", opCode);
			inMap.put("LOGIN_NO", inDto.getLoginNo());
			inMap.put("LOGIN_ACCEPT", loginAccept);
			inMap.put("OFFON_TYPE", offOnType);
			billAccount.delGprsInterMsgOffOn(inMap);
			oper = "开通";
		}
		
		LoginOprEntity loe = new LoginOprEntity();
		loe.setLoginSn(loginAccept);
		loe.setLoginNo(loginNo);
		loe.setLoginGroup(inDto.getGroupId());
		loe.setTotalDate(Long.parseLong(sCurDate));
		loe.setIdNo(idNo);
		loe.setPhoneNo(phoneNo);
		loe.setBrandId("00");
		loe.setPayType("0");
		loe.setPayFee(0);
		loe.setOpCode(opCode);
		record.saveLoginOpr(loe);
		
		//TODO 发短信
		/* 尊敬的客户：您好！您已${oper}流量提醒。中国移动 */
		Map<String, Object> mapTmp  = new HashMap<String, Object>();
		mapTmp.put("oper", oper);

		MBean inMessage = new MBean();
		inMessage.addBody("TEMPLATE_ID", "311100110101");
		inMessage.addBody("PHONE_NO", phoneNo);
		inMessage.addBody("LOGIN_NO", loginNo);
		inMessage.addBody("CHECK_FLAG", true);
		inMessage.addBody("SEND_FLAG", 0);
		inMessage.addBody("DATA", mapTmp);

		log.info("发送短信内容：" + inMessage.toString());
		shortMessage.sendSmsMsg(inMessage,1);
		
		SGprsRemindOutDTO outDto = new SGprsRemindOutDTO();
		return outDto;
	}

	@Override
	public OutDTO integratedRemind(InDTO inParam) {
		Map<String, Object> inMap = new HashMap<String, Object>();
		
		SIntegratedRemindInDTO inDto = (SIntegratedRemindInDTO)inParam;
		String phoneNo = inDto.getPhoneNo();
		String opType = inDto.getOpType();
		String opFlag = inDto.getOpFlag();
		String loginNo = inDto.getLoginNo();
		String opCode = inDto.getOpCode();
		
		if(!loginNo.equals("newsms")){
			throw new BusiException(AcctMgrError.getErrorCode("0000", "90025"), "输入的操作工号不正确。本业务只能通过短信营业厅办理.");
		}
		
		if(!opCode.equals("6338")){
			throw new BusiException(AcctMgrError.getErrorCode("0000", "90022"), "输入的操作代码不正确!");
		}
		
		if(!opType.equals("A")&&!opType.equals("D")&&!opType.equals("E")) {
			throw new BusiException(AcctMgrError.getErrorCode("0000", "90026"), "输入的开通关闭标志不正确，既不是A,也不是D,也不是E!");
		}
		
		UserInfoEntity uie = user.getUserInfo(phoneNo);
		long idNo = uie.getIdNo();
		String brandId = uie.getBrandId();
		
		//取当前时间
		String sCurDate = DateUtil.format(new Date(), "yyyyMMdd");
		
		//取系统流水
		long loginAccept=control.getSequence("SEQ_SYSTEM_SN");
		
		//取用户当前开通关闭状态
		String offOnType = billAccount.getOffOnType(phoneNo, opFlag);
		
		if(opType.equals(offOnType)) {
			if(offOnType.equals("A")) {
				throw new BusiException(AcctMgrError.getErrorCode("0000", "90027"), "该用户已经开通该提醒功能，不能重复开通!");
			}
			if(offOnType.equals("D")) {
				throw new BusiException(AcctMgrError.getErrorCode("0000", "90028"), "该用户已经关闭该提醒功能，不能重复关闭!");
			}
			if(offOnType.equals("E")) {
				throw new BusiException(AcctMgrError.getErrorCode("0000", "90029"), "该用户已经永久关闭该提醒功能，不能重复关闭!");
			}
		}else {
			if(opType.equals("A")) {
				inMap.put("LOGIN_ACCEPT", loginAccept);
				inMap.put("LOGIN_NO", loginNo);
				inMap.put("OP_CODE", opCode);
				inMap.put("PHONE_NO", phoneNo);
				inMap.put("OP_FLAG", opFlag);
				billAccount.delShortMsgOffOn(inMap);
			}else if(offOnType.equals("A")) {
				inMap.put("LOGIN_ACCEPT", loginAccept);
				inMap.put("LOGIN_NO", loginNo);
				inMap.put("OP_CODE", opCode);
				inMap.put("PHONE_NO", phoneNo);
				inMap.put("OP_FLAG", opFlag);
				inMap.put("ID_NO", idNo);
				inMap.put("OFFON_TYPE", opType);
				billAccount.saveShortMsgOffOn(inMap);
			}else if(offOnType.equals("D")&&opType.equals("E")){
				inMap.put("LOGIN_ACCEPT", loginAccept);
				inMap.put("LOGIN_NO", loginNo);
				inMap.put("OP_CODE", opCode);
				inMap.put("PHONE_NO", phoneNo);
				inMap.put("OP_FLAG", opFlag);
				inMap.put("OFFON_TYPE", opType);
				billAccount.updateShortMsgOffOn(inMap);
			}else if(offOnType.equals("E")&&opType.equals("D")){
				throw new BusiException(AcctMgrError.getErrorCode("0000", "90030"), "该用户已经永久关闭该提醒功能，需要先开通才能办理当月关闭!");
			}
		}
		
		LoginOprEntity loe = new LoginOprEntity();
		loe.setLoginSn(loginAccept);
		loe.setLoginNo(loginNo);
		loe.setLoginGroup(inDto.getGroupId());
		loe.setTotalDate(Long.parseLong(sCurDate));
		loe.setIdNo(idNo);
		loe.setPhoneNo(phoneNo);
		loe.setBrandId(brandId);
		loe.setPayType("0");
		loe.setPayFee(0);
		loe.setOpCode(opCode);
		record.saveLoginOpr(loe);
		
		SGprsRemindOutDTO outDto = new SGprsRemindOutDTO();
		return outDto;
	}

	@Override
	public OutDTO gprsTimeRemind(InDTO inParam) {
		
		Map<String, Object> inMap = new HashMap<String, Object>();
		
		SGprsTimeRemindInDTO inDto = (SGprsTimeRemindInDTO)inParam;
		String phoneNo = inDto.getPhoneNo();
		String opType = inDto.getOpType();
		String opFlag = inDto.getOpFlag();
		String callCycle = inDto.getCallCycle();
		String loginNo = inDto.getLoginNo();
		String opCode = inDto.getOpCode();
		
		if(!loginNo.equals("newsms")){
			throw new BusiException(AcctMgrError.getErrorCode("0000", "90025"), "输入的操作工号不正确。本业务只能通过短信营业厅办理.");
		}
		
		if(!opCode.equals("6339")){
			throw new BusiException(AcctMgrError.getErrorCode("0000", "90022"), "输入的操作代码不正确!");
		}
		
		if(!opType.equals("A")&&!opType.equals("D")) {
			throw new BusiException(AcctMgrError.getErrorCode("0000", "90023"), "输入的开通关闭标志不正确，既不是A，也不是D!");
		}
		
		UserInfoEntity uie = user.getUserInfo(phoneNo);
		long idNo = uie.getIdNo();
		String brandId = uie.getBrandId();
		if(!uie.getRunCode().equals("A")){
			throw new BusiException(AcctMgrError.getErrorCode("0000", "90024"), "用户运行状态不正常");
		}
		
		//取当前时间
		String sCurDate = DateUtil.format(new Date(), "yyyyMMdd");
		
		//取系统流水
		long loginAccept=control.getSequence("SEQ_SYSTEM_SN");
		
		String offOnType = billAccount.getTimeOffOnType(phoneNo, opFlag);
		if(opType.equals(offOnType)){
			if(offOnType.equals("A")){
				throw new BusiException(AcctMgrError.getErrorCode("0000", "90031"), "该用户已经开通定时流量提醒功能，不能重复开通!");
			}else {
				throw new BusiException(AcctMgrError.getErrorCode("0000", "90032"), "该用户已经关闭定时流量提醒功能，不能重复关闭!");
			}
		}else {
			if(opType.equals("D")){
				inMap.put("LOGIN_ACCEPT", loginAccept);
				inMap.put("LOGIN_NO", loginNo);
				inMap.put("OP_CODE", opCode);
				inMap.put("PHONE_NO", phoneNo);
				inMap.put("OP_FLAG", opFlag);
				billAccount.delShortMsgTimeOffOn(inMap);
			}else {
				inMap.put("LOGIN_ACCEPT", loginAccept);
				inMap.put("LOGIN_NO", loginNo);
				inMap.put("OP_CODE", opCode);
				inMap.put("PHONE_NO", phoneNo);
				inMap.put("OP_FLAG", opFlag);
				inMap.put("ID_NO", idNo);
				inMap.put("OFFON_TYPE", opType);
				inMap.put("CALL_CYCLE", callCycle);
				billAccount.saveShortMsgTimeOffOn(inMap);
			}
		}
		
		LoginOprEntity loe = new LoginOprEntity();
		loe.setLoginSn(loginAccept);
		loe.setLoginNo(loginNo);
		loe.setLoginGroup(inDto.getGroupId());
		loe.setTotalDate(Long.parseLong(sCurDate));
		loe.setIdNo(idNo);
		loe.setPhoneNo(phoneNo);
		loe.setBrandId(brandId);
		loe.setPayType("0");
		loe.setPayFee(0);
		loe.setOpCode(opCode);
		record.saveLoginOpr(loe);
		
		SGprsRemindOutDTO outDto = new SGprsRemindOutDTO();
		return outDto;
	}
	
	public OutDTO familyOffOn(final InDTO inParam) {
		
		Map<String, Object> inMap = new HashMap<String, Object>();
		
		SGprsRemindInDTO inDto = (SGprsRemindInDTO)inParam;
		String loginNo = inDto.getLoginNo();
		String opCode = inDto.getOpCode();
		String phoneNo = inDto.getPhoneNo();
		String offOnType = inDto.getOpType();		

		
		if(!offOnType.equals("A")&&!offOnType.equals("D")) {
			throw new BusiException(AcctMgrError.getErrorCode("0000", "90023"), "输入的开通关闭标志不正确，既不是A，也不是D!");
		}
		
		UserInfoEntity uie = user.getUserInfo(phoneNo);
		long idNo = uie.getIdNo();
		if(!uie.getRunCode().equals("A")){
			throw new BusiException(AcctMgrError.getErrorCode("0000", "90024"), "用户运行状态不正常!");
		}
		
		//取当前时间
		String sCurDate = DateUtil.format(new Date(), "yyyyMMdd");
		
		//取系统流水
		long loginAccept=control.getSequence("SEQ_SYSTEM_SN");
		
		if(offOnType.equals("A")) {
			inMap.put("PHONE_NO", phoneNo);
			inMap.put("OP_CODE", opCode);
			inMap.put("LOGIN_NO", inDto.getLoginNo());
			inMap.put("LOGIN_ACCEPT", loginAccept);
			inMap.put("OFFON_TYPE", offOnType);
			billAccount.delRemindQinQing(inMap);		
		}else if(offOnType.equals("D")){
			inMap.put("PHONE_NO", phoneNo);
			inMap.put("ID_NO", idNo);
			inMap.put("OP_CODE", opCode);
			inMap.put("LOGIN_NO", inDto.getLoginNo());
			inMap.put("LOGIN_ACCEPT", loginAccept);
			inMap.put("OFFON_TYPE", offOnType);
			billAccount.saveRemindQinQing(inMap);
		}
		
		LoginOprEntity loe = new LoginOprEntity();
		loe.setLoginSn(loginAccept);
		loe.setLoginNo(loginNo);
		loe.setLoginGroup(inDto.getGroupId());
		loe.setTotalDate(Long.parseLong(sCurDate));
		loe.setIdNo(idNo);
		loe.setPhoneNo(phoneNo);
		loe.setBrandId("00");
		loe.setPayType("0");
		loe.setPayFee(0);
		loe.setOpCode("2316");
		record.saveLoginOpr(loe);
		
		SGprsRemindOutDTO outDto = new SGprsRemindOutDTO();
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
	 * @return the shortMessage
	 */
	public IShortMessage getShortMessage() {
		return shortMessage;
	}

	/**
	 * @param shortMessage the shortMessage to set
	 */
	public void setShortMessage(IShortMessage shortMessage) {
		this.shortMessage = shortMessage;
	}
	
}
