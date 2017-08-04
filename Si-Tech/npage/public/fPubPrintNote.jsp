<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%
 /**
 * 作者:zhaohaitao
 * 日期:2008.12.2
 * 模块:积分兑换
 **/
%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>


<%	
    //String org_code_note = (String)session.getAttribute("orgCode");
    String regionCode_note=(String)session.getAttribute("regCode");
	//ArrayList retArrayNote = new ArrayList();
	//String[][] resultNote = new String[][]{};
	//SPubCallSvrImpl callViewNote = new SPubCallSvrImpl();
	String loginNote="";
	String sqlStrNote = "select back_char1 from snotecode where region_code='"+regionCode_note+"' and op_code='XXXX'";

	//retArrayNote = callViewNote.sPubSelect("1",sqlStrNote);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode_note%>" retcode="retCode11" retmsg="retMsg11" outnum="1">
    <wtc:sql><%=sqlStrNote%>
    </wtc:sql>
	</wtc:pubselect>
	<wtc:array id="resultNote" scope="end"/>
<%
	//resultNote  = (String[][])retArrayNote.get(0);
			
		
    for(int i=0;i<resultNote.length;i++){
		 loginNote = (resultNote[i][0]).trim();				 
		}
	loginNote = loginNote.replaceAll("\"","");
	loginNote = loginNote.replaceAll("\'","");
	loginNote = loginNote.replaceAll("\r\n","   ");  
	loginNote = loginNote.replaceAll("\r","   "); 
	loginNote = loginNote.replaceAll("\n","   "); 
	System.out.println("@@@@@@@@@loginNote="+loginNote);

%>
	
