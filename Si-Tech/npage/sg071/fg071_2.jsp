<%@ page language="java" import="java.util.*,java.io.*" pageEncoding="GBK"%>
<%@ page import="com.sitech.crmpd.core.wtc.cache.ServiceTemplate"%>
<%
ServiceTemplate stemplate = ServiceTemplate.getInstance();
Map sMap = stemplate.getServiceMap();
sMap.clear();
ResourceBundle rb = ResourceBundle.getBundle("SERVICE_CONFIG");
for (Enumeration keys = rb.getKeys (); keys.hasMoreElements ();)
{
     final String key = (String) keys.nextElement ();
     final String value = rb.getString (key);
     
     sMap.put (key, value);
}
%>

	<script language="javascript">
			location = "/npage/sg071/fg071.jsp";
	</script>
