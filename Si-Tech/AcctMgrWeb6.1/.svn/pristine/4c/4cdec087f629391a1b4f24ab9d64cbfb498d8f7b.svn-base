/**
 * 
 */
package com.sitech.acctmgr.test.atom.impl.acctmng;

import java.util.HashMap;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.dto.query.SFavTypeQueryInDTO;
import com.sitech.acctmgr.inter.query.IFavType;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * @author liuhl_bj
 *
 */
public class SFavTypeTest extends BaseTestCase {
	private IFavType bean = null;

	@Before
	public void before() {
		bean = (IFavType) getBean("favTypeSvc");
	}

	public String getArgstringFavTypeQry() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiargs = new HashMap<String, Object>();

		busiargs.put("PHONE_NO", "13704605933");
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
	public void testFavType() {
		String inString = getArgstringFavTypeQry();
		MBean mbean = new MBean(inString);
		InDTO inParam = this.parseInDTO(mbean, SFavTypeQueryInDTO.class);
		OutDTO outDto = bean.query(inParam);
		System.err.println("outDto:" + outDto.toJson());
	}

}
