   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-16
********************/
%>
              
<%
  String opCode = "8008";
  String opName = "注册新功能";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=gb2312"%>


<%
	String workNo   = (String)session.getAttribute("workNo");            //工号
	String nopass  = (String)session.getAttribute("password");       	//登陆密码
	String regionCode= (String)session.getAttribute("regCode");
	
		
	//获取输入的信息
	String roleName = request.getParameter("roleName");						
	String roleCode = request.getParameter("roleCode");						
	String parentpopeDomCode = request.getParameter("parentpopeDomCode");						
	String parentFuncCode = request.getParameter("parentFuncCode");						
	String func_code = request.getParameter("func_code");						
	String func_name = request.getParameter("func_name");							
	String main_code = request.getParameter("main_code");	
	String order_id = request.getParameter("order_id");	
	String form_name = request.getParameter("form_name");	
	String note = request.getParameter("note");	
	String pdt_code = request.getParameter("pdt_code");	
	String accTypeList = request.getParameter("accTypeList");
	String open_way = request.getParameter("open_way");	
	String pass_flag = request.getParameter("pass_flag");
	String pass_module = request.getParameter("pass_module");//huangrong add 	免密模块 2011-6-15
	String isFamilyBusi = request.getParameter("isFamilyBusi");
	System.out.println("open_wayopen_wayopen_wayopen_way=="+open_way);
	System.out.println("pass_flagpass_flagpass_flagpass_flagpass_flag=="+pass_flag);
	//掉服务
	String paraArr[] = new String[19];
	paraArr[0] = workNo;
	paraArr[1] = nopass;
	paraArr[2] = "8008";
	paraArr[3] = parentFuncCode;
	paraArr[4] = func_code;
	paraArr[5] = func_name;
	paraArr[6] = main_code;
	paraArr[7] = order_id;
	paraArr[8] = form_name;
	paraArr[9] = note;
	paraArr[10] = parentpopeDomCode;
	paraArr[11] = pdt_code;
	paraArr[12] = accTypeList;
	paraArr[13] = pass_flag;
	paraArr[14] = open_way;
	paraArr[15] = pass_module;//huangrong add 	免密模块 2011-6-15
	paraArr[16] = "";
	paraArr[17] = "";
	paraArr[18] = isFamilyBusi;
	
	System.out.println("~~~~~~~~~~~~~~~~~~~~~~~pass_flag~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"+pass_flag);
	System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~open_way~~~~~~~~~~~~~~~~~~~~~~~~~"+open_way);
	System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~pass_module~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"+pass_module);
  String errCode="";
  String errMsg="";
	try
	{   
	 //	impl.callService("s8008Cfm",paraArr,"1","region", regionCode);
%>
    <wtc:service name="s8008Cfm" outnum="3" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paraArr[0]%>" />
			<wtc:param value="<%=paraArr[1]%>" />
			<wtc:param value="<%=paraArr[2]%>" />
			<wtc:param value="<%=paraArr[3]%>" />
			<wtc:param value="<%=paraArr[4]%>" />
			<wtc:param value="<%=paraArr[5]%>" />
			<wtc:param value="<%=paraArr[6]%>" />
			<wtc:param value="<%=paraArr[7]%>" />
			<wtc:param value="<%=paraArr[8]%>" />
			<wtc:param value="<%=paraArr[9]%>" />
			<wtc:param value="<%=paraArr[10]%>" />
			<wtc:param value="<%=paraArr[11]%>" />
			<wtc:param value="<%=paraArr[12]%>" />		
			<wtc:param value="<%=paraArr[13]%>" />
			<wtc:param value="<%=paraArr[14]%>" />		
			<wtc:param value="<%=paraArr[15]%>" />																
			<wtc:param value="<%=paraArr[16]%>" />																
			<wtc:param value="<%=paraArr[17]%>" />			
			<wtc:param value="<%=paraArr[18]%>" />				
		</wtc:service>
		<wtc:array id="result_t" scope="end" />

<%		
		errCode=code;   
		errMsg=msg; 		 
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	       
	
	if(errCode.equals("000000"))
    {
%>
        <script language='javascript'>
        	rdShowMessageDialog("操作成功！",2);
              parent.location="f8008_1.jsp?popeDomCode="+"<%=parentpopeDomCode%>"+"&roleCode="+"<%=roleCode%>"+"&roleName="+"<%=roleName%>";
        </script>
<%	}
    else
    {
%>        
		  	<script language='jscript'>
	          rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
	          history.go(-1);
	      </script>         
<%            
    }
%>

