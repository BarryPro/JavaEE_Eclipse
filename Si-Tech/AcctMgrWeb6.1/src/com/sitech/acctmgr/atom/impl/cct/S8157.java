package com.sitech.acctmgr.atom.impl.cct;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.MapUtils;

import com.sitech.acctmgr.atom.busi.pay.inter.IPreOrder;
import com.sitech.acctmgr.atom.busi.query.inter.IRemainFee;
import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.cct.CreditAdjEntity;
import com.sitech.acctmgr.atom.domains.cct.CreditChgHisEntity;
import com.sitech.acctmgr.atom.domains.cct.CreditDetailEntity;
import com.sitech.acctmgr.atom.domains.cct.CreditInfoEntity;
import com.sitech.acctmgr.atom.domains.cct.CreditListEntity;
import com.sitech.acctmgr.atom.domains.cust.CustInfoEntity;
import com.sitech.acctmgr.atom.domains.fee.OutFeeData;
import com.sitech.acctmgr.atom.domains.record.LoginOprEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.cct.S8157CfmInDTO;
import com.sitech.acctmgr.atom.dto.cct.S8157CfmOutDTO;
import com.sitech.acctmgr.atom.dto.cct.S8157CreditCfmInDTO;
import com.sitech.acctmgr.atom.dto.cct.S8157CreditCfmOutDTO;
import com.sitech.acctmgr.atom.dto.cct.S8157InitInDTO;
import com.sitech.acctmgr.atom.dto.cct.S8157InitOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBalance;
import com.sitech.acctmgr.atom.entity.inter.IBill;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.ICredit;
import com.sitech.acctmgr.atom.entity.inter.ICust;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.IProd;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.inter.cct.I8157;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.util.DateUtil;

@ParamTypes({ 
	@ParamType(c=S8157InitInDTO.class,m="init",oc=S8157InitOutDTO.class),
	@ParamType(c=S8157CfmInDTO.class,m="cfm",oc=S8157CfmOutDTO.class),
	@ParamType(c=S8157CreditCfmInDTO.class,m="creditCfm",oc=S8157CreditCfmOutDTO.class)
})
public class S8157 extends AcctMgrBaseService implements I8157 {

	protected IUser user;
	protected IBalance balance;
	protected IBill bill;
	protected ICredit credit;
	protected ICust cust;
	protected IProd prod;
	protected IControl control;
	protected IRecord record;
	protected IGroup group;
	protected IPreOrder preOrder;
	protected IRemainFee remainFee;
	
	private static final String MAINCREDIT="主得分";
	private static final String ADDCREDIT="加分项";
	private static final String MINYSCREDIT="减分项";
	

