<%
    /*************************************
    * ��  ��: �ſ�������ѯ m078
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2013-4-15
    **************************************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");		
	String regionCode= (String)session.getAttribute("regCode");
	String groupId= (String)session.getAttribute("groupId");
	String opCode 	= (String)request.getParameter("opCode");		
	String opName 	= (String)request.getParameter("opName");	
	String stypeCode 	= (String)request.getParameter("stypeCode");	
	String inputParsm [] = new String[8];
	
	System.out.println("diling--stypeCode="+stypeCode);
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>
<%
	inputParsm[0] = printAccept; //��ˮ
	inputParsm[1] = "01"; //������ʶ 
	inputParsm[2] = opCode; //��������
	inputParsm[3] = workNo; //���� 
	inputParsm[4] = password; //�������� 
	inputParsm[5] = ""; //�ֻ����� 
	inputParsm[6] = ""; //�ֻ����� 
	inputParsm[7] = stypeCode; //��������
%>

<wtc:service name="sm078Qry" routerKey="region" routerValue="<%=regionCode%>"
	retcode="retCode" retmsg="retMsg" outnum="10">
	<wtc:param value="<%=inputParsm[0]%>"/>
	<wtc:param value="<%=inputParsm[1]%>"/>
	<wtc:param value="<%=inputParsm[2]%>"/>
	<wtc:param value="<%=inputParsm[3]%>"/>
	<wtc:param value="<%=inputParsm[4]%>"/>
	<wtc:param value="<%=inputParsm[5]%>"/>
	<wtc:param value="<%=inputParsm[6]%>"/>
	<wtc:param value="<%=inputParsm[7]%>"/>
</wtc:service>
<wtc:array id="ret" scope="end"/>
<%
	if("000000".equals(retCode)){
%>
	<html xmlns="http://www.w3.org/1999/xhtml">
		<body>
			<form name="frm1">
			 <div id="Main">
					<div id="Operation_Table">
			
						<table cellspacing="0" name="t1" id="t1" vColorTr='set'>
							<tr>
								<th>��������</th> 
								<th>������Դ���� </th> 
								<th>��������ʱ��</th> 
								<th>�ֻ�����</th> 
								<th>SIM������</th> 
								<th>SIM������</th> 
								<!--2016/03/31 liangyl��-->
							<!--	<th>ҵ������</th>-->
								<th>HLR����</th>
								<th>HLR����</th>
							</tr>
			<%
							int nowPage = 1;
							int allPage = 0;
							if(ret.length==0){
								out.println("<tr height='25' align='center'><td colspan='7'>");
								out.println("û���κμ�¼��");
								out.println("</td></tr>");
							}else if(ret.length>0){
								String tbclass = "";
								for(int i=0;i<ret.length;i++){
										tbclass = (i%2==0)?"Grey":"";
										String tempStr = "";
			%>
								<tr align="center" id="row_<%=i%>">
									<td class="<%=tbclass%>"><%=ret[i][0]%></td>
									<td class="<%=tbclass%>"><%=ret[i][1]%></td>
									<td class="<%=tbclass%>"><%=ret[i][2]%></td>
									<td class="<%=tbclass%>"><%=ret[i][3]%></td>
									<td class="<%=tbclass%>"><%=ret[i][4]%></td>
									<td class="<%=tbclass%>"><%=ret[i][5]%></td>
									<!--2016/03/31 liangyl��-->
								<!--	<td class="<%=tbclass%>"><%=ret[i][6]%>��<%=ret[i][7]%>��</td>-->
									<td class="<%=tbclass%>"><%=ret[i][6]%></td>
									<td class="<%=tbclass%>"><%=ret[i][7]%></td>
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
						<input type="hidden" id="nowPage" />
						<input type="hidden" id="allPage" value="<%= allPage %>" />
					</div>
				</div>
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
						return ;
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
	</html>
<%		
		}else{
%>
			<script language="javascript">
				rdShowMessageDialog("������룺<%=retCode%><br>������Ϣ��<%=retMsg%>", 0);
				window.location.href="fm078_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
			</script>
<%
		}
%> 	
