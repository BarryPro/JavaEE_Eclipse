<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-10-19
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
    String opName           = "获取成员资费信息";

    String regionCode       = WtcUtil.repNull((String)session.getAttribute("regCode"));
    String workNo 					= WtcUtil.repNull((String)session.getAttribute("workNo"));

    String iUserType        = WtcUtil.repNull((String)request.getParameter("userType"));
    String iBizCode         = WtcUtil.repNull((String)request.getParameter("bizCode"));
    String iMebMonthFlag    = WtcUtil.repNull((String)request.getParameter("mebMonthFlag"));
    String iGrpProdCode     = WtcUtil.repNull((String)request.getParameter("grpProdCode"));
    String iRegionCode      = WtcUtil.repNull((String)request.getParameter("regionCode"));
    String iSmCode          = WtcUtil.repNull((String)request.getParameter("smCode"));
    String iOpType          = WtcUtil.repNull((String)request.getParameter("opType"));
    String iOpCode          = WtcUtil.repNull((String)request.getParameter("opCode"));
    String iOldFeeCode      = WtcUtil.repNull((String)request.getParameter("oldFeeCode"));
    String iIdNo            = WtcUtil.repNull((String)request.getParameter("idNo"));
    String phoneNo          = WtcUtil.repNull((String)request.getParameter("phoneNo"));/*haoyy add 20120216 关于申请解决车务通业务问题的请示*/

    String rateArr[][]      = new String[][]{};
    try{
    %>
        <wtc:service name="sGetAddProduct" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="6" >
            <wtc:param value="<%=iUserType%>"/>
            <wtc:param value="<%=iIdNo%>"/>
            <wtc:param value="<%=iMebMonthFlag%>"/>
            <wtc:param value="<%=iGrpProdCode%>"/>
            <wtc:param value="<%=iRegionCode%>"/>
            <wtc:param value="<%=iSmCode%>"/>
            <wtc:param value="<%=iOpType%>"/>
            <wtc:param value="<%=iOpCode%>"/>
            <wtc:param value="<%=iOldFeeCode%>"/>
            <wtc:param value="<%=phoneNo%>"/>
            <wtc:param value=""/>
            <wtc:param value="<%=workNo%>"/>
        </wtc:service>
        <wtc:array id="retArr" scope="end"/>
    <%
        if("000000".equals(retCode)){
            rateArr = retArr;
        }else{
        %>
            <script type=text/javascript>
                rdShowMessageDialog("获取资费信息失败！",0);
                window.close();
            </script>
        <%
        }
    }catch(Exception e){
    %>
        <script type=text/javascript>
            rdShowMessageDialog("调用服务sGetAddProduct失败！",0);
            window.close();
        </script>
    <%
        e.printStackTrace();
    }
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>获取成员资费信息</title>
</head>
<script type=text/javascript>
    function saveTo(rateCode,rateName){
        window.opener.doQueryRate(rateCode,rateName);
        window.close();
    }
</script>
<body>
<form name="frm" action="" method="post" >
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">获取成员资费信息</div>
</div>
<table cellspacing=0>
    <tr>
        <th>选择</th>
        <th>资费代码</th>
        <th>资费名称</th>
    </tr>
    <%for(int i=0;i<rateArr.length;i++){%>
    <tr>
        <td>
            <input type='radio' id='sure' name='sure' onClick='javascript:saveTo("<%=rateArr[i][2]%>","<%=rateArr[i][3]%>")'/>
        </td>
        <td>
            <%=rateArr[i][2]%>
        </td>
        <td>
            <%=rateArr[i][3]%>
        </td>
    </tr>
    <%}%>
</table>
<TABLE cellSpacing="0">
    <TR>
        <TD id="footer">
            <input class="b_foot" name="bClose" id="bClose" onClick="window.close()" type=button value="关闭">
        </TD>
    </TR>
</TABLE>
</div>
</form>
</body>
</html>