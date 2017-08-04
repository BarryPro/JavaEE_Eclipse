package com.sitech.acctmgr.atom.dto.adj;

import java.util.List;

import com.sitech.acctmgr.atom.domains.adj.ComplainAdjQryBatchEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
*
* <p>Title:   </p>
* <p>Description:   </p>
* <p>Copyright: Copyright (c) 2016</p>
* <p>Company: SI-TECH </p>
* @author 
* @version 1.0
*/
public class S8041QryBatchOutDTO extends CommonOutDTO {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -7861670270828913427L;
	
	@ParamDesc(path = "LEN_COMPLAIN_LIST", cons = ConsType.STAR, type = "long", len = "10", desc = "批量投诉退费信息列表", memo = "略")
    private int lenComplainBatchList;
	
	@ParamDesc(path = "COMPLAIN_LIST", cons = ConsType.STAR, type = "compx", len = "1", desc = "批量投诉退费信息列表", memo = "略")
    private List<ComplainAdjQryBatchEntity> complainBatchList;

    @Override
    public MBean encode() {
        MBean result = super.encode();
        result.setBody(getPathByProperName("complainBatchList"), complainBatchList);
        result.setBody(getPathByProperName("lenComplainBatchList"), lenComplainBatchList);
        return result;
    }

	/**
	 * @return the complainBatchList
	 */
	public List<ComplainAdjQryBatchEntity> getComplainBatchList() {
		return complainBatchList;
	}

	/**
	 * @param complainBatchList the complainBatchList to set
	 */
	public void setComplainBatchList(List<ComplainAdjQryBatchEntity> complainBatchList) {
		this.complainBatchList = complainBatchList;
	}

	public int getLenComplainBatchList() {
		return lenComplainBatchList;
	}

	public void setLenComplainBatchList(int lenComplainBatchList) {
		this.lenComplainBatchList = lenComplainBatchList;
	}

}
