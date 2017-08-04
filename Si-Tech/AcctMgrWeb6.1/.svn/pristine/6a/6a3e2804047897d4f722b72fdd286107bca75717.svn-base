package com.sitech.acctmgr.atom.dto.pay;

import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.sitech.acctmgr.atom.domains.pay.AgentEntity;
import com.sitech.acctmgr.atom.domains.pay.GroupChargeEntity;
import com.sitech.acctmgr.atom.domains.pay.GroupRelConInfo;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.domains.user.VirtualGrpEntity;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
*
* <p>Title: 产品统付和一点支付账户手动划拨确认入参  </p>
* <p>Description:   </p>
* <p>Copyright: Copyright (c) 2016</p>
* <p>Company: SI-TECH </p>
* @author SUZJ
* @version 1.0
*/
public class S8078CfmInDTO extends CommonInDTO {
	
	private static final long serialVersionUID = 1L;
	
	@ParamDesc(path="BUSI_INFO.OUT_CONTRACT_NO",cons=ConsType.QUES,type="long",len="18",desc="转出账号",memo="略")
	protected long outContractNo;
	@ParamDesc(path="BUSI_INFO.OUT_PHONE_NO",cons=ConsType.QUES,type="long",len="18",desc="转出号码",memo="略")
	protected long outPhoneNo;
	@ParamDesc(path="BUSI_INFO.SHOULD_PAY",cons=ConsType.QUES,type="long",len="18",desc="应付总金额",memo="略")
	protected long shouldPay;
	@ParamDesc(path="BUSI_INFO.OP_NOTE",cons=ConsType.QUES,type="String",len="50",desc="标注",memo="略")
	protected String opNote;
	@ParamDesc(path="BUSI_INFO.PAY_PATH",cons=ConsType.QUES,type="String",len="2",desc="储值渠道",memo="略")
	protected String payPath;
	@ParamDesc(path="BUSI_INFO.OP_TYPE",cons=ConsType.QUES,type="String",len="12",desc="划拨类型",memo="TFAccount:产品统付和一点支付账户手工划拨")
	protected String opType;
	@ParamDesc(path="BUSI_INFO.PAY_METHOD",cons=ConsType.QUES,type="String",len="2",desc="储值方式",memo="略")
	protected String payMethod;
	@ParamDesc(path="BUSI_INFO.REL_CON_LIST",cons=ConsType.PLUS,type="compx",len="1",desc="手动划拨列表",memo="略")
	protected List<GroupRelConInfo> relConList;
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setOutContractNo(Long.parseLong(arg0.getObject(getPathByProperName("outContractNo")).toString()));
		setShouldPay(Long.parseLong(arg0.getObject(getPathByProperName("shouldPay")).toString()));
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("outPhoneNo")))){
			setOutPhoneNo(Long.parseLong(arg0.getObject(getPathByProperName("outPhoneNo")).toString()));
		}
		setPayPath(StringUtils.castToString(arg0.getObject(getPathByProperName("payPath"))));
		setOpCode(StringUtils.castToString(arg0.getObject(getPathByProperName("opCode"))));
		setOpType(StringUtils.castToString(arg0.getObject(getPathByProperName("opType"))));
		setPayMethod(StringUtils.castToString(arg0.getObject(getPathByProperName("payMethod"))));
		setOpNote(StringUtils.castToString(arg0.getObject(getPathByProperName("opNote"))));
		setRelConList(arg0.getList(getPathByProperName("relConList"), GroupRelConInfo.class));

	}

	/**
	 * @return the outContractNo
	 */
	public long getOutContractNo() {
		return outContractNo;
	}

	/**
	 * @param outContractNo the outContractNo to set
	 */
	public void setOutContractNo(long outContractNo) {
		this.outContractNo = outContractNo;
	}

	/**
	 * @return the shouldPay
	 */
	public long getShouldPay() {
		return shouldPay;
	}

	/**
	 * @param shouldPay the shouldPay to set
	 */
	public void setShouldPay(long shouldPay) {
		this.shouldPay = shouldPay;
	}

	/**
	 * @return the outPhoneNo
	 */
	public long getOutPhoneNo() {
		return outPhoneNo;
	}

	/**
	 * @param outPhoneNo the outPhoneNo to set
	 */
	public void setOutPhoneNo(long outPhoneNo) {
		this.outPhoneNo = outPhoneNo;
	}

	/**
	 * @return the relConList
	 */
	public List<GroupRelConInfo> getRelConList() {
		return relConList;
	}

	/**
	 * @param relConList the relConList to set
	 */
	public void setRelConList(List<GroupRelConInfo> relConList) {
		this.relConList = relConList;
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
	
	
	
}
