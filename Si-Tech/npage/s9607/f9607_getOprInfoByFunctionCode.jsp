<%
   /*
   * 功能: 注意事项库修改-根据操作代码查询信息
　 * 版本: v3.0
　 * 日期: 2008-10-10
　 * 作者: zhanghonga
　 * 版权: sitech
   * 修改历史
   * 修改日期 2011-1-6 15:01:07     修改人  ningtn    
   * 修改目的	关于取消BOSS系统注意事项库内容修改、删除工号限制的函
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
    
 		String opCode = "9607";
 		String opName = "注意事项库修改";

		/**需要regionCode来做服务的路由**/
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode = (String)session.getAttribute("regCode");
		String groupId = (String)session.getAttribute("groupId");
		String workNo = (String)session.getAttribute("workNo");
		
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
		String Channels_Code = WtcUtil.repNull(request.getParameter("Channels_Code"));
		String rootDistance = WtcUtil.repNull(request.getParameter("rootDistance"));
		System.out.println("@#$%^&*(((((((((&)))))))))))))))))))==="+rootDistance);
		/**创建一个空的全局数组**/
		String [][]impResultArr = new String[][]{};		
		String[] paraArray1 = new String[12];
		/**1.判断工号的级别,如果root_distance==1,省级,==2,地市,>2,区县或者更小的级别**/
		String checkSql = "select root_distance from dChnGroupMsg where group_id = '"+groupId+"'";
		System.out.println("#######checkSql->"+checkSql);
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
		/*zhangyan add 非客服工号需要校验*/
		String accountType=(String)session.getAttribute("accountType");
		System.out.println("9607 accountType="+accountType);
		if (!accountType.equals("2")  &&  loginRootDistance>3){
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
			paraArray1[9] = iPromptType;		/**iPromptType   提示类型          **/
			paraArray1[10] = iPromptSeq;		/**iPromptSeq    提示序号          **/
		    paraArray1[11] = Channels_Code ;	/**iChnCode      渠道代码          **/
		    for(int ii = 0; ii < paraArray1.length; ii++){
		    	System.out.println("$$$$$$$ ningtn $$$$$$ " + ii + " | " + paraArray1[ii]);
		    }
		
%>
			<wtc:service name="s9607Qry1" outnum="15" retmsg="msg1" retcode="code1" 
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
				System.out.println("$$$$$$$$$$$$$ ningnt 调用s9607Qry1成功  " + code1 + " | " + msg1);
				System.out.println("$$$$$$$$$$$$$ ningnt $$$$  " + result_t.length);
				impResultArr = result_t;
			}else{
				System.out.println("$$$$$$$$$$$$$ ningnt 调用s9607Qry1失败  " + code1 + " | " + msg1);
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
		<!--
			function doChange(){
				var regionRadios = document.getElementsByName("regionRadio");	
				for(var i=0;i<regionRadios.length;i++){
					if(regionRadios[i].checked){
						var impValue = regionRadios[i].value;
						var impArr = impValue.split("|");
					
						parent.document.all.sFunctionCode.value=impArr[1];
						parent.document.all.sFunctionCodeHidden.value=impArr[1];
						parent.document.all.sFunctionCode.disabled = true;
						parent.document.all.sFunctionName.disabled = true;
						parent.document.all.queryfcbutton.disabled = true;
						parent.document.all.clearfcbutton.disabled = true;
						
						parent.document.all.iBillType.value=impArr[2];
						parent.document.all.iBillTypeHidden.value=impArr[2];
						parent.document.all.iBillType.disabled = true;
						
						parent.document.all.iPromptType.value=impArr[3];
						parent.document.all.iPromptTypeHidden.value=impArr[3];
						parent.document.all.iPromptType.disabled=true;

						parent.document.all.Channels_Code.value=impArr[14];
						parent.document.all.Channels_CodeHidden.value=impArr[14];
						parent.document.all.Channels_Code.disabled=true;
						
						parent.document.all.iPromptSeq.value=impArr[4];
						parent.document.all.iPromptSeqHidden.value=impArr[4];
						parent.document.all.iPromptSeq.disabled=true;
						parent.document.all.confirmButton.disabled = false;
						var loginRootDistance = "<%=loginRootDistance%>";
						parent.document.getElementById("showOprInfoFrame").style.display = "block";
						
						parent.document.showOprInfoFrame.location.href = "f9607_oprInfo.jsp?createAccept="+impArr[0]+"&loginRootDistance="+loginRootDistance+"&createLogin="+impArr[6];
						
						//这个参数createLogin传递给父页面,用于判断:
						//当工号是区县的级别时,用这个创建工号跟修改人工号比对,
						//如果相等,则修改发起的途径为:创建人发起的修改
						//如果不相等,则修改发起的途径为:修改者发起的修改
						parent.document.all.createLogin.value.value="";
						parent.document.all.createLogin.value=impArr[6];
					}
				}
				//alert(parent.document.all.Channels_CodeHidden.value);
			}
		//-->
	</script>
</head>
<body>
	<div id="Operation_Table"> 
     <table cellspacing="0">
			<tr align="center">
				<th nowrap>选择</th>
				<th nowrap>创建流水</th>
				<!--
				<th nowrap>操作功能</th>
				<th nowrap>票据类型</th> 
				<th nowrap>提示类型</th>
				<th nowrap>提示序号</th> 
				<th nowrap>有效标志</th> 	
				-->
				<th nowrap>模块名称</th>
				<th nowrap>提示内容</th>	
				<th nowrap>有效标志</th>
				<th nowrap>票据类型</th>
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
						System.out.println(tempStr);
	%>
						<tr align="center" id="row_<%=i%>">
							<td class="<%=tbclass%>">
								<input type="radio" name="regionRadio" value="<%=tempStr%>" onclick="doChange()">	
							</td>
							
							<td class="<%=tbclass%>"><%=impResultArr[i][0]%>&nbsp;</td>
							<!--
							<td><%=impResultArr[i][1]%>&nbsp;</td>
							<td><%=impResultArr[i][2]%>&nbsp;</td>
							<td><%=impResultArr[i][3]%>&nbsp;</td>
							<td><%=impResultArr[i][4]%>&nbsp;</td>
							<td><%=impResultArr[i][8]%>&nbsp;</td>
							-->
							<td class="<%=tbclass%>"><%=impResultArr[i][9]%>&nbsp;</td>
							<td style="word-break:break-all" class="<%=tbclass%>"><%=impResultArr[i][5]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=impResultArr[i][10]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=impResultArr[i][11]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=impResultArr[i][12]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=impResultArr[i][13]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=impResultArr[i][6]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=impResultArr[i][7]%>&nbsp;</td>
						</tr>
	<%				
				}
				allPage = impResultArr.length / 10 + 1 ;
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

