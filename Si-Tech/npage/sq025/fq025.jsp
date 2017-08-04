<%
  /*
   * 功能:订单审核
　 * 版本:  v1.0
　 * 日期: 2009-01-15 10:00
　 * 作者: wanglj
　 * 版权: sitech
　*/
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String opCode = (String)request.getParameter("opCode");
    String opName = (String)request.getParameter("opName");
	//String PSiteId_Cur   = (String)session.getAttribute("siteId");
	String PSiteId_Cur   = (String)session.getAttribute("groupId");
    String PSiteName_Cur = (String)session.getAttribute("siteName");
    String workNo = (String)session.getAttribute("workNo");
    String gCustId =  request.getParameter("gCustId");
    String custOrderId =  request.getParameter("custOrderId");
    String loginNo = (String) session.getAttribute("workNo");	//操作工号
    System.out.println("PSiteId_Cur======"+PSiteId_Cur);
    System.out.println("gCustId======"+gCustId);
    System.out.println("custOrderId======"+custOrderId);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>订单受理</title>
</head>
<script type="text/javascript" src="/njs/si/validate_class.js"></script>
<script type="text/javascript">
		var arrayOrderStr = "";
		var filed_name = "订单子项ID|客户订单ID|业务号码|订单名称|服务数量|状态|受理时间|满意度|优先级|备注"; //列信息
		var page_size = "10";//每页记录数
		var sel_type = "M"; //选择类型,M多选框,S单选框,""没有选择,当为M或S时,点击选择框,会调用selectRow()方法,将ret_quence指定的值返回给选择框
		var ret_quence= "0";//指定采集数据列,形式:"0|3|5"
		var servJsp = "fq025_ajax.jsp?type=1&order_val=<%=workNo%>";//调服务的ajax页面,将服务返回结果整理成二维字符串数组,返回给主页面,主页面调用回调函数处理
		
		var closeFlag = false; //判断是正常提交页面,还是非法关闭页面
		window.onload = function init(){ initPage025();};
		 
function selectRow(){}

function chg_dep()
{
	var sel_dep = document.getElementById("select_dep");
	sel_dep.value = "1"; //根据客户要求,只能审核员工号自己受理的单子
	if(sel_dep.value=="0")
	{
		document.getElementById("thName").innerHTML="";
		document.getElementById("order_val").value="";
		document.getElementById("order_val").className="";
		document.getElementById("order_val").readOnly=true;
	}else if(sel_dep.value=="1")
	{
		document.getElementById("thName").innerHTML="员工号:";
		document.getElementById("order_val").value="";
		document.getElementById("order_val").className="required";
		document.getElementById("order_val").readOnly=true;
	}else if(sel_dep.value=="2")
	{
		document.getElementById("thName").innerHTML="订单号:";
		document.getElementById("order_val").value="";
		document.getElementById("order_val").className="required";
		document.getElementById("order_val").readOnly=false;
	}else if(sel_dep.value=="3")
	{
		document.getElementById("thName").innerHTML="订单子项:";
		document.getElementById("order_val").value="";
		document.getElementById("order_val").className="required";
		document.getElementById("order_val").readOnly=false;
	}
}
 
function gotoPage025(pageNum)
				{
					if(Number(pageNum) <= 0 ||Number(pageNum) > Number(g("totalpage").value)){
						return false;		 
					}
				  var mypacket = new AJAXPacket(servJsp,"请稍后");
				  mypacket.data.add("ret_type","showPageList025");
				  mypacket.data.add("filed_name",filed_name);													
				  mypacket.data.add("pageSize",page_size);
				  mypacket.data.add("currentPage",pageNum);
				  core.ajax.sendPacket(mypacket,publicListPageq025);
				  mypacket = null;
				}
function initPage025()
				{
				  var mypacket = new AJAXPacket(servJsp,"请稍后");
				  mypacket.data.add("ret_type","showPageList025");
				  mypacket.data.add("filed_name",filed_name);													
				  mypacket.data.add("pageSize",page_size);
				  mypacket.data.add("currentPage",1);
				  core.ajax.sendPacket(mypacket,publicListPageq025);
				  mypacket = null;
				}	

 
