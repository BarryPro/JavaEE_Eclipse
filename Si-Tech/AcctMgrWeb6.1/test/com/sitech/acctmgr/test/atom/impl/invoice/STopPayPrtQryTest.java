package com.sitech.acctmgr.test.atom.impl.invoice;

import java.util.HashMap;
import java.util.Map;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.dto.query.STopPayPrtQryInDTO;
import com.sitech.acctmgr.inter.query.ITopPayPrtQry;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

public class STopPayPrtQryTest extends BaseTestCase {

	private ITopPayPrtQry bean;

	@Before
	public void setUp() throws Exception {
		bean = (ITopPayPrtQry) getBean("topPayPrtQrySvc");
	}

	@After
	public void tearDown() throws Exception {
		bean = null;
	}

	private String getArgStringForqry() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiMap = new HashMap<>();
		busiMap.put("FOREIGN_SN", "PST2340157-80812522349321");
		busiMap.put("TOTAL_DATE", "201612");
		busiMap.put("PHONE_NO", "13504680035");

		builder.setBusiargs(busiMap);

		Map<String, Object> oprMap = new HashMap<>();
		oprMap.put("LOGIN_NO", "aan70W");
		oprMap.put("OP_CODE", "8006");
		oprMap.put("GROUP_ID", "13436");
		oprMap.put("PROVINCE_ID", "230000");
		builder.setOperargs(oprMap);

		return builder.toString();
	}

	@Test
	public void testQryPayInfo() throws Exception {
		String inStr = getArgStringForqry();
		System.err.println("inStr:" + inStr);
		InDTO inDTO = parseInDTO(inStr, STopPayPrtQryInDTO.class);
		OutDTO outDto = bean.query(inDTO);
		System.err.println("outdto:" + outDto.toJson());
	}

}
