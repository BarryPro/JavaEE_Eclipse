<%@ page import="import java.io.*"%>
<%@ page import="import java.net.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<html>
	<%
		String test4alog = "";
		String resultVal = "";
		String token = "";
		String workNo = "";
		/* ����ʱʹ�ã���־д���ļ� */
		test4alog = "====4A��֤��ʼ====";
		System.out.println(test4alog);
		try{
			String currTime = new SimpleDateFormat("yyyyMMddHHmmss", Locale.getDefault()).format(new Date());
			/* ��ȡtoken */
			token = request.getParameter("Token");
			session.setAttribute("token4a",null);
			session.setAttribute("token4a",token);
			test4alog = "\r\n== 4A��֤=ningtn========Token==" + token;
			System.out.println(test4alog);
			/*�������л��ip��ַ*/
			System.out.println(token);
			String[] tokenArr = new String[]{""};
			tokenArr = token.split("@");
			test4alog = "\r\n== 4A��֤=ningtn========��ʼ����==" + currTime;
			System.out.println(test4alog);
			for(int i = 0; i < tokenArr.length; i++){
				test4alog = "\r\n --> " + tokenArr[i];
				System.out.println(test4alog);
			}
			System.out.println("==4A��֤==ningtn==============================");
			
			/* �ص�4Aƽ̨ */
			String urlValue = "";
			/*4A���ϵ�ַ���棬��һ���ж�*/
			System.out.println("==4A��֤==ningtn=============================tokenArr.length=" + tokenArr.length);
			if(tokenArr.length == 5){
				/*�µ�ַ*/
				/*2014/05/28 10:04:28 gaopeng 6�³��������м�飬��Ҫ��ʱ��������*/
				urlValue = "http://10.117.70.123:8084/portal/ticket_login.do?method=ticketlogin";
			}else{
				/*�ϵ�ַ*/
				urlValue = "http://10.110.111.193:8081/iam/ticket_login.do?method=ticketlogin";
			}
			
			//����url����
      System.out.println(" 4A��֤ ��ʼ���� url="+urlValue);
      URL url = new URL(urlValue);
      URLConnection uc = url.openConnection();
      uc.setDoOutput(true);
      uc.setDoInput(true);
      HttpURLConnection httpConnection = (HttpURLConnection) uc;
      httpConnection.setRequestMethod("POST");
      OutputStream os = httpConnection.getOutputStream();
      //��������
      String reqDate = "Token="+token 
      							+ "&APP_KEY=" + tokenArr[2]
      							+ "&ACC_KEY=" + tokenArr[1];
			System.out.println("==�ص�4A��֤============================��" + reqDate + "��");
      byte[] bt=null;
      bt = reqDate.getBytes();
      os.write(bt);
      os.close();
      //�ж��Ƿ�ʱ �����ڲ�����
      int rspCode=httpConnection.getResponseCode();
      if(rspCode!=200){//�ڵ����ʱ���ڲ�����
          System.out.println(" 4A��֤ �ڵ����ʱ���ڲ�����");
      }
      //���շ���ֵ
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
      test4alog = "\r\n 4A��֤���ر���=" + data;
      System.out.println(test4alog);
			/* �ص�4Aƽ̨ end~~ */
			/* У��4Aƽ̨���ؽ���������ȷ����¼BOSSϵͳ���������ȷ����ת��ԭ�е�¼ҳ�� */
			resultVal = data.substring(data.indexOf("<RESULT>") + 8,data.indexOf("</RESULT>"));
			workNo = data.substring(data.indexOf("<ACCOUNT>") + 9,data.indexOf("</ACCOUNT>"));
			/*��ֹ�����쳣��¼��4a�Ż�ʱ����session��һ��*/

			session.setAttribute("workNo",null);
			session.setAttribute("workNo",workNo);
			/* ����ʱ���������ֶ���ӷ�����Ϣ */
			test4alog = "\r\n ��� ��" + resultVal;
      System.out.println(test4alog);
			/* ���result ������� 0ʧ�ܣ�1�ɹ��� */

		}catch(Exception e){
			/* ���쳣�ˣ���ԭ�е�ַ��½ */
			test4alog = "\r\n 4A��֤�쳣 ��" + e.toString();
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
		/* ����ʱʹ�ã���־д���ļ� */
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

