<%
/********************
 
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa)2016/11/3 13:31:53------------------
 关于5月下旬集团客户部CRM、BOSS和经分系统需求的函--1、关于将跨省互联网专线订单操作由BOSS迁移至ESOP系统的需求
 
 -------------------------后台人员：wuxy--------------------------------------------
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	String opCode    = WtcUtil.repNull(request.getParameter("opCode"));
  String opName    = WtcUtil.repNull(request.getParameter("opName"));
  
  String workNo     = (String)session.getAttribute("workNo");
  String password   = (String)session.getAttribute("password");
  String regionCode = (String)session.getAttribute("regCode");
	
	String sql_region_list = "select　a.region_code,a.region_name from sregioncode a where a.use_flag='Y' order by a.region_code";
	
	
%> 
  <wtc:service name="TlsPubSelCrm" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=sql_region_list%>" />
	</wtc:service>
	<wtc:array id="result_region_list" scope="end" />
		
		
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<SCRIPT language=JavaScript>


//重置刷新页面
function reSetThis(){
	  location = location;	
}

 
function go_Query(){
	if($("#qry_val").val().trim()==""){
		rdShowMessageDialog("请输入查询值");
		return;
	}
 	var pactket = new AJAXPacket("fm426_GetList.jsp","正在进行电子工单状态修改，请稍候......");
			pactket.data.add("qry_val",$("#qry_val").val().trim());
			pactket.data.add("qry_type",$("#qry_type").val());
			pactket.data.add("opCode","<%=opCode%>");
			core.ajax.sendPacket(pactket,do_Query);
			pactket2=null;
}
//查询动态展示IMEI号码列表，回调
function do_Query(packet){
	var code = packet.data.findValueByName("code"); //返回代码
	var msg = packet.data.findValueByName("msg"); //返回信息
	if(code=="000000"){//查询成功后动态展示列表
			var retArray = packet.data.findValueByName("retArray");
			//获取数组成功，动态拼接列表
			var trObjdStr = "";
			//第二次以后查询会有多余行数据，所以删除除了title以外行的数据
			$("#upgMainTab tr:gt(0)").remove();
			
			for(var i=0;i<retArray.length;i++){
						trObjdStr += "<tr>"+
														 "<td><input type='checkbox'  /></td>"+ //
														 "<td>"+retArray[i][0]+"</td>"+ //
														 "<td>"+retArray[i][1]+"</td>"+ //
														 "<td>"+retArray[i][2]+"</td>"+ //
														 "<td>"+retArray[i][3]+"</td>"+ //
														 "<td>"+retArray[i][4]+"</td>"+ //
														 "<td>"+retArray[i][5]+"</td>"+ //
														 "<td>"+retArray[i][6]+"</td>"+ //
														 "<td>"+retArray[i][7]+"-"+retArray[i][8]+"</td>"+ //
												 "</tr>";
			}
			//将拼接的行动态添加到table中
			$("#upgMainTab tr:eq(0)").after(trObjdStr);
	}else{
		  rdShowMessageDialog("查询失败，"+code+"："+msg,0);
	}
}


function go_set_selWorkNo(bt){
	var sel_region_code = $(bt).val();
	
	if(sel_region_code==""){
		$("#sel_workNo option").remove();
		return;
	}
	
	var pactket = new AJAXPacket("fm426_getWorkNoByRegion.jsp","正在进行电子工单状态修改，请稍候......");
			pactket.data.add("sel_region_code",sel_region_code);
			core.ajax.sendPacket(pactket,do_set_selWorkNo);
			pactket2=null;
}


function do_set_selWorkNo(packet){
	var code = packet.data.findValueByName("code"); //返回代码
	var msg  = packet.data.findValueByName("msg"); //返回信息
	if(code=="000000"){//查询成功后动态展示列表
			var retArray = packet.data.findValueByName("retArray");
			$("#sel_workNo option").remove();
			
			for(var i=0; i<retArray.length; i++){
				$("#sel_workNo").append("<option value='"+retArray[i][0]+"'>"+retArray[i][1]+"</option>");
			}
			
	}
}

function go_Cfm(){
	if($("#sel_workNo").val()==""||$("#sel_workNo").val()==null){
		rdShowMessageDialog("请选择工号");
		return;
	}
	
	var iProdOrderStr = "";
	
	
	$("#upgMainTab").find("input[type='checkbox']:checked").each(function(){
		iProdOrderStr = iProdOrderStr +$(this).parent().parent().find("td:eq(4)").html().trim()+"|";
	});
	
	if(iProdOrderStr.length==0){
		rdShowMessageDialog("请选择订单");
		return;
	}
	if(iProdOrderStr.split("|").length>11){
		rdShowMessageDialog("选择订单不能超过10条记录");
		return;
	}
 	var pactket = new AJAXPacket("fm426_Cmf.jsp","正在进行电子工单状态修改，请稍候......");
			pactket.data.add("opCode","<%=opCode%>");
			pactket.data.add("iProdOrderStr",iProdOrderStr);
			pactket.data.add("sel_workNo",$("#sel_workNo").val());
			core.ajax.sendPacket(pactket,do_Cfm);
			pactket2=null;	
}
function do_Cfm(packet){
	var code = packet.data.findValueByName("code"); //返回代码
	var msg = packet.data.findValueByName("msg"); //返回信息
	if(code=="000000"){
		rdShowMessageDialog("操作成功",2);
		reSetThis();
	}else{
		rdShowMessageDialog("操作失败，"+code+"："+msg,0);
	}
}
</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi"><%=opName%></div></div>

<table cellSpacing="0">
	<tr>
	    <td class="blue" width="15%">查询条件</td>
		  <td width="35%">
			    <select id="qry_type" name="qry_type" onchange="">
					    <option value="1">EC集团客户编码</option>
					    <option value="2">商品订单号</option>
					    <option value="3">产品订单号</option>
					    <option value="4">商品订购关系编码</option>
					    <option value="5">产品订购关系编码</option>
					</select>
		  </td>
		  <td class="blue" width="15%">查询值</td>
		  <td>
			    <input type="text" id="qry_val" name="qry_val" v_type="string"  onblur = "checkElement(this)" maxlength="32" value="" />
			    &nbsp;
			    <input type="button" class="b_foot" value="查询" onclick="go_Query()"          />
		  </td>
	</tr>

</table>


<div class="title"><div id="title_zi">订单列表</div></div>
<TABLE cellSpacing="0" id="upgMainTab">
    <tr>
    		<th >选择</th>
        <th >EC集团客户编码</th>
        <th >EC集团客户名称</th>
        <th >商品订单号</th>
        <th >产品订单号</th>	
        <th >商品订购关系编码</th>
        <th >产品订购关系编码</th>	
        <th >订单接收时间</th>	
        <th >已分配工号</th>	
    </tr>
</table>

<table cellSpacing="0" >
	<tr>
	    <td class="blue" width="15%">选择地市</td>
		  <td width="35%">
		  	<select id="sel_region" name="sel_region" onchange="go_set_selWorkNo(this)">
				    <option value="">--请选择--</option>
<%
						for(int i=0; i<result_region_list.length; i++){					
%>				
								<option value="<%=result_region_list[i][0]%>"><%=result_region_list[i][1]%></option>
<%
						}
%>    
				</select>
		  </td>
		  <td class="blue" width="15%">选择工号</td>
		  <td width="35%">
		  	<select id="sel_workNo" name="sel_workNo">
				</select>
		  </td>
</table>

<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="分配" onclick="go_Cfm()"            />
	 		<input type="button" class="b_foot" value="重置" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>