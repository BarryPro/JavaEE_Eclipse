<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
    /********************
     version v2.0
     开发商: si-tech
     ********************/
%>
<%@ page contentType="text/html;charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<% response.setHeader("Pragma", "No-Cache");
    response.setHeader("Cache-Control", "No-Cache");
    response.setDateHeader("Expires", 0);
%>
<%
    String opCode = "";
    String opName = "黑龙江BOSS-帐号查询";
    
    String phoneNo = request.getParameter("phoneno");

    String inParas[] = new String[2];
    inParas[0] = phoneNo;
    inParas[1] = "0";

    //CallRemoteResultValue value = viewBean.callService("2",phoneNo,"s1500ConQry","5",lens,inParas);
%>
<wtc:service name="s1500ConQry" routerKey="phone" routerValue="<%=phoneNo%>" outnum="5">
    <wtc:param value="<%=inParas[0]%>"/>
    <wtc:param value="<%=inParas[1]%>"/>
</wtc:service>
<wtc:array id="result1" start="0" length="2" scope="end"/>
<wtc:array id="result2" start="2" length="3" scope="end"/>
<%
    String return_code = result1.length > 0 ? result1[0][0] : "";
    String record_num = result1.length > 0 ? result1[0][1] : "";
%>

<% if (!return_code.equals("000000")) { %>
<SCRIPT LANGUAGE="JavaScript">
    <!--
    window.close();
    //-->
</SCRIPT>
<% } else if (record_num.equals("1")) { %>
<SCRIPT LANGUAGE="JavaScript">
    <!--
    window.returnValue = "<%=result2.length>0?result2[0][0]:""%>";
    window.close();
    //-->
</SCRIPT>
<% } else { %>
<HTML>
<HEAD>
    <TITLE>黑龙江BOSS-帐号查询</TITLE>
    <META content=no-cache http-equiv=Pragma>
    <META content=no-cache http-equiv=Cache-Control>

    <script language="JavaScript">
        window.returnValue = '';
        function selAccount() {
            for (i = 0; i < document.frm.account.length; i++) {
                if (document.frm.account[i].checked == true) {
                    window.returnValue = document.frm.account[i].value;
                    break;
                }
            }
            window.close();
        }
    </script>

</head>

<BODY>
<form name="frm" method="post" action="">
    <%@ include file="/npage/include/header_pop.jsp" %>
    <table cellspacing="0">
        <tr align="center">
            <th width="5%">&nbsp;</th>
            <th width="20%">帐号</th>
            <th width="25%">帐户名称</th>
            <th>帐户类型</th>
        </tr>
        <% 
        	String tbclass="";
        	for (int i = 0; i < result2.length; i++) {
        		tbclass = (i%2==0)?"Grey":"";
        %>
        <tr>
        <td class="<%=tbclass%>" height="25">
            <div align="center">
                <input type="radio" name="account" value="<%=result2[i][0].trim()%>" <%if (i==0) {%>checked<%}%>>
            </div>
        </td>
        <td class="<%=tbclass%>" height="25">
            <div align="center"><%=result2[i][0]%>
            </div>
        </td>
        <td class="<%=tbclass%>" height="25">
            <div align="center"><%=result2[i][1]%>
            </div>
        </td>
        <td class="<%=tbclass%>" height="25">
            <div align="center"><%=result2[i][2]%>
            </div>
        </td>
        </tr>
        <%}%>

        <tr>
            <td id="footer" colspan="6">
                <div align="center">
                    <input class="b_foot" type="button" name="Button" value="确定" onClick="selAccount()">
                    <input class="b_foot" type="button" name="return" value="返回" onClick="window.close()">
                </div>
            </td>
        </tr>
    </table>
    <%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</body>
</html>
<%}%>