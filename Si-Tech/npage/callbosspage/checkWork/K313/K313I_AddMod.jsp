<%
  /**
   * 功能: 设置流水抽取规则接触时间规则
　 * 版本: 1.0.0
　 * 日期: 
　 * 作者: zengzq
　 * 版权: sitech
   * update:
　 */
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%!
public String returnInsertSql(String id,String mintime,String maxtime,String getcount,String description){
			String strInsert="insert into dserialNotime t(t.id,t.mintime, t.maxtime, t.getcount,t.description)";
			strInsert+=" values( :v1, :v2, :v3, :v4, :v5)";
			strInsert+="&&"+id+"^"+mintime+"^"+maxtime+"^"+getcount+"^"+description;
       return strInsert;
}
public String returnUpdateSql(String id,String mintime,String maxtime,String getcount,String description){
		String strUpdate="update dserialNotime set mintime=:v1,maxtime=:v2,getcount=:v3,description=:v4 where id=:v5 ";
    strUpdate+="&&"+mintime+"^"+maxtime+"^"+getcount+"^"+description+"^"+id;   
    return strUpdate;
}
public String returnDeleteSql(String id){
		String strDelete="delete dserialNotime t where t.id=:v1" + "&&"+id;
       return strDelete;
}
%>
<%

//获取参数
//String workNo = (String)session.getAttribute("workNo");
//String ip_Addr = (String)session.getAttribute("ipAddr");
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2); 
String retType=request.getParameter("retType");
String id=request.getParameter("id");
String mintime=request.getParameter("mintime");
String maxtime=request.getParameter("maxtime");
String getcount=request.getParameter("getcount");
String description=request.getParameter("description");
String strIP=(String)request.getRemoteAddr(); 
List sqlList=new ArrayList();
String[] sqlArr = new String[]{};
int getcountInt=0;
String   tempAddArr = new String();

if("add".equals(retType)){
	tempAddArr=returnInsertSql( id,mintime, maxtime, getcount, description);
}else if("update".equals(retType)){
	tempAddArr=returnUpdateSql( id, mintime, maxtime, getcount, description);
}else if("delete".equals(retType)){
	tempAddArr=returnDeleteSql(id);
}
sqlList.add(tempAddArr);
System.out.println("tempAddArr:"+tempAddArr);
if(sqlList.size()>0){
	sqlArr = (String[])sqlList.toArray(new String[0]);
	String outnum = String.valueOf(sqlArr.length + 1);   
%>
<wtc:service name="sModifyMulKfCfm"  outnum="<%=outnum%>" routerKey="region" routerValue="<%=regionCode%>">
	 <wtc:param value=""/>
   <wtc:param value="dbchange"/>
   <wtc:params value="<%=sqlArr%>"/>	
</wtc:service>
<wtc:array id="retRows"  scope="end"/>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
core.ajax.receivePacket(response);
<%
sqlList=null;
}else{
%>
var response = new AJAXPacket();
response.data.add("retCode","000000");
core.ajax.receivePacket(response);
<%
}
%>