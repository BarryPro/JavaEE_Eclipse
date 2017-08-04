<%
/********************
 version v2.0
开发商: si-tech
作者: dujl
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
		String op_code=request.getParameter("opcode");
		String opName="无线音乐0元包月绑定配置";
		
		String paraAray[] = new String[8];
					
		paraAray[0] = work_no;
		paraAray[1] = request.getParameter("opCode");
		paraAray[2] = request.getParameter("opType");
		paraAray[3] = request.getParameter("region_code");
		
		if(paraAray[2].equals("a")){
			paraAray[4] = request.getParameter("mode_code");
			paraAray[5] = request.getParameter("g3Mode");
			paraAray[6] = request.getParameter("opNote");
			paraAray[7] = request.getParameter("ctrlCode");
		
		}else if(paraAray[2].equals("d")){
			paraAray[4] = request.getParameter("mode_code1");
			paraAray[5] = request.getParameter("g3Mode1");
			paraAray[6] = request.getParameter("opNote1");
			paraAray[7] = request.getParameter("ctrlCode");
		
		}
		
%>	

      	<wtc:service name="s2069Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="2" >
			   <wtc:params value="<%=paraAray%>"/>
		</wtc:service>
		<wtc:array id="result1" scope="end" />
<%

		if(errCode.equals("0")||errCode.equals("000000")){
		System.out.println("调用服务s2069Cfm in f2069_1.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
%> 
		<script language="JavaScript">
			rdShowMessageDialog("操作成功!");
			window.location="f2069_1.jsp?opCode=<%=op_code%>";
		</script>
<%
 	        		        	
     	}else{
 			System.out.println("调用服务s2069Cfm in f2069Cfm.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
 			System.out.println(errCode+"   errCode    "+errMsg+"    errMsg");
%>   
			<script language="JavaScript">
				rdShowMessageDialog("操作失败!<%=errMsg%>");
				window.location="f2069_1.jsp?opCode=<%=op_code%>";
			</script>
<%	
		}
%>

