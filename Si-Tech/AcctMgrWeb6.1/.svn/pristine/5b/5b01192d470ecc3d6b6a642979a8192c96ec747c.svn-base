package com.sitech.acctmgr.inter.pay;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;


/**
*
* <p>Title:  限额设置接口 </p>
* <p>Description:  限额设置接口 </p>
* <p>Copyright: Copyright (c) 2016</p>
* <p>Company: SI-TECH </p>
* @author SUZJ
* @version 1.0
*/
public interface I8203 {
	
	/**
	* 名称：限额查询
	* @param LIMIT_AREA:：限额区域
	* @param LIMIT_TYPE:：限额类型
	* @param REGION_GROUP:：地市group
	* @param DISTRICT_GROUP：区县group
	* 
	* @return REGION_MONTH_LIMIT：地市月限额
	* @return REGION_DAY_LIMIT：地市日限额
	* @return DISTRICT_MONTH_LIMIT：区县月限额
	* @return DISTRICT_DAY_LIMIT：区县日限额
	 */
	OutDTO init (InDTO inParam);
	
	/**
	* 名称：限额设置确认
	* @param LIMIT_AREA:：限额区域
	* @param LIMIT_TYPE:：限额类型
	* @param REGION_GROUP:：地市group
	* @param DISTRICT_GROUP：区县group
	* @param REGION_MONTH_LIMIT:：地市月限额
	* @param REGION_DAY_LIMIT:：地市日限额
	* @param DISTRICT_MONTH_LIMIT:：区县月限额
	* @param DISTRICT_DAY_LIMIT：区县日限额
	* 
	 */
	OutDTO cfm (InDTO inParam);
	
}