function publicListPageq025(packet){
       error_code = packet.data.findValueByName("errorCode");
       error_msg =  packet.data.findValueByName("errorMsg");
       retType = packet.data.findValueByName("retType"); 
       g("curpage").value= packet.data.findValueByName("currentPage");
       g("totalpage").value= packet.data.findValueByName("totalPage");
       g("totalrec").value= packet.data.findValueByName("totalRec");
       var obj=g("list_page");
	   	  var cols = filed_name.split("|");
	   	  var tmpstr = "";
	   	  for(var i = 0 ; i < cols.length;i++){
	   	  		tmpstr = tmpstr +"<th>" + cols[i]+"</th>";
	   	  }
	   		if(!(sel_type == "")){
	   			obj.innerHTML="<table id='listtbl' name='listtbl'><tr>" + tmpstr + "<th>选择</th></tr></table>";
	   		}else{
	   			obj.innerHTML="<table id='listtbl' name='listtbl'><tr>" + tmpstr + "</tr></table>";
	   		}
       if(error_code != "0"){
       		rdShowMessageDialog("没有待审核订单!");
       		return false;
       }
       if(retType == "showPageList025"){
      		var result = packet.data.findValueByName("arrMsg");
      		if (result == null) return false;
      		var obj = document.getElementById("listtbl");
      		var tabRowNum;
      		for(var i = 0 ; i < result.length; i ++){
      			var resultCol = result[i];
      			if(sel_type=="M"){
      				var rowvalue = "";
							var retval = ret_quence.split("|");
							for(var j = 0 ; j< retval.length; j++){
									rowvalue= rowvalue + resultCol[retval[j]]+"|";
							}
							if(resultCol.length != 0){
      					resultCol.push("<input type='checkbox' name='checkList' value='" + rowvalue + "' onclick='selectRow(this.value)'>");              					
      				}
      			}else if(sel_type=="S"){
      				var rowvalue = "";
							var retval = ret_quence.split("|");
							for(var j = 0 ; j< retval.length; j++){
									rowvalue= rowvalue + resultCol[retval[j]]+"|";
							}
							if(resultCol.length != 0){
      					resultCol.push("<input type='radio' name='singleList' value='" + rowvalue + "' onclick='selectRow(this.value)'>");              					
      				}
      			}
      			 tabRowNum = g("listtbl").rows.length;
      			 dynAddTr("listtbl",tabRowNum,resultCol);
      	  }
      }
 }
 
 /*
*动态添加行wangljadd20090219
*/ 					
function dynAddTr(tableID,trIndex,arrTdCont)
{
	var tableId=g(tableID);
	var insertTr=tableId.insertRow(trIndex);
	var arrTd=new Array();
	for(var i=0;i<arrTdCont.length;i++)
	{
		arrTd[i]=insertTr.insertCell(i);
	}
	for(var i=0;i<arrTdCont.length;i++)
	{
		arrTd[i].innerHTML=arrTdCont[i];
	}
} 

	$(document).ready(function(){
		var checkType="";
		if(sel_type=="M"){
				checkType="checkList";
		}else if(sel_type=="S"){
				checkType="singleList";
		} 
		$("#selAll").toggle(
			function() {
					var obj = g("frm");
					for(var i = 0 ; i< obj.elements.length;i++){
							if(obj[i].name == checkType && obj[i].checked==false){
								obj[i].checked = true;
							}
					}	
			}, 
			function() {
				var obj = g("frm");
					for(var i = 0 ; i< obj.elements.length;i++){
							if(obj[i].name == checkType && obj[i].checked==true){
								obj[i].checked = false;
							}
					}		
			}
		);
	});

function ask_dep()
{
	servJsp = "fq025_ajax.jsp?type="+g("select_dep").value+"&order_val="+g("order_val").value;
	gotoPage025(1);
}
function doSubmit(){
	var checkType="";
	if(sel_type=="M"){
			checkType="checkList";
	}else if(sel_type=="S"){
			checkType="singleList";
	}
	var check = false;
	var obj = g("frm");
	for(var i = 0 ; i< obj.elements.length;i++){
			if(obj[i].name == checkType && obj[i].checked==true){
					check = true;
			}
	}
	if(check == false){
			rdShowMessageDialog("请选择要审核的订单项!",0);	
			return false;
	}
	closeFlag = true;
	document.all.frm.action='fq025_cfm.jsp?array_order='+checkType;
	document.all.frm.submit();
}