	@Override
	public OutDTO init(final InDTO inParam) {
		S8157InitInDTO sCreditQryInDTO = (S8157InitInDTO) inParam;
		S8157InitOutDTO sCreditQryOutDTO = new S8157InitOutDTO();
		Map<String, Object> outMapTmp = null;
		List<CreditListEntity> list = new ArrayList<CreditListEntity>();
		Map<String, Object> inMapTmp=new HashMap<String, Object>();

		String phoneNo = sCreditQryInDTO.getPhoneNo();
		Map<String, Object> inMapParam = new HashMap<String, Object>();
		inMapParam.put("PHONE_NO", phoneNo);
		
		long totalOwe = 0;

		// 获取用户信息
		UserInfoEntity uie = user.getUserInfo(phoneNo);
		String groupId=uie.getGroupId();
		long lIdNo = uie.getIdNo();
		long contractNo = uie.getContractNo();
		String brandName = uie.getBrandName();
		String onLineTime = uie.getOpenTime().substring(0, 4) + "/" + uie.getOpenTime().substring(4, 6) + "/" + uie.getOpenTime().substring(6, 8);
		String runName = uie.getRunName();
		
		//取用户归属地市
		ChngroupRelEntity cgre=group.getRegionDistinct(groupId, "2", sCreditQryInDTO.getProvinceId());
		String sRegionCode = cgre.getRegionCode();
		String regionName = cgre.getRegionName();
		
		//取当前预存
		inMapParam.put("CONTRACT_NO", contractNo);
		long prepay = balance.getAcctBookSum(contractNo, "");
		
		//取欠费
		OutFeeData outFee = remainFee.getConRemainFee(contractNo);
		totalOwe = outFee.getOweFee();

		//取客户名称
		CustInfoEntity cie = cust.getCustInfo(uie.getCustId(), "");				
		String custName = cie.getBlurCustName();
		
		Map<String, Object> creditMap = null;		
		creditMap = credit.getCreditInfo(lIdNo);
		
		//取等级名称
		String creditName ="暂未享受星级";
		if(StringUtils.isNotEmpty((String)creditMap.get("CREDIT_NAME"))){
			creditName = creditMap.get("CREDIT_NAME").toString().trim();
		}		
		
		//取信誉度
		long overFee = 0;
		if(StringUtils.isNotEmpty(creditMap.get("OVER_FEE").toString())) {
			overFee = Long.parseLong(creditMap.get("OVER_FEE").toString());	
		}
		
		//取用户星级信誉度
		String starCredit = "-1";
		CreditInfoEntity creditEnt = credit.getCreditInfoByIdNo(lIdNo, "1");
		if(creditEnt!=null) {
			starCredit = creditEnt.getCreditClass();
		}		

		// 信用度列表
		list = (List<CreditListEntity>) creditMap.get("CREDIT_LIST");
		
		//增加明细展示
	    List<CreditDetailEntity> maincreditDetailList=new ArrayList<CreditDetailEntity>();
	    List<CreditDetailEntity> addcreditDetailList=new ArrayList<CreditDetailEntity>();
	    List<CreditDetailEntity> minscreditDetailList=new ArrayList<CreditDetailEntity>();
		inMapParam =new HashMap<String, Object>(); 
		MapUtils.safeAddToMap(inMapParam, "ID_NO", lIdNo);
		List<CreditDetailEntity>  creditDetailList = credit.qCreditDetail(inMapParam);
        Map<String, String> cfgMap =initCfgMap();
        for(CreditDetailEntity ccdEntity:creditDetailList){
            String codeType=ccdEntity.getCodeType();
            if(cfgMap.containsKey(codeType)){
            	ccdEntity.setCodeType(MapUtils.getString(cfgMap, codeType));
                if(MAINCREDIT.equals(MapUtils.getString(cfgMap, codeType))){
                    maincreditDetailList.add(ccdEntity);
                }else if(ADDCREDIT.equals(MapUtils.getString(cfgMap, codeType))){
                    addcreditDetailList.add(ccdEntity);
                }else if(MINYSCREDIT.equals(MapUtils.getString(cfgMap, codeType))){
                    minscreditDetailList.add(ccdEntity);
                }else{
                    log.error("codeType --> "+codeType+" ------->无信誉度配置，请增加配置 !");
                }
            }
        }
        creditDetailList = new ArrayList<CreditDetailEntity>();
        if(maincreditDetailList.size()!=0)
        creditDetailList.addAll(maincreditDetailList);
        if(addcreditDetailList.size()!=0)
        creditDetailList.addAll(addcreditDetailList);
        if(minscreditDetailList.size()!=0)
        creditDetailList.addAll(minscreditDetailList);
        
		//增加历史信息展示
	    List<CreditChgHisEntity>  creditHisList = credit.qCreditchgHis(lIdNo);
		
		sCreditQryOutDTO.setPhoneNo(phoneNo);
		sCreditQryOutDTO.setIdNo(lIdNo);
		sCreditQryOutDTO.setCustName(custName);
		sCreditQryOutDTO.setBrandName(brandName);
		sCreditQryOutDTO.setRegionId(sRegionCode);
		sCreditQryOutDTO.setRegionName(regionName);
		sCreditQryOutDTO.setOnline_time(onLineTime);
		sCreditQryOutDTO.setPrepayFee(prepay);
		sCreditQryOutDTO.setTotalOwe(totalOwe);
		sCreditQryOutDTO.setOverFee(overFee);
		sCreditQryOutDTO.setCreditName(creditName);
		sCreditQryOutDTO.setRunName(runName);
		sCreditQryOutDTO.setCreditList(list);

		//增加明细展示
		sCreditQryOutDTO.setCreditDetailMsg(creditDetailList);
		//增加变更操作明细展示
		sCreditQryOutDTO.setCreditHisList(creditHisList);
		
		sCreditQryOutDTO.setStarCredit(starCredit);

		
		return sCreditQryOutDTO;
	}

