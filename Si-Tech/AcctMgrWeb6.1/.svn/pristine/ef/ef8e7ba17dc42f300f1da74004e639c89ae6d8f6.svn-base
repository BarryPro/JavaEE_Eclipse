package com.sitech.acctmgr.atom.dto.adj;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.adj.SpInfoEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

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
public class S8041SpOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 946722043046000308L;

	@JSONField(name="LEN_SPINFO")
	@ParamDesc(path="LEN_SPINFO",cons=ConsType.CT001,type="int",len="10",desc="SP业务列表长度",memo="略")
	protected int lenSpinfo;
	
	@JSONField(name="LIST_SPINFO")
	@ParamDesc(path="LIST_SPINFO",cons=ConsType.STAR,type="compx",len="1",desc="SP业务列表",memo="略")
	protected List<SpInfoEntity> listSpInfol;
	
	
 
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setBody("LIST_SPINFO",listSpInfol);
		result.setBody("LEN_SPINFO",lenSpinfo);
		return result;
	}



	/**
	 * @return the listSpInfol
	 */
	public List<SpInfoEntity> getListSpInfol() {
		return listSpInfol;
	}



	/**
	 * @param listSpInfol the listSpInfol to set
	 */
	public void setListSpInfol(List<SpInfoEntity> listSpInfol) {
		this.listSpInfol = listSpInfol;
	}



	/**
	 * @return the lenSpinfo
	 */
	public int getLenSpinfo() {
		return lenSpinfo;
	}



	/**
	 * @param lenSpinfo the lenSpinfo to set
	 */
	public void setLenSpinfo(int lenSpinfo) {
		this.lenSpinfo = lenSpinfo;
	}

	 
	
}
