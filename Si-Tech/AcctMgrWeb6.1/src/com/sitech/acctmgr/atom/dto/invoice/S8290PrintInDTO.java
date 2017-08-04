package com.sitech.acctmgr.atom.dto.invoice;

import java.util.List;

import com.sitech.acctmgr.atom.domains.user.VirtualGrpEntity;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * 名称：集团预开发票
 * 
 * @author liuhl_bj
 *
 */
public class S8290PrintInDTO extends CommonInDTO {

	private static final long serialVersionUID = -939270329172640327L;

	@ParamDesc(path = "BUSI_INFO.VIRTUAL_GRP_LIST", cons = ConsType.PLUS, type = "compx", len = "20", desc = "集团信息", memo = "略")
	private List<VirtualGrpEntity> virtualGrpList;

	@ParamDesc(path = "BUSI_INFO.INV_NO", cons = ConsType.CT001, type = "string", len = "20", desc = "发票号码", memo = "略")
	private String invNo;

	@ParamDesc(path = "BUSI_INFO.PRINT_FEE", cons = ConsType.CT001, type = "long", len = "20", desc = "发票金额", memo = "略")
	private long printFee;

	@ParamDesc(path = "BUSI_INFO.INV_CODE", cons = ConsType.CT001, type = "string", len = "20", desc = "发票代码", memo = "略")
	private String invCode;

	@ParamDesc(path = "BUSI_INFO.UNIT_ID", cons = ConsType.CT001, type = "long", len = "20", desc = "虚拟集团号码", memo = "略")
	private long unitId;

	@ParamDesc(path = "BUSI_INFO.UNIT_NAME", cons = ConsType.CT001, type = "string", len = "20", desc = "虚拟集团名称", memo = "略")
	private String unitName;

	@ParamDesc(path = "BUSI_INFO.PRINT_ITEM", cons = ConsType.CT001, type = "string", len = "20", desc = "开票项目", memo = "略")
	private String printItem;

	@ParamDesc(path = "BUSI_INFO.CUST_MANAGER", cons = ConsType.CT001, type = "string", len = "20", desc = "客户经理名称", memo = "略")
	private String custManager;

	@ParamDesc(path = "BUSI_INFO.ACCOUNT_DATE", cons = ConsType.CT001, type = "string", len = "20", desc = "到账日期", memo = "略")
	private String accountDate;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		log.debug(arg0 + "************" + getPathByProperName("virtualGrpList"));

		virtualGrpList = arg0.getList(getPathByProperName("virtualGrpList"), VirtualGrpEntity.class);
		invNo = arg0.getStr(getPathByProperName("invNo"));
		invCode = arg0.getStr(getPathByProperName("invCode"));
		unitId = ValueUtils.longValue(arg0.getStr(getPathByProperName("unitId")));
		unitName = arg0.getStr(getPathByProperName("unitName"));
		printFee = ValueUtils.longValue(arg0.getStr(getPathByProperName("printFee")));
		printItem = arg0.getStr(getPathByProperName("printItem"));
		custManager = arg0.getStr(getPathByProperName("custManager"));
		accountDate = arg0.getStr(getPathByProperName("accountDate"));
	}

	public List<VirtualGrpEntity> getVirtualGrpList() {
		return virtualGrpList;
	}

	public void setVirtualGrpList(List<VirtualGrpEntity> virtualGrpList) {
		this.virtualGrpList = virtualGrpList;
	}

	public String getInvNo() {
		return invNo;
	}

	public void setInvNo(String invNo) {
		this.invNo = invNo;
	}

	public long getPrintFee() {
		return printFee;
	}

	public void setPrintFee(long printFee) {
		this.printFee = printFee;
	}

	public String getInvCode() {
		return invCode;
	}

	public void setInvCode(String invCode) {
		this.invCode = invCode;
	}

	public long getUnitId() {
		return unitId;
	}

	public void setUnitId(long unitId) {
		this.unitId = unitId;
	}

	public String getUnitName() {
		return unitName;
	}

	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}

	public String getPrintItem() {
		return printItem;
	}

	public void setPrintItem(String printItem) {
		this.printItem = printItem;
	}

	public String getCustManager() {
		return custManager;
	}

	public void setCustManager(String custManager) {
		this.custManager = custManager;
	}

	public String getAccountDate() {
		return accountDate;
	}

	public void setAccountDate(String accountDate) {
		this.accountDate = accountDate;
	}

}
