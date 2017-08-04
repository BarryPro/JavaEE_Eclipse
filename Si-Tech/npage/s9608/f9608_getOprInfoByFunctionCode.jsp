<%
   /*
   * 功能: 注意事项库删除-根据操作代码查询信息
　 * 版本: v3.0
　 * 日期: 2008-10-10
　 * 作者: zhanghonga
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
		<%@ page contentType="text/html;charset=Gb2312"%>
		<%@ include file="/npage/include/public_title_name.jsp" %>
		<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
		/**需要清楚缓存.如果是新页面,可删除**/
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
 		String opCode = "9608";
 		String opName = "注意事项库删除";

		/**需要regionCode来做服务的路由**/
		String workNo = (String)session.getAttribute("workNo");
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode  = (String)session.getAttribute("regCode");
		String belongName = (String)session.getAttribute("orgCode");
		String groupId = (String)session.getAttribute("groupId");
		
		/** 
		 *@inparam	sFunctionCode	提示操作功能
		 *@inparam	iBillType	票据类型
		 *@inparam	iPromptType	提示类型
		 *@inparam	iPromptSeq	提示序号
		 **/
		String sFunctionCode = WtcUtil.repNull(request.getParameter("sFunctionCode"));
		String iBillType = WtcUtil.repNull(request.getParameter("iBillType"));		
		String iPromptType = WtcUtil.repNull(request.getParameter("iPromptType"));		
		String iPromptSeq = WtcUtil.repNull(request.getParameter("iPromptSeq"));		
		
		String[] paraArray1 = new String[11];
		String [][]sVerifyTypeArr = new String[][]{};		
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" 
				routerValue="<%=regionCode%>"  id="servAccept"/>
<%		
		System.out.println("$$$$$$$$$$$$$$ ningtn $$$$$$ " + servAccept);
		String loginPwd = "";
		String phoneNo = "";
		String userPwd = "";
		paraArray1[0] = servAccept;
		paraArray1[1] = "01";			/**iChnSource    渠道标识**/
		paraArray1[2] = opCode;			/**iOpCode       操作代码**/
		paraArray1[3] = workNo;			/**iLoginNo      工号    **/
		paraArray1[4] = "";				/**iLoginPwd     工号密码**/
		paraArray1[5] = "";				/**iPhoneNo      移动号码**/
		paraArray1[6] = "";				/**iUserPwd      号码密码**/
		paraArray1[7] = sFunctionCode;	/**iFunctionCode 需要处理的操作代码**/
		paraArray1[8] = iBillType;		/**iBillType     票据类型          **/
		paraArray1[9] = iPromptType;	/**iPromptType   提示类型          **/
		paraArray1[10] = iPromptSeq;	/**iPromptSeq    提示序号          **/
	    for(int ii = 0; ii < paraArray1.length; ii++){
	    	System.out.println("$$$$$$$ ningtn $$$$$$ " + ii + " | " + paraArray1[ii]);
	    }
%>
		<wtc:service name="s9608Qry1" outnum="14" retmsg="msg1" retcode="code1" 
			routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paraArray1[0]%>" />
			<wtc:param value="<%=paraArray1[1]%>" />
			<wtc:param value="<%=paraArray1[2]%>" />
			<wtc:param value="<%=paraArray1[3]%>" />
			<wtc:param value="<%=paraArray1[4]%>" />
			<wtc:param value="<%=paraArray1[5]%>" />
			<wtc:param value="<%=paraArray1[6]%>" />
			<wtc:param value="<%=paraArray1[7]%>" />
			<wtc:param value="<%=paraArray1[8]%>" />
			<wtc:param value="<%=paraArray1[9]%>" />
			<wtc:param value="<%=paraArray1[10]%>" />
		</wtc:service>
		<wtc:array id="result_t" scope="end"  />
