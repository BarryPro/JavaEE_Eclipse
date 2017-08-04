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

%>
 
<html xmlns="http://www.w3.org/1999/xhtml">
	<script type="text/javascript" src="/npage/public/pubScript.js"></script>
	<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<head>
	
	<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
	<title>纳税人关系管理</title>	
</head>
<body>
	<div id="operation">
		<form method="post" name="frmo004" action="" >
 			<%@ include file="/npage/include/header.jsp" %>
 			<div id="operation_table"> 	
 				<div class="title">
 					<div class="text">操作类型</div>
 				</div>
			 	<div class="input">
					<table>
				 		<tr>
							<th>
								操作类型：
							</th>
							<td class="blue">
								<label class = "col-atttr-01"><input name="op" id="op" type="radio" value="query" onclick="choseType('query')"  checked="checked"/>纳税人总分关系修改</label>
								<label class = "col-atttr-01"><input name="op" id="op" type="radio" value="add" onclick="choseType('add')" />纳税人总分关系新增</label>
								<label class = "col-atttr-01"><input name="op" id="op" type="radio" value="del" onclick="choseType('del')" />纳税人总分关系删除</label>
							</td>
				 		</tr>
					</table>
			 	</div>
			 	
				<div id="query_input">
	  				<div class="title">
	  					<div class="text">纳税人总分关系修改</div>
	  				</div>
	  				<div class="input">
					<table>
						<tr>
							<td class="blue">总机构集团编码：</td>
							<td>
								<input type="text" name="upt_par_UnitId" id="upt_par_UnitId" />
							</td>	
							<td class="blue">分机构集团编码：</td>
							<td>
								<input type="text" name="upt_low_UnitId" id="upt_low_UnitId" />
							</td>	
						</tr>
					</table>
					</div>
					<div id="operation_button">
						<input class="b_foot"  type="button" value="查询" onClick="taxrelListuptQry()">
						<input type="button" class="b_foot" value="重置" onClick="uptreset()" />
					</div>
					<div id="ct_upttaxpayrel_list" style="display:none">
		        <div class="title">
		          <div class="text">纳税人总分关系修改列表</div>
		        </div>
	          <div class="list" id="upt_query_result"></div>
	        		</div>
      			</div>
      	
      			<div id="add_input" name="add_input" style="display:none">
      				<div class="title">
      					<div class="text">纳税人总分关系新增</div>
      				</div>
      				<div class="input">	
		 				<table>
		 					<tr>
							<td class="blue">总机构集团编码：</td>
							<td>
								<input type="text" name="add_par_UnitId" id="add_par_UnitId" />
								<input type="button" id="button" name="sbutton" class="b_text" value="查询" onClick="ChoseCust('1');"/>
							</td>
							<td class="blue">总机构集团名称：</td>
							<td>
								<input type="text" name="add_par_UnitName" id="add_par_UnitName" disabled />
								<input type="hidden" name="add_par_CustId" id="add_par_CustId"/>
							</td>
						</tr>
						<tr>
							<td class="blue">分机构集团编码：</td>
							<td>
								<input type="text" name="add_low_UnitId" id="add_low_UnitId" />
								<input type="button" id="button" name="sbutton" class="b_text" value="查询" onClick="ChoseCust('2');"/>
							</td>
							<td class="blue">分机构集团名称：</td>
							<td>
								<input type="text" name="add_low_UnitName" id="add_low_UnitName" disabled />
								<input type="hidden" name="add_low_CustId" id="add_low_CustId"/>
							</td>
						</tr>
							
						</table>
					</div>	

		 			<div id="operation_button">
		 				<input type="button" class="b_foot" value="新增" id="btnSave" name="btnSave" onclick="taxpayrelAdd()"  />
		 				<input type="button" class="b_foot" value="重置" id="clears" name="clears" onclick="addreset()" />
					</div>
      				</div>
      			
      			<div id="del_input">
	  				<div class="title">
	  					<div class="text">纳税人总分关系删除</div>
	  				</div>
	  				<div class="input">
					<table>
						<tr>
							<td class="blue">总机构集团编码：</td>
							<td>
								<input type="text" name="del_par_UnitId" id="del_par_UnitId" />
							</td>	
							<td class="blue">分机构集团编码：</td>
							<td>
								<input type="text" name="del_low_UnitId" id="del_low_UnitId" />
							</td>	
						</tr>
					</table>
					</div>
					<div id="operation_button">
						<input class="b_foot"  type="button" value="查询" onClick="taxrelListQry()">
						<input type="button" class="b_foot" value="重置" onClick="delreset()" />
					</div>
					<div id="ct_taxpayrel_list" style="display:none">
		        <div class="title">
		          <div class="text">纳税人关系删除列表</div>
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
	
	//选择查询或新增
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
	

	//集团信息查询
	function ChoseCust(flag)
	{
		if(flag=='1')
		{
			if(document.frmo004.add_par_UnitId.value=="")
			{
				rdShowConfirmDialog("请输入总机构集团编码");
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
				rdShowConfirmDialog("请输入分机构集团编码");
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
	
	//查询回调函数
  	function doQueryTaxpayRel(data)
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
      		$("#ct_taxpayrel_list").css("display","");
  		}
  	}   
		
	 //分页查询纳税人资质信息记录
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
      		rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
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
	
	//查询回调函数
  	function doQueryTaxpayUptRel(data)
  	{
  		$("#upt_query_result").empty().append(data);
    	var retCode=$("#retCode").val();
    	var retMsg=$("#retMsg").val();
    	if(retCode !=="000000")
    	{
      		rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
    	}
      	else
    	{
      		$("#ct_upttaxpayrel_list").css("display","");
  		}
  	}   
		
	 //分页查询纳税人资质信息记录
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
      		rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
    	}
      	else
    	{
      		$("#ct_upttaxpayrel_list").css("display","");
  		}
  	} 
	
	
	//客户关系新增
	function taxpayrelAdd()
	{
		if(document.frmo004.add_low_UnitName.value=="" || document.frmo004.add_par_UnitName.value=="")
		{
			rdShowConfirmDialog("总分关系必须填写");
			return false;
		}
		if(document.frmo004.add_par_CustId.value==document.frmo004.add_low_CustId.value)
		{
			rdShowConfirmDialog("同一个机构不能添加为总分关系");
			return false;
		}
		
		var ParCustId = $("#add_par_CustId").val();
		var LowCustId = $("#add_low_CustId").val();
		var packet = new AJAXPacket("fo004_ajax_doRelSubmit.jsp","请稍后...");
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
			rdShowMessageDialog("新增客户关系成功！",2);
			window.location.reload();
		} 
		else
		{
			rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
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
		if(rdShowConfirmDialog('确认要申请删除总分关系么？')==1)
        {
        	var packet = new AJAXPacket("fo004_ajax_doTaxpayerRelDel.jsp","请稍后...");
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
			rdShowMessageDialog("申请删除总分关系操作成功！",2);
			taxrelListQry();
		} 
		else
		{
			rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
		}
	}
	
	function dodelTaxPayerInfo(doDelCustId)
	{
		if(rdShowConfirmDialog('确认要删除总分关系么？')==1)
        {
        	var packet = new AJAXPacket("fo004_ajax_doTaxpayerRelDel.jsp","请稍后...");
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
			rdShowMessageDialog("删除总分关系操作成功！",2);
			taxrelListuptQry();
		} 
		else
		{
			rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
		}
	}

	function uptTaxPayerInfo(UptCustId,UptParUnitId,UptParUnitName,UptLowUnitId,UptLowUnitName,UptParCustId)
	{
		window.open("fo004_TaxpayerelUpt.jsp?UptCustId="+UptCustId+"&UptParUnitId="+UptParUnitId+"&UptParUnitName="+UptParUnitName+"&UptLowUnitId="+UptLowUnitId+"&UptLowUnitName="+UptLowUnitName+"&UptParCustId="+UptParCustId, "总分关系修改", "height=350, width=600,top=100,left=300,scrollbars=yes, resizable=no,location=no, status=yes");
	}

</script>	
</body>
</html>