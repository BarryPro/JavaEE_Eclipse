package com.sitech.acctmgr.atom.dto.query;

import java.util.List;

import com.sitech.acctmgr.atom.domains.query.SpFeeRecycleEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>
 * Title: 回收专款查询出参DTO
 * </p>
 * <p>
 * Description: 回收专款查询出参DTO，封装出参情况
 * </p>
 * <p>
 * Copyright: Copyright (c) 2014
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author liuhl_bj
 * @version 1.0
 */
public class S8413OutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6395318669641105500L;

	@ParamDesc(path = "BILL_LIST", cons = ConsType.QUES, type = "compx", len = "1", desc = "回收专款查询", memo = "略")
	private List<SpFeeRecycleEntity> spFeeRecyList = null;

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sitech.jcfx.dt.out.OutDTO#encode()
	 */
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("spFeeRecyList"), spFeeRecyList);
		log.info(result.toString());
		return result;
	}

	public List<SpFeeRecycleEntity> getSpFeeRecyList() {
		return spFeeRecyList;
	}

	public void setSpFeeRecyList(List<SpFeeRecycleEntity> spFeeRecyList) {
		this.spFeeRecyList = spFeeRecyList;
	}

}
