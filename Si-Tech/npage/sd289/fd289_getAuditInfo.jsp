<%
   /*
   * ����: ���Ѷ�����˲�ѯ
�� * �汾: v3.0
�� * ����: 2011-4-6
�� * ����: ningtn
�� * ��Ȩ: sitech
 ��*/
%>
<%@ page contentType="text/html;charset=Gb2312"%>
		<%@ include file="/npage/include/public_title_name.jsp" %>
		<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
		/**��Ҫ�������.�������ҳ��,���޸�**/
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
		System.out.println("===========fd289_getAuditInfo.jsp start========");
 		String opCode = "d289";
 		String opName = "���Ѷ�����˼�¼��ѯ";
 		String regionCode = (String)session.getAttribute("regCode");
		String groupId = (String)session.getAttribute("groupId");
		String workNo = (String)session.getAttribute("workNo");
		/* ��ȡ���� */
		String msgCode = WtcUtil.repNull(request.getParameter("msgCode"));
		String auditAccept = WtcUtil.repNull(request.getParameter("auditAccept"));
		String startTime = WtcUtil.repNull(request.getParameter("startTime"));
		String endTime = WtcUtil.repNull(request.getParameter("endTime"));
		String createLoginNo = WtcUtil.repNull(request.getParameter("createLoginNo"));
		String rootDistance = WtcUtil.repNull(request.getParameter("rootDistance"));
		System.out.println("========" + msgCode +"|" + auditAccept+"|" + startTime+"|" + endTime+"|" + createLoginNo);
		/* ȫ������ */
		String [][]impResultArr = new String[][]{};
		String[] paraArray1 = new String[10];
		paraArray1[0] = msgCode;
		paraArray1[1] = groupId;
		paraArray1[2] = "20";
		paraArray1[3] = "20";
		paraArray1[4] = createLoginNo;
		paraArray1[5] = auditAccept;
		paraArray1[6] = startTime;
		paraArray1[7] = endTime;
		paraArray1[8] = "01";
		paraArray1[9] = rootDistance;
%>
			<wtc:service name="sd289Qry" outnum="17" retmsg="msg1" retcode="code1" 
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
			</wtc:service>
			<wtc:array id="result_t" scope="end"  />
<%
			if("000000".equals(code1)){
				System.out.println("$$$$$$$$$$$$$ ningnt ����sd289Qry�ɹ�  " + code1 + " | " + msg1);
				System.out.println("$$$$$$$$$$$$$ ningnt $$$$  " + result_t.length);
				impResultArr = result_t;
				
			}else{
%>
				<table cellspacing="0">
					<tr bgcolor='649ECC' height=25 align="center">
						<td>
							<font style="color:red">(��ѯʧ�ܣ�<%= code1 %> <%= msg1 %>)</font>
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
%>
<html>
	<head>
	<title><%=opName%></title>
	<meta content=no-cache http-equiv=Pragma>
	<meta content=no-cache http-equiv=Cache-Control>
	<script language="javascript">
		function doChange(radioObj){
			parent.document.all.msgCode.disabled=true;
			parent.document.all.auditAccept.disabled=true;
			parent.document.all.startTime.disabled=true;
			parent.document.all.endTime.disabled=true;
			parent.document.all.createLoginNo.disabled=true;
			var regionRadios = radioObj.value;
			var radioId=regionRadios.split("|");
			$("#msgName").html(radioId[0]);
			$("#promptType").html(radioId[2]);
			$("#promptSeq").html(radioId[3]);
			$("#releaseAction").html(radioId[4]);
			$("#promptContent").html(radioId[5]);
			$("#confirmLoginNo").html(radioId[6]);
			$("#confirmTime").html(radioId[7]);
			$("#confirmAccept").html(radioId[8]);
			$("#validFlag").html(radioId[13]);
			$("#validTime").html(radioId[9]);
			$("#unvalidTime").html(radioId[10]);
			$("#groupName").html(radioId[12]);
			
			/* ���Ƹ�ҳ���ѯ������Ϣ */
			parent.document.getElementById("qryFieldAuditInfoFrame").style.display = "block";
			parent.document.qryFieldAuditInfoFrame.location = "fd289_getPromptAudit.jsp?create_accept="+radioId[8];
					
		}
	</script>
</head>
<body>
	<div id="Operation_Table">
		<table cellspacing="0">
			<tr align="center">
				<th nowrap>ѡ��</th>
				<th nowrap>����ģ�����</th>
				<th nowrap>����ģ������</th>
				<th nowrap>��������</th>	
				<th nowrap>��ʾ����</th>
				<th nowrap>����/�޸Ĺ���</th> 		
				<th nowrap>����/�޸�ʱ��</th>
				<th nowrap>����/�޸���ˮ</th>
			</tr>
<%
			int nowPage = 1;
			int allPage = 0;
			if(impResultArr.length==0){
				out.println("<tr height='25' align='center'><td colspan='15'>");
				out.println("û���κμ�¼��");
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
						<td class="<%=tbclass%>"><%=impResultArr[i][16]%>&nbsp;</td>
						<td class="<%=tbclass%>"><%=impResultArr[i][0]%>&nbsp;</td>
						<td class="<%=tbclass%>"><%=impResultArr[i][12]%>&nbsp;</td>
						<td class="<%=tbclass%>"><%=impResultArr[i][2]%>&nbsp;</td>
						<td class="<%=tbclass%>"><%=impResultArr[i][6]%>&nbsp;</td>
						<td class="<%=tbclass%>"><%=impResultArr[i][7]%>&nbsp;</td>
						<td class="<%=tbclass%>"><%=impResultArr[i][8]%>&nbsp;</td>
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
						�ܼ�¼����<font name="totalPertain" id="totalPertain"><%=impResultArr.length%></font>&nbsp;&nbsp;
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
	<div id="Operation_Table"> 
		<div class="title">
			<div id="title_zi">��ϸ��Ϣ</div>
		</div>
		<div style="overflow-x:hidden; overflow-y:auto;height:160px;">
		<table>
			<tr>
				<td class="blue" width="15%">����ģ������</td>
				<td id="msgName" width="35%"></td>
				<td class="blue" width="15%">��ʾ����</td>
				<td id="promptType"></td>
			</tr>
			<tr>
				<td class="blue">��ʾ���</td>
				<td id="promptSeq"></td>
				<td class="blue">������������</td>
				<td id="releaseAction"></td>
			</tr>
			<tr>
				<td class="blue">���Ų�������</td>
				<td colspan="3" id="promptContent"></td>
			</tr>
			<tr>
				<td class="blue">����/�޸Ĺ���</td>
				<td id="confirmLoginNo"></td>
				<td class="blue">����/�޸�ʱ��</td>
				<td id="confirmTime"></td>
			</tr>
			<tr>
				<td class="blue">����/�޸���ˮ</td>
				<td id="confirmAccept"></td>
				<td class="blue">��Ч��־</td>
				<td id="validFlag"></td>
			</tr>
			<tr>
				<td class="blue">��Чʱ��</td>
				<td id="validTime"></td>
				<td class="blue">ʧЧʱ��</td>
				<td id="unvalidTime"></td>
			</tr>
			<tr>
				<td class="blue">��������</td>
				<td colspan="3" id="groupName"></td>
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