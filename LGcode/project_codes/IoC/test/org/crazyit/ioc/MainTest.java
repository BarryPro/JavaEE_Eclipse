package org.crazyit.ioc;

import org.junit.runner.RunWith;
import org.junit.runners.Suite;
import org.junit.runners.Suite.SuiteClasses;

import IoC.test.org.crazyit.ioc.context.BeanCreatorTest;
import IoC.test.org.crazyit.ioc.context.PropertyHandlerTest;
import IoC.test.org.crazyit.ioc.context.XmlApplicationContextTest;
import IoC.test.org.crazyit.ioc.factory.XmlBeanFactoryTest;
import IoC.test.org.crazyit.ioc.xml.ElementLoaderTest;
import IoC.test.org.crazyit.ioc.xml.ElementReaderTest;
import IoC.test.org.crazyit.ioc.xml.XmlHolderTest;

@RunWith(Suite.class)
@SuiteClasses( { ElementReaderTest.class, ElementLoaderTest.class, 
	XmlHolderTest.class,BeanCreatorTest.class, PropertyHandlerTest.class,
	XmlApplicationContextTest.class, XmlBeanFactoryTest.class})
public class MainTest {
	
}
