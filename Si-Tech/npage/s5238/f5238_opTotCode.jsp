<%
   /*
   * ����: �ʵ��Ż�����
�� * �汾: v1.0
�� * ����: 2007/01/16
�� * ����: shibo
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>

<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page errorPage="/page/common/errorpage.jsp" %>
<%@ page import = "java.util.*" %>
<%@ page import="java.text.*"%>
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
	
	String login_accept = request.getParameter("login_accept");
	String mode_code = request.getParameter("mode_code");
	String detail_code = request.getParameter("detail_code");
	String note = request.getParameter("note");	
	String region_code = request.getParameter("region_code");
 	String typeButtonNum = request.getParameter("typeButtonNum");
 	String totOrder = request.getParameter("totOrder");
 	
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
	paramsIn[6]=totOrder;
	
	retArray=callView.callFXService("s5238_TotQry",paramsIn,"15");	
	callView.printRetValue();
	errCode = callView.getErrCode();
	errMsg = callView.getErrMsg();
	
	String[][]sOut_order_code    =(String[][])retArray.get(0);
	String[][]sOut_favour_object =(String[][])retArray.get(1);
	String[][]sOut_favour_type   =(String[][])retArray.get(2);
	String[][]sOut_type_mode     =(String[][])retArray.get(3);
	String[][]sOut_favour_cycle  =(String[][])retArray.get(4);
	String[][]sOut_cycle_unit    =(String[][])retArray.get(5);
	String[][]sOut_step_val1     =(String[][])retArray.get(6);
	String[][]sOut_favour1       =(String[][])retArray.get(7);
	String[][]sOut_step_val2     =(String[][])retArray.get(8);
	String[][]sOut_favour2       =(String[][])retArray.get(9);
	String[][]sOut_step_val3     =(String[][])retArray.get(10);
	String[][]sOut_favour3       =(String[][])retArray.get(11);
	String[][]sOut_code_name     =(String[][])retArray.get(12);
	String[][]sOut_first_feeCode =(String[][])retArray.get(13);
	String[][]sOut_second_feeCode=(String[][])retArray.get(14);
	
	//��ѯ�Ѿ����õ��Ż���Ϣ

	SPubCallSvrImpl impTotCode = new SPubCallSvrImpl();
	ArrayList ret_impTotCode = new ArrayList();  
	String sql_impTotCode = "SELECT order_code FROM tMidTotCode WHERE login_accept = " + login_accept + " and region_code = '"+ region_code +"' and total_code = '" + detail_code + "' order by order_code";
	ret_impTotCode = impTotCode.sPubSelect("1",sql_impTotCode,"region",regionCode);
	String[][] retArr_impTotCode = (String[][])ret_impTotCode.get(0);
	/*
	for(int i=0; i<retArr_impTotCode.length; i++){
	  System.out.println("xxxxxxxxxxxxxxxx");
	  System.out.println("xxxxxxxxxxxxxxxx");
	  System.out.println("xxxxxxxxxxxxxxxx");
		System.out.println(retArr_impTotCode[i][0]);
	}
	*/

%>  
    
<html>
<head>
<base target="_self">
<title>�ʵ��Ż�����</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="/css/jl.css"  rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_util.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_check.js"></script>
<script language="JavaScript"> 
    
//-----�ύ���������Ż�����-----
function doSubmit()
{	
	if(document.form1.favour_cycle.value<0)
	{
		rdShowMessageDialog("'�Ż�����'��ֵ����ȷ����������������");
		document.form1.favour_cycle.focus();
		return;
	}
	if(!document.form1.favour_object.checked)
	{
		if(document.form1.first_favour_object.value=="")
		{
			rdShowMessageDialog("�Ż���Ŀ���Ϊ�գ�");
			return;
		}
	}
	document.form1.nextButton.disabled=true;
	document.form1.action="f5238_opTotCode_submit.jsp"; 
	document.form1.submit();
}

//��ѯһ����Ŀ��
function queryFirstFeeCode()
{
	var url = "f5238_queryFirstFeeCode.jsp?second_favour_object=1";
	window.open(url,'','height=600,width=400,left=50,scrollbars=yes');
}


