<%
    /********************
     * @ OpCode    :  6997
     * @ OpName    :  ���ʽ��ѯ
     * @ CopyRight :  si-tech
     * @ Author    :  qidp
     * @ Date      :  2010-03-08
     * @ Update    :  
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);

    String opCode = "6997";
    String opName = "���ʽ��ѯ";
    String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
    String workPwd = WtcUtil.repNull((String)session.getAttribute("password"));
    String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
    String iPhoneNo = request.getParameter("activePhone");
    System.out.println("iPhoneNo = "+iPhoneNo);
    
    String[] inputFlagArr = new String[2];
    inputFlagArr[0] = "5";  /* �ֻ����� */
    inputFlagArr[1] = "72"; /* ���ʽ */
    String iPayType = "";
%>
    <wtc:service name="sPubUserMsg" retcode="sPubUserMsgCode" retmsg="sPubUserMsgMsg" outnum="3" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:param value="0"/>
    	<wtc:param value="<%=iPhoneNo%>"/> 
    	<wtc:params value="<%=inputFlagArr%>"/> 
    </wtc:service>
    <wtc:array id="sPubUserMsgArr" scope="end"/>
<%
    if("000000".equals(sPubUserMsgCode) && sPubUserMsgArr.length>0){
        iPayType = sPubUserMsgArr[1][2];
    }
    
    String[][] iPayArr = new String[][]{};
%>
    <wtc:service name="sPhoneConMsg" retcode="sPhoneConMsgCode" retmsg="sPhoneConMsgMsg" outnum="11" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:param value="<%=iPhoneNo%>"/> 
    </wtc:service>
    <wtc:array id="sPhoneConMsgArr" scope="end"/>
<%
    iPayArr = sPhoneConMsgArr;
    
    String errCode = sPhoneConMsgCode;
    String errMsg = "";
    if("130056".equals(errCode)){
        errMsg = "���û����������û�!";
    }else if("130057".equals(errCode)){
        errMsg = "ȡ���д������!";
    }else if("130029".equals(errCode)){
        errMsg = "���ݿⷢ���쳣����!";
    }else if("139999".equals(errCode)){
        errMsg = "�����ݿ�����ʧ�ܣ�������!";
    }else{
        errMsg = "��ѯ���ʽʧ��!";
    }
%>

<%if("000000".equals(errCode) && iPayArr.length>0){%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><%=opName%></title>
</head>

<body>
<form name="frm" action="" method="post" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">���ʽ��ѯ���</div>
</div>

<table cellspacing="0">
<tr>
    <td class="blue">���ѷ�ʽ</td>
    <td><input type="text" name="t1" id="t1" value="<%=iPayType%>" readOnly class="InputGrey" /></td>
    <td class="blue">��ͬ��</td>
    <td><input type="text" name="t2" id="t2" value="<%=iPayArr[0][2]%>" readOnly class="InputGrey" /></td>
</tr>
<tr>
    <td class="blue">�ͻ����д���</td>
    <td><input type="text" name="t3" id="t3" value="<%=iPayArr[0][3]%>" readOnly class="InputGrey" /></td>
    <td class="blue">�ͻ���������</td>
    <td><input type="text" name="t4" id="t4" value="<%=iPayArr[0][4]%>" readOnly class="InputGrey" /></td>
</tr>
<tr>
    <td class="blue">�ַ����д���</td>
    <td><input type="text" name="t5" id="t5" value="<%=iPayArr[0][5]%>" readOnly class="InputGrey" /></td>
    <td class="blue">�ַ���������</td>
    <td><input type="text" name="t6" id="t6" value="<%=iPayArr[0][6]%>" readOnly class="InputGrey" /></td>
</tr>
<tr>
    <td class="blue">�ͻ��ʺ�</td>
    <td><input type="text" name="t7" id="t7" value="<%=iPayArr[0][7]%>" readOnly class="InputGrey" /></td>
    <td class="blue">���л���</td>
    <td><input type="text" name="t8" id="t8" value="<%=iPayArr[0][8]%>" readOnly class="InputGrey" /></td>
</tr>
<tr id="footer">
    <td colspan="4">
        <input type="button" id="bClose" name="bClose" value="�ر�" class="b_foot" />
    </td>
</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</form>

<script type=text/javascript>
    $(document).ready(function(){
        $("#bClose").bind("click",removeCurrentTab);
    });
</script>

</body>
</html>
<%}else{%>
<script type=text/javascript>
    rdShowMessageDialog("<%=errMsg%>[<%=errCode%>]",0);
    removeCurrentTab();
</script>
<%}%>