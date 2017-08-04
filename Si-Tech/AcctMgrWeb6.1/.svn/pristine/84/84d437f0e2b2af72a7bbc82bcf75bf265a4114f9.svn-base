package com.sitech.acctmgr.atom.impl.pay;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.busi.adj.inter.IAdjCommon;
import com.sitech.acctmgr.atom.domains.adj.AdjBIllEntity;
import com.sitech.acctmgr.atom.domains.adj.AdjExtendEntity;
import com.sitech.acctmgr.atom.domains.base.LoginEntity;
import com.sitech.acctmgr.atom.domains.pay.PayBookEntity;
import com.sitech.acctmgr.atom.domains.pay.PayUserBaseEntity;
import com.sitech.acctmgr.atom.domains.record.LoginOprEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.domains.user.UserPrcEntity;
import com.sitech.acctmgr.atom.dto.pay.WPrePayCardCfmInDTO;
import com.sitech.acctmgr.atom.dto.pay.WPrePayCardCfmOutDTO;
import com.sitech.acctmgr.atom.dto.pay.WPrePayCardLimitInDTO;
import com.sitech.acctmgr.atom.dto.pay.WPrePayCardLimitOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IAdj;
import com.sitech.acctmgr.atom.entity.inter.IBalance;
import com.sitech.acctmgr.atom.entity.inter.IBill;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.ILogin;
import com.sitech.acctmgr.atom.entity.inter.IProd;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.constant.PayBusiConst;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.acctmgr.inter.pay.IWPrePayCard;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BaseException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.util.DateUtil;


@ParamTypes({ @ParamType(m = "limit", c = WPrePayCardLimitInDTO.class,oc = WPrePayCardLimitOutDTO.class),
	  @ParamType(m = "cfm", c = WPrePayCardCfmInDTO.class,oc = WPrePayCardCfmOutDTO.class)
	}
 )
public class WPrePayCard extends AcctMgrBaseService  implements IWPrePayCard{
	
	private IBalance balance;
	private IAdj adj;
	private IUser user;
	private IBill bill;
	private IControl control;
	private IRecord record;
	private IAdjCommon adjCommon;
	private IProd prod;
	private ILogin login;

	@Override
	public OutDTO limit(InDTO inParam) {
		// TODO Auto-generated method stub
		WPrePayCardLimitInDTO inDto = (WPrePayCardLimitInDTO)inParam;
		long contractNo = inDto.getContractNo();
		double payMoneyY = inDto.getPayFee();
		long payMoney = ValueUtils.transYuanToFen(payMoneyY);
		String phoneNo = inDto.getInPhoneNo();
		String loginNo = inDto.getLoginNo();
		
		//获取当前时间
        String curTime = DateUtil.format(new Date(), PayBusiConst.YYYYMMDDHHMMSS2);
        String yearMonth=String.format("%6s", curTime.substring(0, 6));//当前年月
        int totalDate= Integer.parseInt(String.format("%6s", curTime.substring(0, 8)));
        
        //校验
        check(phoneNo,contractNo,totalDate,yearMonth,payMoney);
        
        WPrePayCardLimitOutDTO outDto= new WPrePayCardLimitOutDTO();
		return outDto;
	}

