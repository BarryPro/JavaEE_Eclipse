<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ��Լ�ƻ�����
   * �汾: 1.0
   * ����: 2011/12/12
   * ����: liujian
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>��Լ�ƻ�����</title>
<%	
    String opCode=request.getParameter("opCode");
		String opName=request.getParameter("opName");	
    String workNo=(String)session.getAttribute("workNo");
    String regionCode=(String)session.getAttribute("regCode");
	//	boolean workNoFlag=false;
	//	if(workNo.substring(0,1).equals("k"))
	//		workNoFlag=true;
%>
  </script>
	<META content=no-cache http-equiv=Pragma>
	<META content=no-cache http-equiv=Cache-Control>
	<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
	<script language="javascript">
			/*************************��ʼ��*****************************/
			$(function() {
				$('#opCode').val('<%=opCode%>');
				$('#opName').val('<%=opName%>');
				var opCode = '<%=opCode%>';
				// ����ѡ�е�ҵ��
				if(opCode == 'e505') {
				 $('#backaccept_id').css('display','block');
	  	   $('#opCode').val('e506');
	  	   $('#opName').val('��Լ�ƻ���������');
	  	   /*ningtn ��վ���غ�Լ�ƻ�*/
	  	   $("#bltys").css("display","none");
				}else if(opCode == 'e506') {
					$('input[name="opFlag"][value="two"]').attr("checked","checked");
					$('#backaccept_id').css('display','block');
		  	   $('#opCode').val('e506');
		  	   $('#opName').val('��Լ�ƻ���������');
		  	   /*ningtn ��վ���غ�Լ�ƻ�*/
		  	   $("#bltys").css("display","none");
				}
				
				//ע�ᵥѡ���¼�
			    $('input[name="opFlag"]').click(function() {
			  		var value = $(this).val();
			  	    if(value != "one") {
			  	  	   $('#backaccept_id').css('display','block');
			  	  	   $('#opCode').val('e506');
			  	  	   $('#opName').val('��Լ�ƻ���������');
			  	  	   /*ningtn ��վ���غ�Լ�ƻ�*/
			  	  	   $("#bltys").css("display","none");
			  	    }else {
			  	  	   $('#backaccept_id').css('display','none');
			  	  	   $('#opCode').val('e505');
			  	  	   $('#opName').val('��Լ�ƻ�����');
			  	  	   /*ningtn ��վ���غ�Լ�ƻ�*/
			  	  	   $('#bltys').css('display','block');
			  	    }
			    });
			    
				/*************************�ύ��ťע���¼�*****************************/
				$('#submit_btn').click(function() {
						submit_click();
				})
				/*************************�����ťע���¼�*****************************/
				$('#reset_btn').click(function() {
						$('#backaccept').val('');
				})
			})
			
			/*************************�ύ��ť�¼�ִ����*****************************/
			function submit_click() {
					var value = $('input[name="opFlag"][checked]').val();
					// ��ͬ��ֵ����ò�ͬ�ķ���
					if( value == 'one' ) {
						//����
						frm.action="se505.jsp";
					}else if( value == 'two' ) {
						//����
						frm.action="se506.jsp";
					}
					frm.submit();	
					return true;
			}
	</script>
</head>
<body>
<form name="frm" method="POST">
 	<input type="hidden" name="opCode" id="opCode" >
	<input type="hidden" name="opName" id="opName" >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">ѡ���������</div>
	</div>
<table cellspacing="0">
	<tr> 
		<td class="blue" width="20%">��������</td>
		<td colspan="3">
			
			<input type="radio" name="opFlag" value="two" checked>����
		</td>
	</tr>    
	<tr> 
		<td class="blue">�ֻ����� </td>
		<td> 
			<input type="text" size="12" name="activePhone" id="activePhone" value="<%=activePhone%>" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 maxlength="11" index="0" class="InputGrey" readOnly>
				<font color="orange">*</font>
		</td>
	</tr>
	<tr style="display:none" id="backaccept_id"> 
		<td class="blue">ҵ����ˮ</td>
		<td colspan="3">
			<input class="button" type="text" name="backaccept" id="backaccept" v_must=1 >
				<font color="orange">*</font>
		</td>
	</tr>
	<!-- ningtn �������غ�Լ�ƻ� start-->
	<tr id="bltys" style="display:block" > 
		<td class="blue">ҵ���������</td>
		<td >
			<select id="banlitype" name="banlitype" >
			<option value="0">ǰ̨����</option>
			<option value="1">��վԤԼ</option>
			</select>
		</td>
	</tr>
	<!-- ningtn �������غ�Լ�ƻ� end-->
	<tr> 
		<td colspan="4" align="center" id="footer"> 
			<input class="b_foot" type=button name="confirm" id="submit_btn" value="ȷ��" index="2">    
			<input class="b_foot" type=button name=back id="reset_btn" value="���">
			<input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab();">
		</td>
	</tr>
</table>
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