	@Override
	public OutDTO cfm(InDTO inParam) {
		// TODO Auto-generated method stub
		Map<String, Object> inMap = new HashMap<String, Object>();
		Map<String, Object> outMap = new HashMap<String, Object>();
		
		String sPhoneNo = "";
		long lIdNo = 0;
		String sCreditClass = "";
		String opNote = "";
		String sLoginNo = "";
		
		String groupId = "";
		int cnt = 0;
		
		S8157CfmInDTO sCreditUpInDto = (S8157CfmInDTO) inParam;			
		
		if (StringUtils.isNotEmptyOrNull(sCreditUpInDto.getPhoneNo())){
			sPhoneNo = sCreditUpInDto.getPhoneNo();			
		}	
		sCreditClass = sCreditUpInDto.getCreditClass();
		if(StringUtils.isNotEmptyOrNull(sCreditUpInDto.getOpNote())){
			opNote=sCreditUpInDto.getOpNote();
		}else {
			opNote = "星级手动调整";
		}
		sLoginNo = sCreditUpInDto.getLoginNo();
		
		//取流水
		long seqNo = control.getSequence("SEQ_INT_DEAL_FLAG");
		
		if(lIdNo==0) {
			// 获取用户信息
			UserInfoEntity uie = user.getUserEntity(null, sPhoneNo, null, false);
			groupId= uie.getGroupId();
			lIdNo = uie.getIdNo();
		}else {
			UserInfoEntity uie = user.getUserEntity(lIdNo, null, null, false);
			sPhoneNo = uie.getPhoneNo();
			groupId=uie.getGroupId();
		}
		
		inMap.put("GROUP_ID", groupId);
		ChngroupRelEntity cgre=group.getRegionDistinct(groupId, "2", sCreditUpInDto.getProvinceId());
		String sRegionCode=cgre.getRegionCode();
		
		inMap.put("ID_NO", lIdNo);
		//inMap.put("VALID_FLAG", "1"); //星级修改和信用度是否取消无关
		//放开有效期限制
		outMap=credit.qNoDateCreditInfo(inMap);
		cnt=Integer.parseInt(outMap.get("CNT").toString());
		log.debug("=======cnt:"+cnt);
		inMap.put("PHONE_NO", sPhoneNo);
		inMap.put("ID_NO", lIdNo);
		inMap.put("CREDIT_CLASS", sCreditClass);
		inMap.put("REGION_ID", sRegionCode);
		inMap.put("OP_NOTE", opNote);
		inMap.put("LOGIN_NO", sLoginNo);
		//无信誉度星级信息时，新录入
		if(cnt==0) {
			//正常执行星级修改时，不会走到这个if条件中
			log.error("用户无星级信息[phoneNo:" + sPhoneNo + "]");
			
			credit.saveCreditChgHis(inMap);
			credit.saveCreditInfo(inMap);
			
			inMap.put("SEQ_NO", seqNo);
			inMap.put("OP_FLAG", 1);
			inMap.put("CREDIT_FEE", sLoginNo);
			inMap.put("STOP_FLAG", "0");
			inMap.put("OWE_FLAG", "0");
			inMap.put("VALID_FLAG", "1"); //暂时默认新增为开通信用度用户
			inMap.put("SEND_FLAG", "0");
			credit.saveCreditInfoChg(inMap);
		}else {
		    Map<String, Object> ymMap =getYyyymmddDay(1);
		    Map<String, Object> endMap =getYyyymmddDay(3); 
            MapUtils.safeAddToMap(inMap, "START_DAY_STR", ymMap.get("YMD"));
            MapUtils.safeAddToMap(inMap, "END_DAY_STR", endMap.get("YMD"));
            log.info("START_DAY_STR_inMap====>"+inMap);
			credit.saveCreditChgHis(inMap);

			credit.uCreditGrade(inMap);
			
			inMap.put("SEQ_NO", seqNo);
			inMap.put("OP_FLAG", 2);
			inMap.put("CREDIT_FEE", "0");
			inMap.put("STOP_FLAG", "0");
			inMap.put("OWE_FLAG", "0");
			inMap.put("VALID_FLAG", "1");
			inMap.put("SEND_FLAG", "0");
			
			credit.saveCreditInfoChg(inMap);
		}
		

		long lLoginSn = control.getSequence("SEQ_SYSTEM_SN");
		// 记录操作日志
		String sCurDate = DateUtil.format(new Date(), "yyyyMMdd");
		String sSuffix = sCurDate.substring(0, 6);

		LoginOprEntity loe = new LoginOprEntity();
		loe.setLoginSn(lLoginSn);
		loe.setLoginNo(sLoginNo);
		loe.setLoginGroup(sCreditUpInDto.getGroupId());
		loe.setTotalDate(Long.parseLong(sCurDate));
		loe.setIdNo(lIdNo);
		loe.setPhoneNo(sPhoneNo);
		loe.setBrandId("00");
		loe.setPayType("0");
		loe.setPayFee(0);
		loe.setOpCode("8157");
		loe.setRemark(opNote);
		record.saveLoginOpr(loe);
		
		S8157CfmOutDTO sCreditUpdOutDTO = new S8157CfmOutDTO();
		return sCreditUpdOutDTO;
	}
	
