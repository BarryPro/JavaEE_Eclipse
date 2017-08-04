<%
/********************
 version v2.0
开发商: si-tech
update:anln@2009-02-16 页面改造,修改样式
********************/
%>
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>


<%
		String regionCode = (String)session.getAttribute("regCode");
		 //得到输入参数
        
		//ArrayList str = new ArrayList();
		//String temp[][]=new String[][]{};
		String retCode = "000000";
		String retMessage="";
		String smCode="";
	    	//--------------------------
		String retType = request.getParameter("retType");
		String phoneNo = request.getParameter("phoneNo");
        	String org_code = request.getParameter("org_code"); 
		String opCode = request.getParameter("opCode"); 
		String loginNo = request.getParameter("loginNo"); 
		String opFlag = request.getParameter("opFlag");
	    	String serviceName = "s1249_Valid";
	try{
			System.out.println("-------queryRegister.jsp----------------");
			System.out.println("---retType---" + retType);
	   		System.out.println("---phoneNo---" + phoneNo);
			System.out.println("---org_code---" + org_code);
			System.out.println("---opCode---" + opCode);
			System.out.println("---loginNo---" + loginNo);
			System.out.println("----opFlag---" + opFlag);
			System.out.println("----serviceName--" + serviceName);

	   		String[] paraStrIn = new String[]{loginNo,phoneNo,opCode,org_code,opFlag};
	   		String outParaNums= "26";   
	   		//SPubCallSvrImpl callSvrImpl = new SPubCallSvrImpl();
	   		//str = callSvrImpl.callFXService(serviceName, paraStrIn, outParaNums);
	   	%>
	   		<wtc:service name="s1249_Valid" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="26" >				
				<wtc:param value="<%=loginNo%>"/>	
				<wtc:param value="<%=phoneNo%>"/>	
				<wtc:param value="<%=opCode%>"/>	
				<wtc:param value="<%=org_code%>"/>	
				<wtc:param value="<%=opFlag%>"/>		
			</wtc:service>			
			<wtc:array id="temp"  scope="end"/>
	
	   	<%
	   		if(temp!=null&&temp.length>0){
	       			retCode = temp[0][0];
	       			retMessage =temp[0][1];
       			}
	   		System.out.println("11111111111111111Register=");	  		
	   		//temp=(String[][])str.get(3);
	   		smCode=temp[0][3];
	   		System.out.println("smCode="+smCode); 	   
			System.out.println("------retCode-------" + retCode );
			System.out.println("------retMessage----" + retMessage);
			System.out.println("------smCode---"+smCode);
		
	   }catch(Exception e){
			
	   }
%>
var response = new AJAXPacket();
var retType = "<%=retType%>";
var retCode = "<%=retCode%>";
var retMessage = "<%=retMessage%>";
var smCode="<%=smCode%>";
response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("smCode",smCode);

core.ajax.receivePacket(response);
                                                                                                                                  