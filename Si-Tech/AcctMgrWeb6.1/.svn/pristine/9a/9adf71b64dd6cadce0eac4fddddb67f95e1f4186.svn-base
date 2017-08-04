package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.atom.domains.balance.BookTypeEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>
 * Title: 查询pay_type的信息，冲销信息，回收落地账目项信息出参DTO
 * </p>
 * <p>
 * Description: 查询pay_type的信息，冲销信息，回收落地账目项信息出参DTO，封装出参情况
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
public class S8414QryPayTypeInfoOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6395318669641105500L;

	@ParamDesc(path = "BOOK_TYPE", cons = ConsType.CT001, type = "compx", len = "1", desc = "账本信息", memo = "略")
	private BookTypeEntity bookType = null;

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sitech.jcfx.dt.out.OutDTO#encode()
	 */
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("bookType"), bookType);
		log.info(result.toString());
		return result;
	}

	public BookTypeEntity getBookType() {
		return bookType;
	}

	public void setBookType(BookTypeEntity bookType) {
		this.bookType = bookType;
	}

}
