<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
   /*
   * ����: ��ֵ˰��˰��������Ϣ��¼��ѯ
�� * �汾: v1.0
�� * ����: 2013-08-26
�� * ����: wangjxc	
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����:  	
   * �޸���:
   * �޸�Ŀ��:
 ��*/
%>

<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<script type="text/javascript" src="/npage/public/pubScript.js"></script>
<head>
	<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/My97DatePicker/WdatePicker.js"></script> 
	<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
	<title>��ֵ˰��˰��������Ϣ��¼��ѯ</title>	
</head>
<body>
	<div id="operation">
		<form method="post" name="frmo002" action="aa.jsp" >
 			<%@ include file="/npage/include/header.jsp" %>
 			<div id="operation_table"> 			 			
	  			<div class="title">
	  				<div class="text">��ֵ˰��˰��������Ϣ��¼��ѯ</div>
	  			</div>
	  			<div class="input">
					<table cellspacing="0">
						<tr>
							<td class="blue">�ͻ�ѡ��</td>
							<td>
								<input type="text" name="custName" id="custName" readonly="true"/>
								<input type="hidden" name="cust_id" id="cust_id"/>
								<input type="button" id="button" name="sbutton" class="b_text" value="ѡ��" onClick="selectCust();"/>
							</td>	
							<td class="blue">��˰��ʶ��ţ�</td>
							<td>
								<input type="text" id="taxpayer_id" />
							</td>
						</tr>
					</table>
				</div>	
				<div id="operation_button">
					<input class="b_foot"  type="button" value="��ѯ" onClick="TaxpayListQry()">
					<input type="button" class="b_foot" value="����" onClick="reset()" />  
				</div>
				<div id="ur_special_list" style="display:none">
                <div class="title">
                  <div class="text">��ֵ˰��˰��������Ϣ��־�б�</div>
                </div>
              <div class="list" id="query_result"></div>
            </div>	 			         					
			</div>
 			<%@ include file="/npage/include/footer.jsp" %>
		</form>
	</div>
<script type="text/javascript">
	
	//��ѯ��ֵ˰��˰��������Ϣ
	function TaxpayListQry()
	{
		var CustId       = $("#cust_id").val();
		var TaxpayerId   = $("#taxpayer_id").val();
		var packet = new AJAXPacket("fo002_ajax_ResultQry.jsp");
		packet.data.add("CustId",CustId);
		packet.data.add("TaxpayerId",TaxpayerId);
		packet.data.add("PAGE_NUM","1");   
		core.ajax.sendPacketHtml(packet,doQueryTaxpayer);
    	packet = null;
	}
	
	//��ѯ�ص�����
  function doQueryTaxpayer(data)
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
      $("#ur_special_list").css("display","");
  }
  }   
		
	 //��ҳ��ѯ��˰��������Ϣ��¼
  function doQueryTaxpayList(page_index)
  {
		var CustId       = $("#cust_id").val();
		var TaxpayerId   = $("#taxpayer_id").val();
		var packet = new AJAXPacket("fo002_ajax_ResultQry.jsp");
		packet.data.add("CustId",CustId);
		packet.data.add("TaxpayerId",TaxpayerId);
		packet.data.add("PAGE_NUM",page_index);
		core.ajax.sendPacketHtml(packet,getQueryTaxListResult);
		packet = null;
	}
      
 function getQueryTaxListResult(data)
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
      $("#ur_special_list").css("display","");
  }
  }   
		
		
	//ѡ��ͻ���ť
	function selectCust()
	{
		window.open("fo002_custQuery.jsp", "�ͻ���Ϣ", "height=350, width=600,top=100,left=300,scrollbars=yes, resizable=no,location=no, status=yes");
	}
	
	function setCustId(AddCustId,AddCustName,AddCustLogin)
	{
		$("#cust_id").val(AddCustId);
		$("#custName").val(AddCustName);
	}
		
</script>
</body>
</html>