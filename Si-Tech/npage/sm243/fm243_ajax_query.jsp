<%
    /*************************************
    * ��  ��: m243������ת����ѯ
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2015/3/5 
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
					<div id="title_zi">��ѯ���</div>
				</div>
				<table cellspacing="0" name="t1" id="t1" vColorTr='set'>
				<tr>
					<th>�������</th> 
					<th>���������</th> 
					<th>����ʱ��</th> 
					<th>�����ʷ�����</th> 
				</tr>
				<%
				int nowPage = 1;
				int allPage = 1;
				if(ret.length==0){
					out.println("<tr height='25' align='center'><td colspan='4'>");
					out.println("û���κμ�¼��");
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
						�ܼ�¼����<font name="totalPertain" id="totalPertain"><%=ret.length%></font>&nbsp;&nbsp;
						��ҳ����<font name="totalPage" id="totalPage"><%=allPage%></font>&nbsp;&nbsp;
						��ǰҳ��<font name="currentPage" id="currentPage">1</font>&nbsp;&nbsp;
						ÿҳ������10
						<a href="javascript:setPage('1');">[��һҳ]</a>&nbsp;&nbsp;
						<a href="javascript:setPage('-1');">[��һҳ]</a>&nbsp;&nbsp;
						<a href="javascript:setPage('+1');">[��һҳ]</a>&nbsp;&nbsp;
						<a href="javascript:setPage('<%=allPage%>');">[���һҳ]</a>&nbsp;&nbsp;
						��ת��
						<select name="toPage" id="toPage" style="width:80px" onchange="setPage(this.value);">
							<%
							for (int i = 1; i <= allPage; i ++) {
							%>
								<option value="<%=i%>">��<%=i%>ҳ</option>
							<%
							}
							%>
						</select>
						ҳ
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
				rdShowMessageDialog("������룺<%=retCode%><br>������Ϣ��<%=retMsg%>", 0);
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
				//����������
				$("[id^='row_']").hide();
				//��ʾ��
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