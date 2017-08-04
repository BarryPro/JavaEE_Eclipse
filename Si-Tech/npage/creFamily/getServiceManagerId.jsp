<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
System.out.println("-----------------------------getServiceManagerId.jsp---------------------------------------");  
	String group_id = WtcUtil.repNull(request.getParameter("groupId"));
	System.out.println("====||group_id||===="+group_id);
	String sqlStr = "select t.login_no , t.login_name from dLoginMsg t where login_type='2' and group_id ='"+group_id+"'";
	System.out.println("====||sqlStr||===="+sqlStr);
	StringBuffer sb = new StringBuffer(80);
%>

<wtc:pubselect name="sPubSelect" outnum="2">
	<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end" />
	
<%
	if(retCode.equals("000000") && result.length > 0){
		for(int i=0;i<result.length;i++){
		
			sb.append("<option value='"+result[i][0]+"'>"+result[i][1]+"</option>");
		}	
	}	
	
	System.out.println("sqlStr:::::"+sqlStr);
	System.out.println("-------------------sb.toString()--------------------"+sb.toString());
%>
<%=sb.toString()%>
