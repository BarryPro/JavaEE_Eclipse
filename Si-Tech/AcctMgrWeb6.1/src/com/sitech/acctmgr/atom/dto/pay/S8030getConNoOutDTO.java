package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.account.ContractEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;

/**
 *
 * <p>Title: 托收缴费查询托收账户出参DTO   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public class S8030getConNoOutDTO extends CommonOutDTO{

	private static final long serialVersionUID = -3453705262842807165L;
    
	@JSONField(name="COLLECTION_CON")
	@ParamDesc(path="COLLECTION_CON",cons=ConsType.STAR,type="compx",len="",desc="托收帐户信息列表",memo="略")
	protected List<ContractEntity> collection = null; 
	
	public MBean encode(){
		MBean result = super.encode();
		result.setRoot(getPathByProperName("collection"), collection);
		return result;
	}

	/**
	 * @return the collection
	 */
	public List<ContractEntity> getCollection() {
		return collection;
	}

	/**
	 * @param collection the collection to set
	 */
	public void setCollection(List<ContractEntity> collection) {
		this.collection = collection;
	}

}
