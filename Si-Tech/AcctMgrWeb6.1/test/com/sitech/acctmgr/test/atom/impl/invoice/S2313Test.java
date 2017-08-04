package com.sitech.acctmgr.test.atom.impl.invoice;

import java.util.HashMap;
import java.util.Map;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.dto.invoice.S2313InDTO;
import com.sitech.acctmgr.inter.invoice.I2313;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

public class S2313Test extends BaseTestCase {

	private I2313 bean;

	@Before
	public void setUp() throws Exception {
		bean = (I2313) getBean("2313Svc");
	}

	@After
	public void tearDown() throws Exception {
		bean = null;
	}

	private String getArgStringForPrint() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiMap = new HashMap<>();
		busiMap.put("INV_CODE", "123001570712");
		busiMap.put("BEGIN_NO", "58034975");
		busiMap.put("END_NO", "58034990");
		busiMap.put("REGION_GROUP_ID", "10031");
		busiMap.put("DISTINCT_GROUP_ID", "10057");
		busiMap.put("GROUP_ID", "");

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
	public void testRegionEnter() throws Exception {
		String inStr = getArgStringForPrint();
		System.err.println(inStr + ">>>>>");
		InDTO inDTO = parseInDTO(inStr, S2313InDTO.class);
		OutDTO outDTO = bean.regionEnter(inDTO);
		System.err.println(outDTO.toJson());

	}

	@Test
	public void testDisEnter() throws Exception {
		String inStr = getArgStringForPrint();
		System.err.println(inStr + ">>>>>");
		InDTO inDTO = parseInDTO(inStr, S2313InDTO.class);
		OutDTO outDTO = bean.distinctEnter(inDTO);
		System.err.println(outDTO.toJson());

	}

	@Test
	public void testGroupEnter() throws Exception {
		String inStr = getArgStringForPrint();
		System.err.println(inStr + ">>>>>");
		InDTO inDTO = parseInDTO(inStr, S2313InDTO.class);
		OutDTO outDTO = bean.groupEnter(inDTO);
		System.err.println(outDTO.toJson());

	}
}
