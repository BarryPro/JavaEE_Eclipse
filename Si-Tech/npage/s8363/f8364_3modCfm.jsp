<%
/********************
version v1.0
开发商: si-tech
作者: gaolw
日期: 2009/12/24
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
	  String iLoginAccept = request.getParameter("iLoginAccept");
	  String iChnSource = "01";
	  String iOpCode = request.getParameter("opCode");
		String iLoginNo = (String)session.getAttribute("workNo");
		String iLoginPwd = (String)session.getAttribute("password");
		String iPhoneNo = "";
		String iUserPwd = "";
		String loginNoStr = request.getParameter("loginNo");
		String opCodeStr = request.getParameter("opCodeAdd");
		String limitValueStr = request.getParameter("limitValue");
		String opCount = "";
		String opType = "U";

		
		String orgCode =(String)session.getAttribute("orgCode");
		String regionCode = orgCode.substring(0,2);
		
		String paramsIn[] = new String[12];
		paramsIn[0]  = iLoginAccept;
		paramsIn[1]  = iChnSource;
		paramsIn[2]  = iOpCode;
		paramsIn[3]  = iLoginNo;
		paramsIn[4]  = iLoginPwd;
		paramsIn[5]  = iPhoneNo;
		paramsIn[6]  = iUserPwd;
		paramsIn[7]  = loginNoStr;
		paramsIn[8]  = opCodeStr;
		paramsIn[9]  = limitValueStr;
		paramsIn[10]  = opCount;
		paramsIn[11]  = opType;
		
		for(int i = 0 ; i <paramsIn.length ; i ++){
			System.out.println("paramsIn["+i+"]=======:"+paramsIn[i]);
		}
%>	

      <wtc:service name="s8364Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="2" >
			   <wtc:param value="<%=paramsIn[0]%>"/>
			   <wtc:param value="<%=paramsIn[1]%>"/>
			   <wtc:param value="<%=paramsIn[2]%>"/>
			   <wtc:param value="<%=paramsIn[3]%>"/>
			   <wtc:param value="<%=paramsIn[4]%>"/>
			   <wtc:param value="<%=paramsIn[5]%>"/>
			   <wtc:param value="<%=paramsIn[6]%>"/>
			   <wtc:param value="<%=paramsIn[7]%>"/>
			   <wtc:param value="<%=paramsIn[8]%>"/>
			   <wtc:param value="<%=paramsIn[9]%>"/>
			   <wtc:param value="<%=paramsIn[10]%>"/>
			   <wtc:param value="<%=paramsIn[11]%>"/>
			</wtc:service>
			<wtc:array id="result" scope="end" />
<%
	    if(errCode.equals("0")||errCode.equals("000000")){
      	System.out.println("调用服务s8364Cfm in f8364_3modCfm.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
%> 
	      <script language="JavaScript">
					rdShowMessageDialog("操作成功!",2);
					window.location="f8364_3.jsp?opCode=<%=iOpCode%>&loginNo=<%=loginNoStr%>";
				</script>
<%     		        	
 	    }else{
	 			System.out.println("调用服务s8364Cfm in f8364_3modCfm.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
	 			System.out.println(errCode+"   errCode    "+errMsg+"    errMsg");
%>   
				<script language="JavaScript">
					rdShowMessageDialog("操作失败!<%=errMsg%>");
					window.location="f8364_3.jsp?opCode=<%=iOpCode%>&loginNo=<%=loginNoStr%>";
				</script>
<%	
 			}
%>

