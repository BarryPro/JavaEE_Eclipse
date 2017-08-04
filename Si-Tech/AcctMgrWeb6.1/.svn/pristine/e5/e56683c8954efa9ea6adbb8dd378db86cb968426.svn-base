package com.sitech.acctmgr.atom.impl.pay;

import java.util.HashMap;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.base.LoginEntity;
import com.sitech.acctmgr.atom.domains.record.LoginOprEntity;
import com.sitech.acctmgr.atom.dto.pay.S8229CfmInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8229CfmOutDTO;
import com.sitech.acctmgr.atom.dto.pay.S8229CheckBackCfmInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8229CheckBackCfmOutDTO;
import com.sitech.acctmgr.atom.dto.pay.S8229CheckQueryInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8229CheckQueryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.ICheque;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.ILogin;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.inter.pay.I8229;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BaseException;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;


@ParamTypes({ @ParamType(m = "cfm", c = S8229CfmInDTO.class, oc = S8229CfmOutDTO.class),
			  @ParamType(m = "checkBackCfm", c = S8229CheckBackCfmInDTO.class, oc = S8229CheckBackCfmOutDTO.class),
			  @ParamType(m = "checkQuery", c = S8229CheckQueryInDTO.class, oc = S8229CheckQueryOutDTO.class)
})

