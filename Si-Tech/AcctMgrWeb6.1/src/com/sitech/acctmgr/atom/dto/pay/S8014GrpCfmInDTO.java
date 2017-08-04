package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8014GrpCfmInDTO extends CommonInDTO{
	
	@ParamDesc(path="BUSI_INFO.JT_CONTRACT_NO",cons=ConsType.CT001,type="long",len="18",desc="集团账户",memo="略")
	protected long jtContractNo;
	
	@ParamDesc(path="BUSI_INFO.OP_TYPE",cons=ConsType.CT001,type="String",len="18",desc="转账类型",memo="略")
	protected String opType;
	
	@ParamDesc(path="BUSI_INFO.OP_NOTE",cons=ConsType.CT001,type="String",len="18",desc="备注",memo="略")
	protected String opNote;
	
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="40",desc="用户号码",memo="略")
	protected String phoneNo;
	
	@ParamDesc(path="BUSI_INFO.TRANS_FEE",cons=ConsType.CT001,type="long",len="14",desc="转账总金额",memo="分")
	protected long transFee ;
	
	@ParamDesc(path="BUSI_INFO.FOREIGN_SN",cons=ConsType.CT001,type="String",len="64",desc="外部流水",memo="略")
	private String foreignSn;
	
	@ParamDesc(path="BUSI_INFO.TRANS_COUNT",cons=ConsType.CT001,type="long",len="5",desc="红包个数",memo="略")
	private long transCount;
	
	@ParamDesc(path="BUSI_INFO.ONE_TRANS_FEE",cons=ConsType.CT001,type="long",len="5",desc="每次转账金额",memo="红包每次转账金额")
	private long oneTransFee;
	
	@ParamDesc(path="BUSI_INFO.LOGIN_PHONE_NO",cons=ConsType.QUES,type="String",len="40",desc="操作员联系电话",memo="略")
	protected String loginPhoneNo;
	
	@ParamDesc(path="BUSI_INFO.UNIT_ID",cons=ConsType.CT001,type="long",len="14",desc="集团编码",memo="略")
	protected long unitId;
	
	@ParamDesc(path="BUSI_INFO.PAY_PATH",cons=ConsType.CT001,type="String",len="5",desc="缴费渠道",memo="网厅:02；短厅:04；营业前台:11")
	private String payPath;
	
	@ParamDesc(path="BUSI_INFO.PAY_METHOD",cons=ConsType.CT001,type="String",len="5",desc="缴费方式",memo="现金:0")
	private String payMethod;
	
	@ParamDesc(path="BUSI_INFO.MONITOR",cons=ConsType.QUES,type="String",len="20",desc="话费红包管理员限制标识",memo="0：无限制；1：有限制")
	private String monitor;
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		
		setJtContractNo(Long.parseLong(arg0.getStr(getPathByProperName("jtContractNo")).toString()));
		setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		setTransCount(Long.parseLong(arg0.getStr(getPathByProperName("transCount")).toString()));
		setOneTransFee(Long.parseLong(arg0.getStr(getPathByProperName("oneTransFee")).toString()));
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("unitId")).toString())){
			setTransFee(Long.parseLong(arg0.getStr(getPathByProperName("transFee")).toString()));
		}else{
			setTransFee(0);
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("foreignSn")).toString())){
			setForeignSn(arg0.getStr(getPathByProperName("foreignSn")).toString());
		}else{
			setForeignSn("");
		}
		setUnitId(Long.parseLong(arg0.getStr(getPathByProperName("unitId")).toString()));
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("loginPhoneNo")))){
			setLoginPhoneNo(arg0.getStr(getPathByProperName("loginPhoneNo")));
		}else{
			setLoginPhoneNo("");
		}
		setPayPath(arg0.getStr(getPathByProperName("payPath")));
		setOpType(arg0.getStr(getPathByProperName("opType")));
		setOpNote(arg0.getStr(getPathByProperName("opNote")));
		setPayMethod(arg0.getStr(getPathByProperName("payMethod")));
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("monitor")))){
			setMonitor(arg0.getStr(getPathByProperName("monitor")));
		}else{
			setMonitor("1");//默认有管理员限制
		}
		
	}

	/**
	 * @return the jtContractNo
	 */
	public long getJtContractNo() {
		return jtContractNo;
	}

	/**
	 * @param jtContractNo the jtContractNo to set
	 */
	public void setJtContractNo(long jtContractNo) {
		this.jtContractNo = jtContractNo;
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
	 * @return the transFee
	 */
	public long getTransFee() {
		return transFee;
	}

	/**
	 * @param transFee the transFee to set
	 */
	public void setTransFee(long transFee) {
		this.transFee = transFee;
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
	 * @return the transCount
	 */
	public long getTransCount() {
		return transCount;
	}

	/**
	 * @param transCount the transCount to set
	 */
	public void setTransCount(long transCount) {
		this.transCount = transCount;
	}

	/**
	 * @return the oneTransFee
	 */
	public long getOneTransFee() {
		return oneTransFee;
	}

	/**
	 * @param oneTransFee the oneTransFee to set
	 */
	public void setOneTransFee(long oneTransFee) {
		this.oneTransFee = oneTransFee;
	}

	/**
	 * @return the loginPhoneNo
	 */
	public String getLoginPhoneNo() {
		return loginPhoneNo;
	}

	/**
	 * @param loginPhoneNo the loginPhoneNo to set
	 */
	public void setLoginPhoneNo(String loginPhoneNo) {
		this.loginPhoneNo = loginPhoneNo;
	}

	/**
	 * @return the unitId
	 */
	public long getUnitId() {
		return unitId;
	}

	/**
	 * @param unitId the unitId to set
	 */
	public void setUnitId(long unitId) {
		this.unitId = unitId;
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
	 * @return the monitor
	 */
	public String getMonitor() {
		return monitor;
	}

	/**
	 * @param monitor the monitor to set
	 */
	public void setMonitor(String monitor) {
		this.monitor = monitor;
	}

	/**
	 * @return the opType
	 */
	public String getOpType() {
		return opType;
	}

	/**
	 * @param opType the opType to set
	 */
	public void setOpType(String opType) {
		this.opType = opType;
	}

	/**
	 * @return the opNote
	 */
	public String getOpNote() {
		return opNote;
	}

	/**
	 * @param opNote the opNote to set
	 */
	public void setOpNote(String opNote) {
		this.opNote = opNote;
	}
	
}
