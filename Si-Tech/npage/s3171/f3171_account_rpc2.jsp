<%
/********************
 version v2.0
开发商: si-tech
update:anln@2009-02-18 页面改造,修改样式
********************/
%>
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	String regionCode= (String)session.getAttribute("regCode");
	System.out.println("111111111111111");	
	String contractPay2 = request.getParameter("contractPay2");	
	String num="";
	
    	//SPubCallSvrImpl impl = new SPubCallSvrImpl();	
	//String sqlStr = "select count(*) from dconmsg where account_type in ('0','1') and contract_no not in (select contract_no from dconconmsg) and contract_no='" + contractPay2+"'";
	/*
	String sqlStr = "  SELECT COUNT(*) "
					+"  FROM   DCONMSG "
					+"  WHERE  ACCOUNT_TYPE IN ('0', '1') "
					+"  AND    CONTRACT_NO NOT exists "
					+"  	     (SELECT CONTRACT_NO "
					+"  		   FROM   DCONCONMSG A1 "
					+"  		   WHERE  not exists "
					+"  			  	  (SELECT A11.ACCOUNT_ID "
					+"  				   FROM   DGRPUSERMSG A11 "
					+"  				   WHERE  A11.SM_CODE = 'hl')) "
					+"    AND    CONTRACT_NO = '"+contractPay2+"'";	
	*/
	String sqlStr = "  SELECT COUNT(*)  "
					+" FROM   DCONMSG A                                                      "  
					+" WHERE  (NOT EXISTS													 "  
					+" 		(SELECT 1  "
					+" 		 FROM   DCONCONMSG C "  
					+" 		 WHERE  A.CONTRACT_NO = C.CONTRACT_NO "  
					+" 		 AND    TO_DATE(C.END_DATE, 'yyyymmdd') > SYSDATE) OR EXISTS "  
					+" 		(SELECT 1 "  
					+" 		 FROM   DGRPUSERMSG B "  
					+" 		 WHERE  A.CONTRACT_NO = B.ACCOUNT_ID          "  
					+" 		 AND    B.SM_CODE = 'hl')) "  
					+"	AND    A.CONTRACT_NO = '"+contractPay2+"' "  ;
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
		<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result1" scope="end" />
<%	
	//retArray = impl.sPubSelect("1",sqlStr);	
	String errCode=retCode1;
	String errMsg=retMsg1;
	System.out.println("sqlStr:"+sqlStr);			
	if(errCode.equals("000000"))
	{
		//String[][] result1 = (String[][])retArray.get(0);
		if(result1!=null&&result1.length>0){
			num = result1[0][0];
		}
	}
		
			
%>    
	var response = new AJAXPacket();	
	response.data.add("retFlag","2");
	response.data.add("num","<%=num%>");
	response.data.add("errCode","<%=errCode%>");
	response.data.add("errMsg","<%=errMsg%>");
	core.ajax.receivePacket(response);