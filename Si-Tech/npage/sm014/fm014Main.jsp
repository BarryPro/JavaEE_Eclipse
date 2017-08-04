<%
  /*
   *	IMS固话过户（Centrex）
   *	ningtn
   *	日期: 2013-12-16 13:29:14
   */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<head>
	<title>IMS固话过户（Centrex）</title>
	<%
		request.setCharacterEncoding("GBK");
	  response.setHeader("Pragma","No-Cache"); 
	  response.setHeader("Cache-Control","No-Cache");
	  response.setDateHeader("Expires", 0);
	%>
	<%
		String opCode = (String)request.getParameter("opCode");
  	String opName = (String)request.getParameter("opName");
		String workNo = (String)session.getAttribute("workNo");
		String password = (String)session.getAttribute("password");
		String regionCode= (String)session.getAttribute("regCode");
	%>
	
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script language="javascript">
		/*每页展示行数*/
		var pageRow = 10;
		var checkIdNo = "";
		$(document).ready(function(){
			$("#resultTab").hide();
			$("#pageDiv").hide();
			
			$("#queryBtn").click(function(){
				var unitIdObj = $("#unit_id");
				if(!checkElement(unitIdObj[0])){
					return false;
				}
				
				unitIdObj.attr("readonly","readonly");
				$("#queryType").attr("disabled","disabled");
				$("#resultTab").hide();
				$("#pageDiv").hide();
				queryFunc();
			});
			$("#cleanBtn").click(function(){
				window.location.href="/npage/sm014/fm014Main.jsp?opCode=m014&opName=IMS固话过户（Centrex）&crmActiveOpCode=m014";
			});
			$("#closeBtn").click(function(){
				removeCurrentTab();
			});
			$("#nextBtn").click(function(){
				var cobj = $("#resultTabContent").find(":checkbox");
				checkIdNo = "";
				var phoneNoList = "";
				var checkFlag = true;
				$.each(cobj,function(){
					if($(this).attr("checked")){
						checkIdNo += $(this).val() + ",";
						var parentTrObj = $(this).parent().parent();
						var phoneNo = parentTrObj.find("td:eq(1)").html();
						var unitUnitVal = parentTrObj.find("td:eq(2)").html();
						if(unitUnitVal != "未加入"){
							checkFlag = false;
							rdShowMessageDialog("只有未加成员的号码才可以做过户");
							return false;
						}
						phoneNoList += phoneNo + ",";
					}
				});
				
				if(checkFlag){
					if(checkIdNo.length > 0){
						$("#checkIdNo").val(checkIdNo);
						$("#phoneNoList").val(phoneNoList);
						$("#frm").attr("action","fm014Main_2.jsp");
						$("#frm").submit();
					}else{
						rdShowMessageDialog("请至少选择一条记录办理过户");
						return false;
					}
				}
			});
			
			$("#checkAll").bind("click",function(){
				if($("#checkAll").attr('checked')==undefined){
					$(":checkbox").attr("checked",false);
				}else{
					$(":checkbox").attr("checked",true);
				}
			});
			
		});
		
		function queryFunc(){
			/*集团编码*/
			var unitId = $("#unit_id").val();
			/*查询类型  0-所有，1-已加成员，2-未加成员*/
			var queryType = $("#queryType").val();
			/*开始行数*/
			var startRow = "";
			/*结束行数*/
			var endRow = "";
			
			/*计算行数*/
			var pageNum = viewModel.nowPage();
			startRow = (pageNum-1)*pageRow+1;
			endRow = startRow + pageRow -1;
			
			/*调用查询服务*/
			var getdataPacket = new AJAXPacket("/npage/public/pubCallServ.jsp","正在获得数据，请稍候......");
			getdataPacket.data.add("serviceName","sM014Qry");
			getdataPacket.data.add("outnum","5");
			getdataPacket.data.add("inputParamsLength","11");
			getdataPacket.data.add("inParams0","");
			getdataPacket.data.add("inParams1","01");
			getdataPacket.data.add("inParams2","<%=opCode%>");
			getdataPacket.data.add("inParams3","<%=workNo%>");
			getdataPacket.data.add("inParams4","<%=password%>");
			getdataPacket.data.add("inParams5","");
			getdataPacket.data.add("inParams6","");
			/*集团编码*/
			getdataPacket.data.add("inParams7",unitId);
			/*查询类型*/
			getdataPacket.data.add("inParams8",queryType);
			/*开始行数*/
			getdataPacket.data.add("inParams9",startRow);
			/*结束行数*/
			getdataPacket.data.add("inParams10",endRow);
			core.ajax.sendPacket(getdataPacket);
			getdataPacket = null;
		}
		
		
		
		function doProcess(packet){
			var retCode = packet.data.findValueByName("retcode");
			var retMsg = packet.data.findValueByName("retmsg");
			viewModel.rates.removeAll();
			$("#checkAll").attr("checked",false);
			if("000000" == retCode){
				var result = packet.data.findValueByName("result");
				if(result.length > 0){
					var allCount = result[0][0];
					var insertStr = "";
					$.each(result,function(i,n){
						
						insertStr += "<tr>";
							insertStr += "<td>";
							insertStr += "<input type=\"checkbox\" value=\""+result[i][4]+"\" />";
							insertStr += "</td>";
							insertStr += "<td>";
							insertStr += result[i][1];
							insertStr += "</td>";
							insertStr += "<td>";
							if(result[i][2].length > 0){
								insertStr += result[i][2];
							}else{
								insertStr += "未加入";
							}
							insertStr += "</td>";
							insertStr += "<td>";
							if(result[i][3].length > 0){
								insertStr += result[i][3];
							}else{
								insertStr += "未加入";
							}
							insertStr += "</td>";
						insertStr += "</tr>";
					});
					
					viewModel.allPage(Math.floor((allCount - 1) / pageRow) + 1);
					viewModel.allcount(allCount);
					
					
					$("#resultTabContent").empty();
					$("#resultTabContent").append(insertStr);
					$("#resultTab").show();
					$("#pageDiv").show();
				}else{
					viewModel.nowPage(1);
					viewModel.allPage(1);
					viewModel.allcount(0);
					rdShowMessageDialog("您所输入的查询条件没有查询结果。");
					return false;
				}
			}else{
				viewModel.nowPage(1);
				viewModel.allPage(1);
				viewModel.allcount(0);
				rdShowMessageDialog("查询失败" + retCode + ":" + retMsg);
				return false;
			}
		}
		
		function goPage(goType){
			if(goType == 'f'){
				if(viewModel.nowPage() == 1){
					return false;
				}else{
					viewModel.nowPage(1);
				}
			}else if(goType == 'e'){
				if(viewModel.nowPage() == viewModel.allPage()){
					return false;
				}else{
					viewModel.nowPage(viewModel.allPage());
				}
			}else if(goType == 'p'){
				if(viewModel.nowPage() == 1){
					return false;
				}else{
					viewModel.nowPage(viewModel.nowPage()-1);
				}
			}else if(goType == 'n'){
				if(viewModel.nowPage() == viewModel.allPage()){
					return false;
				}else{
					viewModel.nowPage(viewModel.nowPage()+1);
				}
			}
			queryFunc();
		}
		
	</script>
