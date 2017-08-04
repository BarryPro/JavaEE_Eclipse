<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
   /*
   * 功能: 审批
　 * 版本: v1.0
　 * 日期: 2013/10/17
　 * 作者: wangjxc
　 * 版权: sitech
  */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>

<%
		String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String login_no = (String)session.getAttribute("workNo");
%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<script type="text/javascript" src="/npage/public/pubScript.js"></script>
	<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title><%=opName%></title>
<script type="text/javascript">	
$(document).ready(function(){
	var IdType = "";
$("input[name='selType']").click(function(){
	if($(this).val()=="2"){
		$("#login_accept_all").val("");
		$("#firPer").css("display","");
		$("#secPer").css("display","none");
		$("#thrPer").css("display","none");
		IdType = "01";
		$("#auditState").val(IdType);
		document.getElementById("auditState").disabled=true;
		 $("#approve_list").css("display","none");
		 prelist.length = 0;
		
	}else if($(this).val()=="3"){
		$("#login_accept_all").val("");
		$("#firPer").css("display","none");
		$("#secPer").css("display","");
		$("#thrPer").css("display","none");
		IdType = "03";
		$("#auditState").val(IdType);
		document.getElementById("auditState").disabled=true;
		 $("#approve_list").css("display","none");
		 prelist.length = 0;
	}
	else{
		$("#login_accept_all").val("");
		$("#thrPer").css("display","none");
		$("#firPer").css("display","none");
		$("#secPer").css("display","none");
		IdType = "01";
		$("#auditState").val(IdType);
		document.getElementById("auditState").disabled=false;
		$("#approve_list").css("display","none");
		prelist.length = 0;
	}
});
});


	//查询审批轨迹
	function doQueryApprove()
	{
		var model = $("#selTab").find("input[name='selType']:checked").val();
		var firAssessor = $("#clogin_no").val();
		var secAssessor = $("#elogin_no").val();
		var CustId = $("#cust_id").val();
		var auditState = $("#auditState").val();
		var TaxpayerId = $("#taxpayer_id").val();
		var packet = new AJAXPacket("fo003_ajax_doQuery.jsp");
		if(model=="2"){
			packet.data.add("LoginNo",firAssessor);
		}else if(model=="3"){
			packet.data.add("LoginNo",secAssessor);
		}
		packet.data.add("model",model);
		packet.data.add("auditState",auditState);
		packet.data.add("CustId",CustId);
		packet.data.add("TaxpayerId",TaxpayerId);
		packet.data.add("PAGE_NUM","1");   
		core.ajax.sendPacketHtml(packet,doGetHtml);
		packet =null;
	}
	
	//分页查询授权人含有的功能权限
   	function doQueryApproveList(page_index,total_num)
   	{
   		var model = $("#selTab").find("input[name='selType']:checked").val();
		var firAssessor = $("#clogin_no").val();
		var secAssessor = $("#elogin_no").val();
		var thrAssessor = $("#blogin_no").val();
		var CustId = $("#cust_id").val();
		var auditState = $("#auditState").val();
		var TaxpayerId = $("#taxpayer_id").val();
		var packet = new AJAXPacket("fo003_ajax_doQuery.jsp");
		if(model=="2")
		{
			packet.data.add("LoginNo",firAssessor);
		}else if(model=="3"){
			packet.data.add("LoginNo",secAssessor);
		}
		packet.data.add("model",model);
		packet.data.add("auditState",auditState);
		packet.data.add("CustId",CustId);
		packet.data.add("TaxpayerId",TaxpayerId);
   		packet.data.add("PAGE_NUM",page_index);
		core.ajax.sendPacketHtml(packet,doGetHtml);
		packet =null;
   	}
		
	function doGetHtml(data)
	{
		$("#query_result").empty().append(data);
        var retCode=$("#retCode").val();
        var retMsg=$("#retMsg").val();
       if(retCode !=="000000")
    {
      rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
    }
      else
    {
      $("#approve_list").css("display","");
  }
       
	}
	
	//选择客户按钮
	function selectCust()
	{
		window.open("fo003_custQuery.jsp", "客户信息", "300", "100");
	}
	
	function setCustId(AddCustId,AddCustName,AddCustLogin)
	{
		$("#cust_id").val(AddCustId);
		$("#custName").val(AddCustName);
	}
	
	function uptTaxapp(UptCustId,UpCustOne,modelflag)
	{
		window.open("fo003_TaxpayerApp.jsp?UptCustId="+UptCustId+"&UpCustOne="+UpCustOne+"&modelflag="+modelflag, "审批信息", "height=350, width=600,top=100,left=300,scrollbars=yes, resizable=no,location=no, status=yes");
	}
	
	function uptTaxPayerInfo(UpCustId,queryflag)
	{
		window.open("fo003_TaxpayerUpt.jsp?UpCustId="+UpCustId+"&queryflag="+queryflag, "修改信息", "height=500, width=1000,top=200,left=450,scrollbars=yes, resizable=no,location=no, status=yes");
	}
	
	function viewTaxPayerInfo(UpCustId,queryflag)
	{
		window.open("fo003_TaxpayerView.jsp?UpCustId="+UpCustId+"&queryflag="+queryflag, "展示信息", "height=500, width=1000,top=200,left=450,scrollbars=yes, resizable=no,location=no, status=yes");
	}
		
	function delTaxPayerInfo(DelCustId)
	{
		if(rdShowConfirmDialog('确认要删除改纳税人资质信息么？')==1)
        {
        	var packet = new AJAXPacket("fo003_ajax_doTaxpayerDel.jsp","请稍后...");
			packet.data.add("DelCustId",DelCustId);
			core.ajax.sendPacket(packet,doDelTaxpayer,true);
	  		packet = null;
        }
	}
	
	function doDelTaxpayer(packet)
	{
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		if(retCode == "000000")
		{
			rdShowMessageDialog("删除操作完成！",2);
			doQueryApprove();
		} 
		else
		{
			rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
		}
	}
	
	function resetMsg()
	{
		$("#taxpayer_id").val("");
		$("#cust_id").val("");
		$("#custName").val("");
	}
	
