<%
  /**
   * 功能: 质检权限管理->分配质检权限->保存数据ajax操作
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%!
public String returnInsertSql(String id,String minlength,String maxlength,String getcount,String description){
/**String strInsert="insert into dserialNoTimeLength t(t.id,t.minlength, t.maxlength, t.getcount,t.description)";
       strInsert+=" values('"+id+"','"+minlength+"','"+maxlength+"','"+getcount+"','"+description+"')";
*/
String strInsert="insert into dserialNoTimeLength t(t.id,t.minlength, t.maxlength, t.getcount,t.description)";
strInsert+=" values( :v1, :v2, :v3, :v4, :v5)";
strInsert+="&&"+id+"^"+minlength+"^"+maxlength+"^"+getcount+"^"+description;
       return strInsert;
}
public String returnUpdateSql(String id,String minlength,String maxlength,String getcount,String description){
/**String strUpdate="update dserialNoTimeLength set minlength='"+minlength +"',maxlength='"+maxlength+"',getcount='"+getcount+"',description='"+description+"' where id='"+id+"'";
*/
String strUpdate="update dserialNoTimeLength set minlength= :v1,maxlength= :v2,getcount= :v3,description= :v4 where id= :v5";
strUpdate+="&&"+minlength +"^"+maxlength+"^"+getcount+"^"+description+"^"+id;
       return strUpdate;
}
public String returnDeleteSql(String id){
/**String strDelete="delete dserialNoTimeLength t where t.id='"+id+"'";
*/
String strDelete="delete dserialNoTimeLength t where t.id= :v1&&"+id;
       return strDelete;
}
%>
<%

//获取参数
//String workNo = (String)session.getAttribute("workNo");
//String orgCode = (String)session.getAttribute("orgCode");
//String ip_Addr = (String)session.getAttribute("ipAddr");

String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2); 


String retType=request.getParameter("retType");
String id=request.getParameter("id");
String minlength=request.getParameter("minlength");
String maxlength=request.getParameter("maxlength");
String getcount=request.getParameter("getcount");
String description=request.getParameter("description");
String strIP=(String)request.getRemoteAddr(); 
List sqlList=new ArrayList();
String[] sqlArr = new String[]{};
int getcountInt=0;
String   tempAddArr = new String();

if("add".equals(retType)){
	tempAddArr=returnInsertSql( id,minlength, maxlength, getcount, description);
}else if("update".equals(retType)){
	tempAddArr=returnUpdateSql( id, minlength, maxlength, getcount, description);
}else if("delete".equals(retType)){
	tempAddArr=returnDeleteSql(id);
}
sqlList.add(tempAddArr);
System.out.println("tempAddArr:"+tempAddArr);
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