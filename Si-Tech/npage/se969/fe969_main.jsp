<%
    /*************************************
    * ��  ��: �����ն����۳��� e969
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2012-7-6
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
  request.setCharacterEncoding("GBK");
%>
<html>
<head>
<title>�����ն����۳���</title>
<%
  String opCode="e969";
  String opName="�����ն����۳���";
  String activePhone1 = request.getParameter("activePhone");
	System.out.println("-----------e969-------activePhonee969="+activePhone1);
%>
</script>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language=javascript>
$(document).ready(function(){
  if("<%=activePhone1%>"=="" || "<%=activePhone1%>"==null){
    removeCurrentTab();
  }
});
function subInfo(){
  var acceptNo = $("#acceptNo").val();
  if(acceptNo==""){
  rdShowMessageDialog("��������ˮ�ţ����ܽ��г�����",1);
  return false;
  }
  frm.action="fe969_ReverseNo.jsp";
  frm.submit();
}

function clearInfo(){
  window.location.href="fe969_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=activePhone1%>";
}
</script>
</head>
<body>
	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %> 	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
      <table cellspacing="0">
        <tr> 
          <td class="blue">�ֻ����� </td>
          <td> 
          <input type="text" size="12" name="phoneNo" value="<%=activePhone1%>" id="phoneNo" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 maxlength="11" index="0" class="InputGrey" readOnly />
          <font color="orange">*</font>
          </td>
        </tr>
        <TR>
          <TD class="blue" width="20%">��ˮ��</TD>
          <TD>
          <input type="text" name="acceptNo" id="acceptNo"  value="" size="20" />
           <font class="orange">*</font>
          </TD>
        </TR>
        <tr> 
          <td colspan="2" id="footer"> 
            <div align="center"> 
              <input type="button" id="subBtn" name="subBtn" class="b_foot" value="ȷ��" onClick="subInfo()" />   
              <input type="button" id="clearBtn" name="clearBtn" class="b_foot" value="���" onClick="clearInfo()" />   
              <input type="button" id="closeBtn"  name="closeBtn"  class="b_foot" value="�ر�" onClick="removeCurrentTab();" />
            </div>
          </td>
        </tr>
      </table>
   
<input type="hidden" name="opCode" value="<%=opCode%>" />
<input type="hidden" name="opName" value="<%=opName%>" />
<input type="hidden" name="activePhone" id="activePhone" value="<%=activePhone1%>" />
<%@ include file="/npage/include/footer.jsp" %>
</form>
   
</body>
</html>
