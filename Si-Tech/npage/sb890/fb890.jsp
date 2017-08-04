<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *create:wanghfa@2010-11-29 网上开户配置
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<head>
<title>网上开户配置</title>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<%
	String opCode = WtcUtil.repNull(request.getParameter("opCode"));
	String opName = WtcUtil.repNull(request.getParameter("opName"));
	System.out.println("=========wanghfa========= fb890.jsp " + opCode + ", " + opName);
	String regionCode = (String)session.getAttribute("regCode");
    String workNo = (String)session.getAttribute("workNo");
    String sqlsl11="select group_type,group_typename from SWEBOBJRELATIONCFG  where is_visual = '1' order by to_number(orderby) asc";
    String sqlsl22="select group_type,group_typename from SWEBOBJRELATIONCFG order by to_number(orderby) asc";
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="RetCode1" retmsg="RetMsg1" outnum="2">
			<wtc:sql><%=sqlsl11%></wtc:sql>
		</wtc:pubselect>	
		<wtc:array id="rets1111" scope="end" />
			
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="RetCode2" retmsg="RetMsg2" outnum="2">
			<wtc:sql><%=sqlsl22%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="rets2222" scope="end" />
			
<script language=javascript>
	onload = function() {
		opchange("<%=opCode%>");
		disWebGroupType();
	}
	
	function opchange(opFlag) {
		if (opFlag == "b890") {
			document.getElementById("opCode").value = "b890";
			document.getElementById("opName").value = "营业厅配置(网厅)";
			
			$("#deployWorkNo").slideUp(400, function() {
				$("#deployGroupId").slideDown(400);
			});
		} else if (opFlag == "b892") {
			document.getElementById("opCode").value = "b892";
			document.getElementById("opName").value = "网上开户营业员配置";
			
			$("#deployGroupId").slideUp(400, function() {
				$("#deployWorkNo").slideDown(400);
			});
		}
	}
	
	//选择组织节点
	function queryObjectId() {
		var groupIdOpType = document.getElementById("groupIdOpType").value;
		
		if (groupIdOpType == "a") {
			var path = "tree/groupTree.jsp";
			window.open(path + "?groupType=form_b890&groupId=addObjectId&opCode=<%=opCode%>&webGroupType="+document.getElementById("webGroupType").value,"","height=530,width=450,scrollbars=yes");
		} else if (groupIdOpType == "d") {
		if (document.getElementById("webGroupTypeDel").value == "0") {
					rdShowMessageDialog("请先选择营业厅办理业务类型！", 1);
					return; 
				}
				var webGroupTypeDel11 = $("#webGroupTypeDel").val();
			var path = "tree_d/groupTree_d.jsp";
			window.open(path + "?groupType=form_b890&isDel=Y&groupId=deleteObjectId&webGroupTypeDel1="+webGroupTypeDel11,"","height=530,width=450,scrollbars=yes");
		} else if (groupIdOpType == "q") {
			if (document.getElementById("webGroupTypeQry").value == "0") {
					rdShowMessageDialog("请选择营业厅办理业务类型！", 1);
					return;
				}
				var webGroupTypeQry11 = $("#webGroupTypeQry").val();
			var path = "tree/groupTree_workNo.jsp";
		 	window.open(path+"?grouptype=form_b890&grpId=qryGroupId&grpName=qryGroupName&webGroupTypeQry1="+webGroupTypeQry11,'_blank','height=600,width=300,scrollbars=yes');

		}
	}
	
	function queryWorkNoGroupId() {
		var path = "tree/groupTree_workNo.jsp";
	 	window.open(path+"?grouptype=form_b890&grpId=workNoGroupId&grpName=workNoGroupName",'_blank','height=600,width=300,scrollbars=yes');
	}
	
	function disWebGroupType() {
		var groupIdOpType = document.getElementById("groupIdOpType").value;
		
		if (groupIdOpType == "a") {
			$("#delete").slideUp(400, function() {
				$("#qry").slideUp(400, function() {
					$("#add").slideDown(400);
				});
			});
		} else if (groupIdOpType == "d") {
			$("#add").slideUp(400, function() {
				$("#qry").slideUp(400, function() {
					$("#delete").slideDown(400);
				});
			});
		} else if (groupIdOpType == "q") {
			$("#delete").slideUp(400, function() {
				$("#add").slideUp(400, function() {
					$("#qry").slideDown(400);
				});
			});
		}
	}
	
	function submitt() {
		var cubmittBtn = document.getElementById("cubmitt");
		var groupIdOpType = document.getElementById("groupIdOpType").value;
		cubmittBtn.disabled = true;
		//if (document.getElementsByName("opFlag")[0].checked) {
			if (groupIdOpType == "a") {
			  /* begin diling update for 关于优化网上选号服务流程的需求 @2013/4/8 */
			  /*
				if (document.getElementById("addObjectId").value.trim().length == 0) {
					rdShowMessageDialog("请选择组织节点！", 1);
					cubmittBtn.disabled = false;
					return;
				} else if (document.getElementById("webGroupType").value == "0") {
					rdShowMessageDialog("请选择营业厅办理业务类型！", 1);
					cubmittBtn.disabled = false;
					return;
				}*/
				if (document.getElementById("webGroupType").value == "0") {
					rdShowMessageDialog("请选择营业厅办理业务类型！", 1);
					cubmittBtn.disabled = false;
					return;
				}else if (document.getElementById("addObjectId").value.trim().length == 0) {
					rdShowMessageDialog("请选择组织节点！", 1);
					cubmittBtn.disabled = false;
					return;
				}
				/* end diling update@2013/4/8 */
				if (rdShowConfirmDialog("确认要添加此配置营业厅吗？") == 1) {
					form_b890.action = "fb890_cfm.jsp";
				} else {
					cubmittBtn.disabled = false;
					return;
				}
			} else if (groupIdOpType == "d") {
				if (document.getElementById("webGroupTypeDel").value == "0") {
					rdShowMessageDialog("请选择营业厅办理业务类型！", 1);
					cubmittBtn.disabled = false;
					return; 
				} else if (document.getElementById("deleteObjectId").value.trim().length == 0) {
					rdShowMessageDialog("请选择组织节点！", 1);
					cubmittBtn.disabled = false;
					return;
				}
				if (rdShowConfirmDialog("确认要删除此配置营业厅吗？") == 1) {
					form_b890.action = "fb890_del.jsp";
				} else {
					cubmittBtn.disabled = false;
					return;
				}
			} else if (groupIdOpType == "q") {
				if (document.getElementById("webGroupTypeQry").value == "0") {
					rdShowMessageDialog("请选择营业厅办理业务类型！", 1);
					cubmittBtn.disabled = false;
					return;
				}
				else if(document.getElementById("qryGroupId").value.trim().length == 0) {
					rdShowMessageDialog("请选择组织节点！", 1);
					cubmittBtn.disabled = false;
					return;
				}
				form_b890.action = "fb890_qry.jsp";
			}
/*
		} else if (document.getElementsByName("opFlag")[1].checked) {
			var workNoOpType = document.getElementById("workNoOpType").value;
			if (document.getElementById("workNoGroupId").value.trim().length == 0) {
				rdShowMessageDialog("请选择组织节点！", 1);
				cubmittBtn.disabled = false;
				return;
			}
			if (workNoOpType == "a") {
				form_b890.action = "fb892_main.jsp";
			} else if (workNoOpType == "d" || workNoOpType == "q") {
				form_b890.action = "fb892_main2.jsp";
			}
		}
*/
		
		form_b890.submit();
	}
