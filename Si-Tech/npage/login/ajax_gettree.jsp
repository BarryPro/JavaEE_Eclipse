<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.security.DESPlus"%>
<%
	String parentNode = request.getParameter("parentNode");
	String parentName = request.getParameter("parentName");
	String themePath = (String)session.getAttribute("themePath");
	System.out.println("parentNode="+parentNode);
	
	String  loginNo = (String)session.getAttribute("login_no");
	String  loginStatus = (String)session.getAttribute("login_status");
	String  region_id = (String)session.getAttribute("region_id");
	
	String key_4a = Configuration.getValue("KEY_4A");
    DESPlus desPlus = new DESPlus(key_4a);
    String login_password = desPlus.encrypt("a12345");  //ÃÜÂë¼ÓÃÜ
	
	DESPlus des = new DESPlus("sitech4a");
	String str="login_no=MZZZZZ002&login_password="+login_password+"&ip_address=192.168.20.131&op_code=2923&sendTime=20100202112558947";
	str = des.encrypt(str);
	
  
	
%>

<s:service name="sLogPdomList" >
      <s:param  name="root">
      	<s:param  name="LOGIN_NO" type="string" value="<%=loginNo%>"  />	
      	<s:param  name="LOGIN_STATUS" type="string" value="<%=loginStatus%>"  />	
      	<s:param  name="PARENT_CODE" type="string" value="<%=parentNode%>"  />	
      	<s:param  name="REGION_ID" type="int" value="<%=region_id%>"  />	
      	<s:param  name="OUTDATANAME" type="string" value="RESULT"  />
      </s:param>
</s:service>

<script language="JavaScript">	
	tree<%=parentNode%> = new MzTreeView("tree<%=parentNode%>");
	tree<%=parentNode%>.setIconPath("/nresources/<%=themePath%>/images/mztree/");
	with(tree<%=parentNode%>)
	{
		N["0_<%=parentNode%>"]="T:<%=parentName%>";
		<%
		List data = result.getList("RESULT.RESULT");
		Map map = new HashMap();
		for(int i =0;i<data.size();i++){
			map= MapBean.isMap(data.get(i));
			if(map==null)continue;
			String is_force = (String)map.get("IS_FORCE");
			String authen_flag = (String)map.get("AUTHEN_FLAG");
		%>
			N["<%=map.get("PARENT_CODE")%>_<%=map.get("FUNCTION_CODE")%>"]="T:<%=map.get("FUNCTION_NAME")%>;C:L('<%=map.get("POP_TYPE")%>','<%=map.get("FUNCTION_CODE")%>','<%=map.get("FUNCTION_NAME")%>','<%=map.get("JSP_NAME")%>','<%=is_force+"_"+authen_flag%>')";
		<%
		}
		%>
	}
$('#node<%=parentNode%>').html(tree<%=parentNode%>.toString());
</script>
