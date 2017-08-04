<%
    /********************
     version v2.0
     ������: si-tech
     *
     *create:liujian@2011-12-07 ���ٻ��Ѷ԰뷵�����칵ͨ�޸���
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String opName = WtcUtil.repStr(request.getParameter("opName"), "");
%>
<html>
<head>
	<title><%=opName%></title>
	<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
	<script language="JavaScript">
		//��ʼ��
		$(function() {
				var packet = new AJAXPacket("se465_srv.jsp","���ڻ�ÿͻ���Ϣ�����Ժ�......");
				var _data = packet.data;
				_data.add("opCode","<%=opCode%>");
				_data.add("phone","<%=activePhone%>");
			  _data.add("method","init");  
			 	core.ajax.sendPacket(packet,initProcess);
				getdataPacket = null;
		});
		//��ʼ���ص�����
		function initProcess(packet) {
			 var _data = packet.data;
		 	 var retCode = _data.findValueByName("retcode");
			 var retMsg = _data.findValueByName("retmsg");
			 if(retCode == "000000"){
				 $('#custName').val(_data.findValueByName("custName"));
				 $('#groupName').val(_data.findValueByName("groupName"));
			 }else{
				 rdShowMessageDialog("������룺" + retCode + "��������Ϣ��" + retMsg,0);
				 removeCurrentTab();
				 return false;
			}
		}
		
		//�ύ
		function scl_submit() {
			var childCard = $('#childCard').val();
			var groupSchool = $('#groupSchool').val();
			if(childCard == null || childCard.length == 0){
				rdShowMessageDialog("������ѧ��֤����!");
		     document.frm.groupSchool.focus();
		     return false;
			}
			if(groupSchool == null || groupSchool.length == 0){
				rdShowMessageDialog("���������ԺУ!");
		     document.frm.groupSchool.focus();
		     return false;
			}
			 var packet = new AJAXPacket("se465_srv.jsp","�����ύ�ͻ���Ϣ�����Ժ�......");
			 var _data =  packet.data;
			 _data.add("method","submit");
			 _data.add("opCode","<%=opCode%>");
			 _data.add("phone","<%=activePhone%>");
			 _data.add("groupSchool",groupSchool);
			 _data.add("childCard",childCard);
			 core.ajax.sendPacket(packet);
			 getdataPacket = null;
		}
		//�ύ�ص�����
		function doProcess(packet) {
			 var retCode = packet.data.findValueByName("retcode");
			 var retMsg = packet.data.findValueByName("retmsg");
			 if(retCode == "000000"){
				 //��ʾ��Ҫչʾ����Ϣ
				 rdShowMessageDialog("�����ɹ���",2);
				 removeCurrentTab();
			 }else{
				 rdShowMessageDialog("������룺" + retCode + "��������Ϣ��" + retMsg,0);
				 return false;
			}
		}
		
		function scl_reset() {
			 // location.reload();
			$('#childCard').val('');
			$('#groupSchool').val('');
		}
	</script>
</head>
<body>

<form name="frm" method="POST">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div name="title_zi" id="title_zi"><%=opName%></div>
	</div>
	<table cellspacing="0">
		<tr>
	      <td class="blue">�ֻ����� </td>
	      <td colspan="3">
	      		<input type="text" maxlength="11" name="activePhone" id="activePhone" value="<%=activePhone%>" class="InputGrey" readonly />
	      </td>
	   </tr>
	   <tr>
	   	  <td class="blue">�ͻ����� </td>
	      <td>
	          <input type="text" name="custName" id="custName" class="InputGrey" readonly />
	      </td>
	   	  <td class="blue">�������� </td>
	      <td>
	          <input type="text" name="groupName" id="groupName" class="InputGrey" readonly />
	      </td>
	   </tr>
	   <tr>
	   	  <td class="blue">����ԺУ </td>
	      <td colspan="3">
	          <input type="text" name="groupSchool" id="groupSchool"  v_must=1 v_type="string"  size="100" maxlength="50" />
	          <font class="orange">*</font>
	      </td> 
	   </tr>
	   <tr>
				<td class="blue">ѧ��֤���� </td>
	      <td colspan="3">
	          <input type="text" name="childCard" id="childCard"  v_must=1 v_type="string"  size="100" maxlength="50" />
	      	  <font class="orange">*</font>
		    </td>
	   </tr>
	  <tr id="footer">
	      <td colspan="4">
	          <input class="b_foot" name="submitt"  id="submitt"  type="button" value="ȷ��"  onclick="scl_submit();" />
	          <input class="b_foot" name="reset1"  onClick="scl_reset();" type="button" value="����" />
	          <input class="b_foot" name="close"  onClick="removeCurrentTab();" type=button value="�ر�" />
	      </td>
	  </tr>
	</table>
	<%@ include file="/npage/include/footer_simple.jsp" %> 
</form>
</body>
</html>
