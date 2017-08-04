package com.sitech.acctmgr.inter.query;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * 名称：查询专款账目项和一级账目项，二级账目项，三级账目项的配置信息
 * 
 * @author liuhl
 *
 */
public interface I8414 {

	/**
	 * 名称：查询专款列表
	 * 
	 * @param inParam
	 * @return
	 */
	OutDTO queryPayTypeList(InDTO inParam);

	/**
	 * 名称:根据pay_type查询冲销计划，pay_type是否可转等信息，回收时落地的账目项信息
	 * 
	 * @param inParam
	 * @return
	 */
	OutDTO queryPayTypeInfo(InDTO inParam);

	/**
	 * 名称：查询一级账目项，二级账目项，三级账目项列表
	 * 
	 * @param inParam
	 * @return
	 */
	OutDTO queryItemInfo(InDTO inParam);

	/**
	 * 名称：根据一级账目项查询关联的二级账目项，分页展示
	 * 
	 * @param inParam
	 * @return
	 */
	OutDTO querySecondItemInfoByFirstItem(InDTO inParam);

	/**
	 * 名称：根据一级账目项查询关联的三级账目项，分页展示
	 * 
	 * @param inParam
	 * @return
	 */
	OutDTO queryThirdItemInfoByFirstItem(InDTO inParam);

	/**
	 * 名称：查询一级账目项
	 * 
	 * @param inParam
	 * @return
	 */
	OutDTO queryFirstItemInfo(InDTO inParam);

	/**
	 * 名称：查询账本的落地账目项
	 * 
	 * @param inParam
	 * @return
	 */
	OutDTO queryDownItem(InDTO inParam);

	/**
	 * 名称：查询账本冲销账目项
	 * 
	 * @param inParam
	 * @return
	 */
	OutDTO queryWriteItem(InDTO inParam);
}