	@Override
	public OutDTO cfm(InDTO inParam) {
		// TODO Auto-generated method stub
		WPrePayCardCfmInDTO inDto = (WPrePayCardCfmInDTO)inParam;
		
		long contractNo = inDto.getContractNo();
		double payMoneyY = inDto.getPayFee();
		long payMoney = ValueUtils.transYuanToFen(payMoneyY);
		String phoneNo = inDto.getInPhoneNo();
		String remark = inDto.getRemark();
		String loginNo = inDto.getLoginNo();
		String groupId = inDto.getGroupId();
		String opCode = inDto.getOpCode();
		String provinceId = inDto.getProvinceId();
		
		if(StringUtils.isEmptyOrNull(groupId)){
			LoginEntity logEnt = login.getLoginInfo(loginNo, provinceId);
			groupId = logEnt.getGroupId();
		}
		
		//获取当前时间
        String curTime = DateUtil.format(new Date(), PayBusiConst.YYYYMMDDHHMMSS2);
        String yearMonth=String.format("%6s", curTime.substring(0, 6));//当前年月
        int totalDate= Integer.parseInt(String.format("%6s", curTime.substring(0, 8)));
		
        //校验
        Map<String,Object> outMap = new HashMap<String,Object>();
        outMap = check(phoneNo,contractNo,totalDate,yearMonth,payMoney);
        
        long curBalance = Long.parseLong(outMap.get("CUR_BALANCE").toString());
        int billDay = Integer.parseInt(outMap.get("BILL_DAY").toString());
        UserInfoEntity userEnt = (UserInfoEntity) outMap.get("USER_ENT");
        
        /*取补收流水*/
        long paySn=control.getSequence("SEQ_PAY_SN");

        String acctItemCode="";
        /*wlan预付费电子卡账目项*/
        acctItemCode="0B200000wo";
        
        /*取用户主资费*/
        //取用户主产品
        UserPrcEntity userPrcEnt = prod.getUserPrcidInfo(userEnt.getIdNo());
        String prodPrcid = userPrcEnt.getProdPrcid();
        
        
        //用户基本信息实体设值
        PayUserBaseEntity userBase = new PayUserBaseEntity();
        userBase.setContractNo(contractNo);
        userBase.setCustId(userEnt.getCustId());
        userBase.setIdNo(userEnt.getIdNo());
        userBase.setPhoneNo(phoneNo);
        userBase.setBrandId(userEnt.getBrandId());
        userBase.setUserGroupId(userEnt.getGroupId());
        userBase.setProdPrcid(prodPrcid);

        //账单实体设值
        AdjBIllEntity billEnt = new AdjBIllEntity();
        billEnt.setBillCycle(Integer.parseInt(yearMonth));
        billEnt.setNaturalMonth(Integer.parseInt(yearMonth));
        billEnt.setAcctItemCode(acctItemCode);
        billEnt.setShouldPay(payMoney);
        billEnt.setBillDay(billDay);

        //入账实体设值
        PayBookEntity inBook =  new PayBookEntity();
        inBook.setGroupId(groupId);
        inBook.setLoginNo(loginNo);
        inBook.setOpCode(opCode);
        inBook.setOpNote(remark);
        inBook.setPaySn(paySn);

        
        long billId = control.getSequence("SEQ_BILL_ID");
        billEnt.setBillId(billId);
        
        //补收核心函数
        Map inAdjMap = new HashMap<String, Object>();
        inAdjMap.put("Header", inDto.getHeader());
        inAdjMap.put("PAY_BOOK_ENTITY", inBook);
        inAdjMap.put("ADJ_BILL_ENTITY", billEnt);
        inAdjMap.put("PAY_USER_BASE_ENTITY", userBase);
        inAdjMap.put("PROVINCE_ID", provinceId);
        inAdjMap.put("BILL_ID", billId);

        Map<String, Object> outParamMap = adjCommon.MicroAdj(inAdjMap);

        //补收记录表
        AdjExtendEntity adjExtendEnt = new AdjExtendEntity();
      	adjExtendEnt.setAdjFlag("0");
      	adjExtendEnt.setLoginNo(loginNo);
      	adjExtendEnt.setOffFlag("");
      	adjExtendEnt.setOpCode(opCode);
      	adjExtendEnt.setOpSn(paySn);
      	adjExtendEnt.setRemark(remark);
      	adjExtendEnt.setBillId(billId);
        
        //记录补收信息
		adj.saveAcctAdjOweInfo(billEnt, adjExtendEnt);

        //记录营业员操作记录表
        LoginOprEntity loginOprEnt = new LoginOprEntity();
        loginOprEnt.setBrandId(userBase.getBrandId());
        loginOprEnt.setIdNo(userBase.getIdNo());
        loginOprEnt.setLoginGroup(groupId);
        loginOprEnt.setLoginNo(loginNo);
        loginOprEnt.setLoginSn(paySn);
        loginOprEnt.setOpCode(opCode);
        loginOprEnt.setOpTime(curTime);
        loginOprEnt.setPayFee(payMoney);
        loginOprEnt.setPhoneNo(phoneNo);
        loginOprEnt.setRemark("wlan预付费扣款");
        loginOprEnt.setPayType("0");
        loginOprEnt.setTotalDate(totalDate);
        record.saveLoginOpr(loginOprEnt);
        		
		WPrePayCardCfmOutDTO outDto = new WPrePayCardCfmOutDTO();
		return outDto;
	}
	
	
	
