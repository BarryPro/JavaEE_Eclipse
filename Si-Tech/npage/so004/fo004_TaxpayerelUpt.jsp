<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
   /*
   * ����: ��ֵ˰��˰��������Ϣ��ѯ
�� * �汾: v1.0
�� * ����: 2013-11-29
�� * ����: wangjxc
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����:  	
   * �޸���:
   * �޸�Ŀ��:
 ��*/
%>


<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%
	String login_no = (String)session.getAttribute("workNo");
	String login_name = (String)session.getAttribute("workName");
	String regionCode=(String)session.getAttribute("regCode");
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String hwAccept = "1";
	String showBody = "01";
	String cuDate =new SimpleDateFormat("yyyyMMdd").format(new java.util.Date()).toString();
	
	String UptCustId = request.getParameter("UptCustId");
	String UptParUnitId = request.getParameter("UptParUnitId");
	String UptParUnitName = request.getParameter("UptParUnitName");
	String UptLowUnitId = request.getParameter("UptLowUnitId");
	String UptLowUnitName = request.getParameter("UptLowUnitName");
	String UptParCustId = request.getParameter("UptParCustId");

%>
 
<html xmlns="http://www.w3.org/1999/xhtml">
	<script type="text/javascript" src="/npage/public/pubScript.js"></script>
	<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<head>
	
	<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
	<title>�ֹܷ�ϵ�޸�</title>	
</head>
<body>
	<div id="operation">
		<form method="post" name="frmo004Upt" action="" >
 			<%@ include file="/npage/include/header.jsp" %>
 			<div id="operation_table"> 	
      			<div id="add_input" name="add_input">
      				<div class="title">
      					<div class="text">��˰���ֹܷ�ϵ�޸�</div>
      					<input type="hidden" name="chn_CustId" id="chn_CustId" value='<%=UptCustId%>' />
      				</div>
      				<div class="input">	
		 				<table>
		 					<tr>
							<td class="blue">�ܻ������ű��룺</td>
							<td>
								<input type="text" name="upt_add_par_UnitId" id="upt_add_par_UnitId" value='<%=UptParUnitId%>' onfocus="changevalue()"; />
								<input type="button" id="button" name="sbutton" class="b_text" value="��ѯ" onClick="ChoseCust('1');"/>
							</td>
							<td class="blue">�ܻ����������ƣ�</td>
							<td>
								<input type="text" name="upt_add_par_UnitName" id="upt_add_par_UnitName" value='<%=UptParUnitName%>' disabled />
								<input type="hidden" name="upt_add_par_CustId" id="upt_add_par_CustId" value='<%=UptParCustId%>' />
							</td>
						</tr>
						<tr>
							<td class="blue">�ֻ������ű��룺</td>
							<td>
								<input type="text" name="upt_add_low_UnitId" id="upt_add_low_UnitId" value='<%=UptLowUnitId%>' onfocus="changeovalue()"; />
								<input type="button" id="button" name="sbutton" class="b_text" value="��ѯ" onClick="ChoseCust('2');"/>
							</td>
							<td class="blue">�ֻ����������ƣ�</td>
							<td>
								<input type="text" name="upt_add_low_UnitName" id="upt_add_low_UnitName" value='<%=UptLowUnitName%>' disabled />
								<input type="hidden" name="upt_add_low_CustId" id="upt_add_low_CustId" value='<%=UptCustId%>' />
							</td>
						</tr>
							
						</table>
					</div>	

		 			<div id="operation_button">
		 				<input type="button" class="b_foot" value="�޸�" id="btnSave" name="btnSave" onclick="taxpayrelUpt()"  />
		 				<input type="button" class="b_foot" value="����" id="clears" name="clears" onclick="uptreset()" />
					</div>
      				</div>
			</div>
 			<%@ include file="/npage/include/footer.jsp" %>
		</form>
	</div>

<script type="text/javascript">
	

		//������Ϣ��ѯ
	function ChoseCust(flag)
	{
		if(flag=='1')
		{
			if(document.frmo004Upt.upt_add_par_UnitId.value=="")
			{
				rdShowConfirmDialog("�������ܻ������ű���");
				return false;
			}
			else
			{
				var UnitId = $("#upt_add_par_UnitId").val();
			}	
		}
		else if(flag=='2')
		{
			if(document.frmo004Upt.upt_add_low_UnitId.value=="")
			{
				rdShowConfirmDialog("������ֻ������ű���");
				return false;
			}
			else
			{
				var UnitId = $("#upt_add_low_UnitId").val();
			}	
		}		
		var packet = new AJAXPacket("fo004_ajax_ChoCustList.jsp");
		packet.data.add("UnitId",UnitId); 
		packet.data.add("flag",flag); 
		core.ajax.sendPacket(packet,doQueryChoseCust);
    	packet = null;
	}
	
	//��ѯ�ص�����
  	function doQueryChoseCust(packet)
  	{
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		var ModFlag = packet.data.findValueByName("ModFlag");
    	if(retCode !=="000000")
    	{
      		rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
    	}
      	else
    	{
    		var ChoUnitName = packet.data.findValueByName("ChoUnitName");
			var ChoCustId = packet.data.findValueByName("ChoCustId");
    		if(ModFlag=='1')
    		{
    			$("#upt_add_par_UnitName").val(ChoUnitName);
    			$("#upt_add_par_CustId").val(ChoCustId);
    		}
    		else
    		{
    			$("#upt_add_low_UnitName").val(ChoUnitName);
    			$("#upt_add_low_CustId").val(ChoCustId);
    		}	
      		
 	 	}
  	} 

	function changevalue()
	{
		$("#upt_add_par_UnitName").val("");
	}
	
	function changeovalue()
	{
		$("#upt_add_low_UnitName").val("");
	}
	
	function uptreset()
	{
		$("#upt_add_par_UnitId").val("");
		$("#upt_add_par_UnitName").val("");
		$("#upt_add_par_CustId").val("");
		$("#upt_add_low_UnitId").val("");
		$("#upt_add_low_UnitName").val("");
		$("#upt_add_low_CustId").val("");
	}
	
	function taxpayrelUpt()
	{
		if(document.frmo004Upt.upt_add_low_UnitName.value=="" || document.frmo004Upt.upt_add_par_UnitName.value=="")
		{
			rdShowConfirmDialog("�ֹܷ�ϵ������д");
			return false;
		}
		if(document.frmo004Upt.upt_add_par_CustId.value==document.frmo004Upt.upt_add_low_CustId.value)
		{
			rdShowConfirmDialog("ͬһ�������������Ϊ�ֹܷ�ϵ");
			return false;
		}
		
		var ParCustId = $("#upt_add_par_CustId").val();
		var LowCustId = $("#upt_add_low_CustId").val();
		var chn_CustId = $("#chn_CustId").val();
		var packet = new AJAXPacket("fo004_ajax_doUptRelSubmit.jsp","���Ժ�...");
		packet.data.add("ParCustId",ParCustId);
		packet.data.add("LowCustId",LowCustId);
		packet.data.add("chn_CustId",chn_CustId);
		core.ajax.sendPacket(packet,dorelUptSuccess,true);
	  	packet = null;
		
	}
	
	function dorelUptSuccess(packet)
	{
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		if(retCode == "000000")
		{
			rdShowMessageDialog("�޸��ֹܷ�ϵ�ɹ���",2);
			window.close();
			window.opener.taxrelListuptQry();
		} 
		else
		{
			rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
		}
	}

</script>	
</body>
</html>