<%
		if("000000".equals(code1)){
			System.out.println("$$$$$$$$$$$$$ ningnt 调用s9608Qry1成功  " + code1 + " | " + msg1);
			System.out.println("$$$$$$$$$$$$$ ningnt $$$$  " + result_t.length);
			sVerifyTypeArr = result_t;
		}else{
			System.out.println("$$$$$$$$$$$$$ ningnt 调用s9608Qry1失败  " + code1 + " | " + msg1);
		}
%>
<html>
	<head>
	<title><%=opName%></title>
	<meta content=no-cache http-equiv=Pragma>
	<meta content=no-cache http-equiv=Cache-Control>
	<script language="javascript">
		<!--
			function doChange(){
				var regionRadios = document.getElementsByName("regionRadio");	
				for(var i=0;i<regionRadios.length;i++){
					if(regionRadios[i].checked){
						var impValue = regionRadios[i].value;
						var impArr = impValue.split("|");
						
						//应客户要求,在选择了一条流水之后,需要将这些内容置灰
						parent.document.all.sFunctionCode.value=impArr[0];
						parent.document.all.sFunctionCode.disabled = true;
						
						parent.document.all.iBillType.value=impArr[1];
						parent.document.all.iBillType.disabled = true;
						
						parent.document.all.iPromptType.value=impArr[2];
						parent.document.all.iPromptType.disabled = true;
						
						parent.document.all.iPromptSeq.value=impArr[3];
						parent.document.all.iPromptSeq.disabled = true;
						
						//将提交按钮设置为可用
						parent.document.all.confirmButton.disabled=false;
					
							var createLoginNo = impArr[4];
						document.sAuditLoginInfoFrame.location.href = "f9608_getAuditLoginInfoOpr.jsp?createLoginNo="+createLoginNo;
					}
				}
			}
		//-->
	</script>
</head>
<body>
	<div id="Operation_Table">
     <table  cellspacing="0">
			<tr height=25 align="center">
				<th nowrap>选择</th>
				<th nowrap>操作功能</th>
				<th nowrap>票据类型</th> 
				<th nowrap>提示类型</th>
				<th nowrap>提示序号</th> 
				<th nowrap>提示内容</th>
				<th nowrap>是否打印</th> 
				<th nowrap>有效标志</th>
				<th nowrap>渠道类型</th>
				<th nowrap>创建工号</th> 		
				<th nowrap>创建时间</th>
				<th nowrap>创建流水</th> 		
			</tr> 
	<%
			int nowPage = 1;
			int allPage = 0;
			if(sVerifyTypeArr.length==0){
				out.println("<tr height='25' align='center'><td colspan='11'>");
				out.println("没有任何记录！");
				out.println("</td></tr>");
			}else if(sVerifyTypeArr.length>0){
				String tbclass = "";
				for(int i=0;i<sVerifyTypeArr.length;i++){
						tbclass = (i%2==0)?"Grey":"";
	%>
						<tr align="center" id="row_<%=i%>">
							<td class="<%=tbclass%>">
								<input type="radio" name="regionRadio" value="<%=sVerifyTypeArr[i][12]%>|<%=sVerifyTypeArr[i][11]%>|<%=sVerifyTypeArr[i][10]%>|<%=sVerifyTypeArr[i][3]%>|<%=sVerifyTypeArr[i][7]%>" onclick="doChange()">	
							</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][0]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][1]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][2]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][3]%>&nbsp;</td>
							<td style="word-break:break-all" class="<%=tbclass%>"><%=sVerifyTypeArr[i][4]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][5]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][6]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][13]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][7]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][8]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][9]%>&nbsp;</td>
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
	<table cellspacing="0">
		<tr>
			<td width="14%" class="blue" nowrap>请选择审批人</td>
			<td>
				&nbsp;
				<iframe src="" id="sAuditLoginInfoFrame"  name="sAuditLoginInfoFrame"  width=100% scrolling=no frameborder=0 noresize></iframe>
				<input type="hidden" name="sAuditLogins" value="">
			</td>
		</tr>
  </table>
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
				parent.document.all.qryOprInfoFrame.style.height = window.document.body.scrollHeight
			}
		}
	}
</script>
</html>    

