package com.sitech.acctmgr.atom.dto.invoice;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.invoice.InvInfoEntity;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.out.OutDTO;

public class S8056QryOutDTO extends OutDTO {

	private static final long serialVersionUID = 1L;

	@JSONField(name = "INV_NO")
	@ParamDesc(path = "INV_NO", cons = ConsType.CT001, type = "long", len = "10", desc = "发票号码", memo = "略")
	private List<InvInfoEntity> invInfo;

	@JSONField(name = "PRINT_TYPE")
	@ParamDesc(path = "PRINT_TYPE", cons = ConsType.CT001, type = "long", len = "10", desc = "打印类型", memo = "略")
	private int printType;

	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("invInfo"), invInfo);
		result.setRoot(getPathByProperName("printType"), printType);
		return result;
	}

	public List<InvInfoEntity> getInvInfo() {
		return invInfo;
	}

	public void setInvInfo(List<InvInfoEntity> invInfo) {
		this.invInfo = invInfo;
	}

	public int getPrintType() {
		return printType;
	}

	public void setPrintType(int printType) {
		this.printType = printType;
	}

}
