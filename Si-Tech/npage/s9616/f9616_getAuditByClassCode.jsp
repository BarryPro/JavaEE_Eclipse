 <%
   /*
   * 功能: 审核记录查询-根据界面查询信息
　 * 版本: v3.0
　 * 日期: 2008-10-10
　 * 作者: yangrq
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
		<%@ page contentType="text/html;charset=Gb2312"%>
		<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		/**需要清楚缓存.如果是新页面,可删除**/
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
 		String opCode = "9616";
 		String opName = "审核记录查询";

		/**需要regionCode来做服务的路由**/
		String regionCode  = (String)session.getAttribute("regCode");
		String groupId = (String)session.getAttribute("groupId");


		/** 
		 	*@inparam			audit_accept 审批流水
			*@inparam			op_time_begin      操作时间（创建时间、或修改时间）
			*@inparam			op_time_end      操作时间（创建时间、或修改时间）
			*@inparam			op_code      界面范围
			*@inparam			bill_type    票据类型
			*@inparam			prompt_type  提示类型
			*@inparam			login_no     发起人工号：（创建人、修改人、删除人）
			*@inparam     class_code   代码
			*@inparam     class_value  字段域值
		 **/
		String op_code = WtcUtil.repNull(request.getParameter("op_code01"));
		String audit_accept = WtcUtil.repNull(request.getParameter("audit_accept01"));
		String op_time_begin = WtcUtil.repNull(request.getParameter("op_time01_begin"));
		String op_time_end = WtcUtil.repNull(request.getParameter("op_time01_end"));		
		String bill_type = WtcUtil.repNull(request.getParameter("bill_type01"));		
		String prompt_type = WtcUtil.repNull(request.getParameter("prompt_type01"));	
		String login_no = WtcUtil.repNull(request.getParameter("login_no01"));	
		String class_code = WtcUtil.repNull(request.getParameter("class_code"));	
		String class_value = WtcUtil.repNull(request.getParameter("class_value"));	
		String Channels_Code = WtcUtil.repNull(request.getParameter("Channels_Code"));	
		String rootDistance = WtcUtil.repNull(request.getParameter("rootDistance"));	
		if(Channels_Code.equals("none")){
			Channels_Code="";
		}		
		%>
			
		<wtc:service  name="s9616Qry"  routerKey="region"  routerValue="<%=regionCode%>" outnum="18">
		<wtc:param  value="2"/>
		<wtc:param  value="<%=op_code%>"/>
		<wtc:param  value="<%=groupId%>"/>
     	<wtc:param  value="<%=bill_type%>"/>
      <wtc:param  value="<%=prompt_type%>"/>
      <wtc:param  value="<%=login_no%>"/>
      <wtc:param  value="<%=audit_accept%>"/>
      <wtc:param  value="<%=op_time_begin%>"/>
      <wtc:param  value="<%=op_time_end%>"/>
      <wtc:param  value="<%=class_code%>" />
     	<wtc:param  value="<%=class_value%>" />	
        <wtc:param  value="<%=Channels_Code%>" />
     	<wtc:param  value="<%=rootDistance%>" />    
		</wtc:service> 
		<wtc:array  id="sVerifyTypeArr"  scope="end"/>
<%	
System.out.println("retCode===="+retCode);
System.out.println("retMsg===="+retMsg);
System.out.println("sVerifyTypeArr.length=" + sVerifyTypeArr.length);
%>

<html>
	<head>
	<title><%=opName%></title>
	<meta content=no-cache http-equiv=Pragma>
	<meta content=no-cache http-equiv=Cache-Control>
	<script language="javascript">
		<!--
			function doChange(){
					parent.document.all.audit_accept01.disabled=true;
					parent.document.all.op_time01_begin.disabled=true;
					parent.document.all.op_time01_end.disabled=true;
					parent.document.all.op_code01.disabled=true;
					parent.document.all.bill_type01.disabled=true;
					parent.document.all.prompt_type01.disabled=true;
					parent.document.all.login_no01.disabled=true;
					parent.document.all.class_code.disabled=true;
					parent.document.all.class_value.disabled=true;
				var regionRadios = document.getElementsByName("regionRadio");
				for(var i=0;i<regionRadios.length;i++){		
					if(regionRadios[i].checked){
					var radioValue = regionRadios[i].value;
					parent.document.getElementById("qryFieldAuditInfoFrame").style.display = "block";
					parent.document.qryFieldAuditInfoFrame.location = "f9616_getPromptAuditByClassCode.jsp?create_accept="+radioValue;
					var radioId=regionRadios[i].title.split("|");
					document.getElementById("control_code").innerHTML=radioId[0];
					document.getElementById("billType").innerHTML=radioId[1];
					document.getElementById("promptType").innerHTML=radioId[2];
					document.getElementById("promptNumber").innerHTML=radioId[3];
					document.getElementById("publishAction").innerHTML=radioId[4];
					document.getElementById("promptContent").innerHTML=radioId[5];
					document.getElementById("createName").innerHTML=radioId[6];
					document.getElementById("createTime").innerHTML=radioId[7];
					document.getElementById("createWork").innerHTML=radioId[8];
					document.getElementById("effectiveTime").innerHTML=radioId[9];
					document.getElementById("extinctTime").innerHTML=radioId[10];
					document.getElementById("id6").innerHTML=radioId[11];
					document.getElementById("id5").innerHTML=radioId[12];
					document.getElementById("validFlag").innerHTML=radioId[13];
					document.getElementById("wordCode").innerHTML=radioId[14];
					document.getElementById("classCode").innerHTML=radioId[15];
					document.getElementById("channel").innerHTML=radioId[16];
				}
			}
		}
		//-->
	</script>
