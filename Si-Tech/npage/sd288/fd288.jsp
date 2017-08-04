<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
 version v3.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
 		String opCode = "d288";
 		String opName = "提醒短信审批";
 		
 		String workNo = (String)session.getAttribute("workNo");
		String workName = (String)session.getAttribute("workName");
		String regionCode  = (String)session.getAttribute("regCode");
		String groupId = (String)session.getAttribute("groupId");
		String pass = (String)session.getAttribute("password");
		
 		String [][]impResultArr = new String[][]{};
%>
		<wtc:service  name="sd288Qry"  routerKey="region" 
			 routerValue="<%=regionCode%>" outnum="18" retcode="retCode1" retmsg="retMsg1" > 
			<wtc:param value="<%=workNo%>"/>  
		</wtc:service> 
		<wtc:array  id="sVerifyTypeArr"  scope="end"/>
<%
		if("000000".equals(retCode1)){
		
			System.out.println("=====sd288.jsp调用sd288Qry成功");
		}else{
			System.out.println("=====sd288.jsp调用sd288Qry失败" + retCode1);
%>
		<script language="javascript">
				rdShowMessageDialog("查询审批信息失败。<%=retCode1%>：<%=retCode1%>");
				removeCurrentTab();
		</script>
<%
			return;
		}
%>
<html>
	<head>
	<title>提醒短信审批</title>
	<script language="javascript">
		function doCheckAcc(){
		}
		/**重置页面**/
		function doReset(){
			document.frm.reset();
		}
		function doChange(radioObj){
			var auditAccept = radioObj.value.trim();
			document.all.oprAuditTable.style.display = "block";
			document.all.showMainOprInfoFrame.style.display = "block";
			document.showMainOprInfoFrame.location.href = "fd288_msgInfo.jsp?sAuditAccept=" + auditAccept +"&release_action=" + radioObj.release_action;
			$("#sAuditAccept").val(auditAccept);
			$("#confirmButton").removeAttr("disabled");
		}
		/**关闭页面**/
		function doClose(){
			parent.removeTab("<%=opCode%>");
		}
		function doConfirm(){
			var auditPassVal = $("#sIsAuditPass").val();
			if("none" == auditPassVal){
				rdShowMessageDialog("请选择审批是否通过");
				return false;
			}
			if(document.getElementById("sAuditSuggestion").value=="")
			{
					rdShowMessageDialog("请输入审批意见");
					document.getElementById("sAuditSuggestion").focus();
					return false;
			}
			var confirmFlag = rdShowConfirmDialog("确认要提交操作吗?");
			if(confirmFlag!=1){
				return false;
			}
			var opNoteVal = $("#opNote").val();
			opNoteVal = "操作员<%=workNo%>提醒短信审批" + opNoteVal;
			$("#opNote").val(opNoteVal);
			document.frm.action = "fd288Cfm.jsp";
			document.frm.submit();	
		}
	</script>