	@Override
	public OutDTO creditCfm(InDTO inParam) {

		S8157CreditCfmInDTO inDto = (S8157CreditCfmInDTO)inParam;
		String phoneNo = inDto.getPhoneNo();
		long oldCredit = inDto.getOldCredit();
		long newCredit = inDto.getNewCredit();
		String expireTime = inDto.getExpDate();
		String opNote = inDto.getOpNote();	
		
		//状态判断是否允许做变更
		
		//欠费判断是否允许变更		
		
		//跨地区是否允许做变更
		
		//取用户信息
		UserInfoEntity uie = user.getUserInfo(phoneNo);
		long idNo = uie.getIdNo();
		String groupId = uie.getGroupId();
		String brandId = uie.getBrandId();
		
		//物联网用户不允许做变更
		String addNo="";
		addNo = user.getAddServiceNo(idNo, "16");
		if(StringUtils.isNotEmptyOrNull(addNo)) {
			throw new BusiException(AcctMgrError.getErrorCode("8157", "00009"),"物联网用户不能办理此业务!");
		}
		
		//取系统时间
		String sCurTime = DateUtil.format(new Date(), "yyyyMMddHHmmss");
		String sCurDate = sCurTime.substring(0, 8);
		if(Integer.parseInt(expireTime)<Integer.parseInt(sCurDate)) {
			throw new BusiException(AcctMgrError.getErrorCode("8157", "00011"),"到期时间不能早于当前日期!");
		}
		
		ChngroupRelEntity cgre = group.getRegionDistinct(groupId, "2", inDto.getProvinceId());
		
		long loginAccept=control.getSequence("SEQ_SYSTEM_SN");
		CreditAdjEntity creditAdjEntity = new CreditAdjEntity();
		creditAdjEntity.setIdNo(idNo);
		creditAdjEntity.setOldLimitOwe(oldCredit);
		creditAdjEntity.setNewLimitOwe(newCredit);
		creditAdjEntity.setLoginNo(inDto.getLoginNo());
		creditAdjEntity.setExpireTime(expireTime);
		creditAdjEntity.setLoginAccept(loginAccept);
		creditAdjEntity.setPhoneNo(phoneNo);
		creditAdjEntity.setRegionId(cgre.getRegionCode());
		creditAdjEntity.setOpCode(inDto.getOpCode());
		creditAdjEntity.setOpNote(opNote);
		creditAdjEntity.setStatus("Y");
		
		credit.uDnyCredit(creditAdjEntity);
				
		//同步CRM统一接触
		Map<String, Object> oprCnttMap = new HashMap<String, Object>();
		oprCnttMap.put("Header", inDto.getHeader());
		oprCnttMap.put("PAY_SN", loginAccept);
		oprCnttMap.put("LOGIN_NO", inDto.getLoginNo());
		oprCnttMap.put("GROUP_ID", inDto.getGroupId());
		oprCnttMap.put("OP_CODE", inDto.getOpCode());
		oprCnttMap.put("REGION_ID", cgre.getRegionCode());
		oprCnttMap.put("OP_NOTE", "用户信誉度修改");
		oprCnttMap.put("TOTAL_FEE", 0);
		oprCnttMap.put("CUST_ID_TYPE", "1");
		oprCnttMap.put("CUST_ID_VALUE", phoneNo);
		oprCnttMap.put("OP_TIME", sCurTime);
		preOrder.sendOprCntt(oprCnttMap);
		
		LoginOprEntity loe = new LoginOprEntity();
		loe.setLoginGroup(inDto.getGroupId());
		loe.setLoginNo(inDto.getLoginNo());
		loe.setLoginSn(loginAccept);
		loe.setTotalDate(Long.parseLong(sCurDate));
		loe.setIdNo(idNo);
		loe.setPhoneNo(phoneNo);
		loe.setBrandId(brandId);
		loe.setPayType("00");
		loe.setPayFee(0);
		loe.setOpCode("8157");
		loe.setRemark(opNote);
		record.saveLoginOpr(loe);
		
		S8157CreditCfmOutDTO outDto = new S8157CreditCfmOutDTO();
		outDto.setLoginAccept(String.valueOf(loginAccept));
		outDto.setOpTime(sCurDate);
		return outDto;
	}
	