</script>
</head>
<body>

<form name="form_b890" method="POST">
<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" id="opName" value="<%=opName%>">
<input type="hidden" name="groupId" value="">

<%@ include file="/npage/include/header.jsp" %>

<div class="title">
	<div name="title_zi" id="title_zi">营业厅配置(网厅)</div>
</div>
<!--div class="itemContent" id="deployGroupId" name="deployGroupId"-->
	<table>
		<tr>
			<td class="blue" width="20%">
				操作类型
			</td>
			<td colspan="3">
				<select id="groupIdOpType" name="groupIdOpType" onchange="disWebGroupType()">
						<option value="a" selected>新增</option>
						<option value="d">删除</option>
						<option value="q">查询</option>
				</select>
			</td>
		</tr>
	</table>
	
	<div class="itemContent" id="add" name="add">
		<table>
			<tr>
				<td class="blue" width="20%">
					营业厅办理业务类型
				</td>
				<td width="30%">
					<select id="webGroupType" name="webGroupType">
						<option value="0" selected>--请选择--</option>
              	           <%
        	for(int i=0;i<rets1111.length; i++){
			    out.println("<option class='button' value='"+rets1111[i][0]+"'>"+rets1111[i][1]+"</option>");
			    }
		      %>
					</select>
				</td>
				<td class="blue" width="20%">
					组织节点
				</td>
				<td width="30%">
	  				<input type=text name="addObjectId" id="addObjectId" class="InputGrey" readonly>
	            	<input class="b_text" type="button" name="" value="选择" onclick="queryObjectId();">
		     		<font color="orange">*</font>
				</td>
			</tr>
		</table>
	</div>
	
	<div class="itemContent" id="delete" name="delete">
		<table>
			<tr>
				
					<td class="blue" width="20%">
					营业厅办理业务类型
				</td>
				<td width="30%">
					<select id="webGroupTypeDel" name="webGroupTypeDel">
						<option value="0" selected>--请选择--</option>
              	           <%
        	for(int i=0;i<rets1111.length; i++){
			    out.println("<option class='button' value='"+rets1111[i][0]+"'>"+rets1111[i][1]+"</option>");
			    }
		      %>
					</select>
				</td>
				<td class="blue" width="20%">
					组织节点
				</td>
				<td width="30%">
	  				<input type=text name="deleteObjectId" id="deleteObjectId" class="InputGrey" readonly>
	            	<input class="b_text" type="button" name="" value="选择" onclick="queryObjectId();">
		     		<font color="orange">*</font>
				</td>
			</tr>
		</table>
	</div>
	
	<div class="itemContent" id="qry" name="qry">
		<table>
			<tr>

					<td class="blue" width="20%">
					营业厅办理业务类型
				</td>
				<td width="30%">
					<select id="webGroupTypeQry" name="webGroupTypeQry">
						<option value="0" selected>--请选择--</option>
              	           <%
        	for(int i=0;i<rets2222.length; i++){
			    out.println("<option class='button' value='"+rets2222[i][0]+"'>"+rets2222[i][1]+"</option>");
			    }
		      %>
					</select>
				</td>
								<td class="blue" width="20%">
					组织节点
				</td>
				<td width="30%">
	  				<input type=hidden name="qryGroupId" id="qryGroupId" class="InputGrey" readonly>
	  				<input type=text name="qryGroupName" id="qryGroupName" class="InputGrey" readonly>
	            	<input class="b_text" type="button" name="btnQueryObjectId" value="选择" onclick="queryObjectId();">
		     		<font color="orange">*</font>
				</td>
			</tr>
		</table>
	</div>
	
