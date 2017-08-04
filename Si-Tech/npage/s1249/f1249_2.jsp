
<%
/********************
 version v2.0
开发商: si-tech
update:anln@2009-02-16 页面改造,修改样式
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
		String opCode1 = "1249";
		String opName1 = "Vip金卡受理";
	
        	//得到输入参数
     		String regionCode = (String)session.getAttribute("regCode");
		String[] str = null;
		String retCode = "0";
		String retMessage="";
		
	   	 //--------------------------
		String login_accept=request.getParameter("printAccept");
		
		String phone_no = request.getParameter("phoneNo");
		String op_code = request.getParameter("opCode");
		String belong_code = request.getParameter("belongCode");
		String sm_code = request.getParameter("smCode");
		String login_no = request.getParameter("workno");
		String org_code = request.getParameter("unitCode");
		String phone_type = request.getParameter("smType");
		String op_type = request.getParameter("opeType");
		String vip_novip = request.getParameter("vipNo");
		String owner_name = request.getParameter("custName");
		String owner_id = request.getParameter("IDNo");
		String job = request.getParameter("occupation");
		String occu_type = request.getParameter("businessType");
		String contact_phone = request.getParameter("contactPhone");
		String owner_unit = request.getParameter("unitAddr");
		String owner_zip = request.getParameter("uPostalcode");
		String owner_address = request.getParameter("familyAddr");
		String addr_zip = request.getParameter("fPostalcode");
		String mobile_type = request.getParameter("phoneType");
		String mail_address = request.getParameter("email");
		if(mail_address==null || mail_address.equals(""))  mail_address="xxx";
		String love_content = request.getParameter("personalLike");
		String attr_content = request.getParameter("arrContent");
		String op_fee = "0.00";
		String paycard_fee = request.getParameter("yuan");
		String stkcard_no = request.getParameter("cardNo");
		String op_note = request.getParameter("note");

	    	String serviceName = "s1249_Apply";

		System.out.println("----attr_content------"+attr_content);
		System.out.println("----phone_no-----------" +phone_no);
		System.out.println("----op_code-----------" +op_code);
		System.out.println("----belong_code-----------" +belong_code);
		System.out.println("----login_no-----------" +login_no);
		System.out.println("----sm_code-----------" +sm_code);
	  	String[] paraStrIn = new String[]{phone_no,op_code,belong_code,sm_code,login_no,org_code,phone_type,op_type,vip_novip,owner_name,owner_id,job,occu_type,contact_phone,owner_unit,owner_zip,owner_address,addr_zip,mobile_type,mail_address,love_content,attr_content,op_fee,paycard_fee,stkcard_no,op_note,login_accept};
	   	String outParaNums= "0";   
	   	//SPubCallSvrImpl callSvrImpl = new SPubCallSvrImpl();
   	
	   	//str = callSvrImpl.callService(serviceName, paraStrIn, outParaNums);
	   %>
	   	<wtc:service name="s1249_Apply" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >				
		<wtc:params value="<%=paraStrIn%>"/>							
		</wtc:service>			
		<wtc:array id="temp"  scope="end"/>
	   <%
       		retCode = retCode1;
       		retMessage = retMsg1;
	   	System.out.println("------retCode--------" + retCode);
	  	System.out.println("------retMessage-----" + retMessage);		  


 	
	if(!retCode.equals("000000")){
%>
            <script language='jscript'>
                rdShowMessageDialog('<%=retMessage%>' + '[' + '<%=retCode%>' + ']',0);
               	history.go(-1);
            </script>
<%		}
        else
        {
%>        
            <script language='jscript'>
				  rdShowMessageDialog("Vip金卡受理成功！",2);
                  document.location.href="f1249_1.jsp?opCode=<%=opCode1%>&opName=<%=opName1%>&activePhone=<%=phone_no%>";
            </script>
<%            
        }
%>   
<%String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode1+"&retCodeForCntt="+retCode1+"&opName="+opName1+"&workNo="+login_no+"&loginAccept="+login_accept+"&pageActivePhone="+phone_no+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime; %>
<jsp:include page="<%=url%>" flush="true" />           