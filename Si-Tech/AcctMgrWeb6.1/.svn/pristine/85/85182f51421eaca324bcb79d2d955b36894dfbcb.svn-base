package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.fee.OweFeeEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;

/**
 *
 * <p>Title: 托收缴费查询出参DTO  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public class S8030InitOutDTO extends CommonOutDTO{

	private static final long serialVersionUID = 6967555860125863136L;
    
	@JSONField(name="BANK_CODE")
	@ParamDesc(path="BANK_CODE",cons=ConsType.CT001,type="String",len="12",desc="银行代码",memo="略")
	protected String bankCode;
	
	@JSONField(name="BANK_NAME")
	@ParamDesc(path="BANK_NAME",cons=ConsType.CT001,type="String",len="60",desc="银行名称",memo="略")
	protected String bankName;
	
	@JSONField(name="REGION_NAME")
	@ParamDesc(path="REGION_NAME",cons=ConsType.CT001,type="String",len="100",desc="地市名称",memo="略")
	protected String regionName;
	
	@JSONField(name="PAY_FEE")
	@ParamDesc(path="PAY_FEE",cons=ConsType.CT001,type="Long",len="14",desc="托收金额",memo="略")
	protected long payFee;
	
	@JSONField(name="PAY_NUM")
	@ParamDesc(path="PAY_NUM",cons=ConsType.CT001,type="Long",len="6",desc="托收用户数",memo="略")
	protected long payNum;
	
	@JSONField(name="CONTRACT_NAME")
	@ParamDesc(path="CONTRACT_NAME",cons=ConsType.CT001,type="String",len="100",desc="帐户名称",memo="略")
	protected String contractName;
	
	@JSONField(name="ACCOUTN_NO")
	@ParamDesc(path="ACCOUTN_NO",cons=ConsType.CT001,type="String",len="100",desc="客户托收银行帐号",memo="略")
	protected String accountNo;

	@JSONField(name="USERINFO")
	@ParamDesc(path="USERINFO",cons=ConsType.STAR,type="compx",len="",desc="托收账户账单列表",memo="略")
	protected List<OweFeeEntity> oweFeeList = null;
	
	public MBean encode(){
		MBean result = new MBean();
		result.setRoot(getPathByProperName("bankCode"), bankCode);
		result.setRoot(getPathByProperName("bankName"),bankName);
		result.setRoot(getPathByProperName("regionName"),regionName);
		result.setRoot(getPathByProperName("payFee"),payFee);
		result.setRoot(getPathByProperName("payNum"),payNum);
		result.setRoot(getPathByProperName("contractName"),contractName);
		result.setRoot(getPathByProperName("accountNo"),accountNo);
		result.setRoot(getPathByProperName("oweFeeList"), oweFeeList);
		return result;
	}

	/**
	 * @return the bankCode
	 */
	public String getBankCode() {
		return bankCode;
	}

	/**
	 * @param bankCode the bankCode to set
	 */
	public void setBankCode(String bankCode) {
		this.bankCode = bankCode;
	}

	/**
	 * @return the bankName
	 */
	public String getBankName() {
		return bankName;
	}

	/**
	 * @param bankName the bankName to set
	 */
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	/**
	 * @return the regionName
	 */
	public String getRegionName() {
		return regionName;
	}

	/**
	 * @param regionName the regionName to set
	 */
	public void setRegionName(String regionName) {
		this.regionName = regionName;
	}

	/**
	 * @return the payFee
	 */
	public long getPayFee() {
		return payFee;
	}

	/**
	 * @param payFee the payFee to set
	 */
	public void setPayFee(long payFee) {
		this.payFee = payFee;
	}

	/**
	 * @return the payNum
	 */
	public long getPayNum() {
		return payNum;
	}

	/**
	 * @param payNum the payNum to set
	 */
	public void setPayNum(long payNum) {
		this.payNum = payNum;
	}

	/**
	 * @return the contractName
	 */
	public String getContractName() {
		return contractName;
	}

	/**
	 * @param contractName the contractName to set
	 */
	public void setContractName(String contractName) {
		this.contractName = contractName;
	}

	/**
	 * @return the accountNo
	 */
	public String getAccountNo() {
		return accountNo;
	}

	/**
	 * @param accountNo the accountNo to set
	 */
	public void setAccountNo(String accountNo) {
		this.accountNo = accountNo;
	}

	/**
	 * @return the oweFeeList
	 */
	public List<OweFeeEntity> getOweFeeList() {
		return oweFeeList;
	}

	/**
	 * @param oweFeeList the oweFeeList to set
	 */
	public void setOweFeeList(List<OweFeeEntity> oweFeeList) {
		this.oweFeeList = oweFeeList;
	}
	
}
