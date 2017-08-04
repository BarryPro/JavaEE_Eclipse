<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
   /*
   * 功能: 增值税纳税人资质信息查询
　 * 版本: v1.0
　 * 日期: 2013-11-29
　 * 作者: wangjxc
　 * 版权: sitech
   * 修改历史
   * 修改日期:  	
   * 修改人:
   * 修改目的:
 　*/
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
	<title>总分关系修改</title>	
</head>
<body>
	<div id="operation">
		<form method="post" name="frmo004Upt" action="" >
 			<%@ include file="/npage/include/header.jsp" %>
 			<div id="operation_table"> 	
      			<div id="add_input" name="add_input">
      				<div class="title">
      					<div class="text">纳税人总分关系修改</div>
      					<input type="hidden" name="chn_CustId" id="chn_CustId" value='<%=UptCustId%>' />
      				</div>
      				<div class="input">	
		 				<table>
		 					<tr>
							<td class="blue">总机构集团编码：</td>
							<td>
								<input type="text" name="upt_add_par_UnitId" id="upt_add_par_UnitId" value='<%=UptParUnitId%>' onfocus="changevalue()"; />
								<input type="button" id="button" name="sbutton" class="b_text" value="查询" onClick="ChoseCust('1');"/>
							</td>
							<td class="blue">总机构集团名称：</td>
							<td>
								<input type="text" name="upt_add_par_UnitName" id="upt_add_par_UnitName" value='<%=UptParUnitName%>' disabled />
								<input type="hidden" name="upt_add_par_CustId" id="upt_add_par_CustId" value='<%=UptParCustId%>' />
							</td>
						</tr>
						<tr>
							<td class="blue">分机构集团编码：</td>
							<td>
								<input type="text" name="upt_add_low_UnitId" id="upt_add_low_UnitId" value='<%=UptLowUnitId%>' onfocus="changeovalue()"; />
								<input type="button" id="button" name="sbutton" class="b_text" value="查询" onClick="ChoseCust('2');"/>
							</td>
							<td class="blue">分机构集团名称：</td>
							<td>
								<input type="text" name="upt_add_low_UnitName" id="upt_add_low_UnitName" value='<%=UptLowUnitName%>' disabled />
								<input type="hidden" name="upt_add_low_CustId" id="upt_add_low_CustId" value='<%=UptCustId%>' />
							</td>
						</tr>
							
						</table>
					</div>	

		 			<div id="operation_button">
		 				<input type="button" class="b_foot" value="修改" id="btnSave" name="btnSave" onclick="taxpayrelUpt()"  />
		 				<input type="button" class="b_foot" value="重置" id="clears" name="clears" onclick="uptreset()" />
					</div>
      				</div>
			</div>
 			<%@ include file="/npage/include/footer.jsp" %>
		</form>
	</div>

<script type="text/javascript">
	

		//集团信息查询
	function ChoseCust(flag)
	{
		if(flag=='1')
		{
			if(document.frmo004Upt.upt_add_par_UnitId.value=="")
			{
				rdShowConfirmDialog("请输入总机构集团编码");
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
				rdShowConfirmDialog("请输入分机构集团编码");
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
	
	//查询回调函数
  	function doQueryChoseCust(packet)
  	{
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		var ModFlag = packet.data.findValueByName("ModFlag");
    	if(retCode !=="000000")
    	{
      		rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
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
			rdShowConfirmDialog("总分关系必须填写");
			return false;
		}
		if(document.frmo004Upt.upt_add_par_CustId.value==document.frmo004Upt.upt_add_low_CustId.value)
		{
			rdShowConfirmDialog("同一个机构不能添加为总分关系");
			return false;
		}
		
		var ParCustId = $("#upt_add_par_CustId").val();
		var LowCustId = $("#upt_add_low_CustId").val();
		var chn_CustId = $("#chn_CustId").val();
		var packet = new AJAXPacket("fo004_ajax_doUptRelSubmit.jsp","请稍后...");
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
			rdShowMessageDialog("修改总分关系成功！",2);
			window.close();
			window.opener.taxrelListuptQry();
		} 
		else
		{
			rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
		}
	}

</script>	
</body>
</html>