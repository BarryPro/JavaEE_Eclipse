<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-15 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %> 
<%@ page import="java.util.*" %>
<%
String opCode = "zg10";
String opName = "�������ɻ���";
String workno = (String)session.getAttribute("workNo");
String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
%> 
<HTML>
<HEAD>
<script language="JavaScript">
function docheck()
{
	
	  if(document.frm.contract_no.value=="")
	  {
		  rdShowMessageDialog("������ͳ���˻��ʺ�!");
			document.frm.contract_no.focus();
			return false;
	  }
	  else if(document.getElementById("cus_pass").value=="")
	  {
		  rdShowMessageDialog("�������˻�����!");
			document.getElementById("cus_pass").focus();
			return false;
	  }
	  else
	  {
		   
		    var checkPwd_Packet = new AJAXPacket("../zg01/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
			//xl add new begin
			checkPwd_Packet.data.add("custType", "03");						//01:�ֻ����� 02 �ͻ�����У�� 03�ʻ�����У��
			checkPwd_Packet.data.add("contract_no", document.frm.contract_no.value);		//�ƶ�����,�ͻ�id,�ʻ�id
			checkPwd_Packet.data.add("custPaswd", document.getElementById("cus_pass").value);//�û�.�ͻ�.�ʻ�����
			checkPwd_Packet.data.add("idType", "en");							//en ����Ϊ���ģ�������� ����Ϊ����
			checkPwd_Packet.data.add("idNum", "");							//����
			checkPwd_Packet.data.add("loginNo", "<%=workno%>");				//����
			//xl add new end
			core.ajax.sendPacket(checkPwd_Packet);
			checkPwd_Packet=null;
	  }		 
} 
 
 //core.ajax.sendPacket(myPacket,retsWLWI);
function doProcess(packet){
	var retResult_mm = packet.data.findValueByName("retResult_mm");
	var msg = packet.data.findValueByName("msg");
	
	
	//retResult_mm="000000";  
	
if( retResult_mm=="000000"  )//����У�� ������ȷ
	{
		//rdShowMessageDialog("У�� ͨ��");
		//document.getElementById("query_id").disabled=false;
		/**/
	    document.frm.action="zg10_2.jsp?contract_no="+document.frm.contract_no.value;
	    document.frm.query.disabled=true;
	    document.frm.submit();
		   
	}
	else
	{
		rdShowMessageDialog("�ʺ����������ʺŲ�����!");
		//document.getElementById("pwd_flag").value="1";
	}
	 

    
 
 
  
 // docheck();
}

 
 
  function doclear() {
 		frm.reset();
 }


 function inits()
 {
	 //document.getElementById("query_id").disabled=true;
 }

 function doQry()//ʧ�ܲ�ѯ
 {
	
	  if(document.frm.contract_no.value=="")
	  {
		  rdShowMessageDialog("������ͳ���˻��ʺ�!");
			document.frm.contract_no.focus();
			return false;
	  }
	  else if(document.getElementById("cus_pass").value=="")
	  {
		  rdShowMessageDialog("�������˻�����!");
			document.getElementById("cus_pass").focus();
			return false;
	  }
	  else
	  {
		   
		    var checkPwd_Packet = new AJAXPacket("../zg01/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
			//xl add new begin
			checkPwd_Packet.data.add("custType", "03");						//01:�ֻ����� 02 �ͻ�����У�� 03�ʻ�����У��
			checkPwd_Packet.data.add("contract_no", document.frm.contract_no.value);		//�ƶ�����,�ͻ�id,�ʻ�id
			checkPwd_Packet.data.add("custPaswd", document.getElementById("cus_pass").value);//�û�.�ͻ�.�ʻ�����
			checkPwd_Packet.data.add("idType", "en");							//en ����Ϊ���ģ�������� ����Ϊ����
			checkPwd_Packet.data.add("idNum", "");							//����
			checkPwd_Packet.data.add("loginNo", "<%=workno%>");				//����
			//xl add new end
			//core.ajax.sendPacket(checkPwd_Packet);
			core.ajax.sendPacket(checkPwd_Packet,retsWLWI);
			checkPwd_Packet=null;
	  }		 
}
function retsWLWI(packet)
{
	var retResult_mm = packet.data.findValueByName("retResult_mm");
	var msg = packet.data.findValueByName("msg");
	
	if( retResult_mm=="000000"  )//����У�� ������ȷ
		{
			//rdShowMessageDialog("У�� ͨ��");
			//document.getElementById("query_id").disabled=false;
			/**/
			document.frm.action="zg10_4.jsp?contract_no="+document.frm.contract_no.value;
			document.frm.query.disabled=true;
			document.frm.submit();
			   
		}
		else
		{
			rdShowMessageDialog("�ʺ����������ʺŲ�����!");
			//document.getElementById("pwd_flag").value="1";
		}
}

function doQrySuc()//�ɹ���ѯ
 {
	
	  if(document.frm.contract_no.value=="")
	  {
		  rdShowMessageDialog("������ͳ���˻��ʺ�!");
			document.frm.contract_no.focus();
			return false;
	  }
	  else if(document.getElementById("cus_pass").value=="")
	  {
		  rdShowMessageDialog("�������˻�����!");
			document.getElementById("cus_pass").focus();
			return false;
	  }
	  else
	  {
		   
		    var checkPwd_Packet = new AJAXPacket("../zg01/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
			//xl add new begin
			checkPwd_Packet.data.add("custType", "03");						//01:�ֻ����� 02 �ͻ�����У�� 03�ʻ�����У��
			checkPwd_Packet.data.add("contract_no", document.frm.contract_no.value);		//�ƶ�����,�ͻ�id,�ʻ�id
			checkPwd_Packet.data.add("custPaswd", document.getElementById("cus_pass").value);//�û�.�ͻ�.�ʻ�����
			checkPwd_Packet.data.add("idType", "en");							//en ����Ϊ���ģ�������� ����Ϊ����
			checkPwd_Packet.data.add("idNum", "");							//����
			checkPwd_Packet.data.add("loginNo", "<%=workno%>");				//����
			//xl add new end
			//core.ajax.sendPacket(checkPwd_Packet);
			core.ajax.sendPacket(checkPwd_Packet,retsWLWI1);
			checkPwd_Packet=null;
	  }		 
}
function retsWLWI1(packet)
{
	var retResult_mm = packet.data.findValueByName("retResult_mm");
	var msg = packet.data.findValueByName("msg");
	
	if( retResult_mm=="000000"  )//����У�� ������ȷ
		{
			//rdShowMessageDialog("У�� ͨ��");
			//document.getElementById("query_id").disabled=false;
			/**/
			document.frm.action="../zg10/zg10_5.jsp?contract_no="+document.frm.contract_no.value;
			document.frm.query.disabled=true;
			document.frm.submit();
			   
		}
		else
		{
			rdShowMessageDialog("�ʺ����������ʺŲ�����!");
			//document.getElementById("pwd_flag").value="1";
		}
}
-->
 </script> 
 
<title>������BOSS-��ͨ�ɷ�</title>
</head>
<BODY onload="inits()">
<form action="" method="post" name="frm">
		
		<%@ include file="/npage/include/header.jsp" %>   
  	<div class="title">
			<div id="title_zi">�������ѯ����</div>
		</div>
	<table cellspacing="0">
    <tr> 
      <td class="blue" width="15%">ͳ���˻�����</td>
      <td colspan=3> 
        <input class="button"type="text" name="contract_no" size="20" maxlength="12" colspan=2  onKeyPress="return isKeyNumberdot(0)" >
      </td>
      
       
    </tr>
	 
	<tr id="userpasswd" style="display:block">
				   <td class="blue"  width="15%">�˻�����</td>
					  <td colspan=3>
						<jsp:include page="/npage/query/pwd_one.jsp">
							<jsp:param name="width1" value="16%"  />
							<jsp:param name="width2" value="34%"  />
							<jsp:param name="pname" value="cus_pass"  />
							<jsp:param name="pwd" value="12345"  />
						</jsp:include>
				   </td>
	</tr>
	
<tr>
		<td class="blue">��ѯ��ʼʱ��</td>
		<td>
			<input type="text"    name="begin_time" value=<%=dateStr%> size="17" maxlength="17">(YYYYMMDD)
		</td>
		<td class="blue">��ѯ����ʱ��</td>
		<td>
			<input type="text"    name="end_time" value=<%=dateStr%> size="17" maxlength="17">(YYYYMMDD)
		</td>
	  </tr>

  </table>
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" id="query_id" name="query" class="b_foot" value="��������" onclick="docheck()" >
          &nbsp;
		   <input class="b_foot" name=query onClick="doQrySuc()" type=button value="�����ɹ���¼��ѯ">
		   &nbsp;
		   <input class="b_foot" name=query onClick="doQry()" type=button value="����ʧ�ܼ�¼��ѯ">
		     &nbsp;
          <input type="button" name="return1" class="b_foot" value="���" onclick="doclear()" >
          &nbsp;
		      <input type="button" name="return2" class="b_foot" value="�ر�" onClick="removeCurrentTab()" >
      </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>