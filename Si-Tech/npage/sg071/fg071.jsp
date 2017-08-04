<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.cache.ServiceTemplate"%>
<head>
	<title>WTC配置</title>
	<%
		String opCode = "g071";
		String opName = "WTC配置";
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
	%>
	<%
		String flag = request.getParameter("flag");
		String paths = System.getProperty("user.dir")+"/applications/lib/7001/";
		System.out.println("paths ["+paths+"]");
		System.out.println("flag====="+flag);
		
		ServiceTemplate stemplate = ServiceTemplate.getInstance();
		Map sMap = stemplate.getServiceMap();
	%>
	<script language="javascript">
    	//添加    	
    	function addService(){
    		document.forms[0].action="fg071.jsp?flag=1";
    		document.forms[0].method="post";
    		document.forms[0].submit();
    	}
    	
    	//删除
    	function removeService(){
    		document.forms[0].action="fg071.jsp?flag=2";
    		document.forms[0].method="post";
    		document.forms[0].submit();
    	}
    	
    	//重新加载
    	function reloadService(){
    		document.forms[0].action="fg071.jsp?flag=3";
    		document.forms[0].method="post";
    		document.forms[0].submit();
    	}
    	
    	//查询
    	function QueryService(){
    		document.forms[0].action="fg071.jsp?flag=4";
    		document.forms[0].method="post";
    		document.forms[0].submit();
    	}
    	
    	function reloadService2(){
    		document.forms[0].action="fg071_2.jsp";
    		document.forms[0].method="post";
    		document.forms[0].submit();
    	}
	</script>
<body>
<form name="frm" method="POST" action="selectserv_Cfm.jsp">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">WTC配置</div>
	</div>
    <table>
    	<tr>
    		<td class="blue" width="15%">新增Service</td>
    		<td>
    			<input type="text" name="serviceName" value="">
    			<input type="button" onclick="addService()" value="添加" class="b_text"/>
    			<input type="button" onclick="removeService()" value="删除" class="b_text"/>
    		</td>
    	</tr>
    	<tr>
    		<td colspan="2">
    			<input type="button" onclick="QueryService()" value="查询所有" class="b_text"/>
    			<input type="button" onclick="reloadService()" value="重新加载" class="b_text" style="display:none;"/>
    			<input type="button" onclick="reloadService2()" value="重新加载" class="b_text"/>
    		</td>
    	</tr>
    	<tr>
    		<td colspan="2">
    			<%
			    	String serviceName = request.getParameter("serviceName")==null?"":request.getParameter("serviceName");
			    	if(flag!=null){
			    		int cflag = 0;
			    		try{
			    			cflag = Integer.parseInt(flag);//类型转换容错
			    		}catch(Exception e){
			    			e.printStackTrace();
			    		}finally{
			    			switch(cflag){
					    		case 1://增加
					    			if(!serviceName.equals("")){
							     		stemplate.writeToFile(paths, serviceName, "BOSS");
							     		sMap.put(serviceName,"BOSS");
						     		}
							     	break;
							    case 2://删除
							    	if(!serviceName.equals("")){
							     		Properties pro = new Properties();
											paths = paths+"/SERVICE_CONFIG.properties";
											try {
												pro.load(new FileInputStream(paths));
												if(pro.get(serviceName)!=null) pro.remove(serviceName);
												pro.store(new FileOutputStream(paths),"update time");
											} catch (FileNotFoundException e1) {
												e1.printStackTrace();
											} catch (IOException e1) {
												e1.printStackTrace();
											}
							     		sMap.remove(serviceName);
						     		}
							    	break;
							    case 3://重新加载
							    	ResourceBundle rb = ResourceBundle.getBundle("SERVICE_CONFIG");
										for (Enumeration keys = rb.getKeys (); keys.hasMoreElements ();){
									     final String key = (String) keys.nextElement ();
									     final String value = rb.getString (key);
									     
									     sMap.put (key, value);
										}
						     		break;
						     	default://
						     		Set key = sMap.keySet();
				    		 		out.println("内存中service列表个数："+sMap.size()+"</br></br>");
							     	for (Iterator it = key.iterator(); it.hasNext();) {
							         	String s = (String) it.next();
							         	System.out.println(s);
							         	out.println(s+"="+sMap.get(s)+"</br>");
							     	}
						     		break;
					    	}
			    		}
			    	}
			    
			     %>
    		</td>
    	</tr>
    </table>
	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
				<input type="button" name="close" class="b_foot" value="关闭" onClick="removeCurrentTab();">
			</div>
			</td>
		</tr>
	</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
