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

%>
 
<html xmlns="http://www.w3.org/1999/xhtml">
	<script type="text/javascript" src="/npage/public/pubScript.js"></script>
	<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<head>
	
	<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
	<title>��˰�˹�ϵ����</title>	
</head>
<body>
	<div id="operation">
		<form method="post" name="frmo004" action="" >
 			<%@ include file="/npage/include/header.jsp" %>
 			<div id="operation_table"> 	
 				<div class="title">
 					<div class="text">��������</div>
 				</div>
			 	<div class="input">
					<table>
				 		<tr>
							<th>
								�������ͣ�
							</th>
							<td class="blue">
								<label class = "col-atttr-01"><input name="op" id="op" type="radio" value="query" onclick="choseType('query')"  checked="checked"/>��˰���ֹܷ�ϵ�޸�</label>
								<label class = "col-atttr-01"><input name="op" id="op" type="radio" value="add" onclick="choseType('add')" />��˰���ֹܷ�ϵ����</label>
								<label class = "col-atttr-01"><input name="op" id="op" type="radio" value="del" onclick="choseType('del')" />��˰���ֹܷ�ϵɾ��</label>
							</td>
				 		</tr>
					</table>
			 	</div>
			 	
				<div id="query_input">
	  				<div class="title">
	  					<div class="text">��˰���ֹܷ�ϵ�޸�</div>
	  				</div>
	  				<div class="input">
					<table>
						<tr>
							<td class="blue">�ܻ������ű��룺</td>
							<td>
								<input type="text" name="upt_par_UnitId" id="upt_par_UnitId" />
							</td>	
							<td class="blue">�ֻ������ű��룺</td>
							<td>
								<input type="text" name="upt_low_UnitId" id="upt_low_UnitId" />
							</td>	
						</tr>
					</table>
					</div>
					<div id="operation_button">
						<input class="b_foot"  type="button" value="��ѯ" onClick="taxrelListuptQry()">
						<input type="button" class="b_foot" value="����" onClick="uptreset()" />
					</div>
					<div id="ct_upttaxpayrel_list" style="display:none">
		        <div class="title">
		          <div class="text">��˰���ֹܷ�ϵ�޸��б�</div>
		        </div>
	          <div class="list" id="upt_query_result"></div>
	        		</div>
      			</div>
      	
      			<div id="add_input" name="add_input" style="display:none">
      				<div class="title">
      					<div class="text">��˰���ֹܷ�ϵ����</div>
      				</div>
      				<div class="input">	
		 				<table>
		 					<tr>
							<td class="blue">�ܻ������ű��룺</td>
							<td>
								<input type="text" name="add_par_UnitId" id="add_par_UnitId" />
								<input type="button" id="button" name="sbutton" class="b_text" value="��ѯ" onClick="ChoseCust('1');"/>
							</td>
							<td class="blue">�ܻ����������ƣ�</td>
							<td>
								<input type="text" name="add_par_UnitName" id="add_par_UnitName" disabled />
								<input type="hidden" name="add_par_CustId" id="add_par_CustId"/>
							</td>
						</tr>
						<tr>
							<td class="blue">�ֻ������ű��룺</td>
							<td>
								<input type="text" name="add_low_UnitId" id="add_low_UnitId" />
								<input type="button" id="button" name="sbutton" class="b_text" value="��ѯ" onClick="ChoseCust('2');"/>
							</td>
							<td class="blue">�ֻ����������ƣ�</td>
							<td>
								<input type="text" name="add_low_UnitName" id="add_low_UnitName" disabled />
								<input type="hidden" name="add_low_CustId" id="add_low_CustId"/>
							</td>
						</tr>
							
						</table>
					</div>	

		 			<div id="operation_button">
		 				<input type="button" class="b_foot" value="����" id="btnSave" name="btnSave" onclick="taxpayrelAdd()"  />
		 				<input type="button" class="b_foot" value="����" id="clears" name="clears" onclick="addreset()" />
					</div>
      				</div>
      			
      			<div id="del_input">
	  				<div class="title">
	  					<div class="text">��˰���ֹܷ�ϵɾ��</div>
	  				</div>
	  				<div class="input">
					<table>
						<tr>
							<td class="blue">�ܻ������ű��룺</td>
							<td>
								<input type="text" name="del_par_UnitId" id="del_par_UnitId" />
							</td>	
							<td class="blue">�ֻ������ű��룺</td>
							<td>
								<input type="text" name="del_low_UnitId" id="del_low_UnitId" />
							</td>	
						</tr>
					</table>
					</div>
					<div id="operation_button">
						<input class="b_foot"  type="button" value="��ѯ" onClick="taxrelListQry()">
						<input type="button" class="b_foot" value="����" onClick="delreset()" />
					</div>
					<div id="ct_taxpayrel_list" style="display:none">
		        <div class="title">
		          <div class="text">��˰�˹�ϵɾ���б�</div>
		        </div>
	          <div class="list" id="query_result"></div>
	        		</div>
      			</div>	
      			
			</div>
 			<%@ include file="/npage/include/footer.jsp" %>
		</form>
	</div>

