<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="utils.system"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%
	String loginNo = (String)request.getParameter("loginNo");//����Ա��½����
	String password = (String)request.getParameter("password");//����Ա��½��������
	String group_id = (String)request.getParameter("groupId");
	String phoneNo = (String)request.getParameter("activePhone");//�ֻ���
	String saleSeq = (String)request.getParameter("saleSeq");//��ˮ
	System.out.println("++++++++++++++++++++++f4939_attention group_id="+group_id);
	System.out.println("++++++++++++++++++++++f4939_attention loginNo="+loginNo);
	System.out.println("++++++++++++++++++++++f4939_attention password="+password);
	System.out.println("++++++++++++++++++++++f4939_attention phoneNo="+phoneNo);
	System.out.println("++++++++++++++++++++++f4939_attention saleSeq="+saleSeq);
	
%>
<html>
<head>
	<title>�����˷�����</title>
</head>
<body>
	<div id="operation">
		<div id="operation_table"> 
			<div class="title"><div class="text">�����˷�����</div></div>		
			<div class="input">
				<table id="searchTable">
					<tr>
						<th>����ѡ��</th><th>��ʾ��Ϣ</th>
					</tr>
					<tr>
						<td>
							<select id="selectId" onchange="changeCity(this.value)">
								<option value="0">--��ѡ��--</option>
								<option value="1">���������������� </option>
								<option value="2">��ͨҵ����� </option>							
							</select>
						</td>
						<td>
							<SMALL>����������������<font style="color:red">[�����˻��ֽ�]</font><br/>��ͨҵ�����<font style="color:red">[�������ֽ�]</font>��</SMALL>
							<!-- <input class="required" name="meanName" value=""	maxlength="100" size="30" /> -->
						</td>
					</tr>
				</table>				
			</div>
			<div id="operation_button"><!-- disabled="disabled" -->
				<input type="button" class="b_foot"  disabled="disabled" value="ȷ��" id="btnSubmit" name="btnSubmit" onclick="doRetMain()" />
				<input type="button" class="b_foot" value="�ر�" id="btnCancel" name="btnCancel" onclick="closeWin()" />
			</div>
		</div>
	</div>
	<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
</body>
<script>
	var frm = document.all("frm");
	function changeCity(opId){
		if(opId == "0"){
			$("#btnSubmit").attr("disabled",true);
			return;
		}
		var packet = null;
		packet = new AJAXPacket("<%=request.getContextPath()%>/npage/se118/f4939_checkOrderId.jsp","���Ժ�...");//����У����񡣡����ض�Ӧ��Ϣ
		packet.data.add("saleSeq","<%=saleSeq%>");
		packet.data.add("optype",opId);
		packet.data.add("loginNo","<%=loginNo %>");
		core.ajax.sendPacketHtml(packet,doCheckOrderId,true);
		packet =null;
	}
	function doCheckOrderId(data){
		var sdata = data.split("~");
		var retCode = sdata[0];
		var opType = sdata[1];
		if(retCode == 0){
			$("#btnSubmit").attr("disabled",false);
			rdShowMessageDialog("ҵ����֤�ɹ���",1);
		}else{		
			$("#btnSubmit").attr("disabled",true);
			rdShowMessageDialog("��ѡ��ĳ���ѡ����ʵ�ʲ�������ȷ��ҵ��",1);
			return false;
		}	
	}
	
	function doRetMain(){
		window.opener.retSeq();
		window.close();
	}
	function closeWin(){
		window.close();
	}
	
	
</script>
</html>