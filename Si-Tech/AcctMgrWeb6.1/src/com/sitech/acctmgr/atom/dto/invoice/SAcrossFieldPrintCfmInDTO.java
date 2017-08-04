package com.sitech.acctmgr.atom.dto.invoice;

import java.util.List;

import com.sitech.acctmgr.atom.domains.invoice.AcrossFieldInvEntity;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SAcrossFieldPrintCfmInDTO extends CommonInDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path = "BUSI_INFO.ID_TYPE", cons = ConsType.CT001, type = "String", len = "2", desc = "标识类型", memo = "01:手机号码")
	private String idType;

	@ParamDesc(path = "BUSI_INFO.ID_VALUE", cons = ConsType.CT001, type = "String", len = "20", desc = "标识号码", memo = "手机号码")
	private String idValue;

	@ParamDesc(path = "BUSI_INFO.PRINTED_DATE", cons = ConsType.CT001, type = "string", len = "6", desc = "发票打印日期", memo = "YYYYMM")
	private int totalDate;

	@ParamDesc(path = "BUSI_INFO.HANDLING_NUM", cons = ConsType.QUES, type = "String", len = "20", desc = "漫游省打印发票的操作人员编号", memo = "01:手机号码")
	private String handlingNum;

	@ParamDesc(path = "BUSI_INFO.INFO_CONT", cons = ConsType.PLUS, type = "compx", len = "1", desc = "已打月份发票清单", memo = "略")
	private List<AcrossFieldInvEntity> invList;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		idType = arg0.getStr(getPathByProperName("idType"));
		idValue = arg0.getStr(getPathByProperName("idValue"));
		totalDate = ValueUtils.intValue(arg0.getStr(getPathByProperName("totalDate")));
		handlingNum = arg0.getStr(getPathByProperName("handlingNum"));
		invList = arg0.getList(getPathByProperName("invList"), AcrossFieldInvEntity.class);

	}

	public String getIdType() {
		return idType;
	}

	public void setIdType(String idType) {
		this.idType = idType;
	}

	public String getIdValue() {
		return idValue;
	}

	public void setIdValue(String idValue) {
		this.idValue = idValue;
	}

	public int getTotalDate() {
		return totalDate;
	}

	public void setTotalDate(int totalDate) {
		this.totalDate = totalDate;
	}

	public String getHandlingNum() {
		return handlingNum;
	}

	public void setHandlingNum(String handlingNum) {
		this.handlingNum = handlingNum;
	}

	public List<AcrossFieldInvEntity> getInvList() {
		return invList;
	}

	public void setInvList(List<AcrossFieldInvEntity> invList) {
		this.invList = invList;
	}

}
