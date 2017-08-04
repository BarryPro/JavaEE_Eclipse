package com.sitech.acctmgr.atom.impl.pay;

import static org.apache.commons.collections.MapUtils.safeAddToMap;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.busi.pay.inter.IPayManage;
import com.sitech.acctmgr.atom.busi.pay.inter.IPayOpener;
import com.sitech.acctmgr.atom.busi.pay.inter.IPreOrder;
import com.sitech.acctmgr.atom.busi.pay.inter.ITransType;
import com.sitech.acctmgr.atom.busi.pay.inter.IWriteOffer;
import com.sitech.acctmgr.atom.busi.pay.trans.TransFactory;
import com.sitech.acctmgr.atom.busi.query.inter.IRemainFee;
import com.sitech.acctmgr.atom.domains.account.ContractDeadInfoEntity;
import com.sitech.acctmgr.atom.domains.account.ContractInfoEntity;
import com.sitech.acctmgr.atom.domains.account.CsAccountRelEntity;
import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.cust.CustInfoEntity;
import com.sitech.acctmgr.atom.domains.fee.OutFeeData;
import com.sitech.acctmgr.atom.domains.pay.GroupChargeEntity;
import com.sitech.acctmgr.atom.domains.pay.GroupRelConInfo;
import com.sitech.acctmgr.atom.domains.pay.PayBookEntity;
import com.sitech.acctmgr.atom.domains.pay.PayUserBaseEntity;
import com.sitech.acctmgr.atom.domains.record.LoginOprEntity;
import com.sitech.acctmgr.atom.domains.user.UserDeadEntity;
import com.sitech.acctmgr.atom.domains.user.UserDetailEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.pay.S8078CfmInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8078CfmOutDTO;
import com.sitech.acctmgr.atom.dto.pay.S8078InitInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8078InitOutDTO;
import com.sitech.acctmgr.atom.dto.pay.S8203CfmInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8203CfmOutDTO;
import com.sitech.acctmgr.atom.dto.pay.S8203InitInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8203InitOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IAccount;
import com.sitech.acctmgr.atom.entity.inter.IBalance;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.ICust;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.acctmgr.inter.pay.I8078;
import com.sitech.acctmgrint.atom.busi.intface.IShortMessage;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ @ParamType(m = "init", c = S8078InitInDTO.class, oc = S8078InitOutDTO.class),
	  @ParamType(m = "cfm", c = S8078CfmInDTO.class,oc = S8078CfmOutDTO.class)})
public class S8078 extends AcctMgrBaseService implements I8078{
	
	private IUser user;
	private ICust cust;
	private IGroup group;
	private IRecord record;
	private IPayManage payManage;
	private IWriteOffer	writeOffer;
	private IPayOpener payOpener;
	private IControl control;
	private IBalance balance;
	private IAccount account;
	private IPreOrder preOrder;
	private IRemainFee remainFee;
	protected TransFactory transFactory;
	private IShortMessage shortMessage;
	
