package com.sitech.acctmgr.test.junit;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.BeforeClass;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.TestExecutionListeners;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.sitech.jcf.core.dao.IBaseDao;
import com.sitech.jcfx.context.JCFContext;
import com.sitech.jcfx.dt.DataBus;
import com.sitech.jcfx.dt.DtKit;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

/**
 * SpringJUnit4ClassRunner.class不支持junit4.5以下的版本。只需要把junit4.4或者更低版本升级到更高版本。
 * 
 */
@RunWith(SpringJUnit4ClassRunner.class)
@TestExecutionListeners({ LoadPathExecutionListener.class })
@ContextConfiguration(locations = "classpath:applicationContext-junit.xml")
public abstract class BaseTestCase extends AbstractJUnit4SpringContextTests
{

	protected Log log = LogFactory.getLog(this.getClass());
	protected IBaseDao baseDao;
	
	/**
	 * @param baseDao
	 *            the baseDao to set
	 */
	public void setBaseDao(IBaseDao baseDao){
		String packageName = this.getClass().getPackage().getName();
		//使用StringUtils.split性能更高
		String[] str = StringUtils.split(packageName, "\\.");
		if(str[3].equals("atom") || str[3].equals("app")){
			this.baseDao = baseDao;
		}
	}

	public IBaseDao getBaseDao() {
		return baseDao;
	}

	@BeforeClass
	public static void onSetup()
	{
		JCFContext.junitInit();
	}

	/**
	 * 根据Bean的名称获取Spring注册的对象实例
	 * 
	 * @param beanName
	 *            注册名称
	 * @return 对应的实例队形
	 */
	protected static Object getBean(String beanName)
	{
		return JCFContext.getBean(beanName);
	}

	/**
	 * @Description: 使用MBean生成InDTO
	 * @author: zhangzza
	 * @createTime: 2014年9月28日 下午2:29:02
	 * 
	 * @param
	 * @return InDTO
	 */
	protected InDTO parseInDTO(MBean in, Class<?> clazz)
	{
		InDTO inDTO = DtKit.toDTO(in, clazz);
		DataBus.setMBean(in);
		//DataBus.setInDTO(inDTO);

		return inDTO;
	}

	/**
	 * @Description: 使用json字符串生成InDTO
	 * @author: zhangzza
	 * @createTime: 2014年9月28日 下午2:29:33
	 * 
	 * @param
	 * @return InDTO
	 */
	protected InDTO parseInDTO(String in, Class<?> clazz)
	{
		MBean inBean = new MBean(in);
		InDTO inDTO = DtKit.toDTO(inBean, clazz);
		DataBus.setMBean(inBean);
		//DataBus.setInDTO(inDTO);

		return inDTO;
	}
}
