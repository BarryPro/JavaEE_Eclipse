package com.sitech.acctmgr.atom.dto.acctmng;

import com.sitech.acctmgr.atom.domains.account.AccountListEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;

/**
 * Created by wangyla on 2016/6/23.
 */
public class SConUserRelOutDTO extends CommonOutDTO {

    @ParamDesc(path = "CON_LIST", cons = ConsType.STAR, type = "compx", len = "1", desc = "帐户列表", memo = "略")
    private List<AccountListEntity> conList;
    
    @ParamDesc(path = "CNT", cons = ConsType.CT001, type = "int", len = "1", desc = "帐户列表个数", memo = "略")
    private int cnt;

    @Override
    public MBean encode() {
        MBean result = new MBean();
        result.setBody(getPathByProperName("conList"), conList);
        result.setBody(getPathByProperName("cnt"), cnt);
        return result;
    }

	public int getCnt() {
		return cnt;
	}
	
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	public List<AccountListEntity> getConList() {
        return conList;
    }

    public void setConList(List<AccountListEntity> conList) {
        this.conList = conList;
    }
}
