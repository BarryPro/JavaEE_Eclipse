<%
   /*
   * ����: ע��������޸�-���ݲ��������ѯ��Ϣ
�� * �汾: v3.0
�� * ����: 2008-10-10
�� * ����: zhanghonga
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸����� 2011-1-6 15:01:07     �޸���  ningtn    
   * �޸�Ŀ��	����ȡ��BOSSϵͳע������������޸ġ�ɾ���������Ƶĺ�
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
    
 		String opCode = "9607";
 		String opName = "ע��������޸�";

		/**��ҪregionCode���������·��**/
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode = (String)session.getAttribute("regCode");
		String groupId = (String)session.getAttribute("groupId");
		String workNo = (String)session.getAttribute("workNo");
		
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
		String Channels_Code = WtcUtil.repNull(request.getParameter("Channels_Code"));
		String rootDistance = WtcUtil.repNull(request.getParameter("rootDistance"));
		System.out.println("@#$%^&*(((((((((&)))))))))))))))))))==="+rootDistance);
		/**����һ���յ�ȫ������**/
		String [][]impResultArr = new String[][]{};		
		String[] paraArray1 = new String[12];
		/**1.�жϹ��ŵļ���,���root_distance==1,ʡ��,==2,����,>2,���ػ��߸�С�ļ���**/
		String checkSql = "select root_distance from dChnGroupMsg where group_id = '"+groupId+"'";
		System.out.println("#######checkSql->"+checkSql);
%>
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="1"> 
		<wtc:sql><%=checkSql%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="sVerifyTypeArr"  scope="end"/>
<%
		/**����loginRootDistance���жϹ���Ȩ������**/
		int loginRootDistance = 999999;
		if(retCode.equals("000000")){
			if(sVerifyTypeArr!=null&&sVerifyTypeArr.length>0){
				loginRootDistance = sVerifyTypeArr[0][0].equals("")?loginRootDistance:Integer.parseInt(sVerifyTypeArr[0][0]);
			}
		}
		/**������ŵļ�������ظ�С(Ӫҵ������),���ܽ����޸Ĳ���**/
		/*zhangyan add �ǿͷ�������ҪУ��*/
		String accountType=(String)session.getAttribute("accountType");
		System.out.println("9607 accountType="+accountType);
		if (!accountType.equals("2")  &&  loginRootDistance>3){
			%>
					<table cellspacing="0">
						<tr bgcolor='649ECC' height=25 align="center">
							<td>
								<font style="color:red">(�˹������޸�Ȩ��)</font>
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
			paraArray1[1] = "01";			/**iChnSource    ������ʶ**/
			paraArray1[2] = opCode;			/**iOpCode       ��������**/
			paraArray1[3] = workNo;			/**iLoginNo      ����    **/
			paraArray1[4] = "";				/**iLoginPwd     ��������**/
			paraArray1[5] = "";				/**iPhoneNo      �ƶ�����**/
			paraArray1[6] = "";				/**iUserPwd      ��������**/
			paraArray1[7] = sFunctionCode;	/**iFunctionCode ��Ҫ����Ĳ�������**/
			paraArray1[8] = iBillType;		/**iBillType     Ʊ������          **/
			paraArray1[9] = iPromptType;		/**iPromptType   ��ʾ����          **/
			paraArray1[10] = iPromptSeq;		/**iPromptSeq    ��ʾ���          **/
		    paraArray1[11] = Channels_Code ;	/**iChnCode      ��������          **/
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
				System.out.println("$$$$$$$$$$$$$ ningnt ����s9607Qry1�ɹ�  " + code1 + " | " + msg1);
				System.out.println("$$$$$$$$$$$$$ ningnt $$$$  " + result_t.length);
				impResultArr = result_t;
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
						
						//�������createLogin���ݸ���ҳ��,�����ж�:
						//�����������صļ���ʱ,������������Ÿ��޸��˹��űȶ�,
						//������,���޸ķ����;��Ϊ:�����˷�����޸�
						//��������,���޸ķ����;��Ϊ:�޸��߷�����޸�
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
				<th nowrap>ѡ��</th>
				<th nowrap>������ˮ</th>
				<!--
				<th nowrap>��������</th>
				<th nowrap>Ʊ������</th> 
				<th nowrap>��ʾ����</th>
				<th nowrap>��ʾ���</th> 
				<th nowrap>��Ч��־</th> 	
				-->
				<th nowrap>ģ������</th>
				<th nowrap>��ʾ����</th>	
				<th nowrap>��Ч��־</th>
				<th nowrap>Ʊ������</th>
				<th nowrap>��ʾ����</th>
				<th nowrap>��������</th>
				<th nowrap>��������</th> 		
				<th nowrap>����ʱ��</th>
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