<script type="text/javascript">
	var op_type;
	var index=0; 
	var save_name=new Array();
	$().ready(function(){choseType('query')});
	
	//ѡ���ѯ������
	function choseType(in_type){
		op_type=in_type;
		if(op_type=="query"){
			query_input.style.display="";
			add_input.style.display="none";
			del_input.style.display="none";
		 prelist.length = 0;
		}else if(op_type=="add"){
			query_input.style.display="none";
			add_input.style.display="";
			del_input.style.display="none";
		 prelist.length = 0;
		}
		else if(op_type=="del"){
			query_input.style.display="none";
			add_input.style.display="none";
			del_input.style.display="";
		}	
	}
	

	//������Ϣ��ѯ
	function ChoseCust(flag)
	{
		if(flag=='1')
		{
			if(document.frmo004.add_par_UnitId.value=="")
			{
				rdShowConfirmDialog("�������ܻ������ű���");
				return false;
			}
			else
			{
				var UnitId = $("#add_par_UnitId").val();
			}	
		}
		else if(flag=='2')
		{
			if(document.frmo004.add_low_UnitId.value=="")
			{
				rdShowConfirmDialog("������ֻ������ű���");
				return false;
			}
			else
			{
				var UnitId = $("#add_low_UnitId").val();
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
    			$("#add_par_UnitName").val(ChoUnitName);
    			$("#add_par_CustId").val(ChoCustId);
    		}
    		else
    		{
    			$("#add_low_UnitName").val(ChoUnitName);
    			$("#add_low_CustId").val(ChoCustId);
    		}	
      		
 	 	}
  	}   

	
	
	function taxrelListQry()
	{
		var CustParId = $("#del_par_UnitId").val();
		var CustLowId = $("#del_low_UnitId").val();
		var packet = new AJAXPacket("fo004_ajax_ResultList.jsp");
		packet.data.add("CustParId",CustParId);
		packet.data.add("CustLowId",CustLowId);
		packet.data.add("TypeMod","1");
		packet.data.add("PAGE_NUM","1");   
		core.ajax.sendPacketHtml(packet,doQueryTaxpayRel);
    	packet = null;
	}
	
	//��ѯ�ص�����
  	function doQueryTaxpayRel(data)
  	{
  		$("#query_result").empty().append(data);
    	var retCode=$("#retCode").val();
    	var retMsg=$("#retMsg").val();
    	if(retCode !=="000000")
    	{
      		rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
    	}
      	else
    	{
      		$("#ct_taxpayrel_list").css("display","");
  		}
  	}   
		
	 //��ҳ��ѯ��˰��������Ϣ��¼
  	function doQueryTaxpayrelList(page_index)
  	{
		var CustParId = $("#del_par_UnitId").val();
		var CustLowId = $("#del_low_UnitId").val();
		var packet = new AJAXPacket("fo004_ajax_ResultList.jsp");
		packet.data.add("CustParId",CustParId);
		packet.data.add("CustLowId",CustLowId);
		packet.data.add("TypeMod","1");
		packet.data.add("PAGE_NUM",page_index);
		core.ajax.sendPacketHtml(packet,getQueryTaxrelListResult);
		packet = null;
	}
      
 	function getQueryTaxrelListResult(data)
  	{
  		$("#query_result").empty().append(data);
    	var retCode=$("#retCode").val();
    	var retMsg=$("#retMsg").val();
    	if(retCode !=="000000")
    	{
      		rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
    	}
      	else
    	{
      		$("#ct_taxpayrel_list").css("display","");
  		}
  	} 
	
	
	function taxrelListuptQry()
	{

		var CustParId = $("#upt_par_UnitId").val();
		var CustLowId = $("#upt_low_UnitId").val();	
		var packet = new AJAXPacket("fo004_lowcustQuery.jsp");
		packet.data.add("CustParId",CustParId);
		packet.data.add("CustLowId",CustLowId);
		packet.data.add("TypeMod","2");
		packet.data.add("PAGE_NUM","1");   
		core.ajax.sendPacketHtml(packet,doQueryTaxpayUptRel);
    	packet = null;
	}
	
	//��ѯ�ص�����
  	function doQueryTaxpayUptRel(data)
  	{
  		$("#upt_query_result").empty().append(data);
    	var retCode=$("#retCode").val();
    	var retMsg=$("#retMsg").val();
    	if(retCode !=="000000")
    	{
      		rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
    	}
      	else
    	{
      		$("#ct_upttaxpayrel_list").css("display","");
  		}
  	}   
		
	 //��ҳ��ѯ��˰��������Ϣ��¼
  	function doQueryTaxpayreluptList(page_index)
  	{

		var CustParId = $("#upt_par_UnitId").val();
		var CustLowId = $("#upt_low_UnitId").val();	
		var packet = new AJAXPacket("fo004_ajax_ResultList.jsp");
		packet.data.add("CustParId",CustParId);
		packet.data.add("CustLowId",CustLowId);
		packet.data.add("TypeMod","2");
		packet.data.add("PAGE_NUM",page_index);
		core.ajax.sendPacketHtml(packet,getQueryTaxreluptListResult);
		packet = null;
	}
      
 	function getQueryTaxreluptListResult(data)
  	{
  		$("#upt_query_result").empty().append(data);
    	var retCode=$("#retCode").val();
    	var retMsg=$("#retMsg").val();
    	if(retCode !=="000000")
    	{
      		rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
    	}
      	else
    	{
      		$("#ct_upttaxpayrel_list").css("display","");
  		}
  	} 
	
	
	//�ͻ���ϵ����
	function taxpayrelAdd()
	{
		if(document.frmo004.add_low_UnitName.value=="" || document.frmo004.add_par_UnitName.value=="")
		{
			rdShowConfirmDialog("�ֹܷ�ϵ������д");
			return false;
		}
		if(document.frmo004.add_par_CustId.value==document.frmo004.add_low_CustId.value)
		{
			rdShowConfirmDialog("ͬһ�������������Ϊ�ֹܷ�ϵ");
			return false;
		}
		
		var ParCustId = $("#add_par_CustId").val();
		var LowCustId = $("#add_low_CustId").val();
		var packet = new AJAXPacket("fo004_ajax_doRelSubmit.jsp","���Ժ�...");
		packet.data.add("ParCustId",ParCustId);
		packet.data.add("LowCustId",LowCustId);
		core.ajax.sendPacket(packet,dorelSuccess,true);
	  	packet = null;
	}
	
	function dorelSuccess(packet)
	{
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		if(retCode == "000000")
		{
			rdShowMessageDialog("�����ͻ���ϵ�ɹ���",2);
			window.location.reload();
		} 
		else
		{
			rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
		}
	}
	
		
	function delreset()
	{
		$("#del_par_UnitId").val("");
		$("#del_low_UnitId").val("");
	}
	
	function uptreset()
	{
		$("#upt_par_UnitId").val("");
		$("#upt_low_UnitId").val("");
	}
	
	function addreset()
	{
		$("#add_par_UnitId").val("");
		$("#add_par_UnitName").val("");
		$("#add_par_CustId").val("");
		$("#add_low_UnitId").val("");
		$("#add_low_UnitName").val("");
		$("#add_low_CustId").val("");
	}
	
	function delTaxPayerlist(DelCustId)
	{
		if(rdShowConfirmDialog('ȷ��Ҫ����ɾ���ֹܷ�ϵô��')==1)
        {
        	var packet = new AJAXPacket("fo004_ajax_doTaxpayerRelDel.jsp","���Ժ�...");
			packet.data.add("DelCustId",DelCustId);
			packet.data.add("delMod","1");
			core.ajax.sendPacket(packet,doDelTaxpayerRel,true);
	  		packet = null;
        }
	}
	
	function doDelTaxpayerRel(packet)
	{
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		if(retCode == "000000")
		{
			rdShowMessageDialog("����ɾ���ֹܷ�ϵ�����ɹ���",2);
			taxrelListQry();
		} 
		else
		{
			rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
		}
	}
	
	function dodelTaxPayerInfo(doDelCustId)
	{
		if(rdShowConfirmDialog('ȷ��Ҫɾ���ֹܷ�ϵô��')==1)
        {
        	var packet = new AJAXPacket("fo004_ajax_doTaxpayerRelDel.jsp","���Ժ�...");
			packet.data.add("DelCustId",doDelCustId);
			packet.data.add("delMod","2");
			core.ajax.sendPacket(packet,doDelTaxpayeruptRel,true);
	  		packet = null;
        }
	}
	
	function doDelTaxpayeruptRel(packet)
	{
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		if(retCode == "000000")
		{
			rdShowMessageDialog("ɾ���ֹܷ�ϵ�����ɹ���",2);
			taxrelListuptQry();
		} 
		else
		{
			rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
		}
	}

	function uptTaxPayerInfo(UptCustId,UptParUnitId,UptParUnitName,UptLowUnitId,UptLowUnitName,UptParCustId)
	{
		window.open("fo004_TaxpayerelUpt.jsp?UptCustId="+UptCustId+"&UptParUnitId="+UptParUnitId+"&UptParUnitName="+UptParUnitName+"&UptLowUnitId="+UptLowUnitId+"&UptLowUnitName="+UptLowUnitName+"&UptParCustId="+UptParCustId, "�ֹܷ�ϵ�޸�", "height=350, width=600,top=100,left=300,scrollbars=yes, resizable=no,location=no, status=yes");
	}

</script>	
</body>
</html>