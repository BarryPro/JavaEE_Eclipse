<%
/********************
 version v2.0
开发商: si-tech
作者: gaolw
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
	
		String work_no =(String)session.getAttribute("workNo");
		String work_name =(String)session.getAttribute("workName");
		String orgCode =(String)session.getAttribute("orgCode");
		String regionCode = orgCode.substring(0,2);
		String ip_Addr =(String)session.getAttribute("ip_Addr");
		String pass = (String)session.getAttribute("password");
		String op_code=request.getParameter("opCode");
		String opName="非实名用户备用客户信息配置";
		
		String paraAray[] = new String[16];
					
		paraAray[0] = work_no;
		paraAray[1] = op_code;
		paraAray[2] = request.getParameter("opType");
		//System.out.println("paraAray[2]========="+paraAray[2]);
	
		if(paraAray[2].equals("A"))
		{ 
			paraAray[3] = request.getParameter("tPhoneNo");
			paraAray[4] = "";
			paraAray[5] = request.getParameter("idNo");
			paraAray[6] = request.getParameter("custId");
			paraAray[7] = request.getParameter("tCustName1");
			paraAray[8] = request.getParameter("idType");
			paraAray[9] = request.getParameter("idIccid");
			paraAray[10] = request.getParameter("tContactPhone");
			paraAray[11] = request.getParameter("contactMail");
			paraAray[12] = request.getParameter("tContactAddr");
			String temp[] = paraAray[8].split("\\|");
			paraAray[13] = temp[0];
			paraAray[14] = request.getParameter("vLoginAccept");
			paraAray[15] = orgCode;
		}else if(paraAray[2].equals("U"))
		{
			paraAray[3] = "";
			paraAray[4] = request.getParameter("tPhoneNo1");
		  paraAray[5] = request.getParameter("idNo");
			paraAray[6] = "";
			paraAray[7] = request.getParameter("tCustName1");
			paraAray[8] = request.getParameter("idType");
			paraAray[9] = request.getParameter("idIccid");
			paraAray[10] = request.getParameter("tContactPhone");
			paraAray[11] = request.getParameter("contactMail");
			paraAray[12] = request.getParameter("tContactAddr");
			String temp[] = paraAray[8].split("\\|");
			paraAray[13] = temp[0];
			paraAray[14] = request.getParameter("vLoginAccept");
			paraAray[15] = orgCode;
		}
		
%>	

      <wtc:service name="s6839Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="2" >
			   <wtc:params value="<%=paraAray%>"/>
			</wtc:service>
			<wtc:array id="result" scope="end" />
<%
	    if(errCode.equals("0")||errCode.equals("000000")){
      	System.out.println("调用服务s6839Cfm in f6839Cfm.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
%> 
        <script language="JavaScript">
					rdShowMessageDialog("操作成功!");
					window.location="f6839_1.jsp?opCode=<%=op_code%>";
				</script>
<%     		        	
 	    }else{
	 			System.out.println("调用服务s6839Cfm in f6839Cfm.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
	 			System.out.println(errCode+"   errCode    "+errMsg+"    errMsg");
%>   
				<script language="JavaScript">
					rdShowMessageDialog("操作失败!<%=errMsg%>");
					window.location="f6839_1.jsp?opCode=<%=op_code%>";
				</script>
<%	
 			}
%>