<!--/div-->

<!--div class="itemContent" id="deployWorkNo" name="deployWorkNo">
	<table>
		<div class="title">
			<div name="title_zi" id="title_zi">营业员配置</div>
		</div>
		<tr>
			<td class="blue" width="20%">
				操作类型
			</td>
			<td width="30%">
				<select id="workNoOpType" name="workNoOpType">
						<option value="a" selected>新增</option>
						<option value="d">删除</option>
						<option value="q">查询</option>
				</select>
			</td>
			<td class="blue" width="20%">
				组织节点
			</td>
			<td width="30%">
				<input type="hidden" name="workNoGroupId" id="workNoGroupId" value="">
  				<input type=text name="workNoGroupName" id="workNoGroupName" v_type="string"  v_must=1 class="InputGrey" readonly>
            	<input class="b_text" type="button" name="btnQueryObjectId" value="选择" onclick="queryWorkNoGroupId();">
	     		<font color="orange">*</font>
			</td>
		</tr>
	</table>
</div-->

<table cellspacing="0">
	<tr>
	    <td id="footer">
	      <input class="b_foot" type=button name="cubmitt" value="确定" onClick="submitt();">
	      <input class="b_foot" type=button value="关闭" onClick="removeCurrentTab();">
	    </td>
	</tr>
</table>
  <%@ include file="/npage/include/footer_simple.jsp" %> 
   </form>
</body>
</html>
