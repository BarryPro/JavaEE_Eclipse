package com.sitech.acctmgr.test.junit;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.test.context.TestContext;
import org.springframework.test.context.support.AbstractTestExecutionListener;

import com.sitech.jcf.core.App;

public class LoadPathExecutionListener extends AbstractTestExecutionListener {
	private  Log log = LogFactory.getLog(this.getClass());
	
	public void beforeTestClass(TestContext testContext) throws Exception {
		String path = Thread.currentThread().getContextClassLoader().getResource("").getPath();
        String compilePath = path.replaceFirst("test-classes", "classes");
        log.info("编译路径：  " + compilePath);
        App.setAppPath(compilePath);
	}

}
