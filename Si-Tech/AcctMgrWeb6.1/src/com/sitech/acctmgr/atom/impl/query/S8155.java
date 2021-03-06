package com.sitech.acctmgr.atom.impl.query;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.sitech.acctmgr.atom.domains.account.ContractInfoEntity;
import com.sitech.acctmgr.atom.domains.balance.TransFeeEntity;
import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.cust.CustInfoEntity;
import com.sitech.acctmgr.atom.domains.cust.GrpCustInfoEntity;
import com.sitech.acctmgr.atom.domains.query.RedFeeEntity;
import com.sitech.acctmgr.atom.domains.query.TransLimitEntity;
import com.sitech.acctmgr.atom.domains.record.ActQueryOprEntity;
import com.sitech.acctmgr.atom.domains.record.LoginOprEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.domains.user.UsersvcAttrEntity;
import com.sitech.acctmgr.atom.dto.query.S8155InitInDTO;
import com.sitech.acctmgr.atom.dto.query.S8155InitOutDTO;
import com.sitech.acctmgr.atom.dto.query.S8155RuleQryInDTO;
import com.sitech.acctmgr.atom.dto.query.S8155TransRuleInDTO;
import com.sitech.acctmgr.atom.dto.query.S8155TransRuleOutDTO;
import com.sitech.acctmgr.atom.dto.query.S8155limitQryInDTO;
import com.sitech.acctmgr.atom.dto.query.S8155limitQryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IAccount;
import com.sitech.acctmgr.atom.entity.inter.IBalance;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.ICust;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.inter.query.I8155;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
*
* <p>Title: 话费加油包查询实现类</p>
* <p>Copyright: Copyright (c) 2016</p>
* <p>Company: SI-TECH </p>
* @version 1.0
*/
@ParamTypes({ 
	@ParamType(c = S8155InitInDTO.class,oc=S8155InitOutDTO.class, m = "init"),
	@ParamType(c = S8155limitQryInDTO.class,oc=S8155limitQryOutDTO.class, m = "limitQry"),
	@ParamType(c = S8155RuleQryInDTO.class,oc=S8155limitQryOutDTO.class, m = "ruleQry"),
	@ParamType(c = S8155TransRuleInDTO.class,oc=S8155TransRuleOutDTO.class, m = "transRule")
	})
public class S8155 extends AcctMgrBaseService implements I8155{

