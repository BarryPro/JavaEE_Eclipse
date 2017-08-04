package com.sitech.acctmgr.test.atom.impl.invoice;

import java.util.HashMap;
import java.util.Map;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.dto.invoice.S8215PrintInDTO;
import com.sitech.acctmgr.inter.invoice.I8215;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

public class S8215InvoiceTest extends BaseTestCase {

	private I8215 bean;

	@Before
	public void setUp() throws Exception {
		bean = (I8215) getBean("8215Svc");
	}

	@After
	public void tearDown() throws Exception {
		bean = null;
	}

	private String getArgStringForPrint() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiMap = new HashMap<>();
		busiMap.put("INV_NO", "11111");
		busiMap.put("INV_CODE", "123456789");
		busiMap.put("UNIT_NAME", "张三");
		busiMap.put("PHONE_NO", "17600834360");
		busiMap.put("CONTRACT_NO", "23071568749641");
		busiMap.put("CHECK_NO", "521067");
		busiMap.put("PRINT_FEE", "100");
		busiMap.put("ITEM1", "100");
		busiMap.put("ITEM2", "200");
		busiMap.put("ITEM3", "300");
		busiMap.put("REMARK", "DDDDDD");

		builder.setBusiargs(busiMap);

		Map<String, Object> oprMap = new HashMap<>();
		oprMap.put("LOGIN_NO", "aan70W");
		oprMap.put("OP_CODE", "8215");
		oprMap.put("GROUP_ID", "13436");
		oprMap.put("PROVINCE_ID", "230000");
		builder.setOperargs(oprMap);

		return builder.toString();
	}

	@Test
	public void testPrint() throws Exception {
		String inStr = getArgStringForPrint();
		System.err.println(">>>>>>" + inStr);
		InDTO inDTO = parseInDTO(inStr, S8215PrintInDTO.class);
		OutDTO outDTO = bean.print(inDTO);
		System.err.println(outDTO.toJson());

	}

}