<body>
	<form action="" method="post" name="frm">
	<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi">提醒短信审批</div>
		</div>

		<table cellspacing="0">
			<tr height=25 align="center">
				<th nowrap>选择</th>
				<th nowrap>操作批次流水</th>
				<th nowrap>操作类型</th> 
				<th nowrap>模板名称</th> 
				<th nowrap>短信补充内容</th>
				<th nowrap>提交工号</th>
				<th nowrap>提交时间</th>
				<th nowrap>生效时间</th>
				<th nowrap>失效时间</th>
			</tr>
			<%
				int nowPage = 1;
				int allPage = 0;
				if(sVerifyTypeArr.length==0){
					out.println("<tr height='25' align='center'><td colspan='12'>");
					out.println("<font class='orange'>没有任何记录！</font>");
					out.println("</td></tr>");
				}else if(sVerifyTypeArr.length > 0){
					impResultArr = sVerifyTypeArr;
					String tbclass = "";
					for(int i=0;i<sVerifyTypeArr.length;i++){
						tbclass = (i%2==0)?"Grey":"";
%>
						<tr align="center" id="row_<%=i%>">
							<td class="<%=tbclass%>">
								<input type="radio" name="oprAccRadio" value="
								<%
								if(sVerifyTypeArr[i][5].equals("1"))
								{
									out.println(sVerifyTypeArr[i][0]);
								}
								else
								{
									out.println(sVerifyTypeArr[i][14]);
								}
								%>" 
								<%
								System.out.println("sVerifyTypeArr[i][5]="+sVerifyTypeArr[i][5]);
								System.out.println("sVerifyTypeArr[i][8]="+sVerifyTypeArr[i][8]);
								System.out.println("sVerifyTypeArr[i][14]="+sVerifyTypeArr[i][12]);
								System.out.println("sVerifyTypeArr[i][5].equals(3)="+sVerifyTypeArr[i][5].equals("3"));
								System.out.println("!(sVerifyTypeArr[i][12].equals(sVerifyTypeArr[i][8]))="+!(sVerifyTypeArr[i][12].equals(sVerifyTypeArr[i][8])));
								
									//修改
									if(sVerifyTypeArr[i][5].equals("3")
										&&
										!(sVerifyTypeArr[i][12].equals(sVerifyTypeArr[i][8]))
										)
									{
										out.println("IsNotCreateLoginModify='Y'");
										System.out.println("YYY");
									}else
									{
										out.println("IsNotCreateLoginModify='N'");
										System.out.println("NNN");
									}
								%>
								
								release_action="<%=sVerifyTypeArr[i][5]%>" onclick="doChange(this)">	
								
							</td>
							<td class="<%=tbclass%>"><%
								if(sVerifyTypeArr[i][5].equals("1"))
								{
									out.println(sVerifyTypeArr[i][0]);
									}
							else
								{
									out.println(sVerifyTypeArr[i][14]);
								}
								
								%>&nbsp;</td>
								<td class="<%=tbclass%>">
									<%
										if("1".equals(sVerifyTypeArr[i][5])){
											out.println("发布");
										}else if("2".equals(sVerifyTypeArr[i][5])){
											out.println("删除");
										}else{
											out.println("更新");
										}
									%>
								</td>
								<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][1]%>&nbsp;</td>
								<td style="word-break:break-all;" class="<%=tbclass%>"><%=sVerifyTypeArr[i][6]%>&nbsp;</td>
								<%
								if("1".equals(sVerifyTypeArr[i][5])){
								%>	
										<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][8]%>&nbsp;</td>
										<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][9]%>&nbsp;</td>
								<%				
								}else{
								%>
										<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][12]%>&nbsp;</td>
										<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][13]%>&nbsp;</td>					
								<%					
								}
								%>
										<td class="<%=tbclass%>" nowrap><%=sVerifyTypeArr[i][10]%>&nbsp;</td>
										<td class="<%=tbclass%>" nowrap><%=sVerifyTypeArr[i][11]%>&nbsp;</td>
								</tr>
<%
					}
					allPage = (impResultArr.length- 1) / 10 + 1 ;
				}
			%>
		</table>
		  <div align="center">
			<table align="center" style="background-color:#E6E6E6;">
				<tr>
					<td align="center">
					总记录数：<font name="totalPertain" id="totalPertain"><%=impResultArr.length%></font>&nbsp;&nbsp;
					总页数：<font name="totalPage" id="totalPage"><%=allPage%></font>&nbsp;&nbsp;
					当前页：<font name="currentPage" id="currentPage">1</font>&nbsp;&nbsp;
					每页行数：10
					<a href="javascript:setPage('1');">[第一页]</a>&nbsp;&nbsp;
					<a href="javascript:setPage('-1');">[上一页]</a>&nbsp;&nbsp;
					<a href="javascript:setPage('+1');">[下一页]</a>&nbsp;&nbsp;
					<a href="javascript:setPage('<%=allPage%>');">[最后一页]</a>&nbsp;&nbsp;
					跳转到
					<select name="toPage" id="toPage" style="width:80px" onchange="setPage(this.value);">
