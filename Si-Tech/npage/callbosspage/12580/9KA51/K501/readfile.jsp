<%
  /*
   * ����: ��ʱ�������
�� * �汾: 1.0.0
�� * ����: 2009/02/16
�� * ����: libin
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<HTML>
	<%
		String path = request.getParameter("filename");		
	%>
	<HEAD>
			<base target="_self">
			<Script language="javascript">
			  var fso, f1, ts, s=" ";
			  var ForReading = 1;     
			  fso = new ActiveXObject("Scripting.FileSystemObject");     
			  ts = fso.OpenTextFile("<%=path %>", ForReading);
			  while(!ts.AtEndOfStream)
				{
				s += ts.ReadLine()+" ";
				}
			  window.returnValue = s;		      
			  ts.Close();
			  
			  function gohis(){
					document.sitechform.action="temporaryPhone.jsp";
					document.sitechform.submit();
				}		  
		  </script>
	</HEAD>
	<BODY>
		<form name="sitechform" action="" target=""><BR><BR><BR>
  	<table border="0" cellpadding="0" cellspacing="0" width="100%" align="center">
			<tr align="center">
				<td>����ɹ�</td>
			</tr>
			<tr align="center">
				<td>&nbsp;</td>
			</tr>
			<tr align="center">
				<td><input type="button" class="b_foot" value="��һ��" onClick="gohis();">&nbsp;<input type="button" class="b_foot" value="�ر�" onClick="window.close();"></td>
			</tr>
		</table>
	  </form>
	</BODY>	
</HTML>

