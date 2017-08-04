<%
    /*************************************
    * 功  能: m243·流量转赠查询
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2015/3/5 
    **************************************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String opCode =request.getParameter("opCode");
	String workNo = (String)session.getAttribute("workNo");
	String passwd = (String)session.getAttribute("password");
	String phoneNo = request.getParameter("phoneNo");
	String tm_b = request.getParameter("tm_b");
	String tm_e = request.getParameter("tm_e");
	String regCode = (String)session.getAttribute("regCode");
	String opName = request.getParameter("opName");
	
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>

<wtc:service name = "sLLZZQry" outnum = "4"	routerKey = "region" routerValue = "<%=regCode%>" retcode = "retCode" retmsg = "retMsg" >
	<wtc:param value = "<%=printAccept%>"/>
	<wtc:param value = "01"/>
	<wtc:param value = "<%=opCode%>"/>
	<wtc:param value = "<%=workNo%>"/>
	<wtc:param value = "<%=passwd%>"/>
	<wtc:param value = "<%=phoneNo%>"/>
	<wtc:param value = ""/>
	<wtc:param value = "1"/>
	<wtc:param value = "<%=tm_b%>"/>
	<wtc:param value = "<%=tm_e%>"/>
</wtc:service>
<wtc:array id="ret" scope="end" />
<%
	if("000000".equals(retCode)){
%>
		<div id="Main">
			<div id="Operation_Table">
				<div class="title">
					<div id="title_zi">查询结果</div>
				</div>
				<table cellspacing="0" name="t1" id="t1" vColorTr='set'>
				<tr>
					<th>赠予号码</th> 
					<th>被赠予号码</th> 
					<th>赠予时间</th> 
					<th>赠予资费名称</th> 
				</tr>
				<%
				int nowPage = 1;
				int allPage = 1;
				if(ret.length==0){
					out.println("<tr height='25' align='center'><td colspan='4'>");
					out.println("没有任何记录！");
					out.println("</td></tr>");
				}else if(ret.length>0){
					for(int i=0;i<ret.length;i++){
				%>
					<tr align="center" id="row_<%=i%>">
						<td><%=ret[i][0]%></td>
						<td><%=ret[i][1]%></td>
						<td><%=ret[i][2]%></td>
						<td><%=ret[i][3]%></td>
					</tr>
				<%
					}
					allPage = (ret.length - 1) / 10 + 1 ;
				}
				%>
				</table>
				<div align="center">
				<table align="center">
				<tr>
					<td align="center">
						总记录数：<font name="totalPertain" id="totalPertain"><%=ret.length%></font>&nbsp;&nbsp;
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
			<input type="hidden" id="nowPage" value="<%= nowPage %>" />
			<input type="hidden" id="allPage" value="<%= allPage %>" />
			</div>
		</div>
<%		
		}else{
%>
			<script language="javascript">
				rdShowMessageDialog("错误代码：<%=retCode%><br>错误信息：<%=retMsg%>", 0);
				window.location.href="fm243_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
			</script>
<%
		}
%> 	
<script language="javascript">
	$(document).ready(function(){
		setPage($("#nowPage").val());
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
				return;
			}else if(goPage > $("#allPage").val()){
				return;
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