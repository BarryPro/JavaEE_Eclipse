/**
 * 
 */
package com.sitech.acctmgr.test.atom.impl.acctmng;

import java.util.HashMap;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.dto.query.SMonthShareQryInDTO;
import com.sitech.acctmgr.inter.billAccount.IMonthShareQry;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * @author liuhl_bj
 *
 */
public class SMonthShareQryTest extends BaseTestCase {
	private IMonthShareQry bean = null;

	@Before
	public void before() {
		bean = (IMonthShareQry) getBean("monthShareQrySvc");
	}

	public String getArgstringMonthShareQry() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiargs = new HashMap<String, Object>();

		busiargs.put("ID_NO", "230110010000071172");
		busiargs.put("PHONE_NO", "20700071172");
		busiargs.put("FLAG", "Y");
		builder.setBusiargs(busiargs);
		Map<String, Object> oprMap = new HashMap<>();
		oprMap.put("LOGIN_NO", "aan70W");
		oprMap.put("OP_CODE", "0000");
		oprMap.put("GROUP_ID", "12304");
		builder.setOperargs(oprMap);
		String argstring = builder.toString();
		return argstring;
	}

	@Test
	public void testQryMonthShare() {
		String inString = getArgstringMonthShareQry();
		System.err.println(inString);
		MBean mbean = new MBean(inString);
		InDTO inParam = this.parseInDTO(mbean, SMonthShareQryInDTO.class);
		OutDTO outDto = bean.queryMonthShare(inParam);
		System.err.println(outDto.toJson());
	}

}
