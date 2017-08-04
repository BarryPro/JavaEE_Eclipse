package com.sitech.acctmgr.inter.cct;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
*
* <p>Title: 信用度以及星级修改接口 </p>
* <p>Copyright: Copyright (c) 2014</p>
* <p>Company: SI-TECH </p>
*/
public interface I8157 {
	OutDTO init(final InDTO inParam);
	/**
	 * @author liuhl_bj
	 * Description:用户星级修改
	 * @param sPhoneNo 服务号码
	 * 		  sPassWord  用户密码
	 * 		  sCreditGrade  信用度
	 * 		  sOperNote   操作属性
	 * 		  sLoginNo	工号
	 * @return
	 */
	OutDTO cfm(final InDTO inParam);
	
	/**
	 * @author xiongjy
	 * Description:用户信誉度修改
	 * @param idNo 
	 * 		  oldCredit  
	 * 		  newCredit  
	 * 		  expireTime   
	 * 		  opNote	
	 * @return
	 */
	OutDTO creditCfm(final InDTO inParam);
}