//��ѯ������Ŀ��
function querySecondFeeCode()
{
	if(document.form1.region_code.value!="")
	{
	    var url = "f5238_querySecondFeeCode.jsp?first_favour_object="+document.form1.first_favour_object.value;
		window.open(url,'','height=600,width=500,left=100,scrollbars=yes');
	}
	else
	{
		rdShowMessageDialog("����ѡ��������룡");
		document.form1.query_regioncode.focus();
	}
}

function showThisTotOrder()
{
		var totOrder="";
	  for(var i=0;i<document.all.totOrder.length;i++)
	  {
		  if(document.all.totOrder[i].checked == true)
		  {
			  totOrder=document.all.totOrder[i].value;
		  }
	  }
	  
	//alert(totOrder);
	document.form1.action = "f5238_opTotCode.jsp?apply_flag=Y&login_accept=<%=login_accept%>&detail_code=<%=detail_code%>&note=<%=note%>&mode_code=<%=mode_code%>&region_code=<%=region_code%>&typeButtonNum=<%=typeButtonNum%>&totOrder=" +totOrder ;
	document.form1.submit();
}

//��Ŀ��ѡ��ȫ�����
function onClickFavourObject()
{
	if(document.form1.favour_object.checked)
	{
		document.form1.query_FirstFeeCode.disabled=true;
		document.form1.query_SecondFeeCode.disabled=true;
		document.form1.first_favour_object.v_must="0";
	}
	else
	{
		document.form1.query_FirstFeeCode.disabled=false;
		document.form1.query_SecondFeeCode.disabled=false;
		document.form1.first_favour_object.v_must="1";
	}
}

//�����Ż�����
function setFavcondType()
{
	if(document.form1.favcond_type.value=="0")
	{
		var url = "f5238_setFavcondType0.jsp?login_accept=<%=login_accept%>&region_code=<%=region_code%>&detail_code=<%=detail_code%>&favcond_coder_code="+document.form1.favcond_coder_code.value+"&condetion_coder="+document.form1.condetion_coder.value+"&local_expr="+document.form1.local_expr.value+"&favcond_type="+document.form1.favcond_type.value;
		window.open(encodeURI(url),'','height=600,width=800,left=100,scrollbars=yes');
	}
	else if(document.form1.favcond_type.value=="9")
	{
		var url = "f5238_setFavcondType9.jsp?login_accept=<%=login_accept%>&region_code=<%=region_code%>&detail_code=<%=detail_code%>&favcond_coder_code="+document.form1.favcond_coder_code.value+"&condetion_coder="+document.form1.condetion_coder.value+"&local_expr="+document.form1.local_expr.value+"&favcond_type="+document.form1.favcond_type.value;
		window.open(encodeURI(url),'','height=600,width=800,left=100,scrollbars=yes');
	}
	else if(document.form1.favcond_type.value=="3")
	{
		var url = "f5238_setFavcondType3.jsp?login_accept=<%=login_accept%>&region_code=<%=region_code%>&detail_code=<%=detail_code%>&favcond_coder_code="+document.form1.favcond_coder_code.value+"&condetion_coder="+document.form1.condetion_coder.value+"&local_expr="+document.form1.local_expr.value+"&favcond_type="+document.form1.favcond_type.value;
		window.open(encodeURI(url),'','height=600,width=800,left=100,scrollbars=yes');
	}
	else if(document.form1.favcond_type.value=="2")
	{
		var url = "f5238_setFavcondType2.jsp?login_accept=<%=login_accept%>&region_code=<%=region_code%>&detail_code=<%=detail_code%>&favcond_coder_code="+document.form1.favcond_coder_code.value+"&condetion_coder="+document.form1.condetion_coder.value+"&local_expr="+document.form1.local_expr.value+"&favcond_type="+document.form1.favcond_type.value;
		window.open(encodeURI(url),'','height=600,width=800,left=100,scrollbars=yes');
	}
	else if(document.form1.favcond_type.value=="5")
	{
		var url = "f5238_setFavcondType5.jsp?login_accept=<%=login_accept%>&region_code=<%=region_code%>&detail_code=<%=detail_code%>&favcond_coder_code="+document.form1.favcond_coder_code.value+"&condetion_coder="+document.form1.condetion_coder.value+"&local_expr="+document.form1.local_expr.value+"&favcond_type="+document.form1.favcond_type.value;
		window.open(encodeURI(url),'','height=600,width=800,left=100,scrollbars=yes');
	}
}
//���õ�����Ŀ��
function opLowestFee()
{
	if(document.all.order_code.value=="")
	{
	    rdShowMessageDialog("�Ż�˳����Ϊ�գ�");
		  return;
	}
    var url = "f5238_opLowestFee.jsp?login_accept=<%=login_accept%>&total_code=<%=detail_code%>&region_code=<%=region_code%>&tot_order="+document.all.order_code.value;
	escape(url);
	window.open(url,'','height=600,width=900,left=20,scrollbars=yes');
}
</script>
</head>