	private IBalance balance;
	private IUser user;
	private ICust cust;
	private IGroup group;
	private IControl control;
	private IRecord record;
	private IAccount account;
	@Override
	public OutDTO init(InDTO inParam) {
		// TODO Auto-generated method stub
		List<RedFeeEntity> redFeeInfo = new ArrayList<RedFeeEntity>();
		
		S8155InitInDTO inDto = (S8155InitInDTO)inParam;
		String phoneNo = inDto.getPhoneNo();
		String queryMonth = inDto.getQueryMonth();
		
		//查询集团转账信息
		List<TransFeeEntity> tfeList = balance.getJtTrasfeeInfo(phoneNo,queryMonth);
		for(TransFeeEntity tmpEntity:tfeList){
			long idNoOut = tmpEntity.getIdnoOut();
			String phoneOut = tmpEntity.getPhonenoOut();
			long transFee = Long.valueOf(tmpEntity.getFactorThree());
			int transCount = Integer.valueOf(tmpEntity.getFactorOne());
			String contactPhone = tmpEntity.getFactorTwo();
			String opTime = tmpEntity.getOpTime();
			long unitId = Long.valueOf(tmpEntity.getFactorFour());
			
			//查询集团编码
			GrpCustInfoEntity gcie = cust.getGrpCustInfo(null, unitId);
			long custId = gcie.getCustId();
			
			//查询集团名称
			CustInfoEntity cie = cust.getCustInfo(custId, null);
			String unitName = cie.getCustName();
			String groupId = cie.getGroupId();
			
			//查询地市
			ChngroupRelEntity cgreRegion = group.getRegionDistinct(groupId, "2", inDto.getProvinceId());
			String regionName = cgreRegion.getRegionName();
			
			//查询区县
			ChngroupRelEntity cgreDis = group.getRegionDistinct(groupId, "3", inDto.getProvinceId());
			String disName = cgreDis.getRegionName();
			
			//查询集团客服电话
			String servicePhone="";
			UsersvcAttrEntity uae = user.getUsersvcAttr(idNoOut, "23B250");
			if(uae!=null){
				servicePhone =uae.getAttrValue();
			}			
			
			RedFeeEntity rfe = new RedFeeEntity();
			/*
			String disName="aaa";
			String regionName="bbb";
			String servicePhone="13888888888";
			long unitId=2222;
			String unitName="cccc";
			*/
			rfe.setContactPhone(contactPhone);
			rfe.setDisName(disName);
			rfe.setOpTime(opTime);
			rfe.setProdPrcName(transFee/100+"(元)话费红包");
			rfe.setRegionName(regionName);
			rfe.setServicePhone(servicePhone);
			rfe.setTransCount(transCount);
			rfe.setUnitId(unitId);
			rfe.setUnitName(unitName);
			redFeeInfo.add(rfe);
		}
		
		ActQueryOprEntity oprEntity = new ActQueryOprEntity();
		oprEntity.setQueryType("0");
		oprEntity.setOpCode("8155");
		oprEntity.setContactId("");
		oprEntity.setPhoneNo(phoneNo);
		oprEntity.setBrandId("");
		oprEntity.setLoginNo(inDto.getLoginNo());
		oprEntity.setLoginGroup(inDto.getGroupId());
		oprEntity.setRemark("话费加油包查询");
		oprEntity.setProvinceId(inDto.getProvinceId());
		oprEntity.setHeader(inDto.getHeader());
		record.saveQueryOpr(oprEntity, false);
		
		S8155InitOutDTO outDto = new S8155InitOutDTO();
		outDto.setRedFeeInfo(redFeeInfo);
				
		return outDto;
	}
	
	public OutDTO limitQry(InDTO inParam) {
		List<TransLimitEntity> resultList = new ArrayList<TransLimitEntity>();
		
		S8155limitQryInDTO inDto= (S8155limitQryInDTO)inParam;
		String unitId = inDto.getUnitId();
		String adminPhone = inDto.getAdminPhone();
		String yearMonth = inDto.getYearMonth();
		String operPhone = inDto.getOperPhone();
		
		Map<String,Object> inMap = new HashMap<String,Object>();
		inMap.put("UNIT_ID", unitId);
		inMap.put("ADMIN_PHONE", adminPhone);
		inMap.put("OPER_PHONE", operPhone);
		List<TransLimitEntity> limitList = balance.getTransLimit(inMap);
		for(TransLimitEntity emp:limitList) {
			TransLimitEntity tle = new TransLimitEntity();
			long limitPay =0;
			long totalPayed=0;
			
			operPhone = emp.getOperPhone();
			limitPay = emp.getLimitPay();
			totalPayed = emp.getTotalPayed();
			
			long monthMoney = balance.getTransFeeByUnitId(unitId, operPhone);
			long remainPay = limitPay-totalPayed;
			
			tle.setLimitPay(limitPay);
			tle.setMonthMoney(monthMoney);
			tle.setOperPhone(operPhone);
			tle.setRemainPay(remainPay);
			resultList.add(tle);
		}
		
		S8155limitQryOutDTO outDto = new S8155limitQryOutDTO();
		outDto.setResultList(resultList);;
		return outDto;
	}
	
	
	public OutDTO ruleQry(final InDTO inParam) {
		S8155RuleQryInDTO inDto = (S8155RuleQryInDTO)inParam;
		String unitId = inDto.getUnitId();
		String adminPhone = inDto.getAdminPhone();
		String contractNo = inDto.getContractNo();
		
		Map<String,Object> inMap = new HashMap<String,Object>();
		inMap.put("UNIT_ID", unitId);
		inMap.put("ADMIN_PHONE", adminPhone);
		inMap.put("JT_CONTRACT_NO", contractNo);
		List<TransLimitEntity> resultList = balance.getTransLimit(inMap);
		
		S8155limitQryOutDTO outDto = new S8155limitQryOutDTO();
		outDto.setResultList(resultList);
		return outDto;
	}
	