	private Map<String,Object> check(String phoneNo,long contractNo,int totalDate,String yearMonth,long payMoney){
		
		
        //出账期间无法办理
        
        //存在往月欠费，无法办理
     	boolean isOwe = bill.isUnPayOwe(contractNo);
     	if (isOwe) {
     		log.info("用户有欠费");
     		throw new BaseException(AcctMgrError.getErrorCode("C240", "00004"),"用户往月有欠费，无法办理该业务！");
     	}
        
        /*取用户信息*/
        UserInfoEntity userEnt = user.getUserInfo(phoneNo);
        long idNo = userEnt.getIdNo();
        
        Map bookMap = new HashMap();
        bookMap.put("SPECIAL_FLAG", "0");
        bookMap.put("TRANS_FLAG", "0");
        bookMap.put("CONTRACT_NO", contractNo);
        bookMap.put("QUERY_TIME", totalDate);
        List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
        resultList = balance.getAcctBookList(bookMap);
        
        long curBalance = 0L;
        for(Map<String, Object> resultMap:resultList){
        	curBalance += Long.parseLong(resultMap.get("CUR_BALANCE").toString());
        }
        if(curBalance<payMoney){
        	throw new BaseException(AcctMgrError.getErrorCode("C240", "00005"),"用户可用余额不足,请充值后再办理！");
        }
	 	
        long adjFee = 0L;
        Map<String,Object> monthFeeMap = new HashMap<String,Object>();
        monthFeeMap.put("CONTRACT_NO", contractNo);
        monthFeeMap.put("ID_NO", idNo);
        monthFeeMap.put("YEAR_MONTH", yearMonth);
        adjFee = adj.getMonthFee(monthFeeMap);
        if(adjFee+payMoney > 20000){
        	throw new BaseException(AcctMgrError.getErrorCode("C240", "00006"),"用户当月扣费总金额大于200元，无法再次办理！");
        }
        
        /*取账单bill_day*/
        Map<String, Object> inAdjMap = new HashMap<String, Object>();
        inAdjMap.put("CONTRACT_NO",contractNo);
        inAdjMap.put("BILL_CYCLE",yearMonth);
        inAdjMap.put("BILL_DAY_BEGIN","8000");
        inAdjMap.put("BILL_DAY_END","8500");
        inAdjMap.put("SUFFIX",yearMonth);
        int billDay=bill.getMaxBillDay(inAdjMap);
        
        Map<String,Object> resultMap = new HashMap<String,Object>();
        resultMap.put("CUR_BALANCE", curBalance);
        resultMap.put("BILL_DAY", billDay);
        resultMap.put("USER_ENT", userEnt);
        
        return resultMap;
	}

	public IBalance getBalance() {
		return balance;
	}

	public void setBalance(IBalance balance) {
		this.balance = balance;
	}

	public IAdj getAdj() {
		return adj;
	}

	public void setAdj(IAdj adj) {
		this.adj = adj;
	}

	public IUser getUser() {
		return user;
	}

	public void setUser(IUser user) {
		this.user = user;
	}

	public IBill getBill() {
		return bill;
	}

	public void setBill(IBill bill) {
		this.bill = bill;
	}

	public IControl getControl() {
		return control;
	}

	public void setControl(IControl control) {
		this.control = control;
	}

	public IRecord getRecord() {
		return record;
	}

	public void setRecord(IRecord record) {
		this.record = record;
	}

	public IAdjCommon getAdjCommon() {
		return adjCommon;
	}

	public void setAdjCommon(IAdjCommon adjCommon) {
		this.adjCommon = adjCommon;
	}

	public IProd getProd() {
		return prod;
	}

	public void setProd(IProd prod) {
		this.prod = prod;
	}

	public ILogin getLogin() {
		return login;
	}

	public void setLogin(ILogin login) {
		this.login = login;
	}

}
