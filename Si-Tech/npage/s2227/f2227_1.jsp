<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=gb2312" %>
<script language="JavaScript" src="../../js/common/redialog/redialog.js"></script>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	activePhone = request.getParameter("activePhone");
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arrSession.get(0);
	String workNo   = baseInfo[0][2];                 //����
	String workName = baseInfo[0][3];               //��������
	String belongName = baseInfo[0][16];
	String[][] pass = (String[][])arrSession.get(4);   
	String nopass  = pass[0][0];                     //��½����
	
	String op_name="�˵�����ָ�";
	
	Logger logger = Logger.getLogger("f2227_1.jsp");
	//activePhone = request.getParameter("activePhone");
		
	String[][] custName 	= new String[][]{};		//�ͻ�����
	String[][] month 			= new String[][]{};		//����
	String[][] feeCode		=	new String[][]{};		//һ����Ŀ
	String[][] detailCode = new String[][]{};		//������Ŀ
	String[][] shouldPay 	= new String[][]{};		//Ӧ��
	String[][] favourFee 	=	new String[][]{};		//�Ż�
	String[][] oweFee			=	new String[][]{};		//Ƿ�ѽ��
	String[][] derateFee  =	new String[][]{};		//������
	String[][] accpet     = new String[][]{};		//��ˮ
	String[][] date				= new String[][]{};		//����
	String[][] workNoOut	= new String[][]{};		//����
	String[][] billDay	= new String[][]{};			//����
	String[][] billType	= new String[][]{};			//����
	String[][] feeCode2	= new String[][]{};			//����
	String[][] detailCode2	= new String[][]{};		//����
	
	boolean nextFlag=false;
	
	String action=request.getParameter("action");//�ύ����ҳ��
	
	String phoneno = "";
	String contract_no="";
	String busyType="";
	
	if (action!=null&&action.equals("select"))
	{
	  contract_no=request.getParameter("contract_no");
	  busyType=request.getParameter("busyType");
	  phoneno=request.getParameter("phoneno");
		
		SPubCallSvrImpl callView = new SPubCallSvrImpl();
	 	String paramsIn[] = new String[6];
	 	
	 	paramsIn[0]=contract_no;
	 	paramsIn[1]=phoneno;
	 	paramsIn[2]=workNo+"�����ʵ�����ָ�����";
	 	paramsIn[3]=workNo;
	 	paramsIn[4]="2227";
	 	paramsIn[5]=busyType;
		
		ArrayList acceptList = new ArrayList();
			   
		acceptList = callView.callFXService("s2227", paramsIn, "17");
		callView.printRetValue();
		
		int errCode = callView.getErrCode();
		String errMsg = callView.getErrMsg();
		if(errCode == 0)
		{
		  nextFlag=true;
		  custName 	  = (String[][])acceptList.get(0);
			month 			= (String[][])acceptList.get(1);
			feeCode		  = (String[][])acceptList.get(2);
			detailCode  = (String[][])acceptList.get(3);
			shouldPay 	= (String[][])acceptList.get(4);
			favourFee 	= (String[][])acceptList.get(5);
			oweFee			= (String[][])acceptList.get(6);
			derateFee   = (String[][])acceptList.get(7);
			accpet      = (String[][])acceptList.get(8);
			date				= (String[][])acceptList.get(9);
			workNoOut	  = (String[][])acceptList.get(10);
			billDay	  	= (String[][])acceptList.get(13);
			billType	  = (String[][])acceptList.get(14);
			feeCode2	  = (String[][])acceptList.get(15);
			detailCode2	= (String[][])acceptList.get(16);
			
			if(custName.length==0)
			{
			nextFlag=false;
			%>
			<script language='jscript'>
				rdShowMessageDialog("��ѯ�����޽�����أ�",0);
				history.go(-1);
			</script>
			<%  
			}
		}
	 else
		{
		%>
		<script language='jscript'>
			rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
			history.go(-1);
		</script>
		<%  
		}			
  }
  %>	
