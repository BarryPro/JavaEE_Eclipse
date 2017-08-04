package com.sitech.acctmgr.atom.dto.pay;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.pay.GroupChargeEntity;
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
 * @author LIJXD
 * @version 1.0
 */
public class S8296InitErrOutDTO extends CommonOutDTO{
	/**
	 * 
	 */
	private static final long serialVersionUID = 803941061459939398L;
	//消费信息
	@JSONField(name="LIST_GRPCON")
	@ParamDesc(path="LIST_GRPCON",cons=ConsType.STAR,type="compx",len="1",desc="集团账户划拨成功列表",memo="略")
	protected List<GroupChargeEntity> listGrpCon;
	@JSONField(name="GRPCON_SIZE")
	@ParamDesc(path="GRPCON_SIZE",cons=ConsType.CT001,type="int",len="14",desc="集团账户划拨成功数",memo="略")
	protected int grpConSize = 0;
	
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setRoot(getPathByProperName("listGrpCon"), listGrpCon);
		result.setRoot(getPathByProperName("grpConSize"), grpConSize);
		return result;
	}

	/**
	 * @return the listGrpCon
	 */
	public List<GroupChargeEntity> getListGrpCon() {
		return listGrpCon;
	}

	/**
	 * @param listGrpCon the listGrpCon to set
	 */
	public void setListGrpCon(List<GroupChargeEntity> listGrpCon) {
		this.listGrpCon = listGrpCon;
	}

	/**
	 * @return the grpConSize
	 */
	public int getGrpConSize() {
		return grpConSize;
	}

	/**
	 * @param grpConSize the grpConSize to set
	 */
	public void setGrpConSize(int grpConSize) {
		this.grpConSize = grpConSize;
	}
 
 
 
}
