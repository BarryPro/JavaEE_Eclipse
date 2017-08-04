<%
/**********************************
	zhangyan@2013/8/14 10:48:10
***********************************/
%>

<%@ include file = "/npage/include/public_title_name_p.jsp" %>
<%@ page contentType = "text/html;charset=GBK" %>
<%
String accept = request.getParameter( "logacc" );
String chnSrc = request.getParameter( "chnSrc" );
String opCode = request.getParameter( "opCode" );
String workNo = request.getParameter( "workNo" );
String passwd = request.getParameter( "passwd" );

String phoNo = request.getParameter( "vPhoNo" );   
String usrPwd = request.getParameter( "usrPwd" );
String v_qryChn = request.getParameter( "v_qryChn" );
String v_iccid = request.getParameter( "v_iccid" );
String v_qryAcc = request.getParameter( "v_qryAcc" );

String appr_rst = request.getParameter( "appr_rst" );
String rsn = request.getParameter( "rsn" );
String vChkMsg = request.getParameter( "vChkMsg" );
String ipAddr = ( String )session.getAttribute( "ipAddr" );
String opName = request.getParameter( "opName" );
String errCode = "";
String errMsg = ""; 
String regCode = ( String )session.getAttribute( "regCode" );

String vName = request.getParameter( "vNName" );
String vIdAddr = request.getParameter( "vNHomeAddr" );
String vIdDate = request.getParameter( "vExpTime" );

String tm_b = request.getParameter( "tm_b" );
String tm_e =  request.getParameter( "tm_e" );
String cur_page = request.getParameter( "cur_page" );
String pageNumber = request.getParameter( "pageNumber" );

