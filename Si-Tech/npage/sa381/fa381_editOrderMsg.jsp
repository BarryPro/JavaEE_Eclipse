
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%

    String workNo     = (String)session.getAttribute("workNo");//��������
    String regionCode = (String)session.getAttribute("regCode");
    String opCode = request.getParameter("opCode");
 	  String opName = request.getParameter("opName");
 	  String statusCode = request.getParameter("statusCode");
 	  String phone = request.getParameter("phone");
 	  String express = request.getParameter("express");
 	  String orderId = request.getParameter("orderId");
 	  String orderItemId = request.getParameter("orderItemId");
 	  
 	  
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><%=opName%></title>
    <script type="text/javascript" src="/npage/public/pubLightBox.js"></script>	
</head>
<script>
	$(function() {
		$('#submitBtn').click(function() {
		  if($("#orderNos").val()==""){
		    rdShowMessageDialog("������Ų���Ϊ��!");
				return false;
		  }
			//$(window.opener.document).find("#contactOrderNos<%=statusCode%>").val($('#orderNos').val());
			window.opener.timeout('<%=statusCode%>',$('#orderNos').val(),"<%=phone%>","<%=express%>","<%=orderId%>","<%=orderItemId%>");
			window.close();
		});
		$('#clearBtn').click(function() {
			$('#orderNos').val('');
		});
		$('#closeBtn').click(function() {
			window.close();
		});
	});

</script>
<body>
<form name="frm" action="" method="post" >
<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi">���������д</div>
		</div>
		
		<div>
				<table cellspacing=0>
				    <tr>
				        <td class='blue'>����������</td>
				        <td >
				            <input type="text" name="orderNos" id="orderNos" value="" maxlength="20" />
				        </td>
				    </tr>
				    <tr id='footer'>
				        <td colspan='4'>
				            <input type="button"  id="submitBtn" class='b_foot' value="ȷ��" name="submitBtn" />
				            <input type="button"  id="clearBtn" class='b_foot' value="���" name="clear" />
				            <input type="button"  id="closeBtn" class="b_foot" id="close" name="close" value="�ر�" />
				        </td>
				    </tr>
				</table>
		</div>
					
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>