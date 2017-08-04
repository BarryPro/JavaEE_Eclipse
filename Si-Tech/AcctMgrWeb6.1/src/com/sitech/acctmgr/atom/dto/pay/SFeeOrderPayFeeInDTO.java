package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class SFeeOrderPayFeeInDTO extends CommonInDTO{

	private static final long serialVersionUID = -3682083701969326333L;

	@ParamDesc(path="OPR_INFO.ORDER_LINE_ID",cons=ConsType.QUES,type="String",len="40",desc="外部流水",memo="略")
	private String foreignSn;
	
	@ParamDesc(path="OPR_INFO.OP_TIME",cons=ConsType.QUES,type="String",len="14",desc="外部时间",memo="外部缴费时间，可空，格式为YYYYMMDDHHMISS")
	private String foreignTime;//外部缴费时间，可空，格式为YYYYMMDDHHMISS
	
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.QUES,type="String",len="40",desc="服务号码",memo="略")
	private String phoneNo;
	
	@ParamDesc(path="BUSI_INFO.ID_NO",cons=ConsType.QUES,type="String",len="40",desc="用户ID",memo="略")
	private long idNo;
	
	@ParamDesc(path="BUSI_INFO.CONTRACT_NO",cons=ConsType.QUES,type="long",len="18",desc="账号",memo="略")
	private long contractNo;

	@ParamDesc(path="BUSI_INFO.PAY_PATH",cons=ConsType.CT001,type="String",len="5",desc="缴费渠道",memo="略")
	private String payPath;
	
	@ParamDesc(path="BUSI_INFO.PAY_METHOD",cons=ConsType.CT001,type="String",len="5",desc="缴费方式",memo="略")
	private String payMethod;
	
	@ParamDesc(path="BUSI_INFO.IS_PRINT",cons=ConsType.CT001,type="String",len="5",desc="CRM打印发票标识",memo="Y ：CRM已打印发票  N ：CRM未打印发票")
	private String isPrint;
	
	@ParamDesc(path="BUSI_INFO.PAY_TYPE",cons=ConsType.CT001,type="String",len="5",desc="账本类型",memo="略")
	private String payType;
	
	@ParamDesc(path="BUSI_INFO.PAY_FEE",cons=ConsType.CT001,type="String",len="14",desc="缴费金额",memo="略")
	private long paymonty;
	
	@ParamDesc(path="BUSI_INFO.FLAG",cons=ConsType.QUES,type="String",len="10",desc="标识",memo="预开户标识,传YKH")
	private String flag;
	
	public void decode(MBean arg0){
		
		super.decode(arg0);
		
		foreignSn = arg0.getStr(getPathByProperName("foreignSn"));
		foreignTime = arg0.getStr(getPathByProperName("foreignTime"));
		phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		
		if(arg0.getObject(getPathByProperName("idNo")) != null && !arg0.getObject(getPathByProperName("idNo")).equals("")){
			idNo = Long.parseLong(arg0.getStr(getPathByProperName("idNo")));
		}
		if(arg0.getObject(getPathByProperName("contractNo")) != null && !arg0.getObject(getPathByProperName("contractNo")).equals("")){
			contractNo = Long.parseLong(arg0.getStr(getPathByProperName("contractNo")));
		}
		
		payPath = arg0.getStr(getPathByProperName("payPath"));
		payMethod = arg0.getStr(getPathByProperName("payMethod"));
		
		String tmp = arg0.getStr(getPathByProperName("isPrint"));
		if(tmp.equals("Y")){
			this.isPrint = "2";
		}else{
			this.isPrint = "0";
		}
		
		payType = arg0.getStr(getPathByProperName("payType"));
		
		paymonty = Long.parseLong(arg0.getStr(getPathByProperName("paymonty")));
		
		//预开户传YKH   解析参数的时候 删除掉 PHONE_NO,因为PHONE_NO没有三户资料，按照账户缴费处理
		if(arg0.getObject(getPathByProperName("flag")) != null && !arg0.getObject(getPathByProperName("flag")).equals("")){
			flag = arg0.getStr(getPathByProperName("flag"));
/*			if(flag.equals("YKH")){
				phoneNo = "";
				
			}*/
		}else{
			flag = "";
		}
		
	}

	
	
	

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
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
	 * @return the paymonty
	 */
	public long getPaymonty() {
		return paymonty;
	}

	/**
	 * @param paymonty the paymonty to set
	 */
	public void setPaymonty(long paymonty) {
		this.paymonty = paymonty;
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

	/**
	 * @return the foreignTime
	 */
	public String getForeignTime() {
		return foreignTime;
	}

	/**
	 * @param foreignTime the foreignTime to set
	 */
	public void setForeignTime(String foreignTime) {
		this.foreignTime = foreignTime;
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
	 * @return the idNo
	 */
	public long getIdNo() {
		return idNo;
	}

	/**
	 * @param idNo the idNo to set
	 */
	public void setIdNo(long idNo) {
		this.idNo = idNo;
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
	 * @return the isPrint
	 */
	public String getIsPrint() {
		return isPrint;
	}

	/**
	 * @param isPrint the isPrint to set
	 */
	public void setIsPrint(String isPrint) {
		this.isPrint = isPrint;
	}


}