	private HashMap<String, String>  initCfgMap(){
	    HashMap<String, String> cfgMap =new HashMap<String, String>();
	    MapUtils.safeAddToMap(cfgMap, "02", MAINCREDIT);
	    MapUtils.safeAddToMap(cfgMap, "03", MAINCREDIT);
	    MapUtils.safeAddToMap(cfgMap, "05", ADDCREDIT);
	    MapUtils.safeAddToMap(cfgMap, "06", ADDCREDIT);
	    MapUtils.safeAddToMap(cfgMap, "07", ADDCREDIT);
	    MapUtils.safeAddToMap(cfgMap, "08", ADDCREDIT);
	    MapUtils.safeAddToMap(cfgMap, "09", ADDCREDIT);
	    MapUtils.safeAddToMap(cfgMap, "10", ADDCREDIT);
	    MapUtils.safeAddToMap(cfgMap, "31", MINYSCREDIT);
	    return cfgMap;
	}
	@SuppressWarnings("all")
	public  Map<String, Object> getYyyymmddDay(int index) {
	    
	    DateFormat df =new SimpleDateFormat("yyyyMMdd");   
	    Map ymMap =new HashMap<String, Object>();
        String ymd = "";
        Calendar c = Calendar.getInstance();
        switch (index) {
        case 1:// 第一天
            c.add(Calendar.MONTH, 0);
            c.set(Calendar.DAY_OF_MONTH, 1);
            break;
        case 2:// 最后一天
            c.set(Calendar.DAY_OF_MONTH,
            c.getActualMaximum(Calendar.DAY_OF_MONTH));
            break;
         case 3:// 获取15日
            c.add(Calendar.YEAR,1);
            c.set(Calendar.DAY_OF_MONTH, 15);
            break;
        default:
            break;
        }
        try {
            MapUtils.safeAddToMap(ymMap, "YMD", DateUtil.format(c.getTime(), "yyyyMMdd"));
            MapUtils.safeAddToMap(ymMap, "FIRSTYMDTIME", df.format(c.getTime())+"000001");
            MapUtils.safeAddToMap(ymMap, "LASTYMDTIME", df.format(c.getTime())+"235959");
        } catch (Exception e) {
            log.error("格式转换异常 ：" ,e);
            throw new BusiException(AcctMgrError.getErrorCode("8157", "00010"),
                    "格式转换失败!");
        }
        log.debug("ymMap--->"+ymMap);
        return ymMap;
    }
	
	
	
	
	
	public IUser getUser() {
		return user;
	}

	public void setUser(IUser user) {
		this.user = user;
	}

	public IBalance getBalance() {
		return balance;
	}

	public void setBalance(IBalance balance) {
		this.balance = balance;
	}

	public IBill getBill() {
		return bill;
	}

	public void setBill(IBill bill) {
		this.bill = bill;
	}

	public ICredit getCredit() {
		return credit;
	}

	public void setCredit(ICredit credit) {
		this.credit = credit;
	}

	public ICust getCust() {
		return cust;
	}

	public void setCust(ICust cust) {
		this.cust = cust;
	}

	public IProd getProd() {
		return prod;
	}

	public void setProd(IProd prod) {
		this.prod = prod;
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

	public IGroup getGroup() {
		return group;
	}

	public void setGroup(IGroup group) {
		this.group = group;
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