<body bgcolor="#FFFFFF" text="#000000" background="/images/jl_background_2.gif" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  onMouseDown="hideEvent()" onKeyDown="hideEvent()">
<table width="767" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td background="../../images/jl_background_1.gif">
      <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr> 
          <td align="right" width="45%"> 
            <p><img src="../../images/jl_chinamobile.gif" width="226" height="26"></p>
            </td>
             
          <td width="55%" align="right"><img src="../../images/jl_ico_1.gif" width="13" height="14" hspace="3" align="absmiddle">���ţ�<%=baseInfo[0][2]%>
          <img src="../../images/jl_ico_1.gif" width="13" height="14" hspace="3" align="absmiddle">����Ա��<%=baseInfo[0][3]%> 
          </td>
        </tr>
      </table>
      <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr> 
          <td align="right" background="../../images/jl_background_3.gif" height="69"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td><img src="../../images/jl_logo.gif"></td>
                <td align="right"><img src="../../images/jl_head_1.gif"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
	  <table align="center" width="98%"  bgcolor="#ffffff">
        <tr>
          <td align="right" width="73%">
            <table width="535" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="42"><img src="/images/jl_ico_2.gif" width="42" height="41"></td>
                <td valign="bottom" width="493">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td background="/images/jl_background_4.gif"><font color="FFCC00"><strong>��Ʒ��<%=mode_code%>���ʵ��Ż�����</strong></font></td>
                      <td><img src="/images/jl_ico_3.gif" width="240" height="30"></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
          <td width="27%">
            <table border="0" cellspacing="0" cellpadding="4" align="right">
              <tr>
                <td><img src="/images/jl_ico_4.gif" width="60" height="50"></td>
                <td><img src="/images/jl_ico_5.gif" width="60" height="50"></td>
                <td><img src="/images/jl_ico_6.gif" width="60" height="50"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
	  <TABLE width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
	  <form name="form1"  method="post">
	  <input type="hidden" name="login_accept" value="<%=login_accept%>">
	  <input type="hidden" name="detail_code" value="<%=detail_code%>">
	  <input type="hidden" name="note" value="<%=note%>">
	  <input type="hidden" name="region_code" value="<%=region_code%>">
	  <input type="hidden" name="typeButtonNum" value="<%=typeButtonNum%>">
	  	<TR >
	  		<TD >
	  		  	<TABLE width="100%"  id="mainOne" bgcolor="#FFFFFF" cellspacing="1" border="0">
	            <TBODY>
	  				<tr bgcolor="#F5F5F5">
	  					<TD height="22">&nbsp;&nbsp;�Żݴ��룺</TD>
	  					<TD>
	  						<%=detail_code%>
	  					</TD>
	  					<TD height="22">&nbsp;&nbsp;�Ż�������</TD>
	  					<TD>
	  						<%=note%>
	  					</TD>
	  				</tr>
	  				<tr bgcolor="#F5F5F5">
	  					<TD>&nbsp;&nbsp;�Ż�˳��</TD>
	  					<TD colspan="3">
	  						<!--
	  						<input type=text  v_type="int" v_must=1 v_minlength=1 v_maxlength=5 v_name="�Ż�˳��" name=order_code maxlength=5 value="<%=sOut_order_code[0][0].equals("")?"0":sOut_order_code[0][0]%>"></input>
	  						-->
	  						<input type=text  v_type="int" v_must=1 v_minlength=1 v_maxlength=5 v_name="�Ż�˳��" name=order_code maxlength=5 value="<%=totOrder%>"></input>
	  						<font color="red">(������) </font>
	  						<!-- ��̬����Ѿ����õ��Ż�˳�� -->
	  						<% for(int i=0; i<retArr_impTotCode.length; i++){%> 
	  						<input type="radio" name="totOrder" <% if(retArr_impTotCode[i][0].equals(totOrder))out.println("checked");%> value="<%=retArr_impTotCode[i][0]%>" onClick="showThisTotOrder()">���(<%=retArr_impTotCode[i][0]%>)</input>
	  						<% } %>
	  					</TD>
	  				</tr>
	  				<tr bgcolor="#F5F5F5">
	  					<TD valign="top" height="25">&nbsp;&nbsp;�Ż���Ŀ�</TD>
	  					<TD colspan="3">
	  						<input type="checkbox" name="favour_object" value="*" <%=sOut_favour_object[0][0].equals("*")==true?"checked":""%> onclick="onClickFavourObject()" >ȫ��<br>
	  						һ����Ŀ�<input type=text v_type="string" v_must="0" v_minlength=0 v_maxlength=246 v_name="һ����Ŀ��" name=first_favour_object maxlength=246 size="80"  ></input>
	  									<input class="button" type="button" name="query_FirstFeeCode" onclick="queryFirstFeeCode()" value="ѡ��" <%=sOut_favour_object[0][0].equals("*")==true?"disabled":""%>><br>
	  						������Ŀ�<input type=text  v_type="string" v_must="0" v_minlength=0 v_maxlength=246 v_name="������Ŀ��" name=second_favour_object maxlength=246 size="80"  value=<%=sOut_favour_object[0][0].equals("*")==true?"":sOut_favour_object[0][0]%>></input>
	  									<input class="button" type="button" name="query_SecondFeeCode" onclick="querySecondFeeCode()" value="ѡ��" <%=sOut_favour_object[0][0].equals("*")==true?"disabled":""%>>
	  					</TD>
	  				</tr>
	  				<tr bgcolor="#F5F5F5">
	  					<TD>&nbsp;&nbsp;�Żݷ�ʽ��</TD>
	  					<TD colspan="3">
	  						<input type="radio" name="favour_type" value="1" <%=sOut_favour_type[0][0].equals("1")?"checked":""%><%=sOut_favour_type[0][0].equals("")?"checked":""%>>����
	  						<input type="radio" name="favour_type" value="0" <%=sOut_favour_type[0][0].equals("0")?"checked":""%>>�ͷ�
							<input type="radio" name="favour_type" value="3" <%=sOut_favour_type[0][0].equals("3")?"checked":""%>>����
	  					</TD>
	  				</tr>
	  				<tr bgcolor="#F5F5F5">
	  					<TD>&nbsp;&nbsp;�ͷѷ�ʽ��</TD>
	  					<TD colspan="3">
	  						<input type="radio" name="type_mode" value="0" <%=sOut_type_mode[0][0].equals("0")?"checked":""%><%=sOut_type_mode[0][0].equals("")?"checked":""%>>����ͷ�
	  						<input type="radio" name="type_mode" value="1" <%=sOut_type_mode[0][0].equals("1")?"checked":""%>>�����ͷ�
	  					</TD>
	  				</tr>
	  				<tr bgcolor="#F5F5F5">
	  					<TD>&nbsp;&nbsp;�Ż����ڣ�</TD>
	  					<TD colspan="3">
	  						<input type=text  v_type="int" v_must=1 v_minlength=1 v_maxlength=4 v_name="�Ż�����" name=favour_cycle maxlength=4 value="<%=sOut_favour_cycle[0][0].equals("")?"1":sOut_favour_cycle[0][0]%>"></input>
	  						<font color="red">(�����������ֵΪ9999)</font>
	  					</TD>
	  				</tr>
	  				<tr bgcolor="#F5F5F5">
	  					<TD>&nbsp;&nbsp;���ڵ�λ��</TD>
	  					<TD colspan="3">
	  						<input type="radio" name="cycle_unit" value="2" <%=sOut_cycle_unit[0][0].equals("2")?"checked":""%><%=sOut_cycle_unit[0][0].equals("")?"checked":""%>>������
	  						<input type="radio" name="cycle_unit" value="3" <%=sOut_cycle_unit[0][0].equals("3")?"checked":""%>>��
	  					</TD>
	  				</tr>
	  				<tr bgcolor="#F5F5F5">
	  					<TD width="15%">&nbsp;&nbsp;STEP_VAL1��</TD>
	  					<TD width="35%">
	  						<input type=text  v_type="string" v_must=1 v_minlength=1 v_maxlength=19 v_name="STEP_VAL1" name=step_val1 maxlength=19 value="<%=sOut_step_val1[0][0].equals("")?"-1":sOut_step_val1[0][0]%>"></input>
	  					</TD>
	  					<TD width="15%">&nbsp;&nbsp;FAVOUR1��</TD>
	  					<TD width="35%">
	  						<input type=text  v_type="string" v_must=1 v_minlength=1 v_maxlength=19 v_name="FAVOUR1" name=favour1 maxlength=19 value="<%=sOut_favour1[0][0].equals("")?"0":sOut_favour1[0][0]%>"></input>
	  					</TD>
	  				</tr>
	  				<tr bgcolor="#F5F5F5">
	  					<TD width="15%">&nbsp;&nbsp;STEP_VAL2��</TD>
	  					<TD width="35%">
	  						<input type=text  v_type="string" v_must=1 v_minlength=1 v_maxlength=19 v_name="STEP_VAL2" name=step_val2 maxlength=19 value="<%=sOut_step_val2[0][0].equals("")?"-1":sOut_step_val2[0][0]%>"></input>
	  					</TD>
	  					<TD width="15%">&nbsp;&nbsp;FAVOUR2��</TD>
	  					<TD width="35%">
	  						<input type=text  v_type="string" v_must=1 v_minlength=1 v_maxlength=19 v_name="FAVOUR2" name=favour2 maxlength=19 value="<%=sOut_favour2[0][0].equals("")?"0":sOut_favour2[0][0]%>"></input>
	  					</TD>
	  				</tr>
	  				<tr bgcolor="#F5F5F5">
	  					<TD width="15%">&nbsp;&nbsp;STEP_VAL3��</TD>
	  					<TD width="35%">
	  						<input type=text  v_type="string" v_must=1 v_minlength=1 v_maxlength=19 v_name="STEP_VAL3" name=step_val3 maxlength=19 value="<%=sOut_step_val3[0][0].equals("")?"-1":sOut_step_val3[0][0]%>"></input>
	  					</TD>
	  					<TD width="15%">&nbsp;&nbsp;FAVOUR3��</TD>
	  					<TD width="35%">
	  						<input type=text  v_type="string" v_must=1 v_minlength=1 v_maxlength=19 v_name="FAVOUR3" name=favour3 maxlength=19 value="<%=sOut_favour3[0][0].equals("")?"0":sOut_favour3[0][0]%>"></input>
	  					</TD>
	  				</tr>
	            </TBODY>
	          	</TABLE>
	          	<table width="100%" align="center" id="mainFour" bgcolor="#FFFFFF" cellspacing="1" border="0">
	  				<tr bgcolor="#888888">
	  					<TD height="2"></TD>
	  				</tr>
	  			</table>
	          	<table width="100%" align="center" id="mainFour" bgcolor="#FFFFFF" cellspacing="1" border="0">
	  				<tr bgcolor="#F5F5F5">
	  					<TD>&nbsp;&nbsp;�Ż��������ͣ�</TD>
	  					<TD colspan="5">
	  						<select name="favcond_type" v_name="�Ż���������">
    		        			<option value="0">0-->���»���Ϊ����</option>
    		        			<option value="9">9-->�����Ż�Ϊ����</option>
    		        			<option value="3">3-->�û�����Ϊ����</option>
    		        			<option value="2">2-->������ϢΪ����</option>
    		        			<option value="5">5-->�µ��Ż�Ϊ����</option>
	  						</select>
	  					</TD>
	  				</tr>
	  				<tr bgcolor="#F5F5F5">
	  					<TD width="15%">&nbsp;&nbsp;�Ż�˳��</TD>
	  					<TD width="18%">
	  						<input type=text  v_type="int" v_must=1 v_minlength=1 v_maxlength=5 v_name="�Ż�˳��" name=favcond_coder_code maxlength=5 value="<%=totOrder%>" size="12" readonly ></input>
	  					</TD>
	  					<TD width="15%">&nbsp;&nbsp;�Ż�����˳��</TD>
	  					<TD width="18%">
	  						<input type=text  v_type="int" v_must=1 v_minlength=1 v_maxlength=5 v_name="�Ż�����˳��" name=condetion_coder maxlength=5 value="0" size="12"></input>
	  					</TD>
	  					<TD width="15%">&nbsp;&nbsp;������ϵ��</TD>
	  					<TD width="18%">
	  						<select name="local_expr" v_name="������ϵ">
    		        			<option value="and">and-->�ۼ��Ż�</option>
    		        			<option value="or">or-->�����Ż�</option>
	  						</select>
	  					</TD>
	  				</tr>
	  				<TR bgcolor="#F5F5F5">
	  					<TD height="30" align="center" colspan="6">
	          		 	    <input name="lastButton" type="button" class="button" value="�����Ż�����" onClick="setFavcondType()">
	  					</TD>
	  				</TR>
	  			</table>
	  			<table width="100%" align="center" id="mainThree" bgcolor="#FFFFFF" cellspacing="1" border="0">
	  				<tr bgcolor="#649ECC" height="25">
	  					<TD align="center" width="12%"><b>�Ż���������<b></TD>
	  					<TD align="center" width="8%"><b>�Ż�˳��<b></TD>
	  					<TD align="center" width="12%"><b>�Ż�����˳��<b></TD>
	  					<TD align="center" width="8%"><b>������ϵ<b></TD>
	  					<TD align="center" width="27%"><b>�Ż�����<b></TD>
	  					<TD align="center" width="15%"><b>��������<b></TD>
	  					<TD align="center" width="10%"><b>��ϵ���ʽ<b></TD>
	  					<TD align="center" width="8%"><b>��ֵ<b></TD>
	  				</tr>
	  				<tr bgcolor="#F5F5F5" height="22" >
	  					<td colspan="8">
	  						<IFRAME src="f5238_opTotCodeFrame.jsp?login_accept=<%=login_accept%>&region_code=<%=region_code%>&total_code=<%=detail_code%>" frameBorder=0 id=middle name=middle scrolling="yes" style="HEIGHT: 200; VISIBILITY: inherit; WIDTH: 748; Z-INDEX: 1">
      		  	  			</IFRAME>
      		  	  		</td>
	  				</tr>
	          	</TABLE>
	          	<TABLE width="100%" border=0 align="center" cellSpacing=1 bgcolor="#FFFFFF">
	  			  <TR bgcolor="#F5F5F5">
	  				<TD height="30" align="center">
	          	 	    <input name="nextButton" type="button" class="button" value="ȷ��" onClick="if (check(form1)) doSubmit()" >
	          	 	    &nbsp;
	          	 	    <input name="reset" type="button" class="button" value="ȡ������" onClick="window.opener.form1.typeButton<%=typeButtonNum%>.disabled=false;window.close()" >
	          	 	    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input name="opLowestFeeButt" type="button" class="button" value="���õ�����Ŀ��" onClick="opLowestFee()" >
	  				</TD>
	  			  </TR>
	  	    	</TABLE>
	  			<BR>
	  			<BR>		
	  		</TD>
	  	</TR>
	  </form>
	  </TABLE>
	</TD>
  </TR>
</TABLE>
</body>
</html>

