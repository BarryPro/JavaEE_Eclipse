<%@ page contentType="text/html;charset=GB2312"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<!-- Here:delete by qidp -->
<%
//add by chenjy 2010-1-11 16:06:44
	/* qidp
	String secureRandom=String.valueOf(new java.util.Random(System.currentTimeMillis()*2).nextInt(100000000));
	String A=new DESTest1().encrypt(new DESTest1().encrypt(new DESTest1().getSecureKey())+""+new DESTest1().encrypt(secureRandom));
    */
%>
<%
 String referer=request.getHeader("referer");
 //System.out.println("----------------------"+referer);
 if(referer==null)return;

%>	
<HTML>
	<HEAD>
		<TITLE>�Ĵ��ƶ�CRM�ۺ�ҵ��ϵͳ</TITLE>
		<META http-equiv=Content-Language content=zh-cn>
		<META http-equiv=Content-Type content="text/html; charset=gb2312">
		<META content="MSHTML 6.00.2800.1106" name=GENERATOR>
		<META content=FrontPage.Editor.Document name=ProgId>
		<link href="/nresources/<%=path_in_session%>/css/common.css" rel="stylesheet" type="text/css"></link>
		<link href="/nresources/<%=path_in_session%>/css/login01.css" rel="stylesheet" type="text/css"></link>
		<link href="/nresources/<%=path_in_session%>/css/font_color.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="/njs/extend/jquery/jquery123_pack.js"></script>
		<script language="JavaScript" src="/njs/redialog/redialog.js"></script>
		
		<OBJECT ID="browserctl" CLASSID="CLSID:1A24BFBE-72A4-4663-B853-B937358DD2A3" CODEBASE="/ocx/browserCtl.CAB#version=1,0,0,0" STYLE="DISPLAY: none" VIEWASTEXT></OBJECT>

		<SCRIPT language=javascript>
			
			function rightBrowse()
			{	
				var appName = navigator.appName;
				var userAgent = navigator.userAgent; 
				if(appName.indexOf("Netscape")!= -1)
				{
					rdShowMessageDialog("��ʹ�õ��Ƿ�IE�ں����������ʹ��IE!");
					location="login.htm"; 
				}
				else
					if(appName.indexOf("Microsoft")!=-1)
				{
					try
					{
						browserctl.InitCtrl();
						//alert(browserctl.message);
						//alert(browserctl.isRightBrowse()); 
						var flag = browserctl.isRightBrowse();
						if(flag==1)
						{
							return ;
						}
						else
						{
							rdShowMessageDialog("��ʹ�õ��Ƿ�IE���������ʹ��IE!");
							location="login.htm";
						}
					}
					catch(E)
					{		
						rdShowMessageDialog("�����ؿؼ���");		
						location="login.htm";		
					}
				}   
				return ;
			}
			
			$(document).ready(function(){
				
				//rightBrowse();
				
				$("BUTTON").hover(
					function () {
					    $(this).css("background-position","center");
					},
					function () {
					    $(this).css("background-position","top");
					}
				);
				chgInputStyle();
			});
			
			function chgInputStyle(){
				$("input:text,input:password,textarea").focus(function(){this.className = "focusInput";});	
				$("input:text,input:password,textarea").blur(function(){this.className = "";});	
			}
			
			function doSubmit(thisForm){
				thisForm.SUBMIT.disabled=true;
				thisForm.submit();
			}
			
		</SCRIPT>
			
	
		<%
			
	//�õ��������
		String loginNo = request.getParameter("AccountName");
		String Password = request.getParameter("Password");
		String appendpasswd = request.getParameter("appendpasswd");
		String selfIp = request.getRemoteAddr();
		String versonType = request.getParameter("versonType");
		System.out.println("----------------");
