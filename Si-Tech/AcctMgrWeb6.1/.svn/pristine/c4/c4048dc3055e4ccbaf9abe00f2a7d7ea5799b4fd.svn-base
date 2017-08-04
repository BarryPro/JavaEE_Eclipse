package com.sitech.acctmgr.atom.dto.bill;

import java.util.List;

import com.sitech.acctmgr.atom.domains.bill.BillDisplayEntity;
import com.sitech.acctmgr.atom.domains.bill.BroadBillEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 *
 * @author
 * @version 1.0
 */
public class SBroadBillQueryOutDTO extends CommonOutDTO {

    private static final long serialVersionUID = 4521280734848881591L;
    
    @ParamDesc(path = "BROAD_BILL_LIST", cons = ConsType.CT001, len = "", type = "compx", desc = "宽带账单明细", memo = "")
    List<BroadBillEntity> broadBillList;


    @Override
    public MBean encode() {
        MBean result = new MBean();
        result.setRoot(getPathByProperName("broadBillList"), broadBillList);
        return result;
    }


	public List<BroadBillEntity> getBroadBillList() {
		return broadBillList;
	}


	public void setBroadBillList(List<BroadBillEntity> broadBillList) {
		this.broadBillList = broadBillList;
	}

    
}
