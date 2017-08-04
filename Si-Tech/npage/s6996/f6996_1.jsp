<%
/********************
 version v2.0
 开发商 si-tech
 create hejwa@2010-1-14 :14:39
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%
    String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
    String iPhoneNo = request.getParameter("activePhone");
    String workNo = (String)session.getAttribute("workNo");
    String workPwd = (String)session.getAttribute("password");
    String regionCode = (String)session.getAttribute("regCode");
    
    String queryType = "1003";
    String[][] queryArr = new String[][]{};
%>
    <wtc:service name="sGetUserMsg" retcode="retCode" retmsg="retMsg" outnum="4" routerKey="region" routerValue="<%=regionCode%>">
        <wtc:param value="<%=workNo%>"/>
        <wtc:param value="<%=workPwd%>"/> 
        <wtc:param value="<%=queryType%>"/> 
        <wtc:param value="<%=opCode%>"/> 
        <wtc:param value="<%=iPhoneNo%>"/> 
    </wtc:service>
    <wtc:array id="retArr" scope="end"/>
<%
    queryArr = retArr;
%>
<head>
<title>12580查询</title>
</head>
<body>
<%if("000000".equals(retCode)){%>
<%if(queryArr.length>0){%>
<form name="frm" method="POST">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">12580移动秘书台定制状态查询结果</div>
</div>
<table  cellspacing="0" >
    <tr>
        <td class="blue">当前状态</td>
        <td><%=queryArr[0][0]%></td>
        <td class="blue">当前状态名称</td>
        <td><%=queryArr[0][1]%></td>
    </tr>
    <tr>
        <td class="blue">开始时间</td>
        <td><%=queryArr[0][2]%></td>
        <td class="blue">结束时间</td>
        <td><%=queryArr[0][3]%></td>
    </tr>
    <tr>
        <td colspan="4" id="footer">
            <input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()" />
        </td>
    </tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</form>
<%}else{%>
    <script type=text/javascript>
        rdShowMessageDialog("查询12580移动秘书台定制状态失败！",0);
        removeCurrentTab();
    </script>
<%}%>
<%}else{%>
    <script type=text/javascript>
        rdShowMessageDialog("查询12580移动秘书台定制状态失败！错误代码：<%=retCode%>，错误信息：<%=retMsg%>",0);
        removeCurrentTab();
    </script>
<%}%>
</body>
</html>