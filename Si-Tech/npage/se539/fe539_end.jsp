<%
    /********************
     * @ OpCode    :  se539
     * @ OpName    :  ��������Ź���
     * @ CopyRight :  si-tech
     * @ Author    :  liuweih
     * @ Date      :  2012-01-15
     * @ Update    :  
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String opCode = "se539";
    String opName = "��������Ź���";
    
    String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
    String iUnitId = WtcUtil.repNull((String)request.getParameter("unitId"));

    
    String errPhoneList = WtcUtil.repNull((String)request.getParameter("errPhoneList"));
    String errMsgList = WtcUtil.repNull((String)request.getParameter("errMsgList"));
    
    System.out.println("------------------errPhoneList--------------------------"+errPhoneList);
    System.out.println("------------------errMsgList----------------------------"+errMsgList);
    
  	StringTokenizer stPhone = new StringTokenizer(errPhoneList,"|");
    String[] errPhoneArr = new String[stPhone.countTokens()];
    int i = 0;   
    while(stPhone.hasMoreTokens()){
        errPhoneArr[i++] = stPhone.nextToken();
    }
    System.out.println("------------------errPhoneArr--------------------------"+errPhoneArr.length);
    
    StringTokenizer stMsg = new StringTokenizer(errMsgList,"|");
    String[] errMsgArr = new String[stMsg.countTokens()];
    int j = 0;
    while(stMsg.hasMoreTokens()){
        errMsgArr[j++] = stMsg.nextToken();
    }
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>��������Ź���</title>
</head>
<script language="JavaScript">
    function print_xls(){
        window.open('fe539_printxls.jsp?isno=<%=errPhoneList%>&returnMsg=<%=errMsgList%>&unitID=<%=iUnitId%>&op_Code=<%=opCode%>&orgCode=<%=orgCode%>');
    }
</script>
<BODY>
<form name="frm" action="" method="post" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">δ�ɹ��Ļ�������ŵ��б�</div>
</div>

<TABLE cellSpacing="0">
    <TR>
        <TH width='50%' align='center'>δ���ӳɹ������</TH>
        <TH width='50%'>ʧ��ԭ��</TH>
    </TR>
    <%
    for (int k=0;k<errPhoneArr.length;k++)
    {
        String tdClass = "";
        if (k%2==0){
            tdClass = "Grey";
        }
    %>
        <TR>
            <TD class='<%=tdClass%>' align='center'><%=errPhoneArr[k]%></TD>
            <TD class='<%=tdClass%>'><%=errMsgArr[k]%></TD>
        </TR>
    <%
    }
    %>
</TABLE>

<TABLE cellspacing="0">
    <tr id="footer">
        <td>
            <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=�ر�>
            <input class="b_foot" name=back onClick="window.location='fe539.jsp'" style="cursor:hand" type=button value=����>
        </td>
    </tr>
</TABLE>

<%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
