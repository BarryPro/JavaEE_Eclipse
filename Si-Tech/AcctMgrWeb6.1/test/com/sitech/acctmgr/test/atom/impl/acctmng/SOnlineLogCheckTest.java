/**
 * 
 */
package com.sitech.acctmgr.test.atom.impl.acctmng;

import java.util.HashMap;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.dto.acctmng.SOnlineLogCheckInDTO;
import com.sitech.acctmgr.inter.acctmng.IOnlineLogCheck;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * @author liuhl_bj
 *
 */
public class SOnlineLogCheckTest extends BaseTestCase {
	private IOnlineLogCheck bean = null;

	@Before
	public void before() {
		bean = (IOnlineLogCheck) getBean("onlineLogCheckSvc");
	}

	public String getArgstringOnlineLogCheck() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiargs = new HashMap<String, Object>();

		busiargs.put("BEGIN_TIME", "20100411122446");
		busiargs.put("PHONE_NO", "13836395517");
		busiargs.put("END_TIME", "20170419122556");
		builder.setBusiargs(busiargs);
		Map<String, Object> oprMap = new HashMap<>();
		oprMap.put("LOGIN_NO", "aan70W");
		oprMap.put("OP_CODE", "8181");
		oprMap.put("GROUP_ID", "12304");
		builder.setOperargs(oprMap);
		String argstring = builder.toString();
		return argstring;
	}

	@Test
	public void testCheck() {
		String inString = getArgstringOnlineLogCheck();
		System.err.println(inString);
		MBean mbean = new MBean(inString);
		InDTO inParam = this.parseInDTO(mbean, SOnlineLogCheckInDTO.class);
		OutDTO outDto = bean.check(inParam);
		System.err.println(outDto.toJson());
	}

}