System.out.println(versonType);
System.out.println("=---------------");
		
	//----add by luorui ����ie7�ظ���½-----2009-5-31 9:51------BEGIN--/

	if(!"z".equals(loginNo.substring(0,1))&&!"Z".equals(loginNo.substring(0,1))){ 
				//�ͷ����Ų�������
	String session_flag = (String)session.getAttribute("workNo");
	if(session_flag	!= null&&!session_flag.equals(loginNo))
	{
	%>
	<script>
	 rdShowMessageDialog("��̨���Ե�¼���������š��뽫�ɹ����˳����ٵ�¼",0);
	 location="/";
	//window.close();
	</script>
	<%
	return;
	}	
	}
	//----add by luorui ����ie7�ظ���½-----2009-5-31 9:51------END--/
	
		Enumeration enu = session.getAttributeNames();
		while (enu.hasMoreElements()) {
			String name = (String) enu.nextElement();
			session.removeAttribute(name);
		}
 
		
			String insql = "";
	insql = insql + "select ceil(sysdate-max(UPDATE_TIME)) ";
	insql = insql + "from dloginmsghis where login_no ='" + loginNo
			+ "' ";
	insql = insql
			+ "and (UPDATE_CODE='8004' or ( UPDATE_CODE='8002' and update_type='0') or  UPDATE_CODE='8006') ";
			 
			Date date = new Date();
			java.text.SimpleDateFormat   fnum   =   new   java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss");
			String date_str =	fnum.format(date);
			System.out.println("=========GetAppendPass.jsp============"+date_str+"============="+insql);

	%>
	
	<wtc:pubselect name="sPubSelect" outnum="1"  >
		<wtc:sql><%=insql%></wtc:sql>
	</wtc:pubselect>
	                                  
	<wtc:array id="retStr" scope="end" />
		
	<%
	if(retCode.equals("000000")){
	 if(retStr.length>0 ){
	if (Float.parseFloat(retStr[0][0]) > 80) {
	%>
		<script language="JavaScript">
		<!--
			rdShowMessageDialog("��������Ѿ��޸���<%=retStr[0][0]%>�죬���90�첻�޸ģ����Ž����������!!!");
		//-->
		</script>
	
	<%
	}
	}
	}
	%>	
		<wtc:service name="sSndAppPassWd" routerKey="workno" routerValue="<%=loginNo%>" outnum="2"  >
			<wtc:param value="<%=loginNo%>"/>
			<wtc:param value="<%=Password%>"/>
			<wtc:param value="<%=selfIp%>"/>
		</wtc:service>
	<%	

	if (retCode.equals("000000")) {
	%>
			</HEAD>
			<body class="login-2">
				<div class="header">
				<div class="left"></div><div class="right"></div>
				</div>
				<div class="login-panel">
					<div class="block1">
						<p>
							1.����ʹ��1024��768�ֱ�����������ʹ�õ���1024��768�ķֱ��ʣ��޷���֤ҳ��������ʾ  
						</p>
						<p>
							2.���ڰ�ȫ�����ƣ����汾ֻ��ʹ��IE6.0�汾�������汾������ݲ�֧��
						</p>
					</div>
					<div class="block2">
						<div class="login">
							<div class="row">
								<form name="frm" action="index.jsp" method="post">
									<input type="hidden" name="secureRandom" value="<%=secureRandom%>">
									<input type="hidden" name="A" value="<%=A%>">
									<INPUT TYPE="hidden" name=AccountName value="<%=loginNo%>">
									<INPUT TYPE="hidden" name=Password value="<%=Password%>">
									<INPUT TYPE="hidden" name=versonType value="<%=versonType%>"/>
									<label>��������:</label><div class="inText"><input type="password" name="appendpasswd" /> </div><input name="SUBMIT" class="btn" type="button" size="10" value="ȷ ��" onclick="doSubmit(document.frm)"  />
								</form>
							</div>
							<div class="Lhelp">
								*��δ��ȡ��������,��ʹ�ù��Ŷ�Ӧ�ֻ�����1008633��ȡ.
							</div>
						</div>
					</div>
					<div class="block3">
					</div>
					<div class="footer">�й��ƶ�ͨ�ż����Ĵ����޹�˾ ��Ȩ���� Version 2009</div>
				</div>
				
				</body>
		</HTML>

	<%
	} else if (retCode.equals("900105")) {
	%>
			</HEAD>
			<BODY>
				<form name=frm action="index.jsp" method=post>
					<TABLE height="80%" width="100%" border=0>
						<input type="hidden" name="secureRandom" value="<%=secureRandom%>">
						<input type="hidden" name="A" value="<%=A%>">
						<INPUT style="WIDTH: 210px" TYPE="hidden" name=AccountName value="<%=loginNo%>">
						<INPUT style="WIDTH: 210px" TYPE="hidden" type=password name=Password value="<%=Password%>">
						<INPUT style="WIDTH: 210px" TYPE="hidden" type=password name=appendpasswd value="      ">
						<INPUT TYPE="hidden" name=versonType value="<%=versonType%>"/>
					</TABLE>
				</FORM>
			</BODY>
		</HTML>
	
		<SCRIPT language=javascript>
		    frm.submit();
		</SCRIPT>

<%
	}else{
%>
	
		<SCRIPT language=javascript>
			rdShowMessageDialog("��½����[<%=retCode%>]<%=retMsg%>");
			location="login.htm";
		</SCRIPT>
	
<%
	}
%>
