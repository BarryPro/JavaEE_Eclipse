<%
/********************
 version v2.0
������: si-tech
baixf 20080309 061@2008 �������ƾ���ϵͳӪ������ƽ̨Ŀ��ͻ�Ⱥ��ȡ�������ӿڹ��ܵ�����
*
*update:zhanghonga@2008-08-15 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
 
 <%
 	String opCode = "1310";
	String opName="�˺Žɷѳ���";
    String s_old_status = WtcUtil.repNull(request.getParameter("s_old_status"));
	//ԭ��Ʊ״̬ 0-δ���� 1-ֽ�� 2-�����ն� 6-Ԥռ e-���ӷ�Ʊ r-�վ� z-רƱ
	String regionCode= (String)session.getAttribute("regCode");
	//regionCode="11";
%>
 
 
<HEAD>
<HTML><HEAD><TITLE>�ʺŲ�ѯ</TITLE>
<script LANGUAGE="JavaScript">
	window.returnValue="";
	function selAccount()//��ӡ��Ʊ�� ���ԭ���ߵ��ǵ��ӵ� ֻ���ǵ��ӵ� ��������ֽ�ʵ�
	{	
		  if("<%=s_old_status%>"=="e")
		  {
			  rdShowMessageDialog("ԭ���߷�ƱΪ���ӷ�Ʊ,����ʱֻ�ܿ��ߺ��ֵ��ӷ�Ʊ!");
			  document.frm.busyType1.checked=false;
			  selAccount3();
		  }
		  else
		  {
			  window.returnValue="1";
			  document.getElementById("type_id").value="1";
		//	  document.frm.busyType2.checked=false;
			  document.frm.busyType3.checked=false;
			  document.getElementById("cfm_id").focus();
			  //window.close();
		  }	
		  
	}
	
	function selAccount3()//��ӡ���ӵ� ���ԭ��ֽ�ʵ� ֻ����ֽ�ʵ� ���ܿ����ӵ�
	{	
		  //����У��
		  if("<%=regionCode%>"=="11"||"<%=regionCode%>"=="08")
		  {
			 
			  if("<%=s_old_status%>"!="e")
			  {
				  rdShowMessageDialog("ԭ���߷�Ʊ�ǵ��ӷ�Ʊ,����ʱҲ�������ߺ��ֵ��ӷ�Ʊ!");
				  document.frm.busyType3.checked=false;
				  selAccount();
			  }
			  else
			  {
				  window.returnValue="3";
				  document.getElementById("type_id").value="3";
				  document.frm.busyType1.checked=false;
	 
				  document.getElementById("cfm_id").focus();
			 
			  }	
			  /*
			  window.returnValue="3";
			  document.getElementById("type_id").value="3";
			  document.frm.busyType1.checked=false;
			  document.getElementById("cfm_id").focus();
			  */
		  }
		  else
		  {
			  rdShowMessageDialog("���������Ե�����У���ʱ�������ӡ���ӷ�Ʊ����!");
			  //ֻ�ô�ӡ�վ�
			  //selAccount();
			  document.frm.busyType3.checked=false;
			  return false;
		  }	
		  
		  
	}
	function getAccount()
	{
		window.returnValue=document.getElementById("type_id").value;
		window.close();
	}
	function doback()
	{
		window.returnValue="";
		window.close();
	}
	function init()
	{
		//alert("test is "+"<%=s_old_status%>");
		if("<%=s_old_status%>"=="e")
		{
			document.frm.busyType3.checked=true;
			selAccount3();
		}
		else
		{
			document.frm.busyType1.checked=true;
			selAccount();
		}
	}
</script>
<TITLE>Ӫ����Ϣ��ѯ</TITLE>
</head>

<BODY onload="init()">
<form  name="frm" method="post" action="">      
  <%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">��ӡ����ѡ��</div>
			</div>
      <TABLE cellSpacing="0">
        <TBODY>
         
		  <tr align="center">
	          <td><input name="busyType1" type="radio" value="1" onClick="selAccount()"  onKeyDown="if(event.keyCode==13) selAccount();">��ӡ��Ʊ</td>
           
			  <td><input name="busyType3" type="radio" value="3" onClick="selAccount3()"  onKeyDown="if(event.keyCode==13) selAccount3();">��ӡ���ӷ�Ʊ</td>
          </tr>	
         </TBODY>
	    </TABLE>
 
   <table cellspacing="0">
   <tr> 
      <td colspan="6" id="footer"> 
          <input class="b_foot" type="button" id="cfm_id" name="Button" value="ȷ��" onKeyDown="if(event.keyCode==13) getAccount();"  onClick="getAccount()">
          <input class="b_foot" type="button" name="return" value="����" onClick="doback()">
      </td>
    </tr>
   <input type="hidden" id="type_id" value="1">
 	</table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
</form>
</body>
</html>