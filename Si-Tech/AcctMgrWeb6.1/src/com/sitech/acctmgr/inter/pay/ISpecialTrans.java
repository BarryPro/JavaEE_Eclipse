package com.sitech.acctmgr.inter.pay;

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
public interface ISpecialTrans {
	
	/** 
	* 名称：专款转账确认服务	<br/>
	* 功能：实现专款转账,将转出账户的现金账本或者其它类型的可转账本转为转入账户专款。转为分月到账，用以限制没有消费金额<br/>
	* @return 
	 */
	public OutDTO cfm (InDTO inParam);

	/** 
	* 名称：包年创建服务	<br/>
	* 功能：实现包年专款转账,将转出账户的可转账本转为转入账户专款账本类型。
	*      根据入参 MONTH_FLAG 决定是否要转为分月到账，用以限制没有消费金额<br/>
	 */
	OutDTO bnCfm(InDTO inParam);
	
	/** 
	* 名称：包年宽带提速服务	<br/>
	* 功能：实现包年宽带提速，将原来剩余专款扣除当月月租后转为0账本，然后将可转预存款转为新专款 <br/>
	 */
	OutDTO kdTsCfm(InDTO inParam);
	
	/** 
	* 名称：包年转账校验服务	<br/>
	* 功能：实现包年专款转账校验，主要校验可转金额是否足够
	 */
	OutDTO bnCheck(InDTO inParam);

	/** 
	* 名称：专款转账冲正服务<br/>
	* 功能：实现专款转账冲正服务<br/>
	* @return 
	 */
	public OutDTO rollBack (InDTO inParam);
	
	
	/** 
	* 名称：专款转账取消服务	<br/>
	* 功能：实现专款转账的取消<br/>
	* @return 
	 */
	public OutDTO cancelCfm (InDTO inParam);

	/** 
	* 名称：包年取消	<br/>
	* 功能：实现包年业务取消，专款结束日期做更新、记录包年取消表BAL_YEARCANCEL_INFO<br/>
	* @return 
	 */
	public OutDTO yearCancel(InDTO inParam);
}
