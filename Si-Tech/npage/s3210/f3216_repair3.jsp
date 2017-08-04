<%
    /********************
     * @ OpCode    :  7983
     * @ OpName    :  集团成员增加
     * @ CopyRight :  si-tech
     * @ Author    :  qidp
     * @ Date      :  2009-10-23
     * @ Update    :  
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String opCode = "3216";
    String opName = "BOSS侧数据补录";
    
    String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
    String iUnitId = WtcUtil.repNull((String)request.getParameter("unitId"));
    String iLoginAccept = WtcUtil.repNull((String)request.getParameter("loginAccept"));
    String iGrpName = WtcUtil.repNull((String)request.getParameter("grpName"));
    
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
    <title>BOSS侧数据补录</title>
</head>
<script language="JavaScript">
    function print_xls(){
        window.open('/npage/s7983/f7983_printxls.jsp?phoneNo=<%=errPhoneList%>&returnMsg=<%=errMsgList%>&unitID=<%=iUnitId%>&loginAccept=<%=iLoginAccept%>&grpName=<%=iGrpName%>&op_Code=<%=opCode%>&orgCode=<%=orgCode%>');
    }
    
    function quit(){
        window.close();
    }
    
</script>
<BODY>
<form name="frm" action="" method="post" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">未成功号码列表</div>
</div>

<TABLE cellSpacing="0">
    <TR>
        <TH width='50%' align='center'>未添加成功号码</TH>
        <TH width='50%'>失败原因</TH>
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
            <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=关闭>
            <input class="b_foot" name=back onClick="window.location='f3216.jsp'" style="cursor:hand" type=button value=返回>
        </td>
    </tr>
</TABLE>

<%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