<html>
<head>
<base target="_self">
<title><%=op_name%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../../css/style.css" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_util.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_check.js"></script>
<script language=javascript>
  function doQuery()
  {
  	if(!check(form1))
  	return false;
  	document.form1.action = "f2227_1.jsp?action=select";
  	document.form1.submit();
  }
  
  function isKeyNumberdot(ifdot) 
  {       
  	var s_keycode=(navigator.appname=="Netscape")?event.which:event.keyCode;
  	if(ifdot==0)
  	  if(s_keycode>=48 && s_keycode<=57)
  	  return true;
  	  else
  	  	return false;
  	else
  		{
  			if((s_keycode>=48 && s_keycode<=57) || s_keycode==46)
  			{
  				return true;
  			}
  			else if(s_keycode==45)
  				{
  					rdShowMessageDialog('���������븺ֵ,����������!');
  					return false;
  				}
  				else
  					return false;
      }       
  }
  
  function isNumberString (InString,RefString)
  {
  	if(InString.length==0) return (false);
  	for (Count=0; Count < InString.length; Count++)  
  	{
  		TempChar= InString.substring (Count, Count+1);
  		if (RefString.indexOf (TempChar, 0)==-1)  
  		return (false);
    }
    return (true);
  }
  
  function getcount()
  {
  	
  	if( form1.phoneno.value.length<11 || isNumberString(form1.phoneno.value,"1234567890")!=1 ) 
  	{
  		rdShowMessageDialog("������������,����Ϊ11λ���� !!");
  		document.form1.phoneno.focus();
  		document.form1.cfmButton.disabled=true;
  		document.form1.contract_no.value="";
  		return false;
  	}
  	else if (parseInt(form1.phoneno.value.substring(0,3),10)<134 || 159>parseInt(form1.phoneno.value.substring(0,3),10)>139||parseInt(form1.phoneno.value.substring(0,3),10)>159)
  		{
  			rdShowMessageDialog("������134-139����159��ͷ�ķ������ !!");
  			document.form1.phoneno.focus();
  			document.form1.cfmButton.disabled=true;
  			document.form1.contract_no.value="";
  			return false;
      }
      else 
      	{
      		var h=480;
          var w=650;
          var t=screen.availHeight/2-h/2;
          var l=screen.availWidth/2-w/2;
          var prop="dialogHeight:"+300+"px; dialogWidth:"+500+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
         	if (document.form1.busyType.checked) {
						var str=window.showModalDialog('/page/s1300/getCount.jsp?phoneNo='+document.form1.phoneno.value,"",prop);
				  }
					else 
					{
						var str=window.showModalDialog('/page/s1300/getCountdead.jsp?phoneNo='+document.form1.phoneno.value,"",prop);
					}  
         
          if( typeof(str) != "undefined" )
          {
          	if (parseInt(str)==0)
          	{
          		rdShowMessageDialog("û���ҵ���Ӧ���ʺţ�",0);
          		document.form1.cfmButton.disabled=true;
          		document.form1.contract_no.value="";
          		document.form1.phoneno.focus();
          		return false;
  	        } 
  	        else 
  	        	{
  	        		document.form1.contract_no.value=str;
  	        		document.form1.cfmButton.disabled=false;
  	        		return true;
  	          }
  	        document.form1.cfmButton.disabled=false;
  	        return true;
  	      }
  	      else
  	      	{
  	      		rdShowMessageDialog("��Ӧ���ʺ�δ���� ��",0);
            }
        }
  }
  
  <%
	if(nextFlag)//��ѯ����
	{
	%>
			
		  function previouStep()
		  {
		  	document.location.href="f2227_1.jsp";
		  }
		
			function CheckSum()
			{
				
				var sum = 0;
				if(document.form1.checkName.length!=undefined)
				{
					for(var i=0; i< document.form1.elements["checkName"].length; i++ )
					{
						//�Ѽ������ֵ����checkbox
						var derateFee = 'derateFee'+i;
						document.form1.elements["checkName"][i].value=form1[eval('derateFee')].value;					
						
						if(document.form1.elements["checkName"][i].checked)
						{
							
							sum = sum + parseFloat(document.form1.elements["checkName"][i].value);
							
						}		
					}
					form1.derateFeeTotal.value = Math.round(sum*100)/100 ;
				}
			else
				{	
					if(document.form1.checkName.checked)
					{				
						form1.derateFeeTotal.value = form1.derateFee0.value;
					}
				else
					{
						form1.derateFeeTotal.value="";
					}
				}
			}
			
			function doSubmit()
			{
				if(document.form1.checkName ==undefined)
				{
					rdShowMessageDialog("��ѡ��Ҫ����ļ�¼��",0);
					return false;
				}
				
				var accpetStr="";
				var derateFeeStr="";
				var billDayStr="";
				var billTypeStr="";
				var feeCode2Str="";
				var detailCode2Str="";
				var monthStr="";
				
				if(document.form1.checkName.length!=undefined)
				{
					
					for(var i=0; i< document.form1.elements["checkName"].length; i++ )
					{
						var accpet='accpet'+i;
						var derateFee = 'derateFee'+i;
						var detailCode='detailCode2'+i;
						var billDay='billDay'+i;
						var billType='billType'+i;
						var feeCode2='feeCode2'+i;
						var detailCode2='detailCode2'+i;
						var month='month'+i;
						
						if(document.form1.elements["checkName"][i].checked)
						{
							accpetStr=accpetStr+form1[eval('accpet')].value+"|";
							derateFeeStr=derateFeeStr+form1[eval('derateFee')].value+"|";
							billDayStr=billDayStr+form1[eval('billDay')].value+"|";
							billTypeStr=billTypeStr+form1[eval('billType')].value+"|";
							feeCode2Str=feeCode2Str+form1[eval('feeCode2')].value+"|";
							detailCode2Str=detailCode2Str+form1[eval('detailCode2')].value+"|";
							monthStr=monthStr+form1[eval('month')].value+"|";
						}
					}
				}
				else
				{
					if(document.form1.elements.checkName.checked)
					{
						accpetStr=accpetStr+form1.accpet0.value+"|";
						derateFeeStr=derateFeeStr+form1.derateFee0.value+"|";
						billDayStr=billDayStr+form1.billDay0.value+"|";
						billTypeStr=billTypeStr+form1.billType0.value+"|";
						feeCode2Str=feeCode2Str+form1.feeCode20.value+"|";
						detailCode2Str=detailCode2Str+form1.detailCode20.value+"|";
						monthStr=monthStr+form1.month0.value+"|";
					}
				}
				form1.action="f2227_2.jsp?accpetStr="+accpetStr+"&derateFeeStr="+derateFeeStr+"&billDayStr="+billDayStr+"&billTypeStr="+billTypeStr+"&feeCode2Str="+feeCode2Str+"&detailCode2Str="+detailCode2Str+"&monthStr="+monthStr;
				form1.submit();
			}
<%}%>
</script>
</head>