<%
					for (int i = 1; i <= allPage; i ++) {
%>
						<option value="<%=i%>">第<%=i%>页</option>
<%
					}
%>
					</select>
					页
					</td>
				</tr>
			</table>
			</div>
			<input type="hidden" id="nowPage" />
			<input type="hidden" id="allPage" value="<%= allPage %>" />
		<table>
			<tr>
				<td colspan="4">
					<iframe frameBorder="0" id="showMainOprInfoFrame" align="center" 
						 name="showMainOprInfoFrame" scrolling="no" style="height:100%; 
						 visibility:inherit; width:100%; z-index:1; display:none;"  
						 onload="document.getElementById('showMainOprInfoFrame').style.height=showMainOprInfoFrame.document.body.scrollHeight+'px'"></iframe>
				</td>
			</tr>
		</table>
		<table id="oprAuditTable" style="display:none" cellspacing="0">
			 <tr>
				<td width="15%" class="blue" nowrap>&nbsp;&nbsp;选择的批次流水</td>
				<td>
					<input type="text" name="sAuditAccept" id="sAuditAccept" value="" readonly>						
				</td>
			</tr>
			<tr>
				<td width="15%" class="blue" nowrap>&nbsp;&nbsp;审核是否通过</td>
				<td>
					<select name="sIsAuditPass" id="sIsAuditPass" onchange="doCheckAcc()">
						<option value="none">请选择</option>
						<option value="Y">是</option>
						<option value="N">否</option>
					</select>						
				</td>
			</tr>
			<tr>
				<td width="15%" class="blue" nowrap>&nbsp;&nbsp;审批意见</td>
				<td>
					<input type="text" name="sAuditSuggestion" id="sAuditSuggestion" value="" size="80" maxlength="60">					
				</td>
			</tr>
				<input type="hidden" name="systemNote" value="" size="80" maxlength="60" readonly>
			<tr>
				<td class="blue" nowrap>&nbsp;&nbsp;操作备注</td>
				<td><input type="text" name="opNote" id="opNote" value="" size="80" maxlength="60"></td>
			</tr>
		</table>
			<table cellSpacing="0">
	      <tr> 
	        <td id="footer"> 
	           <input type="button" name="resetButton"  class="b_foot" value="重置" style="cursor:hand;" onclick="doReset()" >&nbsp;
	           <input type="button" name="confirmButton" id="confirmButton"  class="b_foot" 
	            value="确定" style="cursor:hand;" onClick="doConfirm()" disabled>&nbsp;
	           <input type="button" name="closeButton" class="b_foot" value="关闭" style="cursor:hand;" onClick="doClose()" >&nbsp;
	        </td>
	      </tr>
	     </table>
    <%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
<script language="javascript">
	$(document).ready(function(){
		var nowp = "<%= nowPage %>";
		$("#nowPage").val(nowp);
		setPage(nowp);
	});
	function setPage(goPage){
		if (goPage == "-1") {
			setPage(String(parseInt($("#nowPage").val()) - 1));
			return;
		} else if (goPage == "+1") {
			setPage(String(parseInt($("#nowPage").val()) + 1));
			return;
		}else {
			goPage = parseInt(goPage);
			if(goPage < 1){
				return false;
			}else if(goPage > $("#allPage").val()){
				return false;
			}else{
				pageNo = parseInt(goPage);
				//所有行隐藏
				$("[id^='row_']").hide();
				//显示行
				var startRow = (pageNo - 1) * 10;
				var endRow = pageNo * 10 - 1;
				for(var i = startRow; i <= endRow; i++ ){
					var pageStr = "#row_" + i;
					$(pageStr).show();
				}
				$("#nowPage").val(pageNo);
				$("#currentPage").text(pageNo);
				$("#toPage").val(pageNo);
			}
		}
	}
</script>
</html>