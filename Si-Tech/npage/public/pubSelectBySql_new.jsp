<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	/******
	������ѯҳ�棬ʹ�ð󶨱���
	��Σ�
	selectSql : ��ѯ���
	params : ����
	wtcOutNum : ���θ���
	*/
	System.out.println("============ ningtn pubSelectBySql.jsp ====");
	String regionCode= (String)session.getAttribute("regCode");
	String work_no = (String)session.getAttribute("workNo");
  String password = (String)session.getAttribute("password");
  
	String selectSql = WtcUtil.repNull(request.getParameter("selectSql"));
	
   System.out.println("----------sqlxf--------selectSql-------->"+selectSql);
	/* ���� */
	String param = WtcUtil.repNull(request.getParameter("params"));
  String [] params = param.split("\\|");
	/* ���θ��� */
	String wtcOutNum = WtcUtil.repNull(request.getParameter("wtcOutNum"));
	if("".equals(wtcOutNum)){
		wtcOutNum = "1";
	}
	/* ��¼�Ƿ�ɹ���־   1 = �ɹ�    0 = ʧ�� */
	int successFlag = 0;
	String strArray = "var arrMsg; ";
%>
 <wtc:service name="sCrmDefSqlSel" routerKey="region" routerValue="<%=regionCode%>" outnum="<%=wtcOutNum%>" retcode="retCode" retmsg="retMsg">
		  <wtc:param value="<%=selectSql%>"/>
		 <%
		 		for(int i=0;i<params.length;i++){
		 %>		
		 		 <wtc:param value="<%=params[i]%>"/>
		 	<%
		 		}
		 %>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
  System.out.println("============ ningtn pubSelectBySql.jsp  ====" + selectSql);
  System.out.println("============ ningtn pubSelectBySql.jsp  ====" + params);
	System.out.println("============ ningtn pubSelectBySql.jsp  ====" + retCode);
	if(!(retCode.equals("0") || retCode.equals("000000"))){
		successFlag = 0;
	}else{
		successFlag = 1;
		strArray = WtcUtil.createArray("arrMsg",result.length);
	}
%>
<%=strArray%>
<%
	if(successFlag == 1){
		for(int i = 0 ; i < result.length ; i ++){
      for(int j = 0 ; j < result[i].length ; j ++){
      	if(result[i][j].trim().equals("") || result[i][j] == null){
				   result[i][j] = "";
				}
	%>
				arrMsg[<%=i%>][<%=j%>] = "<%=result[i][j].trim()%>";
	<%
			}
		}
	}
	
	System.out.println("------hejwa----------retCode---------->"+retCode);
%>

	var response = new AJAXPacket();

	response.data.add("retcode","<%=retCode%>");
	response.data.add("retmsg","<%=retMsg%>");
	response.data.add("result",arrMsg);
	core.ajax.receivePacket(response);