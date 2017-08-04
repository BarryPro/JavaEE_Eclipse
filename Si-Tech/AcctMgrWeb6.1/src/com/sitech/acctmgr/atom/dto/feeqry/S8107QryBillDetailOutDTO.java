package com.sitech.acctmgr.atom.dto.feeqry;

import java.util.List;

import com.sitech.acctmgr.atom.domains.bill.BillDetailEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8107QryBillDetailOutDTO extends CommonOutDTO {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path="BILL_LIST",cons=ConsType.QUES,type="compx",len="1",desc="账单列表",memo="略")
	private List<BillDetailEntity> outList = null;
	@ParamDesc(path="CONTRACT_NO",cons=ConsType.CT001,type="long",len="18",desc="账户号码",memo="略")
	private long contractNo = 0;
	@ParamDesc(path="ID_NO",cons=ConsType.CT001,type="long",len="18",desc="用户号码",memo="略")
	private long idNo = 0;
	@ParamDesc(path="BEGIN_TIME",cons=ConsType.CT001,type="String",len="30",desc="开始时间",memo="略")	
	private String beginTime = "";
	@ParamDesc(path="END_TIME",cons=ConsType.CT001,type="String",len="30",desc="结束时间",memo="略")	
	private String endTime = "";
	@Override
	public MBean encode() {

		MBean result = super.encode();			
		result.setRoot(getPathByProperName("outList"), outList);
		result.setRoot(getPathByProperName("contractNo"), contractNo);
		result.setRoot(getPathByProperName("idNo"), idNo);
		result.setRoot(getPathByProperName("beginTime"), beginTime);
		result.setRoot(getPathByProperName("endTime"), endTime);
		return result;
	}

	public List<BillDetailEntity> getOutList() {
		return outList;
	}

	public void setOutList(List<BillDetailEntity> outList) {
		this.outList = outList;
	}

	public long getContractNo() {
		return contractNo;
	}

	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}

	public long getIdNo() {
		return idNo;
	}

	public void setIdNo(long idNo) {
		this.idNo = idNo;
	}

	public String getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	
}
