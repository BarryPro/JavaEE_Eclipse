 <%@ page contentType="text/html;charset=GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%
    String orgCode = (String) session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0, 2);
    String opCode = request.getParameter("opCode");
    String workNo = (String) session.getAttribute("workNo");
    String ip_Addr = (String) session.getAttribute("ipAddr");
    String password = (String) session.getAttribute("password");
    String phone_no = request.getParameter("phone_no");
    String oldpassword = request.getParameter("cfmPwdEncryptOld");
    System.out.println("oldpassword======"+oldpassword);
    String  newpassword= request.getParameter("cfmPwdEncryptNew");
    /** 密码加密暂时封住
    newpassword=Encrypt.encrypt(newpassword);
    **/
      System.out.println("newpassword======"+newpassword);
    String vOpNote = request.getParameter("vOpNote");
    String vSystemNote = request.getParameter("vSystemNote");
    String opType=request.getParameter("opType");
    String printAccept=request.getParameter("printAccept");
    

%>
<wtc:service name="s4991Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retcode" retmsg="retmsg"
             outnum="40">
    <wtc:param value="<%=opCode%>"/>
    <wtc:param value="<%=phone_no%>"/>
    <wtc:param value="<%=oldpassword%>"/>
    <wtc:param value="<%=newpassword%>"/>
    <wtc:param value="<%=workNo%>"/>
    <wtc:param value="<%=password%>"/>
    <wtc:param value="<%=ip_Addr%>"/>
    <wtc:param value="<%=vOpNote%>"/>
    <wtc:param value="<%=vSystemNote%>"/>
    <wtc:param value="<%=opType%>"/>	
    <wtc:param value="<%=printAccept%>" />
</wtc:service>
<wtc:array id="result" scope="end"/>

<%
    if (retcode.equals("000000")) {
%>
<script language='jscript'>
    rdShowMessageDialog('操作成功！请返回.......', 2);
    document.location.replace("f4991_1.jsp");
</script>
<%
    }
    if (!retcode.equals("000000")) {
%>
<script language='jscript'>
    rdShowMessageDialog("查询错误！<br>错误代码：'<%=retcode%>'。<br>错误信息：'<%=retmsg%>'。", 0);
    document.location.replace("f4991_1.jsp");
</script>
<%
    }
%>
