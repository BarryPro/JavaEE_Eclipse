<%
   /*
   * ����: ע�������ɾ��-���ݲ��������ѯ��Ϣ
�� * �汾: v3.0
�� * ����: 2008-10-10
�� * ����: zhanghonga
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
		<%@ page contentType="text/html;charset=Gb2312"%>
		<%@ include file="/npage/include/public_title_name.jsp" %>
		<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
		/**��Ҫ�������.�������ҳ��,��ɾ��**/
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
 		String opCode = "9608";
 		String opName = "ע�������ɾ��";

		/**��ҪregionCode���������·��**/
		String workNo = (String)session.getAttribute("workNo");
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode  = (String)session.getAttribute("regCode");
		String belongName = (String)session.getAttribute("orgCode");
		String groupId = (String)session.getAttribute("groupId");
		
		/** 
		 *@inparam	sFunctionCode	��ʾ��������
		 *@inparam	iBillType	Ʊ������
		 *@inparam	iPromptType	��ʾ����
		 *@inparam	iPromptSeq	��ʾ���
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
		paraArray1[1] = "01";			/**iChnSource    ������ʶ**/
		paraArray1[2] = opCode;			/**iOpCode       ��������**/
		paraArray1[3] = workNo;			/**iLoginNo      ����    **/
		paraArray1[4] = "";				/**iLoginPwd     ��������**/
		paraArray1[5] = "";				/**iPhoneNo      �ƶ�����**/
		paraArray1[6] = "";				/**iUserPwd      ��������**/
		paraArray1[7] = sFunctionCode;	/**iFunctionCode ��Ҫ����Ĳ�������**/
		paraArray1[8] = iBillType;		/**iBillType     Ʊ������          **/
		paraArray1[9] = iPromptType;	/**iPromptType   ��ʾ����          **/
		paraArray1[10] = iPromptSeq;	/**iPromptSeq    ��ʾ���          **/
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
			System.out.println("$$$$$$$$$$$$$ ningnt ����s9608Qry1�ɹ�  " + code1 + " | " + msg1);
			System.out.println("$$$$$$$$$$$$$ ningnt $$$$  " + result_t.length);
			sVerifyTypeArr = result_t;
		}else{
			System.out.println("$$$$$$$$$$$$$ ningnt ����s9608Qry1ʧ��  " + code1 + " | " + msg1);
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
						
						//Ӧ�ͻ�Ҫ��,��ѡ����һ����ˮ֮��,��Ҫ����Щ�����û�
						parent.document.all.sFunctionCode.value=impArr[0];
						parent.document.all.sFunctionCode.disabled = true;
						
						parent.document.all.iBillType.value=impArr[1];
						parent.document.all.iBillType.disabled = true;
						
						parent.document.all.iPromptType.value=impArr[2];
						parent.document.all.iPromptType.disabled = true;
						
						parent.document.all.iPromptSeq.value=impArr[3];
						parent.document.all.iPromptSeq.disabled = true;
						
						//���ύ��ť����Ϊ����
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
				<th nowrap>ѡ��</th>
				<th nowrap>��������</th>
				<th nowrap>Ʊ������</th> 
				<th nowrap>��ʾ����</th>
				<th nowrap>��ʾ���</th> 
				<th nowrap>��ʾ����</th>
				<th nowrap>�Ƿ��ӡ</th> 
				<th nowrap>��Ч��־</th>
				<th nowrap>��������</th>
				<th nowrap>��������</th> 		
				<th nowrap>����ʱ��</th>
				<th nowrap>������ˮ</th> 		
			</tr> 
	<%
			int nowPage = 1;
			int allPage = 0;
			if(sVerifyTypeArr.length==0){
				out.println("<tr height='25' align='center'><td colspan='11'>");
				out.println("û���κμ�¼��");
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
				�ܼ�¼����<font name="totalPertain" id="totalPertain"><%=sVerifyTypeArr.length%></font>&nbsp;&nbsp;
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
	<table cellspacing="0">
		<tr>
			<td width="14%" class="blue" nowrap>��ѡ��������</td>
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
				parent.document.all.qryOprInfoFrame.style.height = window.document.body.scrollHeight
			}
		}
	}
</script>
</html>    

