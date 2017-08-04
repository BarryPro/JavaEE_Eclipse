package com.sitech.acctmgr.inter.invoice;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public interface I8248TaxInvo {
	
	/* 查询不同大区的具有资质的集团账户 */
	public OutDTO qryAcctNo(InDTO inParam);

	/* 查询不同大区账户的消费 */
	public OutDTO qryInvo(InDTO inParam);
	
	/** 多账户增值税申请确认服务 **/
	public OutDTO cfmBoss(InDTO inParam);  
	
	/** 多账户增值税申请确认服务 **/
	public OutDTO qryCrmQry(InDTO inParam);  
	
}
