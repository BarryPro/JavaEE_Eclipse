<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
    /*midify by yinzx 20091113 公共查询服务替换*/
    String myParams="";
    String myParams2="";
    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);
  String callerPhone = WtcUtil.repNull(request.getParameter("callerPhone"));
  String sql="select  '1' from dcusthigh b where b.phone_no = :callerPhone  and b.grade_code in ('01','02','03') ";
  myParams="callerPhone="+callerPhone;
%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="4">
			<wtc:param value="<%=sql%>"/>
			<wtc:param value="<%=myParams%>"/>
			</wtc:service>
		<wtc:array id="tSqlTempData2"  scope="end"/>			
var response = new AJAXPacket();
<%
  if(tSqlTempData2.length>0){
%>
     response.data.add("bossUserClass","vip");
     response.data.add("bossUserBrand","vip");

<%
  }else{
  	
  sql="select substr(belong_code,1,2),substr(attr_code,3,2), sm_code from dcustmsg where 1=1 and ";
  if(!callerPhone.equals("")){
  		sql = sql+"phone_no = :callerPhone " ;
  		myParams2="callerPhone="+callerPhone;
  }
	
%>
  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="3">
			<wtc:param value="<%=sql%>"/>
			<wtc:param value="<%=myParams2%>"/>
			</wtc:service>
		<wtc:array id="tSqlTempData"  scope="end"/>	
<%
 if(tSqlTempData.length>0){
 %>  
     response.data.add("bossUserClass","<%=tSqlTempData[0][1]%>");
     response.data.add("bossUserBrand","<%=tSqlTempData[0][2]%>");

<%
 }else{			
			
%>
 response.data.add("bossUserClass","2");
 response.data.add("bossUserBrand","00");
	<%
	}
	}
  %>
core.ajax.receivePacket(response);
