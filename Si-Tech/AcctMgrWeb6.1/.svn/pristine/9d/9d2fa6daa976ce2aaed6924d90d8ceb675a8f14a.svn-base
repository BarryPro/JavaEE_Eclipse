package com.sitech.acctmgr.atom.dto.detail;

import java.util.List;

import com.sitech.acctmgr.atom.domains.detail.DetailQryRecord;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8426QryRecordQryOutDTO extends CommonOutDTO {
	
	private static final long serialVersionUID = 8436652741865718084L;
	
	@ParamDesc(path = "RECORD_LIST", cons = ConsType.QUES, len = "", type = "compx", desc = "详单查询记录列表", memo = "略")
	private List<DetailQryRecord> qryRecordsList;
	
	@ParamDesc(path = "SUM", cons = ConsType.QUES, len = "", type = "int", desc = "查询记录数据总条数", memo = "略")
	private int sum;
	
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("qryRecordsList"), qryRecordsList);
		result.setRoot(getPathByProperName("sum"), sum);
		return result;
	}
	
	public List<DetailQryRecord> getQryRecordsList() {
		return qryRecordsList;
	}
	public void setQryRecordsList(List<DetailQryRecord> qryRecordsList) {
		this.qryRecordsList = qryRecordsList;
	}
	public int getSum() {
		return sum;
	}

	public void setSum(int sum) {
		this.sum = sum;
	}
	
}
