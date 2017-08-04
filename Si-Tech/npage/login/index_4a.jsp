<%@ page import="import java.io.*"%>
<%@ page import="import java.net.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<html>
	<%
		String test4alog = "";
		String resultVal = "";
		String token = "";
		String workNo = "";
		/* 测试时使用，日志写入文件 */
		test4alog = "====4A验证开始====";
		System.out.println(test4alog);
		try{
			String currTime = new SimpleDateFormat("yyyyMMddHHmmss", Locale.getDefault()).format(new Date());
			/* 获取token */
			token = request.getParameter("Token");
			session.setAttribute("token4a",null);
			session.setAttribute("token4a",token);
			test4alog = "\r\n== 4A验证=ningtn========Token==" + token;
			System.out.println(test4alog);
			/*从请求中获得ip地址*/
			System.out.println(token);
			String[] tokenArr = new String[]{""};
			tokenArr = token.split("@");
			test4alog = "\r\n== 4A验证=ningtn========开始调用==" + currTime;
			System.out.println(test4alog);
			for(int i = 0; i < tokenArr.length; i++){
				test4alog = "\r\n --> " + tokenArr[i];
				System.out.println(test4alog);
			}
			System.out.println("==4A验证==ningtn==============================");
			
			/* 回调4A平台 */
			String urlValue = "";
			/*4A新老地址并存，做一下判断*/
			System.out.println("==4A验证==ningtn=============================tokenArr.length=" + tokenArr.length);
			if(tokenArr.length == 5){
				/*新地址*/
				/*2014/05/28 10:04:28 gaopeng 6月初亿阳进行检查，需要暂时处理链接*/
				urlValue = "http://10.117.70.123:8084/portal/ticket_login.do?method=ticketlogin";
			}else{
				/*老地址*/
				urlValue = "http://10.110.111.193:8081/iam/ticket_login.do?method=ticketlogin";
			}
			
			//设置url参数
      System.out.println(" 4A验证 开始访问 url="+urlValue);
      URL url = new URL(urlValue);
      URLConnection uc = url.openConnection();
      uc.setDoOutput(true);
      uc.setDoInput(true);
      HttpURLConnection httpConnection = (HttpURLConnection) uc;
      httpConnection.setRequestMethod("POST");
      OutputStream os = httpConnection.getOutputStream();
      //发送请求
      String reqDate = "Token="+token 
      							+ "&APP_KEY=" + tokenArr[2]
      							+ "&ACC_KEY=" + tokenArr[1];
			System.out.println("==回调4A验证============================【" + reqDate + "】");
      byte[] bt=null;
      bt = reqDate.getBytes();
      os.write(bt);
      os.close();
      //判断是否超时 或是内部错误
      int rspCode=httpConnection.getResponseCode();
      if(rspCode!=200){//节点机超时或内部错误
          System.out.println(" 4A验证 节点机超时或内部错误");
      }
      //接收返回值
      InputStream is = httpConnection.getInputStream();
      InputStreamReader isr = new InputStreamReader(is,"UTF-8");
      BufferedReader br = new BufferedReader(isr);
      String data = "";
      String tstr = "";
      while ((tstr = br.readLine()) != null) {
          data = data + tstr;
      }
      isr.close();
      is.close();
      test4alog = "\r\n 4A验证返回报文=" + data;
      System.out.println(test4alog);
			/* 回调4A平台 end~~ */
			/* 校验4A平台返回结果，如果正确，登录BOSS系统。如果不正确，跳转至原有登录页面 */
			resultVal = data.substring(data.indexOf("<RESULT>") + 8,data.indexOf("</RESULT>"));
			workNo = data.substring(data.indexOf("<ACCOUNT>") + 9,data.indexOf("</ACCOUNT>"));
			/*防止工号异常登录在4a放回时放入session中一份*/

			session.setAttribute("workNo",null);
			session.setAttribute("workNo",workNo);
			/* 测试时候，在这里手动添加返回信息 */
			test4alog = "\r\n 结果 ：" + resultVal;
      System.out.println(test4alog);
			/* 如果result 操作结果 0失败，1成功。 */

		}catch(Exception e){
			/* 有异常了，从原有地址登陆 */
			test4alog = "\r\n 4A验证异常 ：" + e.toString();
      System.out.println(test4alog);
%>
			<SCRIPT language=javascript>
					var widthScree = screen.availWidth-5;
					var heightScree=screen.availHeight-30;	
					window.open('/npage/login/login.jsp','BOSS','width='+widthScree+',height='+heightScree+',left=0,top=0,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
					window.opener=null;
					window.open("","_self");
					window.close();
			</SCRIPT>
<%
		}
		/* 测试时使用，日志写入文件 */
	%>
<META http-equiv=Content-Language content=zh-cn />
<META http-equiv=Content-Type content="text/html; charset=GBK" />
<OBJECT ID="hljMacInfo1" WIDTH=0 HEIGHT=0
 CLASSID="CLSID:C03441C8-3DD3-44A4-B501-D816930AA833"
 codebase="/ocx/hljMacInfo.cab#Version=1,0,0,3">
</OBJECT>

<SCRIPT language=javascript>
	function openLogin(){
		var widthScree = screen.availWidth-5;
		var heightScree=screen.availHeight-30;	
		window.open('/npage/login/login.jsp','BOSS','width='+widthScree+',height='+heightScree+',left=0,top=0,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
		window.opener=null;
		window.open("","_self");
		window.close();
	}
	function openIndex(){
		/*
		loginForm.action="/npage/login/index.jsp";
		loginForm.submit();
		*/
		
		var widthScree = screen.availWidth-5;
		var heightScree = screen.availHeight-30;	
		var path = '/npage/login/login_4a.jsp' 
					+ '?token4a=' + document.all.token4a.value
					+ '&staffNo=' + document.all.staffNo.value;
		window.open(path,'BOSS','width='+widthScree+',height='+heightScree+',left=0,top=0,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
		window.opener=null;
		window.open("","_self");
		window.close();
		
	}
	function initPage(){
		var successFlag = "<%=resultVal%>";
		if("0" == successFlag){
			openLogin();
		}else{
			document.all.uuidCode.value=document.getElementById("hljMacInfo1").getMacInfo();
			openIndex();
		}
	}
</SCRIPT>
<body onload="initPage()">
	<form id="loginForm" name="loginForm" target="_self" method="post">
		<input type="hidden" id="staffNo" name="staffNo" value="<%=workNo%>" />
		<input type="hidden" id="password" name="password" value="" />
		<input type="hidden" name="versonType" value="normal"/>
		<input type="hidden" name="uuidCode" value="">
		<input type="hidden" name="addressFlag" value="1">
		<input type="hidden" name="token4a" id="token4a" value="<%=token%>">
	</form>
</body>
</html>

