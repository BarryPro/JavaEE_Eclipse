 <%

	/********************

	 version v2.0

	开发商: si-tech

	update:anln@2009-02-10 页面改造,修改样式

	********************/

%>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html;charset=GBK"%>

<%@ include file="/npage/include/public_title_name.jsp" %>



<%	

	

	

	ArrayList retArray = new ArrayList();		

	String work_no = (String)session.getAttribute("workNo");		

	String regionCode= (String)session.getAttribute("regCode");

	String opCode =request.getParameter("opCode");

	String opName =request.getParameter("opName");

	
String loginPwd    = (String)session.getAttribute("password"); 

	String paraAray[] = new String[9];

	paraAray[0] =request.getParameter("phone_no");

	paraAray[1] = request.getParameter("optype");

    	paraAray[2] = request.getParameter("listtype");

	paraAray[3] = request.getParameter("offon");

    	paraAray[4] = request.getParameter("opCount");

    	paraAray[5] = request.getParameter("optypestr");

    	paraAray[6] = request.getParameter("opcodestr");

    	paraAray[7] = work_no;

   	paraAray[8] = request.getParameter("login_accept");

    

    	String themob=WtcUtil.repNull(request.getParameter("phone_no"));

    	String theop_code="7378";

    	String thework_no=work_no;

   	String stream=request.getParameter("login_accept");

   	 

    	if(request.getParameter("listtype").equals("W")){

%>

     	     

     	     <%	

		/***用户手机号	phone_no**操作工号	login_no**票据类型	bill_type*/

 

			//String opCode=request.getParameter("opCode");

			String login_accept=request.getParameter("login_accept");

			String retType=request.getParameter("retType");

		    	String billType=request.getParameter("billType");

		    	String phoneNo=request.getParameter("phoneNo");

		    	String errCode="";

		    	String errMsg="";

		    

		    	System.out.println("opCode="+opCode);

		    	System.out.println("opName="+opName);

		    	System.out.println("login_accept="+login_accept);

		    	System.out.println("retType="+retType);

		    	System.out.println("billType="+billType);

		%>

		<wtc:service name="sPrt_Print" routerKey="phone" routerValue="<%=phoneNo%>" outnum="13" >

			<wtc:param value="<%=login_accept%>"/>

			<wtc:param value="<%=opCode%>"/>

			<wtc:param value="<%=billType%>"/>

			<wtc:param value="<%=phoneNo%>"/>

		</wtc:service>

		<wtc:array id="result" scope="end"/>

			<%

					if(result.length>0){

						for(int i=0;i<result.length;i++){

			%>

							var temResultArr = new Array();

			<%

							for(int j=0;j<result[i].length;j++){

							//System.out.println("result["+i+"]["+j+"]=="+result[i][j]);

			%>

								

								temResultArr[<%=j%>] = "<%=result[i][j].replaceAll("\r\n","")%>";

			<%				

							}

			%>

							impResultArr[<%=i%>]=temResultArr;

			<%

						}	

					}

			%>

			<%

			if(retCode.equals("000000")){   

				if(result.length>0)

				{

					 errCode="000000";

			     errMsg="工单打印成功！";

				}

				else{

					 errCode="000001";

			     errMsg="打印内容为空！";

				}

			}else{ 

			   errCode=retCode;

			   errMsg=retMsg;

				}

			%>



    

<%}

	//String[] ret = impl.callService("s7378Cfm",paraAray,"3","region",org_code.substring(0,2));

%>

	<wtc:service name="s7378Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="3" >

	<wtc:param value="<%=paraAray[8]%>"/>

	<wtc:param value="01" />

	<wtc:param value="<%=opCode%>" />

	<wtc:param value="<%=paraAray[7]%>"/>

	<wtc:param value="<%=loginPwd%>" />	

	<wtc:param value="<%=paraAray[0]%>"/>

        <wtc:param value=" " />

		<wtc:param value="<%=paraAray[1]%>"/>

		<wtc:param value="<%=paraAray[2]%>"/>

		<wtc:param value="<%=paraAray[3]%>"/>

		<wtc:param value="<%=paraAray[4]%>"/>

		<wtc:param value="<%=paraAray[5]%>"/>

		<wtc:param value="<%=paraAray[6]%>"/>



	</wtc:service>		

<%	

	String errCode1 = retCode1;

	String errMsg1 = retMsg1;

	if (errCode1.equals("000000")){

%>

		<script language="JavaScript">

			rdShowMessageDialog("操作成功!",2);

   			history.go(-2);

		</script>

<%

	}else{

%>   

		<script language="JavaScript">

			rdShowMessageDialog("操作失败!(<%=errMsg1%>)",0);

			history.go(-1);

		</script>

<%}%>



<%String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+paraAray[8]+"&pageActivePhone="+paraAray[0]+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime; %>

<jsp:include page="<%=url%>" flush="true" />

