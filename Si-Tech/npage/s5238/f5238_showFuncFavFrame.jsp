<% 
  /*
   * ����: �ط��Ż�������Ϣ��ʾ-��ʾ��ѯ���Ĳ�Ʒ����
�� * �汾: v1.00
�� * ����: 2007/01/26
�� * ����: shibo
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
   *  
 ��*/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page errorPage="/page/common/errorpage.jsp" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import="java.util.regex.*"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<%
	//��ȡ�û�session��Ϣ
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arrSession.get(0);
	String workNo   = baseInfo[0][2];                 //����
	String workName = baseInfo[0][3];               	//��������
	String org_code = baseInfo[0][16];
	String ip_Addr  = request.getRemoteAddr();
	String[][] pass = (String[][])arrSession.get(4);   
	String nopass  = pass[0][0];                     	//��½����
	String regionCode=org_code.substring(0,2);
	
	//��ȡ����ҳ�õ�����Ϣ
	String login_accept = request.getParameter("login_accept");	
	String detail_code = request.getParameter("detail_code");      
	String sm_code = request.getParameter("sm_code");
	String region_code = request.getParameter("region_code");
	int errCode=0;
    String errMsg="";
	//��ȡ���е��Ż���Ϣ
	SPubCallSvrImpl callView = new SPubCallSvrImpl();
	ArrayList retArray = new ArrayList();
	String[] paramsIn=new String[7];
	paramsIn[0]=workNo;
	paramsIn[1]=nopass;
	paramsIn[2]="5238";
	paramsIn[3]=login_accept;
	paramsIn[4]=region_code;
	paramsIn[5]=detail_code;
	paramsIn[6]=sm_code;
  	
	retArray=callView.callFXService("s5238_FuncShw",paramsIn,"5");	
	callView.printRetValue();
	errCode = callView.getErrCode();
	errMsg = callView.getErrMsg();
	                        
	String[][]sOut_check_flag   =new String[][]{};
	String[][]sOut_function_code=new String[][]{};
	String[][]sOut_function_name=new String[][]{};
	String[][]sOut_favour_rate  =new String[][]{};
	String[][]sOut_day_flag     =new String[][]{};

	if(errCode==0)
	{
		sOut_check_flag=(String[][])retArray.get(0);
		sOut_function_code=(String[][])retArray.get(1);
		sOut_function_name=(String[][])retArray.get(2);
		sOut_favour_rate=(String[][])retArray.get(3);
		sOut_day_flag=(String[][])retArray.get(4);
	}
%>
<html>
<head>
<title>�ޱ����ĵ�</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="/css/jl.css"  rel="stylesheet" type="text/css">
<script>
//------���б���ѡ�е���Ϣ�ύ����ҳ����---------
function commit()
{
	//parent.submitAdd();
	//parent.opener.document.form1.mode_code.value="test";
	var function_codes = new Array();
	var favour_rates = new Array();
	var day_flags = new Array();
	if(document.all.check_flag==undefined)
	{
		rdShowMessageDialog("û��ѡ����ط����룡");
		parent.document.form1.nextButton.disabled=false;
		return;
	}
	else if(document.all.check_flag.length==undefined)
	{
		if(document.all.check_flag.checked)
		{
			document.form1.function_code_array.value=document.all.function_code.value;
			document.form1.favour_rate_array.value=document.all.favour_rate.value;
			if(document.all.day_flag0[0].checked)
			{
		  		document.form1.day_flag_array.value="0";
			}
			else
			{
				document.form1.day_flag_array.value="1";
			}
		}
		else
		{
			rdShowMessageDialog("û��ѡ����ط����룡");
			parent.document.form1.nextButton.disabled=false;
			return;
		}
	}
	else if(document.all.check_flag.length>0)
	{
		var j=0;
		<%
			for(int i=0;i<sOut_check_flag.length;i++)
			{
		%>
				if(document.all.check_flag[<%=i%>].checked)
				{	
					function_codes[j]=document.all.function_code[<%=i%>].value;
					favour_rates[j]=document.all.favour_rate[<%=i%>].value;
					if(document.all.day_flag<%=i%>[0].checked)
					{
		  				day_flags[j]="0";
					}
					else
					{
						day_flags[j]="1";
					}
					j++;
				}
		<%
			}
		%>  
		if(j==0)
		{
			rdShowMessageDialog("û��ѡ����ط����룡");
			parent.document.form1.nextButton.disabled=false;
			return;
		}
		document.form1.function_code_array.value=function_codes;
		document.form1.favour_rate_array.value=favour_rates;
		document.form1.day_flag_array.value=day_flags;
	}
	document.form1.action="f5238_opFuncFav_submit.jsp";
	document.form1.submit();
}

//--------ȫ��ѡ��---------
function selectAll()
{
	if(document.all.check_flag.length==undefined)
	{
		document.all.check_flag.checked=true;
	}
	else if(document.all.check_flag.length>0)
	{
		for(var i=0;i<document.all.check_flag.length;i++)
		{
			document.all.check_flag[i].checked=true;
		}
	}
}

//----ȫ��ȡ��------
function selectNone()
{
	if(document.all.check_flag.length==undefined)
	{
		document.all.check_flag.checked=false;
	}
	else if(document.all.check_flag.length>0)
	{
		for(var i=0;i<document.all.check_flag.length;i++)
		{
			document.all.check_flag[i].checked=false;
		}
	}
}
</script>

</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form target="middle" action="" method="post" name="form1">
<input type="hidden" name="login_accept" value="<%=login_accept%>"> 
<input type="hidden" name="region_code" value="<%=region_code%>">
<input type="hidden" name="sm_code" value="<%=sm_code%>">
<input type="hidden" name="detail_code" value="<%=detail_code%>">
<input type="hidden" name="function_code_array" value="">
<input type="hidden" name="favour_rate_array" value="">
<input type="hidden" name="day_flag_array" value="">
<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
  	<tr>
    	<td>
      		<table width="730"  border="0"  align="center" bordercolor="#D6D3CE" bgcolor="#ffffff" cellspacing="1">
				<%  
						for(int i=0;i<sOut_check_flag.length;i++)
						{
				%>
						<tr bgcolor="#F5F5F5" height="20" >
							<TD width="35"><input type="checkbox" name="check_flag" <%=sOut_check_flag[i][0].equals("1")==true?"checked":""%>></TD>
							<TD width="75"><input type="text" name="function_code" size="8" class="likebutton4" readonly value="<%=sOut_function_code[i][0]%>"></TD>
							<TD width="368"><input type="text" name="function_name" size="20" class="likebutton4" readonly value="<%=sOut_function_name[i][0]%>"></TD>
							<TD width="122"><input type="text" name="favour_rate" size="6" value="<%=sOut_favour_rate[i][0]%>"></TD>
							<TD width="190">
								<input type="radio" name="day_flag<%=i%>" value="0" <%=sOut_day_flag[i][0].equals("0")==true?"checked":""%>>����
	  							<input type="radio" name="day_flag<%=i%>" value="1" <%=sOut_day_flag[i][0].equals("1")==true?"checked":""%>>����
							</TD>
						</tr>
				<%
						}
	  			%>
      		</table>
		</td>
  	</tr>
</table>
</form>	
</body>
</html>  