</script>
</head>
<body>
<div id="operation">
<%@ include file="/npage/include/header.jsp"%>
<div id="operation_table">
<form action="" name="frmj625_query">
<div class="title">
<div class="text">操作类型</div>
</div>
<div class="input">
	<input type="hidden" id="login_accept_all"  /> 
<table id="selTab">
	<tr>
		<th>查询类型</th>
		<td>
			<input type="radio" name="selType" value="2" checked />上级主管审批人 
			<input type="radio" name="selType" value="3" />财务审批人
			<input type="radio" name="selType" value="4" style="display:none" />
		</td>
	</tr>
	<tr id="firPer">
		<th><span class="red">*上级主管：</span>
		</th>
		<td>
			<input type="text" id="clogin_no" class="" disabled value="<%=login_no%>" /> 
		</td>
	</tr>
	<tr id="secPer" style="display: none">
		<th><span class="red">*财务人员：</span></th>
		<td>
			<input type="text" id="elogin_no" class="" disabled value="<%=login_no%>" /> 
		</td>
	</tr>
	<tr id="thrPer" style="display: none">
		<th><span class="red">*回收人工号：</span></th>
		<td>
			<input type="text" id="blogin_no" class="" disabled value="<%=login_no%>" /> 
		</td>
	</tr>
</table>
</div>
<div class="input">
<div class="title">
<div class="text">查询条件</div>
</div>
<table>
	<tr>
		<td class="blue">客户选择：</td>
							<td>
								<input type="text" name="custName" id="custName" readonly="true"/>
								<input type="hidden" name="cust_id" id="cust_id"/>
								<input type="button" id="button" name="sbutton" class="b_text" value="选择" onClick="selectCust();"/>
							</td>	
							<td class="blue">纳税人识别号：</td>
							<td>
								<input type="text" id="taxpayer_id" />
							</td>
	</tr>
	<tr>
				<td class="blue">审批状态：</td>
		<td><select id="auditState" name="auditState" disabled >
			<option value="01">待审批</option>
			<option value="02">已审批</option>
			<option value="03">待财务审批</option>
			<option value="04">未通过</option>
			<option value="05">财务未通过</option>
		</select>
		</td>
		<td>
			<td>
			</td>
		</td>
	</tr>
</table>
</div>
<div id="operation_button"><input type="button" class="b_foot"
	value="查询" onclick="doQueryApprove()" />
	<input type="button" class="b_foot" value="重置" onClick="resetMsg()" />
</div>
<div id="approve_list" style="display:none">
                <div class="title">
                  <div class="text">审核轨迹</div>
                </div>
              <div class="list" id="query_result"></div>
      </div>  
      
</form>
<%@ include file="/npage/include/footer.jsp"%>
</div>
</div>
</body>
</html>