	@Override
	public OutDTO init(InDTO inParam) {
		
		//每月五号以后才能划拨
		Calendar c = Calendar.getInstance();
		int datenum=c.get(Calendar.DATE);
		if(datenum < 6){
			throw new BusiException(AcctMgrError.getErrorCode("8078", "00002"), "本月五号以后才能划拨！");
		}
		
		// 获取入参信息
		S8078InitInDTO inDto = (S8078InitInDTO)inParam;
		long contractNo = inDto.getContractNo();
		
		//获取统付账户信息
		Map<String,Object> groupInfo = new HashMap<String,Object>();
		Map<String,Object> acctBookMap = new HashMap<String,Object>();
		long idNo = 0;
		String phoneNo = "";
		String groupName = "";
		try {
			UserInfoEntity baseinfo = (UserInfoEntity)user.getUserEntityByConNo(contractNo, true);
			idNo = baseinfo.getIdNo();
			phoneNo = baseinfo.getPhoneNo();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ContractInfoEntity cie = account.getConInfo(contractNo);
		String accountType = cie.getContractattType();
		long custId = cie.getCustId();
		long curBalance = 0;
		
		log.info("类型————————————>"+ accountType);
		if(!(accountType.equals("1") || accountType.equals("A"))){
			throw new BusiException(AcctMgrError.getErrorCode("8078", "00001"), "不是统付账号或一点支付账号");
		}
		if(idNo != 0){
			groupInfo = user.getUrGrpInfo(idNo);
			groupName = (String)groupInfo.get("GROUP_NAME");
			groupName = control.pubEncryptData(groupName, 1);
		}else{
			groupName = "无";
		}
		
		//获取账户预存
		acctBookMap.put("CONTRACT_NO", contractNo);
		acctBookMap.put("PAY_TYPE", "0"); //支付账户预存只从现金账本划拨
		List<Map<String,Object>> acctBook = balance.getAcctBookList(acctBookMap);
		for (Map<String, Object> specMap : acctBook) {
			curBalance += Long.parseLong(specMap.get("CUR_BALANCE").toString());
		}
		
		//获取省内一点支付和集团统付账户二级账户列表
		List<CsAccountRelEntity> listRelCon = account.getAccountRelList(contractNo,"9", "2");
		int relConSize = listRelCon.size();//二级账户数目
		List<GroupRelConInfo> relConList = new ArrayList<GroupRelConInfo>();
		for(CsAccountRelEntity accountEnt : listRelCon){
			GroupRelConInfo relConInfo = new GroupRelConInfo();
			long relCon = accountEnt.getRelContractNo();
			long payValue = accountEnt.getPayValue();
			
			//已销户用户不能做划拨
			UserInfoEntity userInfoEnt = user.getUserEntityByConNo(relCon, false);
			if(userInfoEnt == null){
				throw new BusiException(AcctMgrError.getErrorCode("8078", "00004"), relCon+"是已销户用户,不能做划拨");
			}
			
			//判断是否是合约计划-集团版用户，如果是，不做划拨
			boolean IsBilltotcodeUser = user.IsBilltotcodeUser(contractNo, relCon);
			if(IsBilltotcodeUser){
				throw new BusiException(AcctMgrError.getErrorCode("8078", "00003"), "合约计划-集团版用户不允许做划拨");
			}
			
			//剔除已支付账户
			boolean isPayOrNot = balance.deleteHavePayCon(contractNo, relCon);
			log.info("中断标志:"+isPayOrNot);
			if(isPayOrNot){
				log.info("进入中断");
				continue;
			}
			
			//获取二级账户用户信息
			UserInfoEntity relUserInfo = user.getUserEntityByConNo(relCon, true);
			String relPhoneNo = relUserInfo.getPhoneNo();
			long relCustId = relUserInfo.getCustId();
			UserDetailEntity userDetail = user.getUserdetailEntity(relUserInfo.getIdNo());
			String runName = userDetail.getRunName();
			
			//获取二级账户余额
			OutFeeData outFee = remainFee.getConRemainFee(relCon);
			long remainFee = outFee.getRemainFee();
			
			//获取客户姓名
			CustInfoEntity custEnt = cust.getCustInfo(relCustId, null);
			String conEncrypName = custEnt.getCustName();
			
			relConInfo.setRelCon(relCon);
			relConInfo.setRunName(runName);
			relConInfo.setRemainFee(ValueUtils.transFenToYuan(remainFee));
			relConInfo.setPayValue(payValue);
			relConInfo.setRelPhoneNo(relPhoneNo);
			relConInfo.setConEncrypName(conEncrypName);
			relConList.add(relConInfo);
			
		}
		
		S8078InitOutDTO outDto = new S8078InitOutDTO();
		String typeName = "";
		if(accountType.equals("1")){
			typeName = "集团统付帐户";
		}else if(accountType.equals("A")){
			typeName = "一点支付账户";
		}
		
		outDto.setAccountType(typeName);
		outDto.setCurBalance(curBalance);
		outDto.setCustId(custId);
		outDto.setPhoneNo(phoneNo);
		outDto.setGroupName(groupName);
		outDto.setRelConList(relConList);
		log.info("8078----------->"+outDto.toJson());
		log.info("relConList------>"+relConList.toString());
		return outDto;
	}

	@Override
	public OutDTO cfm(InDTO inParam) {
		
		Map<String,Object> inTransCfmMap = null;
		String totalDate = ""; // 转账日期
		String curYM = "";
		
		// TODO Auto-generated method stub
		S8078CfmInDTO inDto = (S8078CfmInDTO)inParam;
		String provinceId = inDto.getProvinceId();
		String opType = inDto.getOpType();
		String groupId = inDto.getGroupId();
		String loginNo = inDto.getLoginNo();
		String opCode = inDto.getOpCode();
		String opNote = inDto.getOpNote();
		String payPath = inDto.getPayPath();
		String payMethod = inDto.getPayMethod();
		long shouldPay = inDto.getShouldPay();
		long outContractNo = inDto.getOutContractNo();
		long outPhoneNo = inDto.getOutPhoneNo();
		long outIdNo = 0;
		String outBrandId = "";
		String outPhoneNoStr = String.valueOf(outPhoneNo);
		List<GroupRelConInfo> relConList = inDto.getRelConList();
		long foreignSn = control.getSequence("SEQ_PAY_SN");
		String foreignSnStr = String.valueOf(foreignSn);
		
		/* 获取当前日期 */
		String curTime = control.getSysDate().get("CUR_TIME").toString();
		totalDate = curTime.substring(0, 8);
		curYM = curTime.substring(0, 6);
		String vYear = curTime.substring(0,4);
		String vMonth = curTime.substring(4,6);
		
		/*入账实体设值*/
		PayBookEntity bookIn = new PayBookEntity();
		bookIn.setBeginTime(curTime);
		bookIn.setForeignSn(foreignSnStr);
		bookIn.setGroupId(groupId);
		bookIn.setLoginNo(loginNo);
		bookIn.setOpCode(opCode);
		bookIn.setPayMethod("A");
		bookIn.setPayPath(payPath);
		bookIn.setFactorOne("1");
		bookIn.setTotalDate(Integer.parseInt(totalDate));
		bookIn.setYearMonth(Long.parseLong(curYM));
		
		//转账类型
		ITransType transType = transFactory.createTransFactory("TransAccountGrp",true);
		
		//获取转出账户信息
		PayUserBaseEntity outTransBaseInfo = new PayUserBaseEntity();
		ContractInfoEntity outContractEnt = account.getConInfo(outContractNo);
		String outUserGroupId = outContractEnt.getGroupId();
		String contractattType = outContractEnt.getContractattType();
		if(contractattType.equals("A")){
			outTransBaseInfo.setPhoneNo("99999999999");
			outTransBaseInfo.setBrandId("2330XX");
			outTransBaseInfo.setIdNo(0);
			outTransBaseInfo.setRegionId(null);
		}else if(contractattType.equals("1")){
			PayUserBaseEntity outBaseInfo = getUserBaseInfo(String.valueOf(outPhoneNo), outContractNo, true, provinceId);
			outTransBaseInfo.setPhoneNo(outBaseInfo.getPhoneNo());
			outTransBaseInfo.setBrandId(outBaseInfo.getBrandId());
			outTransBaseInfo.setIdNo(outBaseInfo.getIdNo());
			outTransBaseInfo.setRegionId(outBaseInfo.getRegionId());
			outIdNo = outBaseInfo.getIdNo();
			outBrandId = outBaseInfo.getBrandId();
		}
		outTransBaseInfo.setContractNo(outContractNo);
		outTransBaseInfo.setUserGroupId(outUserGroupId);
		outTransBaseInfo.setNetFlag(true);
		for(GroupRelConInfo gce:relConList){
			String phoneNo=gce.getRelPhoneNo();
			long payMoney=gce.getPayValue();
			long contractNo=gce.getRelCon();
			opNote = outContractNo +"向"+contractNo+"转账"+payMoney/100+"元";
			bookIn.setOpNote(opNote);;
			bookIn.setPayFee(payMoney);
			//获取转入账户信息
			PayUserBaseEntity inTransBaseInfo = getUserBaseInfo(phoneNo, contractNo, true, provinceId);
			
			//获取账户类型
			ContractInfoEntity cie = account.getConInfo(outContractNo);
			String contractType = cie.getContractattType();
		
			//获取被支付账户滞纳金优惠率
			long delayFavourRate = 0;
			
			inTransCfmMap = new HashMap<String, Object>();
			safeAddToMap(inTransCfmMap, "Header", inDto.getHeader());
			safeAddToMap(inTransCfmMap, "TRANS_TYPE_OBJ", transType); //转账类型实例化对象
			safeAddToMap(inTransCfmMap, "TRANS_IN", inTransBaseInfo);  //转入账户基本信息
			safeAddToMap(inTransCfmMap, "TRANS_OUT", outTransBaseInfo); //转出账户基本信息
			if(contractType.equals("1")){
				safeAddToMap(inTransCfmMap, "OP_TYPE", opType); //转账类型
			}else{
				safeAddToMap(inTransCfmMap, "OP_TYPE", "YDZF"); 
				bookIn.setFactorOne("0");
			}
			safeAddToMap(inTransCfmMap, "BOOK_IN", bookIn); //入账实体
			
			
				
			/*转账*/
			long transSn = payManage.transBalance(inTransCfmMap);
			
			/*缴费扩展表录入政企客户信息*/
			if(outBrandId.equals("2310ZQ")){
				Map<String,Object> zqMap = new HashMap<String,Object>();
				zqMap.put("PAY_SN", transSn);
				zqMap.put("CUST_ID", outContractEnt.getCustId());
				zqMap.put("OUT_CONTRACT_NO", outContractNo);
				zqMap.put("IN_CONTRACT_NO", contractNo);
				zqMap.put("ID_NO", outIdNo);
				zqMap.put("OP_CODE", opCode);
				zqMap.put("LOGIN_NO", loginNo);
				zqMap.put("FOREIGN_SN", foreignSn);
				zqMap.put("HEADER", inDto.getHeader());
				payManage.insertZQInfo(zqMap);
			}
			
			//用户冲销欠费
			inTransCfmMap = new HashMap<String, Object>();
			safeAddToMap(inTransCfmMap, "Header", inDto.getHeader());
			safeAddToMap(inTransCfmMap, "CONTRACT_NO",contractNo);
			safeAddToMap(inTransCfmMap, "PAY_SN", transSn);
			safeAddToMap(inTransCfmMap, "PHONE_NO", phoneNo);
			safeAddToMap(inTransCfmMap, "LOGIN_NO", bookIn.getLoginNo());
			safeAddToMap(inTransCfmMap, "OP_CODE", bookIn.getOpCode());
			safeAddToMap(inTransCfmMap, "GROUP_ID", bookIn.getGroupId());
			safeAddToMap(inTransCfmMap, "PAY_PATH", bookIn.getPayPath());
			safeAddToMap(inTransCfmMap, "DELAY_FAVOUR_RATE", "0");
			writeOffer.doWriteOff(inTransCfmMap);
			
			//实时开机
			payOpener.doConUserOpen(inDto.getHeader(), inTransBaseInfo, bookIn, inDto.getProvinceId());
			
			//发送短信
			if(contractType.equals("1")){
				Map<String,Object> inMap = new HashMap<String,Object>();
				inMap.put("vYear", vYear);
				inMap.put("vMonth", vMonth);
				inMap.put("PAY_MONEY", payMoney);
				inMap.put("LOGIN_NO", loginNo);
				inMap.put("OP_CODE", opCode);
				inMap.put("PHONE_NO", phoneNo);
				sendMessage(inMap);
			}
			//记录营业员操作日志
			/* 转出号码：记录营业员操作日志 */
			LoginOprEntity outTransOpr = new LoginOprEntity();
			outTransOpr.setBrandId(outTransBaseInfo.getBrandId());
			outTransOpr.setIdNo(outTransBaseInfo.getIdNo());
			outTransOpr.setLoginGroup(groupId);
			outTransOpr.setLoginNo(loginNo);
			outTransOpr.setLoginSn(transSn);
			outTransOpr.setOpCode(opCode);
			outTransOpr.setOpTime(curTime);
			outTransOpr.setPayFee((-1) * payMoney);
			outTransOpr.setPhoneNo(outTransBaseInfo.getPhoneNo());
			outTransOpr.setRemark(opNote);
			outTransOpr.setPayType("A");
			outTransOpr.setTotalDate(Integer.parseInt(totalDate));
			record.saveLoginOpr(outTransOpr);
			
			/* 转入号码：记录营业员操作日志 */
			LoginOprEntity inTransOpr = new LoginOprEntity();
			outTransOpr.setBrandId(inTransBaseInfo.getBrandId());
			outTransOpr.setIdNo(inTransBaseInfo.getIdNo());
			outTransOpr.setLoginGroup(groupId);
			outTransOpr.setLoginNo(loginNo);
			outTransOpr.setLoginSn(transSn);
			outTransOpr.setOpCode(opCode);
			outTransOpr.setOpTime(curTime);
			outTransOpr.setPayFee(payMoney);
			outTransOpr.setPhoneNo(inTransBaseInfo.getPhoneNo());
			outTransOpr.setRemark(opNote);
			outTransOpr.setPayType("A");
			outTransOpr.setTotalDate(Integer.parseInt(totalDate));
			record.saveLoginOpr(outTransOpr);
			
			/* 转入用户发送统一接触消息 */
			inTransCfmMap = new HashMap<String, Object>();
			safeAddToMap(inTransCfmMap, "Header", inDto.getHeader());
			safeAddToMap(inTransCfmMap, "PAY_SN", transSn);
			safeAddToMap(inTransCfmMap, "LOGIN_NO", loginNo);
			safeAddToMap(inTransCfmMap, "GROUP_ID", groupId);
			safeAddToMap(inTransCfmMap, "OP_CODE", opCode);
			safeAddToMap(inTransCfmMap, "OP_NOTE", opNote);
			safeAddToMap(inTransCfmMap, "CUST_ID_TYPE", "1");
			safeAddToMap(inTransCfmMap, "CUST_ID_VALUE", inTransBaseInfo.getPhoneNo());
			safeAddToMap(inTransCfmMap, "OP_TIME", curTime);
			preOrder.sendOprCntt(inTransCfmMap);
			
			/* 转出用户发送统一接触消息 */
			inTransCfmMap = new HashMap<String, Object>();
			safeAddToMap(inTransCfmMap, "Header", inDto.getHeader());
			safeAddToMap(inTransCfmMap, "PAY_SN", transSn);
			safeAddToMap(inTransCfmMap, "LOGIN_NO", loginNo);
			safeAddToMap(inTransCfmMap, "GROUP_ID", groupId);
			safeAddToMap(inTransCfmMap, "OP_CODE", opCode);
			safeAddToMap(inTransCfmMap, "OP_NOTE", opNote);
			safeAddToMap(inTransCfmMap, "CUST_ID_TYPE", "1");
			safeAddToMap(inTransCfmMap, "CUST_ID_VALUE", outTransBaseInfo.getPhoneNo());
			safeAddToMap(inTransCfmMap, "OP_TIME", curTime);
			preOrder.sendOprCntt(inTransCfmMap);
			
		}
		
		
		
		S8078CfmOutDTO outDto = new S8078CfmOutDTO();
		return outDto;
	}
	
	/* 获取用户基本信息 */
	private PayUserBaseEntity getUserBaseInfo(String inPhoneNo, long inContractNo, boolean isTransInFlag, String provinceId) {
		String phoneNo = inPhoneNo;
		long contractNo = inContractNo;
		String conGroup="";
		
		log.info("getUserBaseInfo-->phoneNo:"+phoneNo+",contractNo"+ contractNo);
		
		long idNo = 0;
		String brandId = "";

		/* 获取用户信息 */
		UserInfoEntity  userEntity = user.getUserInfo(phoneNo);
		idNo = userEntity.getIdNo();
		if (contractNo == 0) {
			contractNo = userEntity.getContractNo();
		}
		brandId = userEntity.getBrandId();
			
		/*获取账户信息*/
		ContractInfoEntity conEntity = account.getConInfo(inContractNo);
		conGroup=conEntity.getGroupId();

		//查询账户地市归属信息
		ChngroupRelEntity groupEntity = group.getRegionDistinct(conGroup, "2", provinceId);
		String regionId = groupEntity.getRegionCode();
		
		// 出参信息
		PayUserBaseEntity userBaseInfo = new PayUserBaseEntity();
		userBaseInfo.setBrandId(brandId);
		userBaseInfo.setContractNo(contractNo);
		userBaseInfo.setIdNo(idNo);
		userBaseInfo.setPhoneNo(phoneNo);
		userBaseInfo.setRegionId(regionId);
		userBaseInfo.setUserGroupId(conGroup);
		userBaseInfo.setNetFlag(true);
		
		return userBaseInfo;
	}
	
	public void sendMessage(Map<String,Object> inMap){
		String vYear = (String)inMap.get("vYear");
		String vMonth = (String)inMap.get("vMonth");
		long payMoney = (long)inMap.get("PAY_MONEY");
		String phoneNo = (String)inMap.get("PHONE_NO");
		String loginNo = (String)inMap.get("LOGIN_NO");
		String opCode = (String)inMap.get("OP_CODE");
		Map<String, Object> mapTmp = new HashMap<String, Object>();
		MBean inMessage = new MBean();
		
		/*
		 * 尊敬的客户您好，您所在集团的统一付费账户于${year}年${month}月为您支付话费${pay_money}元。
		 * 详询客户经理${vManagerName}，电话${vManagerPhone}。【中国移动】${sms_release} 
		 */
		
		mapTmp.put("year", vYear);
		mapTmp.put("month",vMonth);
		mapTmp.put("pay_money",ValueUtils.transFenToYuan(payMoney));
		mapTmp.put("vManagerName", "");
		mapTmp.put("vManagerPhone", "");
		mapTmp.put("sms_release", "");
		
		inMessage.addBody("PHONE_NO", phoneNo);
		inMessage.addBody("LOGIN_NO", loginNo);;
		inMessage.addBody("OP_CODE", opCode);
		inMessage.addBody("CHECK_FLAG", true);
		inMessage.addBody("TEMPLATE_ID", "311200807801");
		inMessage.addBody("DATA", mapTmp);
		log.info("发送短信内容：" + inMessage.toString());
		
		String flag = control.getPubCodeValue(2011, "DXFS", null);  // 0:直接发送 1:插入短信接口临时表 2：外系统有问题，直接不发送短信
		if(flag.equals("0")){
			inMessage.addBody("SEND_FLAG", 0);
		}else if(flag.equals("1")){
			inMessage.addBody("SEND_FLAG", 1);
		}else if(flag.equals("2")){
			return;
		}
		
		shortMessage.sendSmsMsg(inMessage, 1);
		
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
	 * @return the payManage
	 */
	public IPayManage getPayManage() {
		return payManage;
	}

	/**
	 * @param payManage the payManage to set
	 */
	public void setPayManage(IPayManage payManage) {
		this.payManage = payManage;
	}

	/**
	 * @return the writeOffer
	 */
	public IWriteOffer getWriteOffer() {
		return writeOffer;
	}

	/**
	 * @param writeOffer the writeOffer to set
	 */
	public void setWriteOffer(IWriteOffer writeOffer) {
		this.writeOffer = writeOffer;
	}

	/**
	 * @return the payOpener
	 */
	public IPayOpener getPayOpener() {
		return payOpener;
	}

	/**
	 * @param payOpener the payOpener to set
	 */
	public void setPayOpener(IPayOpener payOpener) {
		this.payOpener = payOpener;
	}

	/**
	 * @return the transFactory
	 */
	public TransFactory getTransFactory() {
		return transFactory;
	}

	/**
	 * @param transFactory the transFactory to set
	 */
	public void setTransFactory(TransFactory transFactory) {
		this.transFactory = transFactory;
	}

	/**
	 * @return the preOrder
	 */
	public IPreOrder getPreOrder() {
		return preOrder;
	}

	/**
	 * @param preOrder the preOrder to set
	 */
	public void setPreOrder(IPreOrder preOrder) {
		this.preOrder = preOrder;
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

	/**
	 * @return the remainFee
	 */
	public IRemainFee getRemainFee() {
		return remainFee;
	}

	/**
	 * @param remainFee the remainFee to set
	 */
	public void setRemainFee(IRemainFee remainFee) {
		this.remainFee = remainFee;
	}
	
}
