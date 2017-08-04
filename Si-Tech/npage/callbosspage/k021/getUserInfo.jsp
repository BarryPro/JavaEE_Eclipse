<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
    /*midify by yinzx 20091113 公共查询服务替换*/
    String myParams="";
    String myParams2="";
    String myParams3="";
    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);
  String callerPhone = WtcUtil.repNull(request.getParameter("callerPhone"));
  String enterDateTime = new java.text.SimpleDateFormat("yyyyMMddHH:mm:ss").format(new java.util.Date());
  String sql="select '1' from dcusthigh b where b.phone_no = :callerPhone and b.grade_code in ('01','02','03') ";
  myParams3="callerPhone="+callerPhone;
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
			<wtc:param value="<%=sql%>"/>
			<wtc:param value="<%=myParams3%>"/>
			</wtc:service>
	<wtc:array id="tSqlTempData3"  scope="end"/>	
<%
  sql="select substr(belong_code,1,2),substr(attr_code,3,2), sm_code from dcustmsg where ";
  if(!callerPhone.equals("")){
  		sql = sql+"phone_no = :callerPhone " ;
  		myParams="callerPhone="+callerPhone;
  }else{
  	  sql = sql+"1 = 2 " ;
  }
%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="4">
			<wtc:param value="<%=sql%>"/>
			<wtc:param value="<%=myParams%>"/>
			</wtc:service>
		<wtc:array id="tSqlTempData"  scope="end"/>			
var response = new AJAXPacket();
<%
		if(tSqlTempData.length>0){
    sql = "select city_code from scallregioncode where region_code=:tSqlTempData";
    myParams2="tSqlTempData="+tSqlTempData[0][0];
%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
			<wtc:param value="<%=sql%>"/>
			<wtc:param value="<%=myParams2%>"/>
			</wtc:service>
		<wtc:array id="tSqlTempData2"  scope="end"/>			
<%
String city = "";
if(tSqlTempData2.length>0){
	city = tSqlTempData2[0][0];
}
%>
response.data.add("cityCode","<%=city%>");
<%
			if(tSqlTempData3.length>0){
%>
  		response.data.add("bossUserClass","vip");
			response.data.add("bossUserBrand","vip");
<%
			}else{
%>
	response.data.add("bossUserClass","<%=tSqlTempData[0][1]%>");
	response.data.add("bossUserBrand","<%=tSqlTempData[0][2]%>");

<%
			}
%>
response.data.add("userType","0");
<%
	  }else{
%>
response.data.add("retCode","111111");
response.data.add("cityCode","0451");
<%
			if(tSqlTempData3.length>0){
%>
  response.data.add("bossUserClass","vip");
  response.data.add("bossUserBrand","vip");

<%
			}else{
%>
	response.data.add("bossUserClass","2");
	response.data.add("bossUserBrand","00");
<%
			}
%>
response.data.add("userType","0");
<%	  	 
	  }
%>
response.data.add("enterDateTime","<%=enterDateTime%>");
core.ajax.receivePacket(response);

	
	

