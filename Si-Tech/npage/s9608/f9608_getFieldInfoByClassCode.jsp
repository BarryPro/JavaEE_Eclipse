<%
   /*
   * ����: ע�������ɾ��-���ݴ����ѯ��Ϣ
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
		String groupId = (String)session.getAttribute("groupId");
		/** 
		 *@inparam	iBillType	Ʊ������
		 *@inparam	iClassCode	����
		 *@inparam	sClassValue	�ֶ���ֵ
		 *@inparam	iPromptType	��ʾ����
		 *@inparam	iPromptSeq	��ʾ���
		 **/
		String iClassCode = WtcUtil.repNull(request.getParameter("iClassCode"));
		String sClassValue = WtcUtil.repNull(request.getParameter("sClassValue"));
		String iBillType = WtcUtil.repNull(request.getParameter("iBillType2"));		
		String iPromptType = WtcUtil.repNull(request.getParameter("iPromptType2"));		
		String iPromptSeq = WtcUtil.repNull(request.getParameter("iPromptSeq2"));	
		String sFunctionCode = WtcUtil.repNull(request.getParameter("sFunctionCode2"));	
		String [][]sVerifyTypeArr = new String[][]{};		
		String[] paraArray1 = new String[13];
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
		paraArray1[3] = workNo;			/**iLoginNo      ����       		**/         
		paraArray1[4] = "";				/**iLoginPwd     ��������      		**/    
		paraArray1[5] = "";				/**iPhoneNo      �ƶ�����         	**/   
		paraArray1[6] = "";				/**iUserPwd      ��������            **/  
		paraArray1[7] = iClassCode;		/**iClassCode    ����                **/
		paraArray1[8] = sClassValue;	/**iClassValue   �ֶ���ֵ            **/
		paraArray1[9] = sFunctionCode;	/**iFunctionCode ��Ҫ����Ĳ�������  **/
		paraArray1[10] = iBillType;		/**iBillType     Ʊ������            **/
	    paraArray1[11] = iPromptType;	/**iPromptType   ��ʾ����            **/
	    paraArray1[12] = iPromptSeq;    /**iPromptSeq    ��ʾ���            **/
	    for(int ii = 0; ii < paraArray1.length; ii++){
	    	System.out.println("$$$$$$$ ningtn $$$$$$ " + ii + " | " + paraArray1[ii]);
	    }
%>
			<wtc:service name="s9608Qry2" outnum="22" retmsg="msg1" retcode="code1" 
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
				<wtc:param value="<%=paraArray1[12]%>" />
			</wtc:service>
			<wtc:array id="result_t" scope="end"  />
<%
			if("000000".equals(code1)){
				System.out.println("$$$$$$$$$$$$$ ningnt ����s9607Qry1�ɹ�  " + code1 + " | " + msg1);
				System.out.println("$$$$$$$$$$$$$ ningnt $$$$  " + result_t.length);
				sVerifyTypeArr = result_t;
			}else{
				System.out.println("$$$$$$$$$$$$$ ningnt ����s9607Qry1ʧ��  " + code1 + " | " + msg1);
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
		<!--
			function doChange(){
				var regionRadios = document.getElementsByName("regionRadio");	
				for(var i=0;i<regionRadios.length;i++){
					if(regionRadios[i].checked){
						var impValue = regionRadios[i].value;
						var impArr = impValue.split("|");
						
						//Ӧ�ͻ�Ҫ��,��ѡ����һ����ˮ֮��,��Ҫ����Щ�����û�
						parent.document.all.iClassCode.value=impArr[0];
						parent.document.all.iClassCode.disabled = true;
						
						parent.document.all.iClassName.value=impArr[1];
						parent.document.all.iClassName.disabled = true;
						
						parent.document.all.sFunctionCode2.value=impArr[2];
						parent.document.all.sFunctionCode2.disabled = true;
						
						parent.document.all.sClassValue.value=impArr[3];
						parent.document.all.sClassValue.disabled = true;
						
						parent.document.all.iPromptSeq2.value=impArr[4];
						parent.document.all.iPromptSeq2.disabled = true;
						
						parent.document.all.iPromptType2.value=impArr[5];
						parent.document.all.iPromptType2.disabled = true;
						
						parent.document.all.iBillType2.value=impArr[6];
						parent.document.all.iBillType2.disabled = true;
						
						//���ύ��ť����Ϊ����
						parent.document.all.confirmButton.disabled=false;
						
						var createLoginNo = impArr[7];
						document.sAuditLoginInfoFrame2.location.href = "f9608_getAuditLoginInfoField.jsp?createLoginNo="+createLoginNo;
					}
				}
			}
		//-->
	</script>
</head>
<body>
	<div id="Operation_Table">
     <table cellspacing="0">
			<tr height=25 align="center">
				<th nowrap>ѡ��</th>
				<th nowrap>��������</th>
				<th nowrap>Ʊ������</th> 
				<th nowrap>��ʾ����</th>
				<th nowrap>��ʾ���</th>
				<th nowrap>�ֶ�������</th> 
				<th nowrap>�ֶ���ֵ</th>
				<th nowrap>���˳��</th> 
				<th nowrap>��ʾ����</th> 		
				<th nowrap>��Ч��־</th>
				<th nowrap>��ӡѡ��</th>
				<th nowrap>��������</th> 		 		
				<th nowrap>��������</th> 		
				<th nowrap>����ʱ��</th> 		
				<th nowrap>������ˮ</th> 		
			</tr> 
	<%
			int nowPage = 1;
			int allPage = 0;
			if(sVerifyTypeArr.length==0){
				out.println("<tr height='25' align='center'><td colspan='20'>");
				out.println("û���κμ�¼��");
				out.println("</td></tr>");
			}else if(sVerifyTypeArr.length>0){
				String tbclass = "";
				for(int i=0;i<sVerifyTypeArr.length;i++){
				System.out.println(" $$ ningtn $$$$$ " + i + "  -> " + sVerifyTypeArr[i][0]);
						tbclass = (i%2==0)?"Grey":"";
	%>
						<tr align="center" id="row_<%=i%>">
							<td class="<%=tbclass%>">
								<input type="radio" name="regionRadio" value="<%=sVerifyTypeArr[i][17]%>|<%=sVerifyTypeArr[i][4]%>|<%=sVerifyTypeArr[i][20]%>|<%=sVerifyTypeArr[i][5]%>|<%=sVerifyTypeArr[i][3]%>|<%=sVerifyTypeArr[i][18]%>|<%=sVerifyTypeArr[i][19]%>|<%=sVerifyTypeArr[i][10]%>" onclick="doChange()">	
							</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][0]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][1]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][2]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][3]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][4]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][5]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][6]%>&nbsp;</td>
							<td style="word-break:break-all" class="<%=tbclass%>"><%=sVerifyTypeArr[i][7]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][8]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][9]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][21]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][10]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][11]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][12]%>&nbsp;</td>
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
				<iframe src="" id="sAuditLoginInfoFrame2"  name="sAuditLoginInfoFrame2"  width=100% scrolling=no frameborder=0 noresize></iframe>
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
				parent.document.all.qryFieldInfoFrame.style.height = window.document.body.scrollHeight
			}
		}
	}
</script>
</html>