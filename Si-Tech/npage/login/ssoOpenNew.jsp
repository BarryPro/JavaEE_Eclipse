<%

String login_no= request.getParameter("login_no");

//System.out.println("=== lipf ssoJava_new.jsp === login_no == "+login_no);

if(com.huawei.sso.client.util.SingleSignOnUtil.getSessionInitService().fetchReceipt(request) == null)

{

		 if(login_no!=null){

     com.huawei.sso.client.util.SingleSignOnUtil.generateSsoStatus(request,login_no);

     }else{

   	 com.huawei.sso.client.util.SingleSignOnUtil.generateSsoStatus(request,"800920");

   	}

}



%>

<script type="text/javascript">

window.opener.xbzhsHandle=window.open('ssoOpenIframe_new.jsp','','toolbar=no,location=no,directories=no,menubar=no,scrollbars=yes,resizable=yes,left=200,top=120');

//window.opener=null;

window.open("","_self");

window.close();

</script>



