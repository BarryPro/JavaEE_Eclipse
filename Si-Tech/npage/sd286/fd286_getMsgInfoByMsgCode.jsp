<%
   /*
   * 功能: 提醒短信修改
　 * 版本: v3.0
　 * 日期: 2011-3-28
　 * 作者: ningtn
　 * 版权: sitech
 　*/
%>
<%@ page contentType="text/html;charset=Gb2312"%>
		<%@ include file="/npage/include/public_title_name.jsp" %>
		<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
		/**需要清楚缓存.如果是新页面,可修改**/
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
 		String opCode = "d286";
 		String opName = "提醒短信修改";
 		String regionCode = (String)session.getAttribute("regCode");
		String groupId = (String)session.getAttribute("groupId");
		String workNo = (String)session.getAttribute("workNo");
		/* 获取参数 */
		String msgCode = WtcUtil.repNull(request.getParameter("iMsgCode"));
		String msgNote = WtcUtil.repNull(request.getParameter("iMsgNote"));		
		String iPromptType = WtcUtil.repNull(request.getParameter("iPromptType"));		
		String iPromptSeq = WtcUtil.repNull(request.getParameter("iPromptSeq"));
		String rootDistance = WtcUtil.repNull(request.getParameter("rootDistance"));
		String ichannelCode = WtcUtil.repNull(request.getParameter("ichannelCode"));
		System.out.println("$$$$$$$$$$fd286getMsgInfo" + msgCode + "|" + msgCode + "|" + iPromptType + "|" + ichannelCode);
		String [][]impResultArr = new String[][]{};
		String[] paraArray1 = new String[12];
		/**1.判断工号的级别,如果root_distance==1,省级,==2,地市,>2,区县或者更小的级别**/
		String checkSql = "select root_distance from dChnGroupMsg where group_id = '"+groupId+"'";
		System.out.println("#######checkSql->" + checkSql);
%>
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="1"> 
		<wtc:sql><%=checkSql%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="sVerifyTypeArr"  scope="end"/>
<%
		/**根据loginRootDistance来判断工号权限问题**/
		int loginRootDistance = 999999;
		if(retCode.equals("000000")){
			if(sVerifyTypeArr!=null&&sVerifyTypeArr.length>0){
				loginRootDistance = sVerifyTypeArr[0][0].equals("")?loginRootDistance:Integer.parseInt(sVerifyTypeArr[0][0]);
			}
		}
		/**如果工号的级别比区县更小(营业厅级别),则不能进行修改操作**/
		if(loginRootDistance>3){
%>
				<table cellspacing="0">
					<tr bgcolor='649ECC' height=25 align="center">
						<td>
							<font style="color:red">(此工号无修改权限)</font>
						</td>
					</tr>
				</table>		
				<script language="javascript">
					<!--
					parent.document.all.confirmButton.disabled = true;
					//-->
				</script>	
<%
			return;
		}else{
		/* 可以正常办理 */
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
			paraArray1[7] = msgCode;	/**iFunctionCode 需要处理的操作代码**/
			paraArray1[8] = "20";		/**iBillType     票据类型          **/
			paraArray1[9] = "20";		/**iPromptType   提示类型          **/
			paraArray1[10] = iPromptSeq;		/**iPromptSeq    提示序号          **/
		  paraArray1[11] = ichannelCode ;	/**iChnCode      渠道代码          **/
%>
			<wtc:service name="sd286Qry" outnum="15" retmsg="msg1" retcode="code1" 
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
				<wtc:param value="<%=paraArray1[11]%>" />
			</wtc:service>
			<wtc:array id="result_t" scope="end"  />
<%
			if("000000".equals(code1)){
				System.out.println("$$$$$$$$$$$$$ ningnt 调用sd286Qry成功  " + code1 + " | " + msg1);
				System.out.println("$$$$$$$$$$$$$ ningnt $$$$  " + result_t.length);
				impResultArr = result_t;
				
				
			}else{
%>
				<table cellspacing="0">
					<tr bgcolor='649ECC' height=25 align="center">
						<td>
							<font style="color:red">(查询失败：<%= code1 %> <%= msg1 %>)</font>
						</td>
					</tr>
				</table>		
				<script language="javascript">
					<!--
					parent.document.all.confirmButton.disabled = true;
					//-->
				</script>
<%
			}
		}