</head>
<body>
	<div id="Operation_Table">
     <table cellspacing="0">
			<tr align="center">
				<th nowrap>选择</th>
				<th nowrap>界面范围</th>
				<th nowrap>发布区域</th>
				<th nowrap>票据类型</th> 
				<th nowrap>提示类型</th>
				<th nowrap>打印类型</th>
				<th nowrap>创建/修改工号</th>
				<th nowrap>创建/修改时间</th>
				<th nowrap>创建/修改流水</th>
				<th nowrap>渠道类型</th>				
			</tr> 
	<%
			int nowPage = 1;
			int allPage = 0;
			if(sVerifyTypeArr.length==0){
				out.println("<tr height='25' align='center'><td colspan='11'>");
				out.println("<font class='orange'>没有任何记录！</font>");
				out.println("</td></tr>");
			}else if(sVerifyTypeArr.length>0){
				String tbclass = "";
				for(int i=0;i<sVerifyTypeArr.length;i++){
						tbclass = (i%2==0)?"Grey":"";
	%>
						<tr align="center">
							<td class="<%=tbclass%>">
								<input type="radio" name="regionRadio" id="regionRadio" value="<%=sVerifyTypeArr[i][8]%>" title="<%=sVerifyTypeArr[i][0]%>|<%=sVerifyTypeArr[i][1]%>|<%=sVerifyTypeArr[i][2]%>|<%=sVerifyTypeArr[i][3]%>|<%=sVerifyTypeArr[i][4]%>|<%=sVerifyTypeArr[i][5]%>|<%=sVerifyTypeArr[i][6]%>|<%=sVerifyTypeArr[i][7]%>|<%=sVerifyTypeArr[i][8]%>|<%=sVerifyTypeArr[i][9]%>|<%=sVerifyTypeArr[i][10]%>|<%=sVerifyTypeArr[i][11]%>|<%=sVerifyTypeArr[i][12]%>|<%=sVerifyTypeArr[i][13]%>|<%=sVerifyTypeArr[i][14]%>|<%=sVerifyTypeArr[i][15]%>|<%=sVerifyTypeArr[i][17]%>" onclick="doChange()">	
							</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][0]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][12]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][1]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][2]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][16]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][6]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][7]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][8]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][17]%>&nbsp;</td>
						</tr>
	<%				
				}
				allPage = sVerifyTypeArr.length / 10 + 1 ;
			}
	%>
  </table>
  				<div align="center">
				<table align="center">
					<tr>
						<td align="center">
						总记录数：<font name="totalPertain" id="totalPertain"><%=sVerifyTypeArr.length%></font>&nbsp;&nbsp;
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
  </div>
	<div id="Operation_Table"> 
	<div class="title">
		<div id="title_zi">详细信息</div>
	</div>
  <div style="overflow-x:hidden; overflow-y:auto;height:200px;">
  <table cellspacing="0" id="detailInfo" style="display:block; padding:3px;">
				<tr>
					<td width="15%" class="blue" nowrap>界面范围</td>
					<td width="35%" id="control_code">&nbsp;</td>
					<td width="15%" class="blue" nowrap>票据类型</td>
					<td width="35%" id="billType">&nbsp;</td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>提示类型</td>
					<td width="35%" id="promptType">&nbsp;</td>
					<td width="15%" class="blue" nowrap>提示序号</td>
					<td id="promptNumber">&nbsp;</td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>发布动作类型</td>
					<td width="35%" id="publishAction">&nbsp;</td>
					<td width="15%" class="blue" nowrap>提示内容</td>
					<td id="promptContent">&nbsp;</td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>创建/修改工号</td>
					<td width="35%" id="createName">&nbsp;</td>
					<td width="15%" class="blue" nowrap>创建/修改时间</td>
					<td id="createTime">&nbsp;</td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>创建/修改流水</td>
					<td width="35%" id="createWork">&nbsp;</td>
					<td width="15%" class="blue" nowrap>生效时间</td>
					<td id="effectiveTime">&nbsp;</td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>失效时间</td>
					<td width="35%" id="extinctTime">&nbsp;</td>
					<td width="15%" class="blue" nowrap>输出顺序</td>
					<td width="35%" id="id6">&nbsp;</td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>发布区域</td>
					<td id="id5">&nbsp;</td>
					<td width="15%" class="blue" nowrap>有效标志</td>
					<td width="35%" id="validFlag">&nbsp;</td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>代码</td>
					<td id="wordCode">&nbsp;</td>
					<td width="15%" class="blue" nowrap>字段域值</td>
					<td width="35%" id="classCode">&nbsp;</td>
				</tr>
				<tr>
					<td width="15%" class="blue" nowrap>渠道类型</td>
					<td width="35%" id="channel">&nbsp;</td>
					<td >&nbsp;</td>
					<td >&nbsp;</td>					
				</tr>				
	</table>
	</div>
 	</div>
</body>
<script language="javascript">
	$(document).ready(function(){
		var nowp = "<%= nowPage %>";
		$("#nowPage").val(nowp);
		setPage(nowp);
	});
	function setPage(goPage){
		if (goPage == "-1") {
			setPage(parseInt($("#nowPage").val()) - 1);
			return;
		} else if (goPage == "+1") {
			setPage(parseInt($("#nowPage").val()) + 1);
			return;
		}else{ 
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
				parent.document.all.qryFieldInfoFrame.style.height = window.document.body.scrollHeight
			}
		}
	}
</script>
</html>    

