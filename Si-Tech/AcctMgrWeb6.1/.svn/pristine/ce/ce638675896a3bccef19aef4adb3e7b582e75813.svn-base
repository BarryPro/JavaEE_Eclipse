package com.sitech.acctmgr.atom.dto.query;

import java.util.List;

import com.sitech.acctmgr.atom.domains.bill.ItemEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>
 * Title: 根据一级账目项查询二级账目项出参DTO
 * </p>
 * <p>
 * Description: 根据一级账目项查询二级账目项出参DTO，封装出参情况
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
public class S8414QryItemByFirstCodeOutDTO extends CommonOutDTO {

	private static final long serialVersionUID = -6395318669641105500L;

	@ParamDesc(path = "ITEM_LIST", cons = ConsType.QUES, type = "compx", len = "1", desc = "二级账目项", memo = "略")
	private List<ItemEntity> itemList = null;

	@ParamDesc(path = "TOTAL_NUM", cons = ConsType.QUES, type = "string", len = "10", desc = "总条数，用于分页", memo = "略")
	private int totalNum;

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sitech.jcfx.dt.out.OutDTO#encode()
	 */
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("itemList"), itemList);
		result.setRoot(getPathByProperName("totalNum"), totalNum);
		log.info(result.toString());
		return result;
	}

	public List<ItemEntity> getItemList() {
		return itemList;
	}

	public void setItemList(List<ItemEntity> itemList) {
		this.itemList = itemList;
	}

	public int getTotalNum() {
		return totalNum;
	}

	public void setTotalNum(int totalNum) {
		this.totalNum = totalNum;
	}

}
