<%
/********************
 * version v2.0
 * ������: si-tech
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		System.out.println("============ fd564_qry.jsp ==========");
		String workNo = (String)session.getAttribute("workNo");
		
		String password = (String)session.getAttribute("password");		
		String regionCode= (String)session.getAttribute("regCode");
		String groupId= (String)session.getAttribute("groupId");
		
		String phoneNo 	= request.getParameter("phoneNo");
		
		String idCardNo = request.getParameter("idCardNo");
		String orderNo = request.getParameter("orderNo");
		String startTime = request.getParameter("startTime");
		String endTime 	= request.getParameter("endTime");
		String opCode 	= request.getParameter("opCode");		
		String  inputParsm [] = new String[13];
		inputParsm[0] = "";  //��ˮ
		inputParsm[1] = "01"; //������ʶ 
		inputParsm[2] = opCode; //�������� 
		inputParsm[3] = workNo; //����  
		inputParsm[4] = password; //�������� 
		inputParsm[5] = phoneNo; //�ֻ����� 
		inputParsm[6] = "";      //�ֻ����� 
		inputParsm[7] = "";  //��ע 
		inputParsm[8] = orderNo; //������ 
		inputParsm[9] = idCardNo; //���֤��
		inputParsm[10] = startTime; //��ʼʱ�� 
		inputParsm[11] = endTime; //����ʱ�� 
		inputParsm[12] = "";//�ͻ�����
%>
		<wtc:service name="sD564Qry" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="12">
				<wtc:param value="<%=inputParsm[0]%>"/>
				<wtc:param value="<%=inputParsm[1]%>"/>
				<wtc:param value="<%=inputParsm[2]%>"/>
				<wtc:param value="<%=inputParsm[3]%>"/>
				<wtc:param value="<%=inputParsm[4]%>"/>
				<wtc:param value="<%=inputParsm[5]%>"/>
				<wtc:param value="<%=inputParsm[6]%>"/>
				<wtc:param value="<%=inputParsm[7]%>"/>
				<wtc:param value="<%=inputParsm[8]%>"/>
				<wtc:param value="<%=inputParsm[9]%>"/>
				<wtc:param value="<%=inputParsm[10]%>"/>
				<wtc:param value="<%=inputParsm[11]%>"/>		
				<wtc:param value="<%=inputParsm[12]%>"/>								
		</wtc:service>
		<wtc:array id="ret" scope="end"/>
<%
		if("000000".equals(retCode)){
			System.out.println("============ fd564_qry.jsp ==========" + ret.length);
			
		}else{
%>
			<script language="javascript">
	      rdShowMessageDialog("������Ϣ��<%=retMsg%><br>������룺<%=retCode%>", 0);
	   	</script>
<%
		}
%>
<body>
<form name="frm1">
  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">����ԤԼѡ����Ϣ��ѯ�б�</div>
			</div>
			<table cellspacing="0" name="t1" id="t1">
				<tr>
					<th>�ֻ�����</th>
					<th>�ͻ�����</th>
					<th>���֤��</th>
					<th>������</th>
					<th>��վ����ʱ��</th>
					<th>ԤԼӪҵ��</th>
					<th>����״̬</th>
					<th>ҵ������</th>
				</tr>
<%
				int nowPage = 1;
				int allPage = 0;
				if(ret.length==0){
					out.println("<tr height='25' align='center'><td colspan='15'>");
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
						<td class="<%=tbclass%>"><%=ret[i][8]%></td>
						<%
						if(ret[i][4]!="" && ret[i][4]!=null)
						{
						%>						
							<td class="<%=tbclass%>"><%=new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss", Locale.getDefault()).format(new java.text.SimpleDateFormat("yyyyMMddHHmmss").parse(ret[i][4]))%></td>						
						<%
						}else{
						
						%>
							<td class="<%=tbclass%>"><%=ret[i][4]%></td>			
						<%
						}
						%>										
						<td class="<%=tbclass%>"><%=ret[i][5]%></td>
						<td class="<%=tbclass%>"><%=ret[i][11]%></td>
						<td class="<%=tbclass%>"><%=ret[i][9]%></td>
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
      	