<body>
<form name="frm" id="frm" method="POST" >
	<input type="hidden" name="checkIdNo" id="checkIdNo" />
	<input type="hidden" name="phoneNoList" id="phoneNoList" />
	<input type="hidden" name="opCode" value="<%=opCode%>" />
	<input type="hidden" name="opName" value="<%=opName%>" />
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">固话查询</div>
	</div>
	<table cellspacing="0">
    <tr>
      <td class="blue">集团编号</td>
      <td>
      	<input name="unit_id" id="unit_id" size="24" maxlength="11" 
      	 v_type="0_9" v_must="1" index="3" onblur="checkElement(this)">
      	<font class="orange">*</font>
      </td>
      <td class="blue">查询方式</td>
      <td>
      	<select id="queryType">
      		<option value="0">所有</option>
      		<option value="1">已加成员</option>
      		<option value="2">未加成员</option>
      	</select>
      </td>
    </tr>
  </table>
  <table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
				<input type="button" id="queryBtn" class="b_foot" value="查询" />
				&nbsp;
				<input type="button" id="cleanBtn" class="b_foot" value="清除" />
				&nbsp;
				<input type="button" id="closeBtn" class="b_foot" value="关闭" />
			</div>
			</td>
		</tr>
	</table>
  <table cellspacing="0" id="resultTab">
    <tr>
    	<th>全选<input id="checkAll" type="checkbox"></th>
      <th>固话号码</th>
      <th>已加入集团的集团编码</th>
      <th>已加入集团的集团名称</th>
    </tr>
    <tbody id="resultTabContent">
    </tbody>
  </table>
  
	<div id="pageDiv" align="center">
		第<span data-bind="text:nowPage"></span>/<span data-bind="text:allPage"></span>页 &nbsp;&nbsp;
		共<span data-bind="text:allcount"></span>条 &nbsp;&nbsp;
		[<a style="cursor:pointer" onclick="goPage('f')">首页</a>]&nbsp;&nbsp;
		[<a style="cursor:pointer" onclick="goPage('p')">上一页</a>]&nbsp;&nbsp;
		[<a style="cursor:pointer" onclick="goPage('n')">下一页</a>]&nbsp;&nbsp;
		[<a style="cursor:pointer" onclick="goPage('e')">尾页</a>]
	
	
  <table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
				<input type="button" id="nextBtn" class="b_foot" value="下一步" />
			</div>
			</td>
		</tr>
	</table>
	</div>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
<script language="javascript">
		var viewModel = {
			rates: ko.observableArray([]),
			queryFlag:ko.observable(false),
			nowPage:ko.observable(1),
			allPage:ko.observable(1),
			allcount:ko.observable(0)
		}
		ko.applyBindings(viewModel);
</script>
</html>