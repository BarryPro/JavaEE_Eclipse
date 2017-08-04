package com.sitech.acctmgr.atom.dto.adj;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.bill.ItemEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;


/**
*
* <p>Title:   </p>
* <p>Description:   </p>
* <p>Copyright: Copyright (c) 2014</p>
* <p>Company: SI-TECH </p>
* @author liuyc_billing
* @version 1.0
*/
public class S8010GetItemOutDTO extends CommonOutDTO{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -8576646030595552700L;
	
	@JSONField(name="ITEM_INFO")
	@ParamDesc(path="ITEM_INFO",cons=ConsType.STAR,type="compx",len="1",desc="资费标识",memo="略")
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
