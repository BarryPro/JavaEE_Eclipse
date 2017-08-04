package com.sitech.acctmgr.atom.dto.adj;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title:   投诉退费确认入参DTO</p>
 * <p>Description:   对入参进行解析成MBean，并检验入参的正确性</p>
 * <p>Copyright: Copyright (c) 2016</p>
 * <p>Company: SI-TECH </p>
 * @author guowy
 * @version 1.0
 */
public class S8041BackCfmInDTO extends CommonInDTO{


	/**
	 * 
	 */
	private static final long serialVersionUID = -3126459383379854449L;
	
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="40",desc="服务号码",memo="略")
	protected String phoneNo;
	/*@ParamDesc(path="BUSI_INFO.CONTRACT_NO",cons=ConsType.CT001,type="long",len="18",desc="账号",memo="略")
	protected long contractNo;*/
	@ParamDesc(path="BUSI_INFO.REMARK",cons=ConsType.QUES,type="String",len="1024",desc="备注",memo="略")
	protected String remark ;
	@ParamDesc(path="BUSI_INFO.COMP_MONEY",cons=ConsType.CT001,type="long",len="14",desc="补偿金额",memo="略")
	protected long compMoney;
	@ParamDesc(path="BUSI_INFO.BACK_TYPE",cons=ConsType.CT001,type="String",len="2",desc="补偿类型",memo="补偿类型  1：单倍  2: 双倍")
	protected String backType;
	@ParamDesc(path="BUSI_INFO.SP_FLAG",cons=ConsType.CT001,type="String",len="2",desc="sp退费标识",memo="1：非sp退费  2：sp退费")
	protected String spFlag;
	@ParamDesc(path="BUSI_INFO.BACK_SN",cons=ConsType.CT001,type="long",len="14",desc="退费流水",memo="略")
	protected long backSn;

	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		//setContractNo(Long.parseLong(arg0.getObject(getPathByProperName("contractNo")).toString()));
		setRemark(arg0.getStr(getPathByProperName("remark")));
		setCompMoney(Long.parseLong(arg0.getObject(getPathByProperName("compMoney")).toString()));
		setBackType(arg0.getStr(getPathByProperName("backType")));
		setSpFlag(arg0.getStr(getPathByProperName("spFlag")));
		setBackSn(Long.parseLong(arg0.getObject(getPathByProperName("backSn")).toString()));
		if(StringUtils.isEmptyOrNull(arg0.getStr(getPathByProperName("opCode")))){
			opCode="8041";
		}
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
	 * @return the remark
	 */

	public String getRemark() {
		return remark;
	}


	/**
	 * @param remark the remark to set
	 */
	public void setRemark(String remark) {
		this.remark = remark;
	}

	/**
	 * @return the compMoney
	 */
	public long getCompMoney() {
		return compMoney;
	}


	/**
	 * @param compMoney the compMoney to set
	 */
	public void setCompMoney(long compMoney) {
		this.compMoney = compMoney;
	}


	/**
	 * @return the backType
	 */
	public String getBackType() {
		return backType;
	}


	/**
	 * @param backType the backType to set
	 */
	public void setBackType(String backType) {
		this.backType = backType;
	}


	/**
	 * @return the spFlag
	 */
	public String getSpFlag() {
		return spFlag;
	}


	/**
	 * @param spFlag the spFlag to set
	 */
	public void setSpFlag(String spFlag) {
		this.spFlag = spFlag;
	}


	/**
	 * @return the backSn
	 */
	public long getBackSn() {
		return backSn;
	}


	/**
	 * @param backSn the backSn to set
	 */
	public void setBackSn(long backSn) {
		this.backSn = backSn;
	}
}
