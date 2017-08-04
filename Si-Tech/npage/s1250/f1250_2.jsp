<%
 /**
 * 作者:zhaohaitao
 * 日期:2008.12.2
 * 模块:积分兑换
 **/
%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.io.*" %>

<%
    //得到输入参数
    String opCode = "1250";
    String opName = "积分兑换";    
    String region_code = request.getParameter("region_code");     //地区代码
    String phone_no = request.getParameter("Ed_Phone_no");        //手机号码
    String Used_Point = request.getParameter("Ed_Favour_point");  
    String Used_Point_all = request.getParameter("Ed_Favour_point_all");  
    String Favour_Code = request.getParameter("Sel_Favour_name");  
    String Favour_Code_all = request.getParameter("Sel_Favour_name_all");  
    String Favour_Count = request.getParameter("Ed_UsedCount");  
    String Favour_Count_all = request.getParameter("Ed_UsedCount_all");  
    String Op_note = request.getParameter("Ed_Op_note");      
          
    String login_no = request.getParameter("workno");   
    String Orgcode = request.getParameter("OrgCode");    
    String op_code = request.getParameter("op_code");   
    String System_Note = region_code + ":" + phone_no + ":" +  Used_Point 
             + ":" + Favour_Code + ":" +  Favour_Count ;     
    String Ip_Address = request.getParameter("ip_Addr");   
	String vGoodId = request.getParameter("Ed_vGoodID");  
	String vMessFee = request.getParameter("fee");  
	String loginAccept = request.getParameter("loginAccept"); 
	
	String ret_code = "";
    String retMessage = "";
    //add by diling for 安全加固修改服务列表
	  String password = (String)session.getAttribute("password");
 %>
 
 <%   
	String input[] = new String[14];
	input[0] = phone_no;
	input[1] = Used_Point_all;
	input[2] = Favour_Code_all;
	input[3] = Favour_Count_all;
	input[4] = Op_note;
	input[5] = login_no;
	input[6] = Orgcode;
	input[7] = op_code;
	input[8] = System_Note;
	input[9] = Ip_Address;
	input[10] = loginAccept;
	input[11] = vGoodId;
	input[12] =  vMessFee;
	input[13] =  password;
	System.out.println("loginAccept==========="+loginAccept);
	System.out.println("input[0]="+input[0]);
	System.out.println("input[1]="+input[1]);
	System.out.println("input[2]="+input[2]);
	System.out.println("input[3]="+input[3]);
	System.out.println("input[4]="+input[4]);
	System.out.println("input[5]="+input[5]);
	System.out.println("input[6]="+input[6]);
	System.out.println("input[7]="+input[7]);
	System.out.println("input[8]="+input[8]);
	System.out.println("input[9]="+input[9]);
	System.out.println("input[10]="+input[10]);
	System.out.println("input[11]="+input[11]);
	System.out.println("input[12]="+input[12]);
	System.out.println("input[13]="+input[13]);
    try               
    {   
        //impl.callService("s1250Cfm", input, "1", "region",region_code);        
%>
		<wtc:service name="s1250Cfm"   routerKey="region" routerValue="<%=region_code%>" retcode="retCode" retmsg="retMsg" outnum="1" >
			<wtc:param value="<%=input[10]%>"/>
			<wtc:param value="01" />
			<wtc:param value="<%=input[7]%>"/>
			<wtc:param value="<%=input[5]%>"/>
			<wtc:param value="<%=input[13]%>" />	
			<wtc:param value="<%=input[0]%>"/>
			<wtc:param value=" " /> 		 
    		<wtc:param value="<%=input[1]%>"/>
			<wtc:param value="<%=input[2]%>"/>
			<wtc:param value="<%=input[3]%>"/>
    		<wtc:param value="<%=input[4]%>"/>		 
			<wtc:param value="<%=input[6]%>"/>   	 
			<wtc:param value="<%=input[8]%>"/>
			<wtc:param value="<%=input[9]%>"/>    
			<wtc:param value="<%=input[11]%>"/>
			<wtc:param value="<%=input[12]%>"/>
		</wtc:service>
		<wtc:array id="tempArr" scope="end"/>
<%
		System.out.println("retcode=============="+retCode);
		System.out.println("retmsg=============="+retMsg);
		ret_code =  retCode;
        retMessage =  retMsg;
    }catch( Exception e){
    	System.out.println("1250 f1250_2.jsp Call sunView is Failed!");
    }   
        
    String url = "/npage/contact/upCnttInfo.jsp?opCode="+op_code+"&retCodeForCntt="+ret_code+"&opName="+opName+"&workNo="+login_no+"&loginAccept="+loginAccept+"&pageActivePhone="+phone_no+"&retMsgForCntt="+retMessage+"&opBeginTime="+opBeginTime; 
%>
	<jsp:include page="<%=url%>" flush="true" />
<%
    if( !ret_code.equals("000000"))
    {
%>
        <script>
            rdShowMessageDialog("<%=retMessage%>");
            if(<%=op_code%>==1299)
            {window.location="f1299_1.jsp?op_code=1299&activePhone=<%=phone_no%>";}
            else
            {window.location="f1250_1.jsp?op_code=1250&activePhone=<%=phone_no%>";}
        </script>
<%  }
    else
    {
    	String statisLoginAccept = loginAccept; /*流水*/
		String statisOpCode=op_code;
		String statisPhoneNo=phone_no;	
		String statisIdNo="";	
		String statisCustId=WtcUtil.repNull(request.getParameter("cust_id"));	

		String statisUrl = "/npage/public/pubCustSatisIn.jsp"
			+"?statisLoginAccept="+statisLoginAccept
			+"&statisOpCode="+statisOpCode
			+"&statisPhoneNo="+statisPhoneNo
			+"&statisIdNo="+statisIdNo	
			+"&statisCustId="+statisCustId;	
    	System.out.println("@zhangyan~~~~statisLoginAccept="+statisLoginAccept);
    	System.out.println("@zhangyan~~~~statisOpCode="+statisOpCode);
    	System.out.println("@zhangyan~~~~statisPhoneNo="+statisPhoneNo);
    	System.out.println("@zhangyan~~~~statisIdNo="+statisIdNo);
    	System.out.println("@zhangyan~~~~statisCustId="+statisCustId);
    	System.out.println("@zhangyan~~~~statisUrl="+statisUrl);
 %>
		<jsp:include page="<%=statisUrl%>" flush="true" />
	   
        <script>
             rdShowMessageDialog("积分兑奖操作成功!");
             if(<%=op_code%>==1299)
                {window.location="f1299_1.jsp?op_code=1299&activePhone=<%=phone_no%>";}
             else
                {window.location="f1250_1.jsp?op_code=1250&activePhone=<%=phone_no%>";}
        </script>
<%            
    }
%>




