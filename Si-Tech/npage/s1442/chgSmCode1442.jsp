<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2008-12-31
 ********************/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page errorPage="../common/errorpage.jsp" %>

<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.*;"%>
<%

    SPubCallSvrImpl co=new SPubCallSvrImpl();
    
    //--------------------------
    String srv_no = request.getParameter("srv_no");
    String verifyType = request.getParameter("verifyType");
    String sq1="select CHINASIM_FLAG from shlrcode  where phoneno_head=substr('"+srv_no+"',1,7)";
    String sq2="select sm_code from dcustmsg  where phone_no='"+srv_no+"'";
    
    ArrayList retArray=new ArrayList();
    String [][]result=new String[][]{};
    String ret_code="000000";
    String ret_message="";
    
    String smCode="gn";
    String hlr="0";
try
{
	retArray = co.sPubSelect("1",sq1,"phone",srv_no);
	result = (String[][])retArray.get(0);
	hlr = result[0][0]; 
	if(hlr.equals("1"))
	{
      smCode="z0";
	}
	else if(hlr.equals("0"))
	{
      retArray = co.sPubSelect("1",sq2,"phone",srv_no);
	  result = (String[][])retArray.get(0);
	  smCode = result[0][0]; 
	}
	ret_code = "000000";
}catch(Exception e){	
	ret_code = "000001";
	ret_message = "用户资料不存在！";
}

%>

var response = new RPCPacket();
var errCode = "<%=ret_code%>";
var errMsg = "<%=ret_message%>";
var smCode = "<%=smCode%>";
var verifyType="<%= verifyType %>";
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("errCode",errCode);
response.data.add("errMsg",errMsg);
response.data.add("smCode",smCode);
response.data.add("verifyType",verifyType);

core.rpc.receivePacket(response);




