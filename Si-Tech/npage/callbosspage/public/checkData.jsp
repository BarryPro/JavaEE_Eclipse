<%
	/*
	 * 功能: 检查各种状态下时间
	 * 版本: 1.0
	 * 日期: 2008/12/21
	 * 作者: lijin 
	 * 版权: sitech
	 * 
	 *  
	 */
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
  String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);
  String workNo=request.getParameter("called_no_agent");
  String oprType=request.getParameter("oprType");
   String sqlStr="select to_char(count(*)) count from dagentoprinfo where (staffno=:staffno or operate_object=:operate_object) and operate_type in("+oprType+")and operate_end is null";
   myParams = "staffno="+workNo+",operate_object="+workNo;
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
			<wtc:param value="<%=sqlStr%>"/>
			<wtc:param value="<%=myParams%>"/>
	</wtc:service>
<wtc:array id="queryList" scope="end"/>
<%
 int rowCount=0;
 String sql="";
 rowCount = Integer.parseInt(queryList[0][0]);
 if(rowCount>0){
  sql="select operate_type, operate_object, staffno from dagentoprinfo where (staffno=:staffno or operate_object=:operate_object) and operate_type in("+oprType+")and operate_end is null";
  myParams = "staffno="+workNo+",operate_object="+workNo;
 }
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="3">
			<wtc:param value="<%=sql%>"/>
			<wtc:param value="<%=myParams%>"/>
	</wtc:service>
<wtc:array id="row" scope="end"/>
var response = new AJAXPacket();
response.data.add("num","<%=rowCount%>");
<%if(rowCount>0){
 String datalist ="";
 String oprObject="";
 String staffNoList="";
 for(int i=0;i<row.length;i++){
  datalist=datalist+","+row[i][0];
  oprObject=oprObject+","+row[i][1];
  staffNoList=staffNoList+","+row[i][2];
 }
response.data.add("oprType","<%=datalist%>");
response.data.add("object","<%=oprObject%>");
response.data.add("staffNoList","<%=staffNoList%>");
<%}%>

core.ajax.receivePacket(response);

	