	public OutDTO transRule(InDTO inParam) {
		S8155TransRuleInDTO inDto = (S8155TransRuleInDTO)inParam;	
		String unitId = inDto.getUnitId();
		String adminPhone = inDto.getAdminPhone();
		String jtContractNo = inDto.getJtContractNo();
		String phoneTemp = inDto.getPhoneTemp();
		String limitPayTemp = inDto.getLimitPayTemp();
		String beginYmd = inDto.getBeginYmd();
		String endYmd = inDto.getEndYmd();
		String phoneNum = inDto.getPhoneNum();
		String opType = inDto.getOpType();
		
		String[] phoneArray = phoneTemp.split("\\|");
		String[] limitPayArray = limitPayTemp.split("\\|");
		
		if(opType.equals("0")&&(phoneArray.length!=limitPayArray.length)
				&&phoneTemp.substring(phoneTemp.length()-1)!="|"
				&&limitPayTemp.substring(limitPayTemp.length()-1)!="|") {
			throw new BusiException(AcctMgrError.getErrorCode("8155","00002"), "号码,金额必须以 | 结尾！");
		}
		
		if(Integer.parseInt(phoneNum)!=phoneArray.length) {
			throw new BusiException(AcctMgrError.getErrorCode("8155","00006"), "充值号码个数和号码串个数不一致!");
		}
		
		ContractInfoEntity cie = account.getConInfo(Long.parseLong(jtContractNo));
		String accountType = cie.getAccountType();
		long custId = cie.getCustId();
		if(!accountType.equals("1")){
			throw new BusiException(AcctMgrError.getErrorCode("8155","00003"), "集团产品账号不存在["+jtContractNo+"]!");
		}
		
		GrpCustInfoEntity gcie = cust.getGrpCustInfo(custId, null);
		long unitIdCom = gcie.getUnitId();
		if(!String.valueOf(unitIdCom).equals(unitId)) {
			throw new BusiException(AcctMgrError.getErrorCode("8155","00004"), "集团账号对应集团编码有误！");
		}
		
		//剃重
		List<String> result = new ArrayList<>();
		List<String> resultMoney = new ArrayList<>();
		boolean flag;
		for(int i=0;i<phoneArray.length;i++) {
			flag = false;  
		    for(int j=0;j<result.size();j++){  
		        if(phoneArray[i].equals(result.get(j))){  
		            flag = true;  
		            break;  
		        }  
		    }  
		    if(!flag){  
		        result.add(phoneArray[i]);
		        resultMoney.add(limitPayArray[i]);
		    }
		}		
		String[] arrayPhone = (String[]) result.toArray(new String[result.size()]);
		String[] arrayMoney = (String[]) resultMoney.toArray(new String[resultMoney.size()]);
		
		for (int k = 0; k < arrayPhone.length; k++) {
			
			Map<String, Object> inMap = new HashMap<String, Object>();
			inMap.put("OP_TYPE", opType);
			inMap.put("UNIT_ID", unitId);
			inMap.put("ADMIN_PHONE", adminPhone);
			inMap.put("JT_CONTRACT_NO", jtContractNo);
			inMap.put("OPER_PHONE", arrayPhone[k]);
			inMap.put("BEGIN_YMD", beginYmd);
			inMap.put("END_YMD", endYmd);
			inMap.put("LIMIT_PAY", arrayMoney[k]);
			log.info("xxxxx=="+inMap.toString());
			balance.oprTransLimit(inMap);
		}
		
		S8155TransRuleOutDTO outDto = new S8155TransRuleOutDTO();
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
	/**
	 * @return the cust
	 */
	public ICust getCust() {
		return cust;
	}
	/**
	 * @param cust the cust to set
	 */
	public void setCust(ICust cust) {
		this.cust = cust;
	}
	/**
	 * @return the group
	 */
	public IGroup getGroup() {
		return group;
	}
	/**
	 * @param group the group to set
	 */
	public void setGroup(IGroup group) {
		this.group = group;
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
	 * @return the account
	 */
	public IAccount getAccount() {
		return account;
	}

	/**
	 * @param account the account to set
	 */
	public void setAccount(IAccount account) {
		this.account = account;
	}


}