if ( appr_rst.equals("0") ) /*审核不通过*/
{
%>
	<wtc:service name = "sI037Cfm" outnum = "30"routerKey = "region" routerValue = "<%=regCode%>" 
		retcode = "rc_cfm" retmsg = "rm_cfm" >
		<wtc:param value = "<%=accept%>"/>
		<wtc:param value = "<%=chnSrc%>"/>
		<wtc:param value = "<%=opCode%>"/>
		<wtc:param value = "<%=workNo%>"/>
		<wtc:param value = "<%=passwd%>"/>
			
		<wtc:param value = "<%=phoNo%>"/>
		<wtc:param value = "<%=usrPwd%>"/>
		<wtc:param value = "<%=v_qryChn%>"/>
		<wtc:param value = "<%=v_iccid%>"/>
		<wtc:param value = "<%=v_qryAcc%>"/>
			
		<wtc:param value = "<%=rsn%>"/>
		<wtc:param value = "<%=vChkMsg%>"/>
		<wtc:param value = "<%=vName%>"/>
		<wtc:param value = "<%=vIdAddr%>"/>
		<wtc:param value = "<%=vIdDate%>"/>
	</wtc:service>
	<wtc:array id="rst" scope="end" />
<%
	errCode = rc_cfm;
	errMsg = rm_cfm;
	
	if( !"000000".equals(errCode))
	{
	%>
		<script>
			rdShowMessageDialog( "<%=errCode%>" + ":" + "<%=errMsg%>" , 0 );
			window.history.go(-1);
		</script>    
	<%
	}
	else
	{%>
		<script>
			rdShowMessageDialog( "<%=errCode%>"+":"+"<%=errMsg%>" , 2 );
			window.location = "fi037_lst.jsp?tm_b=<%=tm_b%>"
				+"&opCode=<%=opCode%>"
				+"&opName=<%=opName%>"
				+"&chn_code=<%=v_qryChn%>"
				+"&cur_page=<%=cur_page%>"
				+"&phoNo=<%=phoNo%>"
				+"&pageNumber=<%=pageNumber%>"
				+"&tm_e=<%=tm_e%>";
		</script>
	<%
	}	
}
else
{
	String vNIdType = request.getParameter("vIdType");
%>
	<wtc:service name="spubGetId" routerKey="region" routerValue="<%=regCode%>"
		 retCode="retCode1" retMsg="retMsg1" outnum="3" >
	<wtc:param value="<%=regCode%>"/>
	<wtc:param value="<%=vNIdType%>"/>
	<wtc:param value="0"/>
	</wtc:service>
	<wtc:array id="rst_id" scope="end"/>
<%
	String org_code = ( String )session.getAttribute( "orgCode" );
	String vNName = request.getParameter( "vNName" );
	String vNPwd = request.getParameter( "vNPwd" );
	String vNStatus = request.getParameter("vNStatus");   			
	String vNGrade = request.getParameter("vNGrade");   			
	String vNConName = request.getParameter("vNConName");   			
	String vNConTel = request.getParameter("vNConTel");   			
	String vNConAddr = request.getParameter("vNConAddr");   			
	String vNConPostNum = request.getParameter("vNConPostNum");   			
	String vNConPostAddr = request.getParameter("vNConPostAddr");   			
	String vNConFax = request.getParameter("vNConFax");   			
	String vNConEMail = request.getParameter("vNConEMail");   			
	String vNSex = request.getParameter("vNSex");   			
	String vNBirth = request.getParameter("vNBirth");   			
	String vNWork = request.getParameter("vNWork");   			
	String vNEduLevel = request.getParameter("vNEduLevel");   			
	String vNLove = request.getParameter("vNLove");   			
	String vNHabit = request.getParameter("vNHabit");   			
	String vNewCustId = rst_id[0][2]; 
	String vNHomeAddr = request.getParameter("vNHomeAddr");
	String vIdNo = request.getParameter("vIdNo");
	String vExpTime = request.getParameter("vExpTime");
	String vNBelongCode = request.getParameter("vNBelongCode");
%>
	<wtc:service name = "sm058Cfm" outnum = "30"
		routerKey = "region" routerValue = "<%=regCode%>" 
		retcode = "rc_cfm" retmsg = "rm_cfm" >
		<wtc:param value = "<%=accept%>"/>
		<wtc:param value = "m058"/>
		<wtc:param value = "<%=workNo%>"/>
		<wtc:param value = "<%=passwd%>"/>
		<wtc:param value = "<%=org_code%>"/>
		
		<wtc:param value = "<%=vIdNo%>"/>
		<wtc:param value = "<%=vNewCustId%>"/>
		<wtc:param value = "<%=vNBelongCode%>"/>
		<wtc:param value = "<%=vNName%>"/>
		<wtc:param value = "<%=vNPwd%>"/>
			
		<wtc:param value = "<%=vNStatus%>"/>
		<wtc:param value = "<%=vNGrade%>"/>
		<wtc:param value = "<%=vNHomeAddr%>"/>
		<wtc:param value = "<%=vNIdType%>"/>
		<wtc:param value = "<%=v_iccid%>"/>
			
		<wtc:param value = "<%=vNHomeAddr%>"/>
		<wtc:param value = "<%=vExpTime%>"/>
		<wtc:param value = "<%=vNConName%>"/>
		<wtc:param value = "<%=vNConTel%>"/>
		<wtc:param value = "<%=vNConAddr%>"/>
			
		<wtc:param value = "<%=vNConPostNum%>"/>
		<wtc:param value = "<%=vNConPostAddr%>"/>
		<wtc:param value = "<%=vNConFax%>"/>
		<wtc:param value = "<%=vNConEMail%>"/>
		<wtc:param value = "<%=vNSex%>"/>
			
		<wtc:param value = "<%=vNBirth%>"/>
		<wtc:param value = "<%=vNWork%>"/>
		<wtc:param value = "<%=vNEduLevel%>"/>
		<wtc:param value = "<%=vNLove%>"/>
		<wtc:param value = "<%=vNHabit%>"/>
		
		<wtc:param value = "0"/>
		<wtc:param value = "0"/>
		<wtc:param value = "<%=opName%>"/>
		<wtc:param value = "<%=opName%>"/>
		<wtc:param value = "<%=ipAddr%>"/>
			
		<wtc:param value = ""/>
		<wtc:param value = ""/>
		<wtc:param value = ""/>
		<wtc:param value = ""/>
		<wtc:param value = ""/>
			
		<wtc:param value = ""/>
		<wtc:param value = ""/>
		<wtc:param value = "0"/>
		<wtc:param value = "Y"/>
		<wtc:param value = ""/>
			
		<wtc:param value = "0"/>
		<wtc:param value = "<%=v_qryChn%>"/>
		<wtc:param value = "<%=v_qryAcc%>"/>
		<wtc:param value = ""/>
	</wtc:service>
	<wtc:array id="rst" scope="end" />

	<%
	errCode = rc_cfm;
	errMsg = rm_cfm;
	
	if( !"000000".equals(errCode))
	{
		appr_rst = errCode.equals("i03738")?"3":( 
			errCode.equals( "i03741" )?"4":(
				errCode.equals( "i03798" )?"5":(
					errCode.equals( "i03740" )?"6":(
						errCode.equals( "i03745" )?"0":(
							errCode.equals( "123896" )?"7":"N"
						)
					)
				)
			)
		);
		if ( !"N".equals(appr_rst) )
		{	
		%>
			<script>
			if (rdShowConfirmDialog( "<%=errCode%>:<%=errMsg%>"
				+"审核结果将被处理成不通过,是否确认?" ) == "1")
			{
				var packet = new AJAXPacket("fi037_ajax.jsp"
					,"正在进行预占处理，请稍等......");
				packet.data.add("accept","<%=accept%>"); 
				packet.data.add("chnSrc","<%=chnSrc%>"); 
				packet.data.add("opCode","<%=opCode%>"); 
				packet.data.add("workNo","<%=workNo%>"); 
				packet.data.add("passwd","<%=passwd%>"); 
				
				packet.data.add("phoNo","<%=phoNo%>"); 
				packet.data.add("usrPwd","<%=usrPwd%>"); 
				packet.data.add("v_qryChn","<%=v_qryChn%>"); 
				packet.data.add("v_iccid","<%=v_iccid%>"); 
				packet.data.add("v_qryAcc","<%=v_qryAcc%>"); 
								
				packet.data.add("appr_rst","<%=appr_rst%>"); 
				packet.data.add("errMsg","<%=errMsg%>"); 
				packet.data.add("vName","<%=vName%>"); 
				packet.data.add("vIdAddr","<%=vIdAddr%>"); 
				packet.data.add("vIdDate","<%=vIdDate%>"); 

				core.ajax.sendPacket(packet,function(packet)
				{
					var retCode = packet.data.findValueByName("retCode");
					var retMsg = packet.data.findValueByName("retMsg");
					
					if(retCode == "000000")
					{
						rdShowMessageDialog( retCode+":"+retMsg , 2 );
					}
					else
					{
						rdShowMessageDialog( retCode+":"+retMsg , 0 );
					}
					window.location = "fi037_lst.jsp?tm_b=<%=tm_b%>"
						+"&opCode=<%=opCode%>"
						+"&opName=<%=opName%>"
						+"&chn_code=<%=v_qryChn%>"
						+"&cur_page=<%=cur_page%>"
						+"&pageNumber=<%=pageNumber%>"
						+"&phoNo=<%=phoNo%>"
						+"&tm_e=<%=tm_e%>";
				} );
			}
			else
			{
				window.history.go(-1);
			}
			</script>
		<%
		}
		else
		{
		%>
			<script>
				rdShowMessageDialog( "<%=rc_cfm%>"+":"+"<%=rm_cfm%>" , 0 );				
				window.history.go(-1);
			</script>  
		<%
		}
	}
	else
	{
	%>
		<script>
			rdShowMessageDialog( "<%=errCode%>"+":"+"<%=errMsg%>" , 2 );
			window.location = "fi037_lst.jsp?tm_b=<%=tm_b%>"
				+"&opCode=<%=opCode%>"
				+"&opName=<%=opName%>"
				+"&chn_code=<%=v_qryChn%>"
				+"&cur_page=<%=cur_page%>"
				+"&pageNumber=<%=pageNumber%>"
				+"&phoNo=<%=phoNo%>"
				+"&tm_e=<%=tm_e%>";
		</script>
	<%
	}
}
%>

