package com.sitech.acctmgr.atom.impl.pay;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.busi.pay.inter.IPreOrder;
import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.base.LoginEntity;
import com.sitech.acctmgr.atom.domains.pay.AgentEntity;
import com.sitech.acctmgr.atom.domains.record.LoginOprEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.pay.S2302CfmInDTO;
import com.sitech.acctmgr.atom.dto.pay.S2302CfmOutDTO;
import com.sitech.acctmgr.atom.dto.pay.S2302InitInDTO;
import com.sitech.acctmgr.atom.dto.pay.S2302InitOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IAgent;
import com.sitech.acctmgr.atom.entity.inter.IBalance;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.ILogin;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.inter.pay.I2302;
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
@ParamTypes({ @ParamType(c = S2302InitInDTO.class, oc = S2302InitOutDTO.class, m = "init"),
	@ParamType(c = S2302CfmInDTO.class, oc = S2302CfmOutDTO.class, m = "cfm")							
			})
public class S2302 extends AcctMgrBaseService implements I2302 {
	
	private IGroup		group;
	private ILogin		login;
	private IAgent		agent;
	private IBalance	balance;
	private IRecord		record;
	private IControl	control;
	private IUser		user;
	private IPreOrder	preOrder;

	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.inter.pay.I2302#init(com.sitech.jcfx.dt.in.InDTO)
	 */
	@Override
	public OutDTO init(InDTO inParam) {
		
		S2302InitInDTO inDto = (S2302InitInDTO)inParam;
		if( StringUtils.isEmptyOrNull(inDto.getGroupId()) ){
			LoginEntity  loginEntity = login.getLoginInfo(inDto.getLoginNo(), inDto.getProvinceId());
			inDto.setGroupId(loginEntity.getGroupId());
		}
		
		Map<String, Object> outMapTmp = null;
		String regionGroupId = inDto.getRegionGroupId();
		String districtGroupId = inDto.getDistrictGroupId();
		
		outMapTmp = group.getCurrentGroupInfo(regionGroupId, inDto.getProvinceId());
		String regionGroupName = outMapTmp.get("GROUP_NAME").toString();
		
		outMapTmp = group.getCurrentGroupInfo(districtGroupId, inDto.getProvinceId());
		String districtGroupName = outMapTmp.get("GROUP_NAME").toString();
		
		ChngroupRelEntity groupEntity = group.getRegionDistinct(inDto.getGroupId(), "2", inDto.getProvinceId());
		String loginRegionGruopId = groupEntity.getParentGroupId();
		if(!loginRegionGruopId.equals(regionGroupId)){
			
			throw new BusiException(AcctMgrError.getErrorCode("2302", "00001"), "不允许跨地市录入!");
		}
		
		Map<String, Object> outAgent = agent.getDistrictAgentList(districtGroupId, Integer.parseInt(inDto.getPageNum()), inDto.getProvinceId(), "1");
		List<AgentEntity> agentList = (List<AgentEntity>)outAgent.get("result");
		int totalNum = (int) outAgent.get("sum");
		List<AgentEntity> outAgentList = new ArrayList<AgentEntity>();
		for(AgentEntity agentTmp : agentList){
			
			agentTmp.setRegionGroupId(regionGroupId);
			agentTmp.setRegionGroupName(regionGroupName);
			agentTmp.setDistrictGroupId(districtGroupId);
			agentTmp.setDistrictGroupName(districtGroupName);
			outAgentList.add(agentTmp);
		}
		long loginAccept = control.getSequence("SEQ_SYSTEM_SN");
		String sCurDate = DateUtil.format(new Date(), "yyyyMMddHHmmss");
		//记录营业员操作日志
		LoginOprEntity in = new LoginOprEntity();
		in.setPayFee(0);
		in.setLoginSn(loginAccept);
		in.setLoginNo(inDto.getLoginNo());
		in.setLoginGroup(inDto.getGroupId());
		in.setOpCode(inDto.getOpCode());
		in.setTotalDate(Long.parseLong(sCurDate.substring(0, 8)));
		in.setRemark("空中充值代理商信息查询");
		record.saveLoginOpr(in);
		
		S2302InitOutDTO outDto = new S2302InitOutDTO();
		outDto.setAgentList(outAgentList);
		outDto.setTotalNum(totalNum);
		return outDto;
	}

	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.inter.pay.I2302#cfm(com.sitech.jcfx.dt.in.InDTO)
	 */
	@Override
	public OutDTO cfm(InDTO inParam) {

		S2302CfmInDTO inDto = (S2302CfmInDTO)inParam;
		if( StringUtils.isEmptyOrNull(inDto.getGroupId()) ){
			LoginEntity  loginEntity = login.getLoginInfo(inDto.getLoginNo(), inDto.getProvinceId());
			inDto.setGroupId(loginEntity.getGroupId());
		}
		log.info("2302 cfm begin:" + inDto.getMbean());
		
		String sCurDate = DateUtil.format(new Date(), "yyyyMMddHHmmss");
		
		List<AgentEntity> agentList = inDto.getAgentList();
		for(AgentEntity agent : agentList){
			Map<String, Object> inMap = new HashMap<String, Object>();
			if(agent.getAgentConNo() == 0){
				continue;
			}
			
			inMap.put("AGT_PHONE_NO", agent.getAgentPhone());
			inMap.put("AGT_CONTRACT_NO", agent.getAgentConNo());
			inMap.put("CHECK_TYPE", "1");
			inMap.put("LOGIN_NO", inDto.getLoginNo());
			balance.saveAgentCheck(inMap);
			
			long loginAccept = control.getSequence("SEQ_SYSTEM_SN");
			UserInfoEntity  userInfo = user.getUserInfo(agent.getAgentPhone());
			//记录营业员操作日志
			LoginOprEntity in = new LoginOprEntity();
			in.setIdNo(userInfo.getIdNo());
			in.setBrandId(userInfo.getBrandId());
			in.setPhoneNo(userInfo.getPhoneNo());
			in.setPayType("");
			in.setPayFee(0);
			in.setLoginSn(loginAccept);
			in.setLoginNo(inDto.getLoginNo());
			in.setLoginGroup(inDto.getGroupId());
			in.setOpCode(inDto.getOpCode());
			in.setTotalDate(Long.parseLong(sCurDate.substring(0, 8)));
			in.setRemark("设置空中充值代理商账户网厅缴费限制");
			record.saveLoginOpr(in);
			
			ChngroupRelEntity groupEntity = group.getRegionDistinct(userInfo.getGroupId(), "2", inDto.getProvinceId());
			//同步统一接触
			Map<String, Object> oprCnttMap = new HashMap<String, Object>(); 
			oprCnttMap.put("Header", inDto.getHeader()); 
			oprCnttMap.put("PAY_SN", loginAccept); 
			oprCnttMap.put("LOGIN_NO", inDto.getLoginNo()); 
			oprCnttMap.put("GROUP_ID", inDto.getGroupId()); 
			oprCnttMap.put("OP_CODE", inDto.getOpCode()); 
			oprCnttMap.put("REGION_ID", groupEntity.getRegionCode()); 
			oprCnttMap.put("OP_NOTE", "设置空中充值代理商账户网厅缴费限制"); 
			oprCnttMap.put("CUST_ID_TYPE", "1"); 
			oprCnttMap.put("CUST_ID_VALUE", userInfo.getPhoneNo()); 
			oprCnttMap.put("OP_TIME", sCurDate); 
			preOrder.sendOprCntt(oprCnttMap);
		}
		

		
		S2302CfmOutDTO outDto = new S2302CfmOutDTO();
		return outDto;
	}

	public IRecord getRecord() {
		return record;
	}

	public void setRecord(IRecord record) {
		this.record = record;
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

	public IGroup getGroup() {
		return group;
	}

	public void setGroup(IGroup group) {
		this.group = group;
	}

	public ILogin getLogin() {
		return login;
	}

	public void setLogin(ILogin login) {
		this.login = login;
	}

	public IAgent getAgent() {
		return agent;
	}

	public void setAgent(IAgent agent) {
		this.agent = agent;
	}

	public IBalance getBalance() {
		return balance;
	}

	public void setBalance(IBalance balance) {
		this.balance = balance;
	}

	public IPreOrder getPreOrder() {
		return preOrder;
	}

	public void setPreOrder(IPreOrder preOrder) {
		this.preOrder = preOrder;
	}

}
