package com.sitech.acctmgr.atom.impl.acctmng;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.account.ContractInfoEntity;
import com.sitech.acctmgr.atom.domains.base.LoginEntity;
import com.sitech.acctmgr.atom.domains.pub.pubUpdateEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.acctmng.S8283CfmInDTO;
import com.sitech.acctmgr.atom.dto.acctmng.S8283CfmOutDTO;
import com.sitech.acctmgr.atom.dto.acctmng.S8283InitInDTO;
import com.sitech.acctmgr.atom.dto.acctmng.S8283InitOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IAccount;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.ILogin;
import com.sitech.acctmgr.atom.entity.inter.IShortMsg;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.inter.acctmng.I8283;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.util.DateUtil;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
@ParamTypes({ @ParamType(c = S8283InitInDTO.class, oc = S8283InitOutDTO.class, m = "init"),
	          @ParamType(c = S8283CfmInDTO.class, oc = S8283CfmOutDTO.class, m = "cfm")
			})
public class S8283 extends AcctMgrBaseService implements I8283 {
	
	private ILogin		login;
	private IAccount	account;
	private IShortMsg	shortMsg;
	private IControl	control;
	private IUser		user;
	
	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.inter.acctmng.I8283#init(com.sitech.jcfx.dt.in.InDTO)
	 */
	@Override
	public OutDTO init(InDTO inParam) {
		
		S8283InitInDTO inDto = (S8283InitInDTO)inParam;
		if( StringUtils.isEmptyOrNull(inDto.getGroupId()) ){
			LoginEntity  loginEntity = login.getLoginInfo(inDto.getLoginNo(), inDto.getProvinceId());
			inDto.setGroupId(loginEntity.getGroupId());
		}
		
		log.info("S8283 init begin: " + inDto.getMbean());
		
		ContractInfoEntity conEntity = account.getConInfo(inDto.getContractNo());
		
		List<Map<String, Object>> conPhoneList = shortMsg.getShortMsgList(null, inDto.getContractNo());
		
		List<Map<String, Object>> phoneConList = null;
		if(inDto.getPhoneNo() != null && !inDto.getPhoneNo().equals("")){
			phoneConList = shortMsg.getShortMsgList(inDto.getPhoneNo(), null);
		}
		
		S8283InitOutDTO outDto = new S8283InitOutDTO();
		outDto.setPhoneNo(inDto.getPhoneNo());
		outDto.setContractNo(conEntity.getContractNo());
		outDto.setContractName(conEntity.getContractName());
		outDto.setConPhoneList(conPhoneList);
		outDto.setPhoneConList(phoneConList);
		return outDto;
	}

	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.inter.acctmng.I8283#cfm(com.sitech.jcfx.dt.in.InDTO)
	 */
	@Override
	public OutDTO cfm(InDTO inParam) {
		
		S8283CfmInDTO inDto = (S8283CfmInDTO)inParam;
		if( StringUtils.isEmptyOrNull(inDto.getGroupId()) ){
			LoginEntity  loginEntity = login.getLoginInfo(inDto.getLoginNo(), inDto.getProvinceId());
			inDto.setGroupId(loginEntity.getGroupId());
		}
		log.info("S8283 cfm begin: " + inDto.getMbean());
		
		/*取当前年月和当前时间*/
		String sCurTime = control.getSysDate().get("CUR_TIME").toString();
		String totalDate = sCurTime.substring(0, 8);
		
		long loginAccept = control.getSequence("SEQ_SYSTEM_SN");
		pubUpdateEntity updateEntity = new pubUpdateEntity();
		updateEntity.setUpdateAccept(loginAccept);
		updateEntity.setUpdateCode(inDto.getOpCode());
		updateEntity.setUpdateDate(totalDate);
		updateEntity.setUpdateLogin(inDto.getLoginNo());
		
		//1：新增，2：修改，3：删除
		if(inDto.getUpdateFlag().equals("1")){
			
			if(shortMsg.isConfig(inDto.getContractNo())){
				throw new BusiException(AcctMgrError.getErrorCode("8283","00002"), "该账户已经配置接收短信提醒用户!");
			}
			
			UserInfoEntity userEntity = user.getUserEntityByPhoneNo(inDto.getPhoneNo(), true);
			
			Map<String, Object> inMap = new HashMap<String, Object>();
			inMap.put("CONTRACT_NO", inDto.getContractNo());
			inMap.put("PHONE_NO", inDto.getPhoneNo());
			inMap.put("ID_NO", userEntity.getIdNo());
			inMap.put("LOGIN_NO", inDto.getLoginNo());
			inMap.put("OP_CODE", inDto.getOpCode());
			inMap.put("REMARK", inDto.getRemark());
			shortMsg.inShortMsgInfo(inMap);
		}else if(inDto.getUpdateFlag().equals("2")){
			
			updateEntity.setUpdateType("U");
			if(!shortMsg.isConfig(inDto.getContractNo())){
				throw new BusiException(AcctMgrError.getErrorCode("8283","00001"), "该账户未配置接收短信提醒用户!");
			}
			shortMsg.inShortMsgInfoHis(inDto.getContractNo(), updateEntity);
			shortMsg.upPhone(inDto.getContractNo(), inDto.getPhoneNo());
			
		}else if(inDto.getUpdateFlag().equals("3")){
			
			updateEntity.setUpdateType("D");
			if(!shortMsg.isConfig(inDto.getContractNo())){
				throw new BusiException(AcctMgrError.getErrorCode("8283","00001"), "该账户未配置接收短信提醒用户!");
			}
			log.debug("qiaolin: " + updateEntity.toString());
			shortMsg.inShortMsgInfoHis(inDto.getContractNo(), updateEntity);
			shortMsg.dConfig(inDto.getContractNo());
		}
		
		
		S8283CfmOutDTO outDto = new S8283CfmOutDTO();
		return outDto;
	}
	
	

	public IControl getControl() {
		return control;
	}

	public void setControl(IControl control) {
		this.control = control;
	}

	public IUser getUser() {
		return user;
	}

	public void setUser(IUser user) {
		this.user = user;
	}

	public ILogin getLogin() {
		return login;
	}

	public void setLogin(ILogin login) {
		this.login = login;
	}

	public IAccount getAccount() {
		return account;
	}

	public void setAccount(IAccount account) {
		this.account = account;
	}

	public IShortMsg getShortMsg() {
		return shortMsg;
	}

	public void setShortMsg(IShortMsg shortMsg) {
		this.shortMsg = shortMsg;
	}

}
