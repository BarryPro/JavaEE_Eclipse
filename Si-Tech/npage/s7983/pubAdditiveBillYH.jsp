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
    String workNo           = WtcUtil.repNull((String)session.getAttribute("workNo"));		/*wangleic add 2011-7-1 11:20AM*/
    String opCode           = WtcUtil.repNull((String)request.getParameter("opCode"));
    String idNo             = WtcUtil.repNull((String)request.getParameter("id_no"));
    String mebMonthFlag     = WtcUtil.repNull((String)request.getParameter("mebMonthFlag"));
    String productId        = WtcUtil.repNull((String)request.getParameter("grpProdCode"));
    String regionCode       = WtcUtil.repNull((String)request.getParameter("regionCode"));
    String smCode           = WtcUtil.repNull((String)request.getParameter("smCode"));
    String opType           = "";
    String bizCode          = WtcUtil.repNull((String)request.getParameter("bizCode"));
    String payFlag          = WtcUtil.repNull((String)request.getParameter("payFlag"));
    String unitId           = WtcUtil.repNull((String)request.getParameter("unitId"));//zhangyan
    String userType         = WtcUtil.repNull((String)request.getParameter("userType"));//zhouby
    System.out.println("zhouby sGetAddProduct userType =["+userType+"]");   
    if("AD".equals(smCode) || "ML".equals(smCode) || "MA".equals(smCode)){
        opType = WtcUtil.repNull((String)request.getParameter("opType"));
    }else{
        opType = "";
    }
    
    String rateArr[][]      = new String[][]{};
    try{
    %>
        <wtc:service name="sGetAddProduct" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="6" >
            <wtc:param value=""/>
            <wtc:param value="<%=idNo%>"/>
            <wtc:param value="<%=mebMonthFlag%>"/>
            <wtc:param value="<%=productId%>"/>
            <wtc:param value="<%=regionCode%>"/>
            <wtc:param value="<%=smCode%>"/>
            <wtc:param value="<%=opType%>"/>
            <wtc:param value="<%=opCode%>"/>
            <wtc:param value=""/>
            <wtc:param value="<%=bizCode%>"/>
            <wtc:param value="<%=payFlag%>"/>
            <wtc:param value="<%=workNo%>"/>
           	<wtc:param value="<%=unitId%>"/>
           	<wtc:param value=""/>
           	<wtc:param value="<%=userType%>"/>
        </wtc:service>
        <wtc:array id="retArr" scope="end"/>
    <%
        if("000000".equals(retCode)){
            rateArr = retArr;
        }else{
        %>
            <script type=text/javascript>
                rdShowMessageDialog("获取资费信息失败！<br>错误代码：<%=retCode%>，错误信息：<%=retMsg%>",0);
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
        window.opener.doQueryRateYH(rateCode,rateName);
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