package com.sitech.acctmgr.atom.dto.adj;

import java.util.List;

import com.sitech.acctmgr.atom.domains.account.AccountListEntity;
import com.sitech.acctmgr.atom.domains.adj.ComplainAdjQryEntity;
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
public class S8041QryOutDTO extends CommonOutDTO {
	
    /**
	 * 
	 */
	private static final long serialVersionUID = -7878751370976969842L;
	
	@ParamDesc(path = "LEN_COMPLAIN_LIST", cons = ConsType.STAR, type = "long", len = "10", desc = "投诉退费信息列表长度", memo = "略")
    private int lenComplainList;
	
	@ParamDesc(path = "COMPLAIN_LIST", cons = ConsType.STAR, type = "compx", len = "1", desc = "投诉退费信息列表", memo = "略")
    private List<ComplainAdjQryEntity> complainList;

    @Override
    public MBean encode() {
        MBean result = super.encode();
        result.setBody(getPathByProperName("complainList"), complainList);
        result.setBody(getPathByProperName("lenComplainList"), lenComplainList);
        return result;
    }

	/**
	 * @return the complainList
	 */
	public List<ComplainAdjQryEntity> getComplainList() {
		return complainList;
	}

	/**
	 * @param complainList the complainList to set
	 */
	public void setComplainList(List<ComplainAdjQryEntity> complainList) {
		this.complainList = complainList;
	}

	public int getLenComplainList() {
		return lenComplainList;
	}

	public void setLenComplainList(int lenComplainList) {
		this.lenComplainList = lenComplainList;
	}

}
