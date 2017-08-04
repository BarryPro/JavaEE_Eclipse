<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

	String callerPhone = WtcUtil.repNull(request.getParameter("callerPhone"));
	java.util.Date now = new java.util.Date();
	java.text.SimpleDateFormat outFormat = new java.text.SimpleDateFormat("yyyyMM");
	String yearmonth = outFormat.format(now);
	String sqlStr = "select to_char(nvl(count(*),0)) from dcallcall"+yearmonth+" d where d.begin_date> sysdate - 2/24 and d.end_date<trunc(sysdate+1) and d.caller_phone=:callerPhone ";
	myParams = "callerPhone="+callerPhone ;
	String call_count = "0";
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="3">
	<wtc:param value="<%=sqlStr%>"/>
	<wtc:param value="<%=myParams%>"/>
	</wtc:service>
	<wtc:array id="resultList" scope="end"/>
	<%
	  if(resultList.length>0){
	     call_count = resultList[0][0];
	  }
		out.clear();
		out.print("Y|"+call_count);
	%>