window.onbeforeunload =function LeaveWin(){
	        if(!closeFlag){
	        	<%
	        		if(custOrderId != null && !"".equals(custOrderId)){
	        	%>
	        			closeLog();
	        	<%}%>
	        	rdShowMessageDialog("该订单还未审核,处于待审核状态,请到客户首页查询该订单进行断点重新受理操作!");
	    	}
		}
		
		function closeLog(){
			var myPacket = new AJAXPacket("fq025_log_ajax.jsp","正在获得信息，请稍候......");
			var opNote = "操作员<%=loginNo%>非法关闭订单审核页面,<%=custOrderId%>订单处于待审核状态";			
			myPacket.data.add("opNote",opNote);
			myPacket.data.add("custOrderId","<%=custOrderId%>");	
			myPacket.data.add("opCode",g("opCode").value);	
			myPacket.data.add("loginNo","<%=loginNo%>");
			core.ajax.sendPacket(myPacket,getCloseLog);	
			myPacket=null;	
		}
		function getCloseLog(packet){
			var err_code = packet.data.findValueByName("errorCode");
		}		
</script>

<body>
	<FORM method="post" name="frm" id="frm" >
 	<%@ include file="/npage/include/header.jsp" %>
 	<div class="title">
	<div id="title_zi">客户订单查询</div>
</div>

			<table cellspacing=0>
				<tr>
					<td class='blue'>查询条件</td>
					<td>
						<select id="select_dep" onchange="chg_dep()" readonly="true">
							<!--<option value="0">0->不限</option>-->
							<option value="1">1->员工号</option>
							<!--<option value="2">2->订单号</option>-->
							<!--<option value="3">3->订单子项</option>-->
						</select>
					</td>
					<td class='blue' id="thName"><!--不限:--> 操作员工</td>
					<td>
						<input type="text" id="order_val" name="order_val" class="" value="<%=workNo%>"readonly/>
					</td>
					<td ><input type="button" name="quer" class="b_text" value="查询"  onclick="ask_dep()"/></td>
				</tr>
			</table>
</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">客户订单子项</div>
</div>

     		<!--定义列表DIV-->
				<div class="list" id="list_page">
				</div>
				<div id="operation_pagination">
				    <table cellspacing=0>
				        <tr><td>
					第<input type="text" size="3" style="text-align:right" readOnly name="curpage" id="curpage" value="1">页
					共<input type="text" size="3" style="text-align:right" readOnly name="totalpage" id="totalpage" value="1">页
					<input type="text" size="5" style="text-align:right" name="totalrec" id="totalrec" value="1">条记录
					<a style="cursor:hand;" onclick=gotoPage025("1")>[首页]</a></span>&nbsp;
					<a style="cursor:hand;" onclick=gotoPage025(Number(g("curpage").value)-1)>[上一页]</a>&nbsp;
					<a style="cursor:hand;" onclick=gotoPage025(Number(g("curpage").value)+1)>[下一页]</a>&nbsp;
					<a style="cursor:hand;" onclick=gotoPage025(Number(g("totalpage").value))>[尾页]</a>&nbsp;
					转到<input type="text" size="5" onchange="gotoPage025(Number(this.value))">页
				</td></tr>
			</table>
				</div>
		<div id="footer">
			<input type="button" class="b_foot_long" name="selAll" id="selAll" value="全部选择" > 
			<input type="button" class="b_foot" value="审核" onclick="doSubmit()"> 
		</div>
		<input type="hidden"  id="sum_ret" value="" />
		<input type="hidden"  id="ask_depval" value="0" />
		<input type="hidden" name="gCustId" id="gCustId" value="<%=gCustId%>">
		<input type="hidden" id="opCode" name="opCode" value="<%=opCode%>"/>
		<%@ include file="/npage/include/footer.jsp" %>
	</form>
</body>
</html>


