<%
  /**
   * 功能: 
　 * 版本: 1.0.0
　 * 日期: 
　 * 作者: 
　 * 版权: sitech
   * update:
　 */
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%!
public String returnInsertSql(String id,String mindate,String maxdate,String getcount,String description,String getDflag){
//dateflag 0表示上月 1表示当月
/**String strInsert="insert into dserialNodate t(t.id,t.mindate, t.maxdate, t.getcount,t.description,t.dateflag)";
       strInsert+=" values('"+id+"','"+mindate+"','"+maxdate+"','"+getcount+"','"+description+"','"+getDflag+"')";
*/
String strInsert="insert into dserialNodate t(t.id,t.mindate, t.maxdate, t.getcount,t.description,t.dateflag)";
strInsert+=" values( :v1, :v2, :v3, :v4, :v5, :v6)";
strInsert+="&&"+id+"^"+mindate+"^"+maxdate+"^"+getcount+"^"+description+"^"+getDflag;
       return strInsert;
}
public String returnUpdateSql(String id,String mindate,String maxdate,String getcount,String description,String getDflag){
/**String strUpdate="update dserialNodate set mindate='"+mindate +"',maxdate='"+maxdate+"',getcount='"+getcount+"',description='"+description +"',dateflag = '"+getDflag+"' where id='"+id+"'";
*/
String strUpdate="update dserialNodate set mindate= :v1,maxdate= :v2,getcount= :v3,description= :v4,dateflag =  :v5 where id= :v6";
strUpdate+="&&"+mindate +"^"+maxdate+"^"+getcount+"^"+description +"^"+getDflag+"^"+id;
       return strUpdate;
}
public String returnDeleteSql(String id){
/**String strDelete="delete dserialNodate t where t.id='"+id+"'";
*/
String strDelete="delete dserialNodate t where t.id= :v1&&"+id;
       return strDelete;
}
%>
<%

//获取参数
//String workNo = (String)session.getAttribute("workNo");
//String orgCode = (String)session.getAttribute("orgCode");
//String ip_Addr = (String)session.getAttribute("ipAddr");
String retType=request.getParameter("retType");
String id=request.getParameter("id");
String mindate=request.getParameter("mindate");
String maxdate=request.getParameter("maxdate");
String getcount=request.getParameter("getcount");
String description=request.getParameter("description");
String getDflag=request.getParameter("getDflag");
String strIP=(String)request.getRemoteAddr(); 
List sqlList=new ArrayList();
String[] sqlArr = new String[]{};
int getcountInt=0;
String   tempAddArr = new String();

String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2); 

if("add".equals(retType)){
	tempAddArr=returnInsertSql( id,mindate, maxdate, getcount, description,getDflag);
}else if("update".equals(retType)){
	tempAddArr=returnUpdateSql( id, mindate, maxdate, getcount, description,getDflag);
}else if("delete".equals(retType)){
	tempAddArr=returnDeleteSql(id);
}
sqlList.add(tempAddArr);
if(sqlList.size()>0){
	sqlArr = (String[])sqlList.toArray(new String[0]);
	String outnum = String.valueOf(sqlArr.length + 1);   
%>
<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode%>">
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