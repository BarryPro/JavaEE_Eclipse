package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title: 托收缴费确认入参DTO  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public class S8030CfmInDTO extends CommonInDTO{

	private static final long serialVersionUID = 7545571099382664554L;
    
	@ParamDesc(path="BUSI_INFO.CONTRACT_NO",cons=ConsType.CT001,type="String",len="18",desc="帐户号码",memo="略")
	protected long contractNo;
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="40",desc="服务号码",memo="略")
	protected String phoneNo;
	@ParamDesc(path="BUSI_INFO.PAY_TYPE",cons=ConsType.CT001,type="String",len="5",desc="缴费类型",memo="略")
	protected String payType;
	@ParamDesc(path="BUSI_INFO.PAY_MONEY",cons=ConsType.CT001,type="String",len="14",desc="缴费金额",memo="略")
	protected String payMoney;
	@ParamDesc(path="BUSI_INFO.BANK_CODE",cons=ConsType.CT001,type="String",len="12",desc="银行代码",memo="略")
	protected String bankCode;
	@ParamDesc(path="BUSI_INFO.PAY_PATH",cons=ConsType.CT001,type="String",len="5",desc="缴费渠道",memo="略")
	protected String payPath;
	@ParamDesc(path="BUSI_INFO.PAY_METHOD",cons=ConsType.CT001,type="String",len="5",desc="缴费方式",memo="略")
	protected String payMethod;
	@ParamDesc(path="BUSI_INFO.YEAR_MONTH",cons=ConsType.CT001,type="Long",len="6",desc="托收年月",memo="略")
	protected int yearMonth;
	@ParamDesc(path="BUSI_INFO.FETCH_NO",cons=ConsType.STAR,type="String",len="9",desc="批次",memo="略")
	protected String fetchNo;
	@ParamDesc(path="BUSI_INFO.PAY_NOTE",cons=ConsType.STAR,type="String",len="60",desc="备注",memo="略")
	protected String payNote;

	public void decode(MBean arg0){
		super.decode(arg0);
		if (StringUtils.isEmptyOrNull(opCode)){
			opCode = "8030";//设置默认值
		}
		setContractNo(Long.parseLong(arg0.getStr(getPathByProperName("contractNo"))));
		setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		setPayType(arg0.getStr(getPathByProperName("payType")));
		setPayMoney(arg0.getStr(getPathByProperName("payMoney")));
		setBankCode(arg0.getStr(getPathByProperName("bankCode")));
		setPayPath(arg0.getStr(getPathByProperName("payPath")));
		setPayMethod(arg0.getStr(getPathByProperName("payMethod")));
		setYearMonth(Integer.parseInt(arg0.getStr(getPathByProperName("yearMonth"))));
		setFetchNo(arg0.getStr(getPathByProperName("fetchNo")));
		setPayNote(arg0.getStr(getPathByProperName("payNote")));
		if (StringUtils.isEmptyOrNull(payNote)){
			payNote = "";//设置缴费默认备注，待完善
		}	
	}

	/**
	 * @return the contractNo
	 */
	public long getContractNo() {
		return contractNo;
	}

	/**
	 * @param contractNo the contractNo to set
	 */
	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}

	/**
	 * @return the phoneNo
	 */
	public String getPhoneNo() {
		return phoneNo;
	}

	/**
	 * @param phoneNo the phoneNo to set
	 */
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	/**
	 * @return the payType
	 */
	public String getPayType() {
		return payType;
	}

	/**
	 * @param payType the payType to set
	 */
	public void setPayType(String payType) {
		this.payType = payType;
	}

	/**
	 * @return the payMoney
	 */
	public String getPayMoney() {
		return payMoney;
	}

	/**
	 * @param payMoney the payMoney to set
	 */
	public void setPayMoney(String payMoney) {
		this.payMoney = payMoney;
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
	 * @return the payPath
	 */
	public String getPayPath() {
		return payPath;
	}

	/**
	 * @param payPath the payPath to set
	 */
	public void setPayPath(String payPath) {
		this.payPath = payPath;
	}

	/**
	 * @return the payMethod
	 */
	public String getPayMethod() {
		return payMethod;
	}

	/**
	 * @param payMethod the payMethod to set
	 */
	public void setPayMethod(String payMethod) {
		this.payMethod = payMethod;
	}

	/**
	 * @return the yearMonth
	 */
	public int getYearMonth() {
		return yearMonth;
	}

	/**
	 * @param yearMonth the yearMonth to set
	 */
	public void setYearMonth(int yearMonth) {
		this.yearMonth = yearMonth;
	}

	/**
	 * @return the fetchNo
	 */
	public String getFetchNo() {
		return fetchNo;
	}

	/**
	 * @param fetchNo the fetchNo to set
	 */
	public void setFetchNo(String fetchNo) {
		this.fetchNo = fetchNo;
	}

	/**
	 * @return the payNote
	 */
	public String getPayNote() {
		return payNote;
	}

	/**
	 * @param payNote the payNote to set
	 */
	public void setPayNote(String payNote) {
		this.payNote = payNote;
	}
}
