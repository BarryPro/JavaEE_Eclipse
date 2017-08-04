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

	String login_no = (String)session.getAttribute("workNo");
	String login_name = (String)session.getAttribute("workName");
	String regionCode=(String)session.getAttribute("regCode");
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String hwAccept = "1";
	String showBody = "01";

%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<script type="text/javascript" src="/npage/public/pubScript.js"></script>
	<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title><%=opName%></title>
<script type="text/javascript">	
$(document).ready(function(){
	doQueryApprove();
	var IdType = "";
$("input[name='selType']").click(function(){
	if($(this).val()=="2"){
		doQueryApprove();
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
		doQueryApprove();
		$("#login_accept_all").val("");
		$("#firPer").css("display","none");
		$("#secPer").css("display","none");
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
		var regionCode="<%=regionCode%>";
		var model = $("#selTab").find("input[name='selType']:checked").val();
		var packet = new AJAXPacket("fo005_ajax_doQuery.jsp");
		packet.data.add("regionCode",regionCode);
		packet.data.add("model",model);
		packet.data.add("PAGE_NUM","1");  
		 
		core.ajax.sendPacketHtml(packet,doGetHtml);
		packet =null;
	}
	
	//分页查询授权人含有的功能权限
   	function doQueryApproveList(page_index,total_num)
   	{
   		var regionCode="<%=regionCode%>";
   		var model = $("#selTab").find("input[name='selType']:checked").val();
		var packet = new AJAXPacket("fo005_ajax_doQuery.jsp");
		packet.data.add("regionCode",regionCode);
		packet.data.add("model",model);
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
	
	
	function viewTaxPayerInfo(UpCustId,queryflag)
	{
		window.open("fo005_TaxpayerView.jsp?UpCustId="+UpCustId+"&queryflag="+queryflag, "展示信息", "height=500, width=1000,top=200,left=450,scrollbars=yes, resizable=no,location=no, status=yes");
	}
		

	function uptTaxrel(CustIdRel,UpFlag)
	{
		var packet = new AJAXPacket("fo005_ajax_doApproveRel.jsp","请稍后...");
		packet.data.add("CustIdRel",CustIdRel);
		packet.data.add("UpFlag",UpFlag);
		core.ajax.sendPacket(packet,doSuccessOk,true);
	  	packet = null;
	}
		
	function doSuccessOk(packet)
	{
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		if(retCode == "000000")
		{
			rdShowMessageDialog("审批操作完成！",2);
			doQueryApprove();
		} 
		else
		{
			rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
		}
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
			<input type="radio" name="selType" value="2" checked />财务审批人 
			<input type="radio" name="selType" value="3" style="display:none" />
			<input type="radio" name="selType" value="4" style="display:none" />
		</td>
	</tr>
	<tr id="firPer">
		<th><span class="red">*财务人员：</span>
		</th>
		<td>
			<input type="text" id="clogin_no" class="" disabled value="<%=login_no%>" /> 
		</td>
	</tr>
	<tr id="secPer" style="display: none">
		<th><span class="red">*税务人员：</span></th>
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