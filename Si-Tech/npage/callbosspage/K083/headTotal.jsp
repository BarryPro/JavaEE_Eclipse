<%
  /*
   * ����: 12580��ҳ��
�� * �汾: 1.0.0
�� * ����: 2009/02/12
�� * ����: libin
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%
		response.setHeader("Pragma","No-cache"); 
		response.setHeader("Cache-Control","no-cache"); 
		response.setDateHeader("Expires", 0);
%>
<%
	String tf32ty = (String)session.getAttribute("KFTF32");//�����ж��Ƿ������뿪ͨ�ƶ��������
  String caphone = (String)session.getAttribute("capn");//�������
%>
<html>
	<head>

		<script language="javascript">
		var totalphone;
		var total_phone;
		function connectphone(){
			window.showModalDialog('../../connectware.jsp','','dialogWidth:400px;dialogHeight:150px;center:1');
		}

		function getHiscall(){
			
			total_phone = document.form1.total_phone.value;
			
			window.showModalDialog('../../hisCall.jsp?phone='+total_phone,'','dialogWidth:600px;dialogHeight:400px;center:1');
		}
		
		function callOff(){
		 
			/*var ret = window.top.cCcommonTool.ReleaseCall();
			
			if(ret==0){
				
				alert(�һ����);
			
			}
			*/
			var top_button_release=window.top.document.getElementById("K013");
			top_button_release.click();
		}
		</script>
	</head>
  <body >
  <form name="form1" method="post">
  	<input type="hidden" id="total_phone" name="total_phone" value="" />
  	<input type="hidden" id="tf32ty" name="tf32ty" value="<%=tf32ty==null?"":tf32ty %>" />
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	  <tr align="left">
	  </tr>	  
		</table>
	</form>
  </body>
</html>
