package com.sitech.acctmgr.test.atom.impl.invoice;

import java.util.HashMap;
import java.util.Map;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.dto.invoice.eleInvoice.SEleInvoiceQueryInDto;
import com.sitech.acctmgr.inter.invoice.IEleInvoice;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

public class SEleInvoiceTest extends BaseTestCase {

	private IEleInvoice bean;

	@Before
	public void setUp() throws Exception {
		bean = (IEleInvoice) getBean("eleInvoiceSvc");
	}

	@After
	public void tearDown() throws Exception {
		bean = null;
	}

	private String getArgStringForPrint() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiMap = new HashMap<>();
		busiMap.put("INV_CODE", "1100111560");
		busiMap.put("INV_NO", "00466986");
		busiMap.put("BEGIN_DATE", "20161201");
		busiMap.put("END_DATE", "20170501");
		busiMap.put("INV_TYPE", "M");
		
		builder.setBusiargs(busiMap);

		Map<String, Object> oprMap = new HashMap<>();
		oprMap.put("LOGIN_NO", "aan70W");
		oprMap.put("OP_CODE", "2313");
		oprMap.put("GROUP_ID", "13436");
		oprMap.put("PROVINCE_ID", "230000");
		builder.setOperargs(oprMap);

		return builder.toString();
	}

	@Test
	public void testQuery() throws Exception {
		String inStr = getArgStringForPrint();
		System.err.println(inStr + ">>>>>");
		InDTO inDTO = parseInDTO(inStr, SEleInvoiceQueryInDto.class);
		OutDTO outDTO = bean.query(inDTO);
		System.err.println(outDTO.toJson());

	}


}
