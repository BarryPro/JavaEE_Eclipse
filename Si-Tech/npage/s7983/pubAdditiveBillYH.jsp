<%
/********************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2009-10-19
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
    String opName           = "��ȡ��Ա�ʷ���Ϣ";
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
                rdShowMessageDialog("��ȡ�ʷ���Ϣʧ�ܣ�<br>������룺<%=retCode%>��������Ϣ��<%=retMsg%>",0);
                window.close();
            </script>
        <%
        }
    }catch(Exception e){
    %>
        <script type=text/javascript>
            rdShowMessageDialog("���÷���sGetAddProductʧ�ܣ�",0);
            window.close();
        </script>
    <%
        e.printStackTrace();
    }
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>��ȡ��Ա�ʷ���Ϣ</title>
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
	<div id="title_zi">��ȡ��Ա�ʷ���Ϣ</div>
</div>
<table cellspacing=0>
    <tr>
        <th>ѡ��</th>
        <th>�ʷѴ���</th>
        <th>�ʷ�����</th>
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
            <input class="b_foot" name="bClose" id="bClose" onClick="window.close()" type=button value="�ر�">
        </TD>
    </TR>
</TABLE>
</div>
</form>
</body>
</html>