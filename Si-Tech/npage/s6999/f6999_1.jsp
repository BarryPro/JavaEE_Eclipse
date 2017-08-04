<%
    /********************
     * @ OpCode    :  6999
     * @ OpName    :  IP优惠礼包查询
     * @ CopyRight :  si-tech
     * @ Author    :  qidp
     * @ Date      :  2010-03-09
     * @ Update    :  
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
    
    String queryType = "1004";
    String[][] queryArr = new String[][]{};
%>
    <wtc:service name="sGetUserMsg" retcode="retCode" retmsg="retMsg" outnum="6" routerKey="region" routerValue="<%=regionCode%>">
        <wtc:param value="<%=workNo%>"/>
        <wtc:param value="<%=workPwd%>"/> 
        <wtc:param value="<%=queryType%>"/> 
        <wtc:param value="<%=opCode%>"/> 
        <wtc:param value="<%=iPhoneNo%>"/> 
    </wtc:service>
    <wtc:array id="retArr" scope="end"/>
<%
    queryArr = retArr;
    
    for(int iii=0;iii<retArr.length;iii++){
				for(int jjj=0;jjj<retArr[iii].length;jjj++){
					System.out.println("---------------------retArr["+iii+"]["+jjj+"]=-----------------"+retArr[iii][jjj]);
				}
		}
%>
<head>
<title>12580查询</title>
</head>
<body>
<%if("000000".equals(retCode)){%>
<form name="frm" method="POST">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">12580移动秘书台定制状态查询结果</div>
</div>
<table  cellspacing="0" >
    <tr>
        <th>当前状态</th>
        <th>当前状态名称</th>
        <th>礼包代码</th>
        <th>礼包代码名称</th>
        <th>开始时间</th>
        <th>结束时间</th>
    </tr>
    <%if(queryArr.length>0){%>
        <%for(int i=0;i<queryArr.length;i++){%>
            <tr>
                <td><%=(queryArr[i][0]==null?"":queryArr[i][0])%></td>
                <td><%=(queryArr[i][1]==null?"":queryArr[i][1])%></td>
                <td><%=(queryArr[i][2]==null?"":queryArr[i][2])%></td>
                <td><%=(queryArr[i][3]==null?"":queryArr[i][3])%></td>
                <td><%=(queryArr[i][4]==null?"":queryArr[i][4])%></td>
                <td><%=(queryArr[i][5]==null?"":queryArr[i][5])%></td>
            </tr>
        <%}%>
    <%}else{%>
        <tr><td colspan="6" align="center">对不起，没有查找到符合的记录</td></tr>
    <%}%>
    <tr>
        <td colspan="6" id="footer">
            <input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()" />
        </td>
    </tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</form>
<%}else{%>
    <script type=text/javascript>
        rdShowMessageDialog("查询IP优惠礼包失败！错误代码：<%=retCode%>，错误信息：<%=retMsg%>",0);
        removeCurrentTab();
    </script>
<%}%>
</body>
</html>