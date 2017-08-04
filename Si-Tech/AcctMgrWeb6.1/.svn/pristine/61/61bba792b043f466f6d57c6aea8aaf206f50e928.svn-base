/**
 * 
 */
package com.sitech.acctmgr.atom.dto.acctmng;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;
import org.apache.commons.lang.StringUtils;

/**
 * @author wangyla
 * 
 */
public class S8225QryCollBillInDTO extends CommonInDTO {

	private static final long serialVersionUID = 4874983903215285969L;
	@ParamDesc(path = "BUSI_INFO.CONTRACT_NO", cons = ConsType.CT001, desc = "帐户号码", len = "18", type = "string", memo = "略")
	private long contractNo;
	@ParamDesc(path = "BUSI_INFO.BILL_CYCLE", cons = ConsType.CT001, desc = "查询帐期", len = "6", type = "string", memo = "略")
	private int billCycle;
	@ParamDesc(path = "BUSI_INFO.OP_TYPE", cons = ConsType.CT001, desc = "操作类型[NORMAL|ERROR]", len = "6", type = "string", memo = "略")
	private String opType; // 操作类型， NORMAL:用户清单查询 ERROR:用户错单查询
	@ParamDesc(path = "BUSI_INFO.PAGE_SIZE", cons = ConsType.CT001, desc = "每页显示条数", len = "10", type = "string", memo = "略")
	private int pageSize;
	@ParamDesc(path = "BUSI_INFO.PAGE_NUM", cons = ConsType.CT001, desc = "当前页数", len = "8", type = "string", memo = "略")
	private int pageNum;
	@ParamDesc(path = "BUSI_INFO.QRY_TYPE", cons = ConsType.CT001, desc = "查询总体和明细信息标识", len = "2", type = "string", memo = "1:查询总体信息  2:查询托收账单列表信息")
	private String qryType;

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		contractNo = Long.parseLong(arg0.getStr(getPathByProperName("contractNo")));
		billCycle = Integer.parseInt(arg0.getStr(getPathByProperName("billCycle")));
		opType = arg0.getStr(getPathByProperName("opType"));
		opCode = arg0.getStr(getPathByProperName("opCode"));
		if (StringUtils.isNotEmpty(arg0.getStr(getPathByProperName("pageSize")))) {
			pageSize = Integer.parseInt(arg0.getStr(getPathByProperName("pageSize")));
		}
		if (StringUtils.isNotEmpty(arg0.getStr(getPathByProperName("pageNum")))) {
			pageNum = Integer.parseInt(arg0.getStr(getPathByProperName("pageNum")));
		}
		qryType = arg0.getStr(getPathByProperName("qryType"));
	}

	public long getContractNo() {
		return contractNo;
	}

	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}

	public int getBillCycle() {
		return billCycle;
	}

	public void setBillCycle(int billCycle) {
		this.billCycle = billCycle;
	}

	public String getOpType() {
		return opType;
	}

	public void setOpType(String opType) {
		this.opType = opType;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public String getQryType() {
		return qryType;
	}

	public void setQryType(String qryType) {
		this.qryType = qryType;
	}
}