<body bgcolor="#FFFFFF" text="#000000" background="/images/jl_background_2.gif" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >
	<form action="" name="form1"  method="post">
		<%@ include file="../../page/public/headboss2.jsp" %>
		<input type=hidden name="actphone" value="<%=activePhone%>">
		<div id="Operation_Table">
			<TABLE  width="98%" align="center" id="mainOne" bgcolor="#FFFFFF" cellspacing="1" border="0" >
			 <TR bgcolor="#F5F5F5" id="line_1"> 
		  		<td width=10% height = 20>�û����ͣ�</td>
                <TD height = "20">
                    <input name="busyType" type="radio"  value="0" checked>�����û� 
                    <!--<input name="busyType" type="radio"  value="1">�����û� -->
                </td> 
                <td  width="10%" height = 20>&nbsp;</td>
                <td  width="20%" height = 20>���ţ�<%=belongName%></td>
     	</TR>
			 <TR bgcolor="#F5F5F5" id="line_1"> 
		  		<td width=10% height = 20>������룺</td>
	     		<td width=20% height = 20> 
		             <input type="text" name="phoneno" value="<%=activePhone%>" readonly maxlength="11" class="button" onkeydown="if(event.keyCode==13)getcount()" onKeyPress="return isKeyNumberdot(0)" <% if(nextFlag){out.println("readonly");}%>>
		             <input class="button" name=sure22 type=button value=��ѯ�ʺ� onClick="getcount();"  <% if(nextFlag){out.println("disabled");} %>>
	        	</td>	            	
	        	<TD width=10% height = 20>�ʻ�ID��</TD>
	        	<td width=20% height = 20>
	        	  <input type="text"  v_type="int"  v_must=1 v_minlength=1 v_maxlength=14 v_name="�ʻ�ID"  name="contract_no" maxlength=14 <% if(nextFlag){out.println("readonly");}%>>
	        	  <input name="Submit1" id="cfmButton" type="button" class="button"   onKeyUp="if(event.keyCode==13)doQuery();" onMouseUp="doQuery();" style="cursor:hand" disabled value="��ѯ"  <% if(nextFlag){out.println("disabled");} %>>&nbsp;
	        	</td>
	      	</TR>
    	</TABLE>
			<%
			if(nextFlag)//��ѯ����
			{
			%>
						<table align="center" width="98%"  bgcolor="#ffffff">
							<tr bgcolor="#E8E8E8" align="left">
								<td colspan="4"><font size=2><strong>�ʻ���Ϣչʾ</strong></font></td>
							</tr>
              <tr bgcolor="#F5F5F5" >
              	<td align="center"><font size=2>�ͻ�����</font></td>
              	<td align="left"><font size=2><%=custName[0][0]%></font></td>
              	<td>&nbsp;</td><td>&nbsp;</td>
              </tr>
            </table>
			      <table width="98%" align="center" bgcolor="#FFFFFF" cellspacing="1" border="0" >
			      	<tr bgcolor="E8E8E8">
			      		<td  width="8%" height="20" > <div align="center">ѡ��</div></td>
			      		<td  width="8%" height="20" > <div align="center">�·�</div></td>
			      		<td  width="8%" height="20" > <div align="center">һ����Ŀ</div></td>
			      		<td  width="8%" height="20" > <div align="center">������Ŀ</div></td>
			      		<td  width="8%" height="20" > <div align="center">Ӧ��</div></td>
			      		<!--<td  width="8%" height="20" > <div align="center">�Ż�</div></td>				
			      		<td  width="8%" height="20" > <div align="center">Ƿ�ѽ��</div></td>-->
			      		<td  width="8%" height="20" > <div align="center">������</div></td>
			      		<td  width="8%" height="20" > <div align="center">��ˮ</div></td>
			      		<td  width="8%" height="20" > <div align="center">����</div></td>
			      		<td  width="8%" height="20" > <div align="center">��������</div></td>
			      	</tr>
			      	<%
			      	for(int i = 0; i < month.length; i++)
			      	{
				      	if((i+1)%2==1){
				      		out.println("<tr bgcolor=F5F5F5 height=20>");
				      	}else
				      	{
				      		out.println("<tr bgcolor=E8E8E8 height=20>");
				      	}
				      	%>
				      	  <td align="center" height="20">
				      	  	<input type="checkbox" name="checkName"  onclick="CheckSum()" >
				      	  </td> 
				      	  <td align="center" height="20"> <%=month[i][0]%></td> 
				      	  <td align="center" height="20"> <%=feeCode[i][0]%></td> 
	                <td align="center" height="20"> <%=detailCode[i][0]%></td> 
	                <td align="center" height="20"> <%=shouldPay[i][0]%></td> 
	                <!--td align="center" height="20"> <%=favourFee[i][0]%></td> 				
	                <td align="center" height="20"> <%=oweFee[i][0]%></td--> 
	                <td align="center" height="20"> <%=derateFee[i][0]%><input type=hidden name=derateFee<%=i%> value="<%=derateFee[i][0]%>"></td> 
	                <td align="center" height="20"> <%=accpet[i][0]%><input type=hidden name=accpet<%=i%> value="<%=accpet[i][0]%>"></td> 
	                <td align="center" height="20"> <%=date[i][0]%></td> 
	                <td align="center" height="20"> <%=workNoOut[i][0]%></td> 
	              </tr>
	              <input type=hidden name=billDay<%=i%> value="<%=billDay[i][0]%>">
	              <input type=hidden name=billType<%=i%> value="<%=billType[i][0]%>">
	              <input type=hidden name=feeCode2<%=i%> value="<%=feeCode2[i][0]%>">
	              <input type=hidden name=detailCode2<%=i%> value="<%=detailCode2[i][0]%>">
	              <input type=hidden name=month<%=i%> value="<%=month[i][0]%>">
	             
	            <%
              }
              %>		
		        </table>
		        <table align="center" width="98%"  bgcolor="#ffffff">
							<tr bgcolor="#E8E8E8" id="line_1" align="left">
								<td width="30%" colspan="4">
									<font size=2 color=red><strong>�����ܽ��
									<input type="text" name="derateFeeTotal" readonly></strong></font>
								</td>
							</tr>
            </table>
		        <table align="center" width="98%"  bgcolor="#ffffff">
		        	<tr bgcolor="#F5F5F5" id="line_1" align="center"> 
		        		<td colspan="4" align="center" >
		        			<input class="button" name="previous" style="cursor:hand" type=button value="��һ��" onclick="previouStep()">&nbsp;&nbsp;
		        			<input class="button" name="submitButton" style="cursor:hand" type=button value="ȷ��" onclick="doSubmit()">&nbsp;&nbsp;
		        			<input name="Submit2" id="cfmButton2" type="button" class="button"   onclick="window.close()" style="cursor:hand" value="�� ��" >&nbsp;
		        		</td>
		        	</tr>
		        </table>
		      </TD>
		    </TR>
		  </TABLE>
		  <script language='jscript'>
		  	document.form1.phoneno.value="<%=phoneno%>";
		  	document.form1.contract_no.value="<%=contract_no%>";
		  	
		  	var b = "<%=busyType%>";
		  	if(b=="0")
		  	{
		  		document.form1.busyType.checked=true;
		  	}
		  else
		  	{
		  		//document.form1.busyType[1].checked=true;
		  	}
		  	//document.form1.busyType[0].disabled = true;
		  	//document.form1.busyType[1].disabled = true;
		  	
		  	
			</script> 
			<%
			}//end   if(nextFlag==2)    
			%>
    </div>
    <%@ include file="../public/foot.jsp" %>
  </form>
</body>
</html>

