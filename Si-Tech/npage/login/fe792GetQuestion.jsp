<%
  /* *********************
   * ����: ���������һ�
   * �汾: 1.0
   * ����: 2012-4-25 15:20:41
   * ����: ningtn
   * ��Ȩ: si-tech
   * *********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String workNo = request.getParameter("workNo");
	String[] inParamsStr = new String[2];
	inParamsStr[0] = "select count(1)  from wPwdQuestion  where login_no=:workNo";
	inParamsStr[1] = "workNo="+workNo;
%>
<wtc:service name="TlsPubSelCrm" retcode="code" retmsg="msg" outnum="1">
									<wtc:param value="<%=inParamsStr[0]%>"/>
									<wtc:param value="<%=inParamsStr[1]%>"/>
</wtc:service>
<wtc:array id="countQuestion"  scope="end"/>
<%
System.out.println("countQuestion[0][0]=="+countQuestion[0][0]);
/*�������û�����������������ʾ ����չʾ����*/
if(!(countQuestion[0][0].equals("0")))
{
		/*����û��½�أ�Ҳû��region��û����·����*/
		String getQuestionSql = "SELECT   question_id, question_desc "+
							" FROM spwdquestion "+
							" WHERE TRIM (func_type) = '1' AND isshow = 'Y' "+
							" ORDER BY question_id ";
		String strArray = "var arrMsg; ";
		System.out.println("countQuestion[0][0]=="+getQuestionSql);
		%>
				<wtc:pubselect name="sPubSelect" outnum="2" 
							retcode="retCode" retmsg="retMsg" >
					<wtc:sql><%=getQuestionSql%></wtc:sql>
				</wtc:pubselect>
				<wtc:array id="questionResult" scope="end"/>
		<%
			if(retCode.equals("000000")){
				strArray = WtcUtil.createArray("arrMsg",questionResult.length);
			}
		%>
		<%=strArray%>
		<%
			for(int i = 0 ; i < questionResult.length ; i ++){
				for(int j = 0 ; j < questionResult[i].length ; j ++){
		%>
				arrMsg[<%=i%>][<%=j%>] = "<%=questionResult[i][j].trim()%>";
		<%
				}
			}
		%>
			var response = new AJAXPacket();
		
			response.data.add("retCode","<%=retCode%>");
			response.data.add("retmsg","<%=retMsg%>");
			response.data.add("result",arrMsg);
			core.ajax.receivePacket(response);
<%			
}else{
%>	
			var response = new AJAXPacket();
		
			response.data.add("retCode","-1");
			response.data.add("retmsg","�ù���δ���������һ�����");
			response.data.add("result","");
			core.ajax.receivePacket(response);
<%			
}
%>