package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title:  紅包冲正入参DTO </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author hanfl
 * @version 1.0
 */
public class S8056GrpTrnsBankInDTO extends CommonInDTO{


	/**
	 * 
	 */
	private static final long serialVersionUID = -3341195619624167211L;

	@JSONField(name="PHONE_NO")
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="40",desc="服务号码",memo="略")
	protected String phoneNo;
	
	@JSONField(name="PAY_DATE")
	@ParamDesc(path="BUSI_INFO.PAY_DATE",cons=ConsType.CT001,type="String",len="8",desc="红包充值日期 ",memo="略")
	protected String payDate;
	
	@JSONField(name="PAY_SN")
	@ParamDesc(path="BUSI_INFO.PAY_SN",cons=ConsType.CT001,type="long",len="14",desc="要冲正的缴费流水",memo="略")
	protected long	paySn;

	@JSONField(name="FOREIGN_SN")
	@ParamDesc(path="BUSI_INFO.FOREIGN_SN",cons=ConsType.CT001,type="long",len="14",desc="外部流水",memo="略")
	protected String foreignSn;

	@JSONField(name="GROUP_PHONE_NO")
	@ParamDesc(path="BUSI_INFO.GROUP_PHONE_NO",cons=ConsType.QUES,type="String",len="40",desc="集团号码（虚拟20号码）",memo="略")
	protected String groupPhoneNo;
	
	@JSONField(name="CONTRACT_NO")
	@ParamDesc(path="BUSI_INFO.CONTRACT_NO",cons=ConsType.QUES,type="long",len="100",desc="集团产品账号 ",memo="略")
	protected long contractNo;
	
	@JSONField(name="PAY_PATH")
	@ParamDesc(path="BUSI_INFO.PAY_PATH",cons=ConsType.CT001,type="String",len="5",desc="渠道",
	memo="")
	protected String payPath;
	
	@JSONField(name="PAY_METHOD")
	@ParamDesc(path="BUSI_INFO.PAY_METHOD",cons=ConsType.CT001,type="String",len="5",desc="缴费方式",
	memo="A:转账")
	protected String payMethod;
	
	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.in.InDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		
		if (StringUtils.isEmptyOrNull(opCode)){
			opCode = "8056";//设置默认值
		}
		
		phoneNo = arg0.getBodyStr("BUSI_INFO.PHONE_NO").trim();
		payDate = arg0.getBodyStr("BUSI_INFO.PAY_DATE");
		setPaySn(Long.parseLong(arg0.getStr(getPathByProperName("paySn"))));
		setGroupPhoneNo(arg0.getStr(getPathByProperName("groupPhoneNo")));
		setContractNo(Long.parseLong(arg0.getStr(getPathByProperName("contractNo"))));
		setPayPath(arg0.getStr(getPathByProperName("payPath")));
		setPayMethod(arg0.getStr(getPathByProperName("payMethod")));
		setForeignSn(arg0.getStr(getPathByProperName("foreignSn")));
	}


	/**
	 * @return the phoneNo
	 */
	public String getPhoneNo() {
		return phoneNo;
	}


	/**
	 * @return the payDate
	 */
	public String getPayDate() {
		return payDate;
	}


	/**
	 * @return the paySn
	 */
	public long getPaySn() {
		return paySn;
	}

	/**
	 * @param phoneNo the phoneNo to set
	 */
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}


	/**
	 * @param payDate the payDate to set
	 */
	public void setPayDate(String payDate) {
		this.payDate = payDate;
	}

	/**
	 * @return the contractNo
	 */
	public long getContractNo() {
		return contractNo;
	}


	/**
	 * @param paySn the paySn to set
	 */
	public void setPaySn(long paySn) {
		this.paySn = paySn;
	}


	/**
	 * @param contractNo the contractNo to set
	 */
	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}

	/**
	 * @return the payPath
	 */
	public String getPayPath() {
		return payPath;
	}

	/**
	 * @return the payMethod
	 */
	public String getPayMethod() {
		return payMethod;
	}

	/**
	 * @param payPath the payPath to set
	 */
	public void setPayPath(String payPath) {
		this.payPath = payPath;
	}

	/**
	 * @param payMethod the payMethod to set
	 */
	public void setPayMethod(String payMethod) {
		this.payMethod = payMethod;
	}

	/**
	 * @return the groupPhoneNo
	 */
	public String getGroupPhoneNo() {
		return groupPhoneNo;
	}

	/**
	 * @param groupPhoneNo the groupPhoneNo to set
	 */
	public void setGroupPhoneNo(String groupPhoneNo) {
		this.groupPhoneNo = groupPhoneNo;
	}


	/**
	 * @return the foreignSn
	 */
	public String getForeignSn() {
		return foreignSn;
	}


	/**
	 * @param foreignSn the foreignSn to set
	 */
	public void setForeignSn(String foreignSn) {
		this.foreignSn = foreignSn;
	}

}

