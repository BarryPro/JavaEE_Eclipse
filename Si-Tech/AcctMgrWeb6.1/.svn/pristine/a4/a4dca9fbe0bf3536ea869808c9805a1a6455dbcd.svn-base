package com.sitech.acctmgr.atom.dto.adj;

import com.sitech.acctmgr.atom.domains.bill.BillItemEntity;
import com.sitech.acctmgr.atom.domains.bill.ItemEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.dt.MBean;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author LIJXD
 * @version 1.0
 */
public class S8011GetItemOutDTO extends CommonOutDTO {

	protected List<ItemEntity> itemList = new ArrayList<ItemEntity>();

	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setBody("ITEM_INFO",itemList);
		return result;
	}

	public List<ItemEntity> getItemList() {
		return itemList;
	}

	public void setItemList(List<ItemEntity> itemList) {
		this.itemList = itemList;
	}
}
