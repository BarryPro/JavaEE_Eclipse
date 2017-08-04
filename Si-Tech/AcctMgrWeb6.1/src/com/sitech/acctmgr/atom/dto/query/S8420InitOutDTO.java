package com.sitech.acctmgr.atom.dto.query;

import java.util.List;

import com.sitech.acctmgr.atom.domains.query.TdUnifyPayEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8420InitOutDTO extends CommonOutDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path="RESULTLIST",cons=ConsType.STAR,type="compx",len="1",desc="TD统付列表",memo="略")
	List<TdUnifyPayEntity> resultList;
	
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("resultList"), resultList);
		log.info(result.toString());
		return result;
	}

	/**
	 * @return the resultList
	 */
	public List<TdUnifyPayEntity> getResultList() {
		return resultList;
	}

	/**
	 * @param resultList the resultList to set
	 */
	public void setResultList(List<TdUnifyPayEntity> resultList) {
		this.resultList = resultList;
	}
}
