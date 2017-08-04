package com.sitech.acctmgr.atom.dto.invoice;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.invoice.BalInvprintInfoEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * 名称：根据inv_no和inv_code查询发票记录出差
 * 
 * @author liuhl_bj
 *
 */
public class S8240qryInvoByInvNoOutDTO extends CommonOutDTO {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@JSONField(name = "INV_INFO_LIST")
	@ParamDesc(path = "INV_INFO_LIST", cons = ConsType.PLUS, type = "compx", len = "1", desc = "发票信息列表", memo = "略")
	private List<BalInvprintInfoEntity> invInfoList = new ArrayList<BalInvprintInfoEntity>();

	@JSONField(name = "TOTAL_NUM")
	@ParamDesc(path = "TOTAL_NUM", cons = ConsType.PLUS, type = "int", len = "1", desc = "总发票条数", memo = "略")
	private int totalNum;

	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setBody(getPathByProperName("invInfoList"), this.invInfoList);
		result.setBody(getPathByProperName("totalNum"), this.totalNum);
		return result;
	}

	public List<BalInvprintInfoEntity> getInvInfoList() {
		return invInfoList;
	}

	public void setInvInfoList(List<BalInvprintInfoEntity> invInfoList) {
		this.invInfoList = invInfoList;
	}

	public int getTotalNum() {
		return totalNum;
	}

	public void setTotalNum(int totalNum) {
		this.totalNum = totalNum;
	}

}
