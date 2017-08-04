<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@page import="com.sitech.crmpd.kf.dto.dcallcall.Dcallcallyyyymm"%> 
<%@page import="com.sitech.crmpd.kf.cache.DCallCacheManager"%>
<%
    /*midify by yinzx 20091113 公共查询服务替换*/
  String myParams="";
  String org_code = (String)session.getAttribute("orgCode");
  String regionCode = org_code.substring(0,2);
  String strContactId=request.getParameter("strContactId");
  String strContactMonth= request.getParameter("strContactMonth");
  String sqlStr="select t.call_cause_id,t.callcausedescs,t.bak from dcallcall"+strContactMonth+" t where t.contact_id=:strContactId " ;    
  myParams="strContactId="+strContactId;
  Dcallcallyyyymm upatedcallcallpage=DCallCacheManager.getInstance().getValue(strContactId); 
  
  
  String call_id;
  String call_desc;
  String sBak;
 if(upatedcallcallpage==null)
 {     
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="3">
<wtc:param value="<%=sqlStr%>"/>
<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:row id="row" start="0" length="3" >
var response = new AJAXPacket();
response.data.add("call_cause_id","<%=row[0]%>");
response.data.add("callcausedescs","<%=row[1]%>");
response.data.add("remarkInfo","<%=row[2]%>");
core.ajax.receivePacket(response);
</wtc:row>
<%
}
else if (upatedcallcallpage.getCall_cause_id()==null)
{
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="3">
<wtc:param value="<%=sqlStr%>"/>
<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:row id="row" start="0" length="3" >
var response = new AJAXPacket();
response.data.add("call_cause_id","<%=row[0]%>");
response.data.add("callcausedescs","<%=row[1]%>");
response.data.add("remarkInfo","<%=row[2]%>");
core.ajax.receivePacket(response);
</wtc:row>
<%
}
else
{
 call_id=upatedcallcallpage.getCall_cause_id();
 call_desc=upatedcallcallpage.getCallcausedescs();
 sBak=upatedcallcallpage.getBak();
%>
var response = new AJAXPacket();
response.data.add("call_cause_id","<%=call_id%>");
response.data.add("callcausedescs","<%=call_desc%>");
response.data.add("remarkInfo","<%=sBak%>");
core.ajax.receivePacket(response);
<%
}
%>