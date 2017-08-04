<%
  /*
   * 功能: 选择听取流水
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: hanjc
　 * 版权: sitech
   * update: mixh 2009/02/21
　 */
%>

<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>

<%
  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

String contact_id = (String)request.getParameter("contact_id");
/*-----------------------------------*/
String loginNo = (String)request.getParameter("loginNo");
String staffno = (String)request.getParameter("staffno");
String classid="";
String queryclassid="";
String myParamsclass=""; 

String classSql =" select distinct ds.class_id from dcallkfstaffclass ds ,dloginmsgrelation dr where ds.kf_login_no= dr.kf_login_no and  dr.valid_flag='Y' and  boss_login_no =:loginNo union all select distinct ds.class_id from dcallkfstaffclass ds ,dloginmsgrelation dr where ds.kf_login_no= dr.kf_login_no and  dr.valid_flag='Y' and  boss_login_no =:staffno " ;
       myParamsclass="loginNo="+loginNo+",staffno="+staffno; 
       
/*-----------------------------------*/         
String idname     = (String)request.getParameter("idname");
String flag       = "N";//录音文件数量标志，Y为1条，N为大于1条，mixh add 20090620
String file_path  = "";
//录音分表 by libin 2009-05-22
String  tablename_ym = "";
/**
if(contact_id != null && contact_id.indexOf("KF") >= 0){
	tablename_ym = contact_id.substring(0,6);
}else if(contact_id != null && contact_id.indexOf("KF") < 0){
	tablename_ym = contact_id.substring(4,10);
}*/
if(contact_id != null){
	tablename_ym = contact_id.substring(0,6);
}
String strSql     = "select REPLACE(t.file_path,'\\','\\\\') from dcallrecordfile"+tablename_ym+" t where t.contact_id=:contact_id";
myParams = "contact_id="+contact_id ;
/**
*判断当前流水录音文件有几个
*/
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
 <wtc:param value="<%=strSql%>" />
 <wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="checkList" scope="end" />

<%
if(checkList.length==1){
flag="Y";
file_path=checkList[0][0];
}

if (loginNo!= null ||loginNo!="")
{
%>


        <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
					<wtc:param value="<%=classSql%>"/>
					<wtc:param value="<%=myParamsclass%>"/>
					</wtc:service>
				<wtc:array id="banzu" scope="end"/>	
<%
	 
	      if(banzu.length==2)
     {
        classid=banzu[0][0];
        queryclassid=banzu[1][0];
        System.out.println("----------- "+classid+" ======== "+ queryclassid);
        if(!classid.equals(queryclassid)){
					flag="X";
				}
     }
}    
   %>
var response = new AJAXPacket();
response.data.add("file_path","<%=file_path%>");
response.data.add("flag","<%=flag%>");
response.data.add("contact_id","<%=contact_id%>");
response.data.add("idname","<%=idname%>");
core.ajax.receivePacket(response);