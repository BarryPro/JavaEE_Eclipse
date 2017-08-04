<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
		String shortNo = WtcUtil.repNull(request.getParameter("shortNo"));
		System.out.println("######################################shortNo=="+shortNo);
		String groupId = WtcUtil.repNull(request.getParameter("groupId"));
		System.out.println("######################################groupId=="+groupId);
		StringBuffer sbSql = new StringBuffer();
		sbSql.append("select ACC_NBR from group_instance_member ");
		sbSql.append("where SHORT_NUM= '");
		sbSql.append(shortNo);
		sbSql.append("' and group_id = '");
		sbSql.append(groupId);
		sbSql.append("' and STATE='A' AND EXP_DATE>SYSDATE");
		String flag="";
%>
<wtc:pubselect name="sPubSelect" outnum="1">
 <wtc:sql><%=sbSql.toString()%></wtc:sql> 
</wtc:pubselect>
<wtc:array id="result" scope="end"/>
	<%
	if("000000".equals(retCode)){
	System.out.println("######################################result.length=="+result.length);
		if(result.length>0){
		flag="Y";
	}else{
		flag="N";
		}
	}
	out.println(flag);
	%>