<%
    /********************
    * 功  能: 手机支付主账户现金充值冲正 9995
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: dujl
    * update：diling@2011/11/2 手机支付主账户充值冲正功能完善需求
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
		String opName="手机支付主账户充值冲正";
		
		String loginAccept = request.getParameter("operateAccept"); //旧流水
		String printAccept = request.getParameter("printAccept"); //新生成流水
		
		String phoneNo = request.getParameter("phoneNo");
		
		String sql_payEd = "select pay_ed from sphonepaymsg where login_accept = '"+loginAccept+"'";
%>

      
        
        <wtc:pubselect name="sPubSelect"  routerKey="regionCode" routerValue="<%=regionCode%>" outnum="1" retcode="retCode" retmsg="retMsg">
            <wtc:sql><%=sql_payEd%></wtc:sql>
        </wtc:pubselect>
        <wtc:array id="payEdResult" scope="end" />
<%
        if(!"000000".equals(retCode)){
%>
            <script language=javascript>
	          rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
	          window.location="f9995_main.jsp?opCode=<%=op_code%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
	        </script>
<%
        }else{
    		String payEd = payEdResult[0][0];  //冲正金额
    		System.out.println("-------9995Cfm--------payEd="+payEd);
    		String paraAray[] = new String[8];
    		paraAray[0] = work_no;
    		paraAray[1] = op_code;
    		paraAray[2] = phoneNo;
    		paraAray[3] = payEd;
    		paraAray[4] = loginAccept; 
    		paraAray[5] = pass;
    		paraAray[6] = orgCode;
    		paraAray[7] = printAccept; 
    		
    		System.out.println("-------s9995Cfm--------paraAray[0]="+paraAray[0]);
    		System.out.println("-------s9995Cfm--------paraAray[1]="+paraAray[1]);
    		System.out.println("-------s9995Cfm--------paraAray[2]="+paraAray[2]);
    		System.out.println("-------s9995Cfm--------paraAray[3]="+paraAray[3]);
    		System.out.println("-------s9995Cfm--------paraAray[4]="+paraAray[4]);
    		System.out.println("-------s9995Cfm--------paraAray[5]="+paraAray[5]);
    		System.out.println("-------s9995Cfm--------paraAray[6]="+paraAray[6]);
    		System.out.println("-------s9995Cfm--------paraAray[7]="+paraAray[7]);
		
%>

	<wtc:service name="s9995Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="2" >
    	<wtc:param value="<%=paraAray[0]%>"/>
    	<wtc:param value="<%=paraAray[1]%>"/>
    	<wtc:param value="<%=paraAray[2]%>"/>
    	<wtc:param value="<%=paraAray[3]%>"/>
    	<wtc:param value="<%=paraAray[4]%>"/>
    	<wtc:param value="<%=paraAray[5]%>"/>
    	<wtc:param value="<%=paraAray[6]%>"/>  
    	<wtc:param value="<%=paraAray[7]%>"/>  
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<%

	      if(errCode.equals("0")||errCode.equals("000000")){
          	System.out.println("调用服务s9995Cfm in f9995Cfm.jsp 成功---------------------------");
%> 
          <script language="JavaScript">
							rdShowMessageDialog("操作成功!");
							window.location="f9995_main.jsp?opCode=<%=op_code%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
						</script>
<%
 	        		        	
 	     	}else{
			 			System.out.println("调用服务s9995Cfm in f9995Cfm.jsp 失败-------------------------");
			 			System.out.println(errCode+"   errCode    "+errMsg+"    errMsg");
%>   
						<script language="JavaScript">
							rdShowMessageDialog("<%=errCode%><%=errMsg%>");
							window.location="f9995_main.jsp?opCode=<%=op_code%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
						</script>
<%	
 			}
 	}
%>