%>
<html>
	<head>
	<title><%=opName%></title>
	<meta content=no-cache http-equiv=Pragma>
	<meta content=no-cache http-equiv=Cache-Control>
	<script language="javascript">
			function doChange(radioObj){
				var impValue = radioObj.value;
				var impArr = impValue.split("|");
				parent.document.all.msgCode.value=impArr[1];
				parent.document.all.msgCodeHide.value=impArr[1];
				parent.document.all.msgNote.value=impArr[9];
				parent.document.all.msgNoteHide.value=impArr[9];
				parent.document.all.msgCode.disabled = true;
				parent.document.all.msgNote.disabled = true;
				parent.document.all.clearMsgInfoBtn.disabled = true;
				parent.document.all.getMsgInfoBtn.disabled = true;
				/* 提示类型 */
				parent.document.all.iPromptType.value=impArr[3];
				parent.document.all.iPromptTypeHide.value=impArr[3];
				parent.document.all.iPromptType.disabled = true;
				/* 提示序号 */
				parent.document.all.iPromptSeq.value=impArr[4];
				parent.document.all.iPromptSeqHide.value=impArr[4];
				parent.document.all.iPromptSeq.disabled = true;
				/* 为父页面赋值 */
				parent.document.all.showMsgInfo.style.display = "block";
				parent.document.all.sPromptContent.value = impArr[5];
				var createLoginNo = "<%=workNo%>";
				parent.document.sAuditLoginInfoFrame.location.href = "../sd285/fd285_getAuditLoginInfo.jsp?createLoginNo="+createLoginNo;
				parent.document.all.confirmButton.disabled = "";

				var getdataPacket = new AJAXPacket("fd286_getGroupName.jsp","正在获得发布地区，请稍候......");
				getdataPacket.data.add("workNo","<%=workNo%>");
				getdataPacket.data.add("createAccept",impArr[0]);
				getdataPacket.data.add("createLogin",impArr[6]);
				core.ajax.sendPacket(getdataPacket);
				getdataPacket = null;
			}
			function doProcess(packet){
				retCode = packet.data.findValueByName("retcode");
				retMsg = packet.data.findValueByName("retmsg");
				result = packet.data.findValueByName("result");
				/* 创建者的groupId */
				creatGrpId = packet.data.findValueByName("creatGrpId");
				
				var groupids = "";
				var td = "<table cellspacing=\"0\" id=\"dataTable\">";
				td = td + "<tr>";
				td = td + "<th>节点代码</th><th>节点名称</th>";
				td = td + "</tr>";
				for(var i = 0; i < result.length; i++){
					td = td + "<tr>";
					td = td + "<td>" + result[i][0] + "</td><td>" + result[i][1] + "</td>"
					td = td + "</tr>";
				}
				/* 生成发布区域 */
				parent.document.all.impGroupId.innerHTML = td;
				/* 判断是否是创建者修改 impArr[6] 
					 如果是同级别(groupId相同)工号修改   Y
					 否则  N
				*/
				var isCreateStart = "";
				if("<%=groupId%>" == creatGrpId){
					isCreateStart = "Y";
				}else{
					isCreateStart = "N";
				}
				parent.document.all.sIsCreaterStart.value = isCreateStart;
				
			}
	</script>
</head>
<body>
	<div id="Operation_Table">
		<table cellspacing="0">
			<tr align="center">
				<th nowrap>选择</th>
				<th nowrap>创建流水</th>
				<th nowrap>短信模块名称</th>
				<th nowrap>短信补充内容</th>	
				<th nowrap>有效标志</th>
				<th nowrap>提示类型</th>
				<th nowrap>渠道类型</th>
				<th nowrap>创建工号</th> 		
				<th nowrap>创建时间</th>
			</tr>
<%
			int nowPage = 1;
			int allPage = 0;
			if(impResultArr.length==0){
				out.println("<tr height='25' align='center'><td colspan='15'>");
				out.println("没有任何记录！");
				out.println("</td></tr>");
			}else if(impResultArr.length>0){
				String tbclass = "";
				for(int i=0;i<impResultArr.length;i++){
						tbclass = (i%2==0)?"Grey":"";
						String tempStr = "";
						for(int j=0;j<impResultArr[i].length;j++){
							tempStr+=(impResultArr[i][j]+"|");
						}
%>
					<tr align="center" id="row_<%=i%>">
						<td class="<%=tbclass%>">
							<input type="radio" name="regionRadio" value="<%=tempStr%>" onclick="doChange(this)">	
						</td>
						<td class="<%=tbclass%>"><%=impResultArr[i][0]%>&nbsp;</td>
						<td class="<%=tbclass%>"><%=impResultArr[i][9]%>&nbsp;</td>
						<td style="word-break:break-all" class="<%=tbclass%>"><%=impResultArr[i][5]%>&nbsp;</td>
						<td class="<%=tbclass%>"><%=impResultArr[i][10]%>&nbsp;</td>
						<td class="<%=tbclass%>"><%=impResultArr[i][12]%>&nbsp;</td>
						<td class="<%=tbclass%>"><%=impResultArr[i][13]%>&nbsp;</td>
						<td class="<%=tbclass%>"><%=impResultArr[i][6]%>&nbsp;</td>
						<td class="<%=tbclass%>"><%=impResultArr[i][7]%>&nbsp;</td>
					</tr>
<%
				}
				allPage = (impResultArr.length - 1) / 10 + 1 ;
			}
%>
		</table>
		<div align="center">
			<table align="center">
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
		} else if (goPage.length == 2 && "+1" == goPage) {
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
			}
		}
	}
</script>
</html> 