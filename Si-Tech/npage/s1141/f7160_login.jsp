<%
    /********************
     version v2.0
     ������: si-tech
     *
     *update:zhanghonga@2008-09-09 ҳ�����,�޸���ʽ
     *������ҳ��������֤����
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = "7160";
	String opName = "�����ͺ���";
%>
<html>
<head>
<title>�����ͺ���</title>

    <script language=javascript>
				onload=function(){
				    //�������Ϊ��,��رմ�ҳ��
				    if (<%=activePhone%>==null||<%=activePhone%>=="") {
				        parent.removeTab('<%=opCode%>');
				        return false;
				    }					
					  /*doCfm();*/	
				}
				
        function doCfm()
        {
			document.all.opcode.value="7160";
			frm.action="f7160_1.jsp";
			frm.submit();
        }
    </script>
	</head>

	<body>
	<form name="frm" method="POST">
    	<input type="hidden" name="opcode">
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
			    <div id="title_zi">�����ͺ���</div>
			</div>
	    <table cellspacing="0">
	        <tr>
	          <td width="16%" class="blue">�������</td>
	          <td>
	             <input class="InputGrey" type="text" value="<%=activePhone%>" size="12" name="srv_no" id="srv_no" readonly>
	          </td>
	        </tr>
	        <tr>
	            <td colspan="2" id="footer">
	                <input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm()">
	                <input class="b_foot" type=button name=qryP value="�ر�" onClick="parent.removeTab('<%=opCode%>')">
	            </td>
	        </tr>
	    </table>
	    <%@ include file="/npage/include/footer_simple.jsp" %>
	</form>
</body>
</html>