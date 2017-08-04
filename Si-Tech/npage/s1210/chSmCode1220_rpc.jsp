<%
/********************
 version v2.0
开发商: si-tech
update:liutong@2008.09.19
********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

//SPubCallSvrImpl co=new SPubCallSvrImpl();

//--------------------------
String srv_no = request.getParameter("srv_no");
String verifyType = request.getParameter("verifyType");
String sq1="select CHINASIM_FLAG from shlrcode  where phoneno_head=substr('"+srv_no+"',1,7)";
String sq2="select decode(trim(sm_code),'gn','全球通','zn','神州行','dn','动感地带','TE','铁通e固话','全球通') from dcustmsg  where phone_no='"+srv_no+"'";

//ArrayList retArray=new ArrayList();
//String [][]result=new String[][]{};
String rret_code="000000";
String rret_message="";

String smCode="gn";

/**
try
{
	retArray = co.sPubSelect("1",sq1,"phone",srv_no);
	result = (String[][])retArray.get(0);
	hlr = result[0][0]; 
	if(hlr.equals("1"))
	{
      smCode="z0";
	}
	else if(hlr.equals("0"))
	{
      retArray = co.sPubSelect("1",sq2,"phone",srv_no);
	  result = (String[][])retArray.get(0);
	  smCode = result[0][0]; 
	}
	ret_code = "000000";
}catch(Exception e){	
	ret_code = "000001";
	ret_message = "用户资料不存在！";
}
**/
%>
			<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
			<wtc:sql><%=sq1%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result1" scope="end" />
<%
 		 if(retCode1.equals("0")||retCode1.equals("000000")){
          System.out.println("调用服务sPubSelect1 in chSmCode1220_rpc.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
 	        	if(result1.length==0){
 	            }else{
 	        	  
							if( result1[0][0].equals("1"))
							{
						      smCode="z0";
							}
							else if( result1[0][0].equals("0"))
							{
						     
							  %>
										  <wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>"  retcode="ret_code" retmsg="ret_message" outnum="1">
											<wtc:sql><%=sq2%></wtc:sql>
											</wtc:pubselect>
											<wtc:array id="result" scope="end" />
							  <%
							  				rret_code=ret_code;
								 	     	rret_message=ret_message;
							  			  if(ret_code.equals("0")||ret_code.equals("000000")){
								          System.out.println("调用服务sPubSelect2 in chSmCode1220_rpc.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
								 	        	if(result.length==0){
								 	            }else{
								 	        	    smCode = result[0][0]; 
								 	        	}
								 	        	
								 	     	}else{
								 	         	System.out.println(ret_code+"    ret_code");
								 	     		System.out.println(ret_message+"    ret_message");
								 	     		
								 				System.out.println("调用服务sPubSelect2 in chSmCode1220_rpc.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
								 			
								 			}
							  
							  
							  
							 
							}
 	        	   
 	        	}
 	         rret_code = "000000";
 	     	}else{
 	     		rret_code = "000001";
				rret_message = "用户资料不存在！";
 	         	System.out.println(retCode1+"    retCode1");
 	     		System.out.println(retMsg1+"    retMsg1");
 				System.out.println("调用服务sPubSelect1 in chSmCode1220_rpc.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
 			}



%>

var response = new AJAXPacket();
var errCode = "<%=rret_code%>";
var errMsg = "<%=rret_message%>";
var smCode = "<%=smCode%>";
var verifyType="<%= verifyType %>";
response.data.add("errCode",errCode);
response.data.add("errMsg",errMsg);
response.data.add("smCode",smCode);
response.data.add("verifyType",verifyType);

core.ajax.receivePacket(response);