public class S8229 extends AcctMgrBaseService 
						implements I8229{
	
	private ICheque cheque;
	private IControl control;
	private ILogin login;


	@Override
	public OutDTO cfm(InDTO inParam) {
		// TODO Auto-generated method stub
		
		S8229CfmInDTO inDto =(S8229CfmInDTO)inParam;
		log.info("8229 cfm inDto: "+ inParam.getMbean());
		
		String bankCode = inDto.getBankCode();
		String loginPwd = inDto.getLoginPwd();
		String popType= inDto.getPopType();
		String checkNo = inDto.getCheckNo();
		String bankCount = inDto.getBankCount();
		long checkMoney = inDto.getCheckMoney();
		String pownerUnit = inDto.getPownerUnit();
		String pownerName = inDto.getPownerName();
		String pownerId = inDto.getPownerId();
		String contactNo = inDto.getContactNo();
		String remark = inDto.getRemark();
		String opCode = inDto.getOpCode();
		String loginNo = inDto.getLoginNo();
		String groupId = inDto.getGroupId();
		
		
		if(checkMoney>50000000){
			log.error("------>支票金额大于五十万, checkMoney -" + checkMoney);
			throw new BaseException(AcctMgrError.getErrorCode("8229", "00001"), "支票金额大于五十万元！");
		}
		
		
		long cnt = cheque.getCheckCount(bankCode,checkNo);
		int cntPay = cheque.getCheckPrepayInfo(bankCode, checkNo);
		if(cnt > 0 || cntPay > 0){
			throw new BaseException(AcctMgrError.getErrorCode("8229", "00002"), "同一张支票不能记录两次！");
		}
		
		//获取日期
		String opTime = control.getSysDate().get("CUR_TIME").toString();
		int curYM = Integer.parseInt(opTime.substring(0, 6));
		int totalDate = Integer.parseInt(opTime.substring(0, 8));
		
		// 获取流水
		long paySn = control.getSequence("SEQ_PAY_SN");
		log.info("--------paySn->"+paySn);
		
		
		
		//记录支票记录表
		Map<String,Object> inMapOpr = new HashMap<String,Object>();
		inMapOpr.put("BANK_CODE", bankCode);
		inMapOpr.put("TOTAL_DATE", totalDate);
		inMapOpr.put("PAY_SN", paySn);
		inMapOpr.put("OP_TIME", opTime);
		inMapOpr.put("CHECK_NO", checkNo);
		inMapOpr.put("CHECK_PAY", checkMoney);
		inMapOpr.put("LOGIN_GROUP", groupId);
		inMapOpr.put("LOGIN_NO", loginNo);
		inMapOpr.put("OP_CODE", opCode);
		inMapOpr.put("REMARK", remark);
		cheque.insCheckOpr(inMapOpr);
		
		//记录支票详细信息表
		Map<String,Object> inMsgMap =new HashMap<String,Object>();
		inMsgMap.put("BANK_CODE", bankCode);
		inMsgMap.put("OWNER_UNIT", pownerUnit);
		inMsgMap.put("CHECK_MONEY",checkMoney);
		inMsgMap.put("OWNER_NAME", pownerName);
		inMsgMap.put("BANK_COUNT", bankCount);
		inMsgMap.put("CHECK_NO", checkNo);
		inMsgMap.put("OWNER_ID", pownerId);
		inMsgMap.put("CHECK_STATUS", "0");
		inMsgMap.put("LOGIN_NO", loginNo);
		//此处默认1，后续需要确认 SELECT check_flag INTO vCheck_Flag FROM sBaseCode
		inMsgMap.put("CONFIRM_STATUS", "1");
		inMsgMap.put("CONTACT_PERSON", contactNo);
		inMsgMap.put("OP_CODE", opCode);
		inMsgMap.put("REMARK", remark);
		cheque.saveCheckMsgInfo(inMsgMap);
		
		//记录支票金额表，--------老系统为--默认为1时,须进行本操作IF vCheck_Flag = '1' 才执行
		Map<String,Object> inMap = new HashMap<String,Object>(); 
		inMap.put("OP_TIME", opTime);
		inMap.put("BANK_CODE", bankCode);
		inMap.put("CHECK_NO", checkNo);
		inMap.put("CHECK_PREPAY",checkMoney);
		cheque.saveCheckPrepayInfo(inMap);
		
		//记录营业员操作记录表
		LoginOprEntity loginOprEnt = new LoginOprEntity();
		loginOprEnt.setLoginGroup(groupId);
		loginOprEnt.setLoginNo(loginNo);
		loginOprEnt.setLoginSn(paySn);
		loginOprEnt.setOpCode(opCode);
		loginOprEnt.setOpTime(opTime);
		loginOprEnt.setPayFee(checkMoney);
		loginOprEnt.setRemark("收支票");
		loginOprEnt.setPayType("0");
		loginOprEnt.setTotalDate(totalDate);
		
		
		S8229CfmOutDTO outDto = new S8229CfmOutDTO();  
		log.info("---->8229 cfm_out"+outDto.toJson());
		return outDto;
	}
	@Override
	public OutDTO checkBackCfm(InDTO inParam) {
		
		S8229CheckBackCfmInDTO inDto = (S8229CheckBackCfmInDTO)inParam;  
		
		String loginNo = inDto.getLoginNo();
		String loginPwd = inDto.getLoginPwd();
		String popType= inDto.getPopType();
		String bankCode = inDto.getBankCode();
		String checkNo = inDto.getCheckNo();
		String remark = inDto.getRemark();
		String opCode = inDto.getOpCode();
		String groupId = inDto.getGroupId();
		
		if( StringUtils.isEmptyOrNull(groupId) ){
			LoginEntity  loginEntity = login.getLoginInfo(inDto.getLoginNo(), inDto.getProvinceId());
			groupId = loginEntity.getGroupId();
		}
		
		//校验支票是否已使用
		//获取支票余额
		long checkPrepay = cheque.getCheckPrepay(bankCode, checkNo);
		long checkMoney = Long.parseLong(cheque.getCheckMsgInfo(bankCode, checkNo).get("CHECK_MONEY").toString());
		
		if(checkPrepay != checkMoney){
			log.info("支票不允许退收！");
			throw new BusiException(AcctMgrError.getErrorCode("8229", "00003"),
					"支票已经被使用，不允许退收!");
		}
		
		//获取日期
		String opTime = control.getSysDate().get("CUR_TIME").toString();
		int curYM = Integer.parseInt(opTime.substring(0, 6));
		int totalDate = Integer.parseInt(opTime.substring(0, 8));
		
		// 获取流水
		long loginAccept = control.getSequence("SEQ_PAY_SN");
		
		/*
		 * 删除收缴支票表中的记录前,先做历史备份
		 * 删除用户在交款支票表中的记录
		 */
		
		Map<String, Object> inMapTmp = new HashMap<String, Object>();
		inMapTmp.put("UPDATE_ACCEPT", loginAccept);
		inMapTmp.put("UPDATE_DATE", totalDate);
		inMapTmp.put("UPDATE_LOGIN", inDto.getLoginNo());
		inMapTmp.put("UPDATE_CODE", inDto.getOpCode());
		cheque.deleteCheckMsgInfo(bankCode, checkNo,inMapTmp);
		
		//删除用户在预存支票表中的记录
		cheque.removeCheckPrepayInfo(bankCode, checkNo);
		
		//记录支票操作日志
		Map<String,Object> inMapOpr = new HashMap<String,Object>();
		inMapOpr.put("BANK_CODE", bankCode);
		inMapOpr.put("TOTAL_DATE", totalDate);
		inMapOpr.put("PAY_SN", loginAccept);
		inMapOpr.put("OP_TIME", opTime);
		inMapOpr.put("CHECK_NO", checkNo);
		inMapOpr.put("CHECK_PAY", checkPrepay);
		inMapOpr.put("LOGIN_GROUP", groupId);
		inMapOpr.put("LOGIN_NO", loginNo);
		inMapOpr.put("OP_CODE", opCode);
		inMapOpr.put("REMARK", remark);
		cheque.insCheckOpr(inMapOpr);
		
		S8229CheckBackCfmOutDTO outDto = new S8229CheckBackCfmOutDTO();  
		return outDto;
	}
	
	@Override
	public OutDTO checkQuery(InDTO inParam) {
		S8229CheckQueryInDTO inDto = (S8229CheckQueryInDTO)inParam;  
		
		String checkNo = inDto.getCheckNo();
		String bankCode = inDto.getBankCode();
		
		String checkMoney = null;
		String bankCount = null;
		String ownerUnit = null;
		String ownerName = null;
		String contactPerson = null;
		String ownerId = null;
		
		if( StringUtils.isEmpty(checkNo) || StringUtils.isEmpty(bankCode)){
			log.info("支票号码，银行代码必须入力！");
			throw new BusiException(AcctMgrError.getErrorCode("8229", "00004"),
					"支票号码或银行代码为空!");
		}
		
		Map<String ,Object > map = new HashMap<String,Object>();
		//通过bankCode和CheckNo查询支票信息
		
		map = cheque.getCheckMsgInfo(bankCode, checkNo);
		
		//log.info("hanfl test:"+map.toString());
		
		if(map == null){
			log.info("支票信息不存在");
			throw new BusiException(AcctMgrError.getErrorCode("8229", "00005"),
					"支票信息不存在!");
		}
		
		//获取支票信息
		checkMoney = map.get("CHECK_MONEY").toString();
		bankCount = map.get("BANK_COUNT").toString();
		ownerUnit = map.get("OWNER_UNIT").toString();
		ownerName = map.get("OWNER_NAME").toString();
		contactPerson = map.get("CONTACT_PERSON").toString();
		ownerId = map.get("OWNER_ID").toString();
		

		S8229CheckQueryOutDTO outDto = new S8229CheckQueryOutDTO();  
		outDto.setBankCount(bankCount);
		outDto.setCheckMoney(checkMoney);
		outDto.setContactPerson(contactPerson);
		outDto.setOwnerId(ownerId);
		outDto.setOwnerUnit(ownerUnit);
		outDto.setOwnerName(ownerName);
		
		
		return outDto;
	}

	
	
	
	public ICheque getCheque() {
		return cheque;
	}

	public void setCheque(ICheque cheque) {
		this.cheque = cheque;
	}

	public IControl getControl() {
		return control;
	}

	public void setControl(IControl control) {
		this.control = control;
	}

	public ILogin getLogin() {
		return login;
	}
	
	public void setLogin(ILogin login) {
		this.login = login;
	}
	
	
}
