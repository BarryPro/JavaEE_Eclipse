package com.sitech.acctmgr.atom.dto.adj;

import java.util.List;

import com.sitech.acctmgr.atom.domains.adj.BalCustRefundEntity;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8084CfmInDTO  extends CommonInDTO{

	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 2566902080759562607L;
	
	@ParamDesc(path = "BUSI_INFO.BAL_CUSTREFUND_LIST", cons = ConsType.PLUS, type = "compx", len = "1", desc = "sp信息列表", memo = "略")
    private List<BalCustRefundEntity> balCustRefundList;
	
	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.STAR, type = "String", len = "20", desc = "服务号码", memo = "略")
    private String phoneNo;
	@ParamDesc(path = "BUSI_INFO.SUM_FEE", cons = ConsType.STAR, type = "long", len = "40", desc = "实际退费", memo = "略")
    private long sumFee;
	@ParamDesc(path = "BUSI_INFO.PAY_FEE", cons = ConsType.STAR, type = "long", len = "40", desc = "补充退费", memo = "略")
    private long payFee;
	@ParamDesc(path = "BUSI_INFO.SUB_TIME", cons = ConsType.STAR, type = "String", len = "20", desc = "核减时间", memo = "略")
    private String subTime;
	@ParamDesc(path = "BUSI_INFO.SUB_TYPE", cons = ConsType.STAR, type = "String", len = "20", desc = "核减类型", memo = "略")
    private String subType;
	@ParamDesc(path = "BUSI_INFO.BILL_TYPE", cons = ConsType.STAR, type = "String", len = "20", desc = "计费类型", memo = "略")
    private String billType;
	@ParamDesc(path = "BUSI_INFO.BACK_BUSI", cons = ConsType.STAR, type = "String", len = "20", desc = "退费业务", memo = "略")
    private String backBusi;
	@ParamDesc(path = "BUSI_INFO.BACK_TYPE", cons = ConsType.STAR, type = "String", len = "20", desc = "退费种类", memo = "略")
    private String backType;
	@ParamDesc(path = "BUSI_INFO.DOUBLE_FLAG", cons = ConsType.STAR, type = "String", len = "4", desc = "双倍标识", memo = "略")
    private String doubleFlag;
	@ParamDesc(path = "BUSI_INFO.REMARK", cons = ConsType.STAR, type = "String", len = "100", desc = "备注", memo = "略")
    private String remark;
    @ParamDesc(path = "BUSI_INFO.ERR_SERIAL", cons = ConsType.STAR, type = "String", len = "40", desc = "投诉流水", memo = "略")
    private String errSerial;
	
	
	 @Override
	 public void decode(MBean arg0) {
	      super.decode(arg0);
	      setBalCustRefundList(arg0.getList(getPathByProperName("balCustRefundList"),BalCustRefundEntity.class));
	      log.error("balCustRefundList.size+++++++++++++++****"+balCustRefundList.size());
	      if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("sumFee")))){
	    	  sumFee = Long.parseLong(arg0.getStr(getPathByProperName("sumFee")));
	      }
	      if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("payFee")))){
	    	  payFee = Long.parseLong(arg0.getStr(getPathByProperName("payFee")));
	      }
	      
	      subTime = arg0.getStr(getPathByProperName("subTime"));
	      phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
	      subType = arg0.getStr(getPathByProperName("subType"));
	      billType = arg0.getStr(getPathByProperName("billType"));
	      backBusi = arg0.getStr(getPathByProperName("backBusi"));
	      backType = arg0.getStr(getPathByProperName("backType"));
	      doubleFlag = arg0.getStr(getPathByProperName("doubleFlag"));
	      remark = arg0.getStr(getPathByProperName("remark"));
	 }

	public List<BalCustRefundEntity> getBalCustRefundList() {
		return balCustRefundList;
	}

	public void setBalCustRefundList(List<BalCustRefundEntity> balCustRefundList) {
		this.balCustRefundList = balCustRefundList;
	}

	public long getSumFee() {
		return sumFee;
	}

	public void setSumFee(long sumFee) {
		this.sumFee = sumFee;
	}

	public String getSubTime() {
		return subTime;
	}

	public void setSubTime(String subTime) {
		this.subTime = subTime;
	}

	public String getSubType() {
		return subType;
	}

	public void setSubType(String subType) {
		this.subType = subType;
	}

	public void setBillType(String billType) {
		this.billType = billType;
	}

	public String getBackBusi() {
		return backBusi;
	}

	public void setBackBusi(String backBusi) {
		this.backBusi = backBusi;
	}

	public String getBackType() {
		return backType;
	}

	public void setBackType(String backType) {
		this.backType = backType;
	}

	public String getDoubleFlag() {
		return doubleFlag;
	}

	public void setDoubleFlag(String doubleFlag) {
		this.doubleFlag = doubleFlag;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getBillType() {
		return billType;
	}

	public String getErrSerial() {
		return errSerial;
	}

	public void setErrSerial(String errSerial) {
		this.errSerial = errSerial;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public long getPayFee() {
		return payFee;
	}

	public void setPayFee(long payFee) {
		this.payFee = payFee;
	}
	 
	
	 
}
