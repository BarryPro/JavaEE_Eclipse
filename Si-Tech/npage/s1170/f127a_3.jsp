<%
/********************
* 功能: 主资费预约取消 127a || 主资费冲正 127b
* version v3.0
* 开发商: si-tech
* update by qidp @ 2008-12-01
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%
	/*
	0、sInLoginNo   工号
	1、sInLoginPasswd 工号密码
	2、sInOpCode 操作代码
	3、sInOrgCode 工号归属
	4、sInIpAddr IP地址
	5、sInOldLoginAccept 冲正流水
	6、sInIdNo id_no
	7、sInPhoneNO 手机号
	8、groupId
	9、流水
	*/

	String work_no = (String)session.getAttribute("workNo");
	String pass = (String)session.getAttribute("password");
	String orgCode = (String)session.getAttribute("orgCode") ;
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String groupId = (String)session.getAttribute("groupId");
	String id_no = (String)request.getParameter("id_no");
	String phone = (String)request.getParameter("phone");
	String printAccept = (String)request.getParameter("printAccept");
	String opCode = "127a";
	String opName = "主资费预约取消";

	String sInOldLoginAccept = (String)request.getParameter("next_main_stream");

	String[] paraAray1 = new String[10];
	paraAray1[0] = work_no;		/* 操作工号   */
	paraAray1[1] = pass; 	        /* 手机号码   */
	paraAray1[2] = opCode;
	paraAray1[3] = orgCode;
	paraAray1[4] = ip_Addr;
	paraAray1[5] = sInOldLoginAccept;
	paraAray1[6] = id_no;
	paraAray1[7] = phone;
	paraAray1[8] = groupId;
	paraAray1[9] = printAccept;

	System.out.println("------------ly---------------");
	for (int i=0;i<paraAray1.length;i++)
	{
		System.out.println(paraAray1[i]);
	}
	System.out.println("------------ly---------------");
	String titleStr = "主资费预约取消";;
 %>
 <wtc:service name="s127aCfm" routerKey="phone" routerValue="<%=phone%>" outnum="32" retcode="s1270GetMsgCode" retmsg="s1270GetMsgMsg">
        <wtc:param value="<%=paraAray1[0]%>"/>
        <wtc:param value="<%=paraAray1[1]%>"/>
        <wtc:param value="<%=paraAray1[2]%>"/>
        <wtc:param value="<%=paraAray1[3]%>"/>
        <wtc:param value="<%=paraAray1[4]%>"/>
        <wtc:param value="<%=paraAray1[5]%>"/>
        <wtc:param value="<%=paraAray1[6]%>"/>
        <wtc:param value="<%=paraAray1[7]%>"/>
        <wtc:param value="<%=paraAray1[8]%>"/>
        <wtc:param value="<%=paraAray1[9]%>"/>
	</wtc:service>
	<wtc:array id="retS127aInitArr"  scope="end"/>
<%
	String errCode = s1270GetMsgCode;
    String errMsg = s1270GetMsgMsg;
    String ret_code = "" ;
    String ret_msg = "";
    if(errCode.equals("000000"))
    {
        ret_code = "000000";          // 返回代码
    }else
    {
        ret_code = errCode;
    }
    ret_msg = errMsg;			  // 提示信息
 %>
 <html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE><%=titleStr%></TITLE>
</HEAD>
<%
    if(!ret_code.equals("000000")){%>
        <script language='jscript'>
            var ret_code = "<%=ret_code%>";
            var ret_msg = "<%=ret_msg%>";
            rdShowMessageDialog("查询错误！<br>错误代码：'<%=ret_code%>'。<br>错误信息：'<%=ret_msg%>'。",0);
        	document.location.replace("f1170Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>");
         	//window.close();
         	removeCurrentTab();
         </script>
<%  }
	else
	{
%>
	  <script language='jscript'>
       rdShowMessageDialog("冲正操作成功！",1);
       //window.close();
       removeCurrentTab();
       </script>
<%}%>
</html>