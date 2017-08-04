package com.sitech.acctmgr.atom.dto.pay;

 
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author LIJXD
 * @version 1.0
 */
public class S2310AuditInDTO extends CommonInDTO{

 
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@ParamDesc(path = "BUSI_INFO.AUDIT_FLAG", cons = ConsType.CT001, desc = "审核标志", len = "1", type = "string", memo = "Y同意;X不同意")
	protected String auditFlag;
	
	@ParamDesc(path = "BUSI_INFO.BATCH_SN", cons = ConsType.CT001, desc = "批次流水", len = "8", type = "long", memo = "选中的批次流水")
	protected long batchSn;



	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.common.dto.CommonInDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public void decode(MBean arg0) {
		// TODO Auto-generated method stub
		super.decode(arg0);
		setAuditFlag(arg0.getStr(getPathByProperName("auditFlag")));
		setBatchSn(Long.parseLong(arg0.getObject(getPathByProperName("batchSn")).toString()));
	}

	public String getAuditFlag() {
		return auditFlag;
	}

	public void setAuditFlag(String auditFlag) {
		this.auditFlag = auditFlag;
	}

	public long getBatchSn() {
		return batchSn;
	}

	public void setBatchSn(long batchSn) {
		this.batchSn = batchSn;
	}
}
