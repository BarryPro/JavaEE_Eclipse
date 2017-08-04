<%
  /* *********************
   * 功能: 工号密码维护问题新增
   * 版本: 1.0
   * 日期: 2012-4-24 10:38:48
   * 作者: ningtn
   * 版权: si-tech
   * *********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String opCode=request.getParameter("opCode");
  String opName=request.getParameter("opName");
  String workNo = (String)session.getAttribute("workNo");
  String password = (String)session.getAttribute("password");
  String regionCode= (String)session.getAttribute("regCode");
%>
		<wtc:service name="se791Qry" routerKey="region" 
			 routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
				<wtc:param value=""/>
				<wtc:param value="01"/>
				<wtc:param value="<%=opCode%>"/>
				<wtc:param value="<%=workNo%>"/>
				<wtc:param value="<%=password%>"/>
				<wtc:param value=""/>
				<wtc:param value=""/>
				<wtc:param value=""/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
<%
	String oFlag = "Y";
	if("000000".equals(retCode1)){
		/*调用 检验工号是否有密码保护记录 服务成功*/
		if(result != null && result.length > 0){
			oFlag = result[0][0];
		}
	}
	System.out.println("ningtn fe791AddQuestion " + retCode1 + " | " + oFlag);
	if(oFlag.equals("Y")){
%>
	<script language="javascript">
		rdShowMessageDialog("该用户已经添加过问题不允许修改，如果想修改请删除问题后重新录入。");
		location="/npage/se791/fe791Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	</script>
<%
	}else{
	String getQuestionSql = "SELECT   question_id, question_desc "+
					" FROM spwdquestion "+
					" WHERE TRIM (func_type) = '1' AND isshow = 'Y' "+
					" ORDER BY question_id ";
%>
		<wtc:pubselect name="sPubSelect" outnum="2" 
					routerKey="region" routerValue="<%=regionCode%>"  
					retcode="retCode" retmsg="retMsg" >
			<wtc:sql><%=getQuestionSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="questionResult" scope="end"/>
<%
	if(!"000000".equals(retCode) || questionResult == null || questionResult.length == 0){
%>
	<script language="javascript">
		rdShowMessageDialog("查询问题列表失败，<%=retCode%><%=retMsg%>");
	</script>
<%
	}
%>
<div class="title">
		<div id="title_zi">设置密码重置问题-请至少设置两个</div>
	</div>
	<table cellspacing="0">
		<tr>
			<th width="25%">问题</th>
			<th>答案</th>
		</tr>
		<%
		if(questionResult != null && questionResult.length > 0){
			for(int i = 0; i < questionResult.length; i++){
		%>
		<tr>
			<td>
				&nbsp;&nbsp;
				<select name="questionList" onchange="changeQues(this,<%=i%>)">
					<option value="0">--请选择问题--</option>
					<%
						for(int j = 0; j < questionResult.length; j++){
					%>
							<option value="<%=questionResult[j][0]%>"><%=questionResult[j][1]%></option>
					<%
						}
					%>
				</select>
			</td>
			<td>
				<input type="text" name="answer" maxlength="40" size="40" />
			</td>
		</tr>
		<%
			}
		}
		%>
	</table>
<%}%>