<%
    /*************************************
    * ��  ��: �����ն����۳��� e899
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2012-7-6
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
	String regCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
	String opCode = (String)request.getParameter("opCode");
	String opName = (String)request.getParameter("opName");  
	String iPhoneNo = request.getParameter("activePhone");
              
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
  <TITLE>�����ն����۳���</TITLE>
</HEAD>
<body>
<SCRIPT language="JavaScript">
  
function queryInfo(){
  if(!check(frm)) return false;
  var phoneNo = $("#phoneNo").val();
  var orderNo = $("#orderNo").val();
  if(phoneNo==""&&orderNo==""){
    rdShowMessageDialog("����������һ����ѯ������",1);
    return false;
  }
  frm.action="fe899_queryInfo.jsp";
  frm.submit();
}

function clearInfo(){
  window.location.href="fe899_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=iPhoneNo%>";
}

</SCRIPT>
 
<FORM method=post name="frm" >
  <input type="hidden" id="opCode" name="opCode"  value="<%=opCode%>" />
  <input type="hidden" id="opName" name="opName"  value="<%=opName%>" />
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">�����ն����۳���</div>
</div>
	<TABLE cellSpacing=0>
        <TR id="deliveryTr"> 
          <TD class='blue' nowrap>�ֻ�����</TD>
          <TD>
           <input type="text" name="phoneNo" id="phoneNo" v_type="mobphone" value="<%=iPhoneNo%>" size="20" readOnly />
		      </TD>
          <TD class='blue' nowrap>������</TD>
          <TD>
          	<input type="text" name="orderNo" id="orderNo" v_type="0_9" size="20" value="" />
          </TD>
        </TR>
         <tr>
            <td colspan="4" align="center" id="footer">
                <input type="button" id="queryBtn" name="queryBtn" class="b_foot" value="ȷ��" onClick="queryInfo()" />   
                <input type="button" id="queryBtn" name="queryBtn" class="b_foot" value="���" onClick="clearInfo()" />   
                <input type="button" id="closeBtn"  name="closeBtn"  class="b_foot" value="�ر�" onClick="removeCurrentTab();" />
            </td>
        </tr>
    </TABLE>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
