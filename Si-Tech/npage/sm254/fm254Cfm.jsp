<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  String workNo = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");

  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
  
  
  String loginAccept = request.getParameter("loginAccept");
  String opflag = WtcUtil.repNull(request.getParameter("opflag"));  
  String iccidhao = WtcUtil.repNull(request.getParameter("iccidhao"));
  String isgua = WtcUtil.repNull(request.getParameter("isgua"));
  String isyouji = WtcUtil.repNull(request.getParameter("isyouji"));
  String oldbegin = WtcUtil.repNull(request.getParameter("oldbegin"));
  String oldend = WtcUtil.repNull(request.getParameter("oldend"));
  
  String opnotess=workNo+"进行外省有价卡登记操作";
  String phone_no = WtcUtil.repNull(request.getParameter("phone_no"));
  String custnames = WtcUtil.repNull(request.getParameter("custnames"));
  String duiduansheng = WtcUtil.repNull(request.getParameter("duiduansheng"));
  String tousudanhao = WtcUtil.repNull(request.getParameter("tousudanhao"));
  String danzhangmiane = WtcUtil.repNull(request.getParameter("danzhangmiane"));
  String infilling_number = WtcUtil.repNull(request.getParameter("infilling_number"));
  String lisankahao = WtcUtil.repNull(request.getParameter("lisankahao"));
  String lisanjine = WtcUtil.repNull(request.getParameter("lisanjine"));
  String kami = WtcUtil.repNull(request.getParameter("kami"));

	String  inputParsm [] = new String[20];
	inputParsm[0] = loginAccept;
	inputParsm[1] = "01";
	inputParsm[2] = opCode;
	inputParsm[3] = workNo;
	inputParsm[4] = password;
	inputParsm[5] = phone_no;
	inputParsm[6] = "";
	inputParsm[7] = opnotess;
	inputParsm[8] = opflag;
	inputParsm[9] = custnames;
	inputParsm[10] = iccidhao;
	inputParsm[11] = isgua;
	inputParsm[12] = isyouji;
	inputParsm[13] = duiduansheng;
	inputParsm[14] = tousudanhao;
	if(opflag.equals("1")) {
	inputParsm[15] = oldbegin;
	inputParsm[16] = oldend;	
	inputParsm[17] = danzhangmiane;
  }else {
  inputParsm[15] = lisankahao;
	inputParsm[16] = "";	
	inputParsm[17] = lisanjine;
	}
	inputParsm[18] = infilling_number;
	inputParsm[19] = kami;

		


	
%>
	<wtc:service name="sM254Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1">
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
			<wtc:param value="<%=inputParsm[13]%>"/>
			<wtc:param value="<%=inputParsm[14]%>"/>
			<wtc:param value="<%=inputParsm[15]%>"/>
			<wtc:param value="<%=inputParsm[16]%>"/>
			<wtc:param value="<%=inputParsm[17]%>"/>
			<wtc:param value="<%=inputParsm[18]%>"/>
			<wtc:param value="<%=inputParsm[19]%>"/>
	</wtc:service>
	<wtc:array id="ret" scope="end"/>
<%
	if("000000".equals(retCode)){
	
%>	
    <script language="javascript">
 	      rdShowMessageDialog("外省有价卡登记成功！",2);
 	      window.location="fm254.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
<%}else{

%>
  	<script language="javascript">
 	    rdShowMessageDialog("外省有价卡登记失败！错误代码：<%=retCode%> ，错误信息：<%=retMsg%>",0);
 		  window.location="fm254.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
<%
	}
%>
