<%
   /*
   * ����: ������Ϣ����
�� * �汾: v1.0
�� * ����: 2007/01/09
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
	DateFormat df = new SimpleDateFormat("yyyyMMdd");
	Date d1=new Date();
	String sysdate=df.format(d1);
	
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
	String region_code = request.getParameter("region_code");
	String begin_time = request.getParameter("begin_time");
	String end_time = request.getParameter("end_time");
 	
 	int errCode=0;
    String errMsg="";

    SPubCallSvrImpl callView = new SPubCallSvrImpl();
    
	ArrayList retArray1 = new ArrayList();
    String[][] result1 = new String[][]{};
	int recordNum1=0;
	String sqlStr1 = "select prepay_least,deposit_least,mark_least,a.pay_type,b.pay_name,to_char(a.begin_time,'yyyymmdd'),to_char(a.end_time,'yyyymmdd') from tMidBillModeRelease a,sPayType b where a.pay_type=b.pay_type and login_accept="+login_accept;
	retArray1 = callView.sPubSelect("7", sqlStr1);
    result1 = (String[][])retArray1.get(0);
    recordNum1 = result1.length;
    if (result1[0][0].trim().length() == 0)  recordNum1 = 0;

	String prepay_least="0.00",deposit_least="0.00",mark_least="0",pay_type="p",pay_name="����",tmpAccType="p",tmpAccTypeName="����";
	if(recordNum1>0)
	{
	    prepay_least=result1[0][0]; 
		deposit_least=result1[0][1]; 
		mark_least=result1[0][2]; 
		pay_type=result1[0][3]; 
		pay_name=result1[0][4]; 
		begin_time=result1[0][5]; 
	  end_time=result1[0][6]; 
	}

    ArrayList retArray2 = new ArrayList();
    String[][] result2 = new String[][]{};
	int recordNum2=0;
	String sqlStr2 = "select a.account_type,b.type_name,fee_code,pay_order,fee_rate,trim(a.detail_code) from tMidYearUserRate a, sAccountType b where a.account_type=b.account_type and a.login_accept="+login_accept;
	retArray2 = callView.sPubSelect("6", sqlStr2);
    result2 = (String[][])retArray2.get(0);
    recordNum2 = result2.length;
    if (result2[0][0].trim().length() == 0)  {
    recordNum2 = 0;
  } else {
  	 	tmpAccType = result2[0][0];
 	    tmpAccTypeName = result2[0][1];
  	}

	System.out.println("result2[0][5]------"+result2[0][5]);

 	//��ȡ���е��Ż���Ϣ
 	//SPubCallSvrImpl callView = new SPubCallSvrImpl();
	ArrayList retArray = new ArrayList();
	String[] paramsIn=new String[6];
	paramsIn[0]=workNo;
	paramsIn[1]=nopass;
	paramsIn[2]="5238";
	paramsIn[3]=login_accept;
	paramsIn[4]=region_code;
	paramsIn[5]="";
	
//	retArray=callView.callFXService("s5238_YearInfoQry",paramsIn,"1");	
//	callView.printRetValue();
//	errCode = callView.getErrCode();
//	errMsg = callView.getErrMsg();
	
//	String[][]sOut_note=(String[][])retArray.get(0);
	

%>

<html>
<head>
<base target="_self">
<title>���˲�Ʒ����</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="/css/jl.css"  rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_util.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_check.js"></script>
<script language="JavaScript">
	
//�ж�������Ƿ�Ϊ����	
function ischinese()
{
 	var ret=false;
 	var s=document.all.detail_code.value;
 	for(var i=0;i<s.length;i++)
 	{
 	 	ret=(s.charCodeAt(i)>=10000);
 	 	if(ret==true)
 	 	{
 	 		rdShowMessageDialog("�������Żݴ�������������ģ�");
 	 		document.all.detail_code.focus();
 	 		return;
 	 	}
 	}
}  

//���Ż������޸�ʱ�Żݴ���Ϊ��
function ChangeDetailType()
{
	document.form1.detail_code.value="";
}



//�����������ʾ����
function addDetail()
{	
	var rows = document.getElementById("mainFour").rows.length;
	var newrow = document.getElementById("mainFour").insertRow(rows);
	newrow.bgColor="#f5f5f5";
	newrow.height="20";
	newrow.align="left"; 
	
  var vFeeCode  =  document.form1.fee_code.value.replace(/,/g,"|");
  var vFeeDetCode  =  document.form1.detail_code.value.replace(/,/g,"|");
   
	newrow.insertCell(0).innerHTML ='<input type="checkbox" name="checkbox1" checked>';
	newrow.insertCell(1).innerHTML ='<input type="text" name="fee_codes" size="6" class="likebutton4" readonly value="'+ vFeeCode +'">';
	newrow.insertCell(2).innerHTML ='<input type="text" name="pay_orders" size="8" class="likebutton4" readonly value="'+ document.form1.pay_order.value +'">';
	newrow.insertCell(3).innerHTML ='<input type="text" name="fee_rates" size="8" class="likebutton4" readonly value="'+ document.form1.fee_rate.value +'">';
	newrow.insertCell(4).innerHTML ='<input type="text" name="detail_codes" size="8" class="likebutton4" readonly value="'+ vFeeDetCode +'">';
		
}

//�ύ����һҳ
function submitAdd()
{      
	if(!checkElement("prepay_least")) 
    {
        document.all.prepay_least.focus();
	    return;
    }
	if(!checkElement("deposit_least")) 
    {
        document.all.deposit_least.focus();
	    return;
    }
	if(!checkElement("mark_least")) 
    {
        document.all.mark_least.focus();
	    return;
    }
	if(!checkElement("pay_type")) 
    {
        document.all.pay_type.focus();
	    return;
    }	
	
	var account_types = new Array();
	var fee_codes = new Array();
	var pay_orders = new Array();
	var fee_rates = new Array();
	var detail_codes = new Array();
	
	if(document.all.checkbox1==undefined)
	{
		//rdShowMessageDialog("û����ɵļ�¼��");
		//return;
	}
	else if(document.all.checkbox1.length==undefined)
	{
		if(document.all.checkbox1.checked) 
		{		  
		  	document.form1.account_types_array.value=document.all.account_type.value;
		  	document.form1.fee_codes_array.value=document.all.fee_codes.value;
		  	document.form1.pay_orders_array.value=document.all.pay_orders.value;
		  	document.form1.fee_rates_array.value=document.all.fee_rates.value;
		  	document.form1.detail_codes_array.value=document.all.detail_codes.value;
		}
		else
		{
			//rdShowMessageDialog("û����ɵļ�¼��");
			//return;
		}
	}
	else if(document.all.checkbox1.length>0)
	{
		var j=0;
		for(var i=0;i<document.all.checkbox1.length;i++)
		{
			if(document.all.checkbox1[i].checked)
			{	
				account_types[j]=document.all.account_type.value;
				fee_codes[j]=document.all.fee_codes[i].value;
				pay_orders[j]=document.all.pay_orders[i].value;
				fee_rates[j]=document.all.fee_rates[i].value;
				detail_codes[j]=document.all.detail_codes[i].value;
				j++;
			}	
		}
		document.form1.account_types_array.value=account_types;
		document.form1.fee_codes_array.value=fee_codes;
		document.form1.pay_orders_array.value=pay_orders;
		document.form1.fee_rates_array.value=fee_rates;
		document.form1.detail_codes_array.value=detail_codes;
		if(j==0)
		{
			//rdShowMessageDialog("û����ɵļ�¼��");
			//return;
		}
	}
	document.form1.action="f5238_opYearInfo_submit.jsp"; 
	document.form1.submit();
}

/**��ѯר������**/
function queryPayType()
{
    var pageTitle = "ר�����Ͳ�ѯ";
    var fieldName = "ר�����|ר������|";
    var sqlStr ="select pay_type,pay_name from sPayType where show_flag='0'   ";
	
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "2|0|1|";
    var retToField = "pay_type|pay_name|";
    if(!PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)) return false;

	return true;
}
/**��ѯ�ʻ�����**/
function queryAccountType()
{
    var pageTitle = "�ʻ����Ͳ�ѯ";
    var fieldName = "�ʻ�����|�ʻ�����|";
    var sqlStr ="select account_type,type_name from sAccountType  where flag='1' ";
	
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "2|0|1|";
    var retToField = "account_type|account_name|";
    if(!PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)) return false;

	return true;
}
function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/page/public/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  
    retInfo = window.showModalDialog(path);
    if(retInfo ==undefined)      
    { 
		return false;  
	}
    var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    while(chPos_field > -1)
    {
        obj = retToField.substring(0,chPos_field);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0,chPos_retInfo);
        document.all(obj).value = valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");
        
    }
	return true;
}

//ѡ��һ����Ŀ����
function queryFeeCode()
{
	var url = "f5238_queryMultiFeeCode.jsp?";
  window.open(url,'','height=600,width=500,scrollbars=yes');	
}
//ѡ�������Ŀ����
function queryDetailCode()
{
	if(!checkElement("fee_code")) 
  {
      document.all.fee_code.focus();
	    return;
  }
  
	var url = "f5238_queryMultiFeeCodeDet.jsp?fee_code="+document.all.fee_code.value;
    window.open(url,'','height=600,width=500,scrollbars=yes');	
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
	  <table align="center" width="98%"  bgcolor="#ffffff">
        <tr>
          <td align="right" width="73%">
            <table width="535" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="42"><img src="/images/jl_ico_2.gif" width="42" height="41"></td>
                <td valign="bottom" width="493">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td background="/images/jl_background_4.gif"><font color="FFCC00"><strong>������Ϣ����</strong></font></td>
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
	  	<input type="hidden" name="mode_code" value="<%=mode_code%>">
	  	<input type="hidden" name="region_code" value="<%=region_code%>">
	    <input type="hidden" name=pay_order value="0">

	  	<input type="hidden" name="account_types_array" >
	  	<input type="hidden" name="fee_codes_array" >
	  	<input type="hidden" name="pay_orders_array" >
	  	<input type="hidden" name="fee_rates_array" >
	  	<input type="hidden" name="detail_codes_array" >
	  	<input type="hidden" name="page_flag" value="">
	  	<TR >
	  		<TD >
	  		  	<TABLE width="100%"  id="mainOne" bgcolor="#FFFFFF" cellspacing="1" border="0">
	            <TBODY>
	  	        	<TR bgcolor="#F5F5F5" >
	  					<TD>
	  						<table width="100%" align="center" id="mainThree" bgcolor="#FFFFFF" cellspacing="1" border="0">
							    <tr bgcolor="#F5F5F5" height="22">
	  								<TD colspan=4><font color="blue">������Ϣ:</font></TD>
	  							</tr>
	  							<tr bgcolor="#F5F5F5" height="22">
	  								<TD width="16%">�ʷѴ��룺</TD>
	  								<TD width="34%"><%=mode_code%></TD>
									<TD width="16%">��ͻ��֣�</TD>
	  								<TD width="34%">									  
									  	<input type=text  v_type="string"  v_must=1 v_minlength=0 v_maxlength=10 v_name="��ͻ���"  name=mark_least maxlength=5 value="<%=mark_least%>">
									  </input>
									</TD>
	  							</tr>    
	  							<tr bgcolor="#F5F5F5" height="22">
	  								<TD>���Ѻ��</TD>
	  								<TD>
									  <input type=text  v_type="string"  v_must=1 v_minlength=0 v_maxlength=10 v_name="���Ѻ��"  name=deposit_least maxlength=5 value="<%=deposit_least%>">
									  </input><font color="red">(��λ��Ԫ)</font>
                                    </TD>
									<TD>���Ԥ�棺</TD>
	  								<TD>
									  <input type=text  v_type="string"  v_must=1 v_minlength=0 v_maxlength=10 v_name="���Ԥ��"  name=prepay_least maxlength=5 value="<%=prepay_least%>">
									  </input><font color="red">(��λ��Ԫ)</font>
									</TD>
	  							</tr>
								<tr bgcolor="#F5F5F5" height="22">
	  								<TD>ר�����ͣ�</TD>
	  								<TD>
									  <input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=2 v_name="ר�����"  name=pay_type value="<%=pay_type%>" maxlength=10 size="10" readonly>
	  								  <input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=20 v_name="ר������"  name=pay_name value="<%=pay_name%>" maxlength=20 readonly>
									  <input class="button" type="button" name="query_payType" onclick="queryPayType()" value="ѡ��">
                                    </TD>
									<TD>�ʻ����ͣ�</TD>
	  								<TD>
									  <input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=2 v_name="�ʻ�����"  name=account_type value="<%=tmpAccType%>" maxlength=10 size="10" readonly>
	  								  <input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=20 v_name="�ʻ�����"  name=account_name value="<%=tmpAccTypeName%>" maxlength=20 readonly>
									  <input class="button" type="button" name="query_accountType" onclick="queryAccountType()" value="ѡ��">
									</TD>
	  							</tr>
	  							<tr bgcolor="#F5F5F5" height="22">
	  								<TD>��ʼʱ�䣺</TD>
	  								<TD>
									<input type=text  v_type="date" v_must=1 v_minlength=1 v_maxlength=8 v_name="��ʼʱ��" name=begin_time value="<%=begin_time.equals("")?sysdate:begin_time%>" maxlength=8 ></input>&nbsp;<font color="red">(YYYYMMDD)</font>
                    </TD>
									<TD>����ʱ�䣺</TD>
	  								<TD>
	  						<input type=text  v_type="date" v_must=1 v_minlength=1 v_maxlength=8 v_name="����ʱ��" name=end_time value="<%=end_time.equals("")?"20500101":end_time%>" maxlength=8 onChange="endTimeChg()" ></input>&nbsp;<font color="red">(YYYYMMDD)</font>
									</TD>
	  							</tr>
						    </table>
	  						<table width="100%" align="center" id="mainThree" bgcolor="#FFFFFF" cellspacing="1" border="0">
							    <tr bgcolor="#F5F5F5" height="22">
	  								<TD colspan=2><font color="blue">��ϸ��Ϣ:</font></TD>
	  							</tr>
								<tr bgcolor="#F5F5F5" height="22">
	  								<TD width="16%">һ����Ŀ�</TD>
	  								<TD width="84%">
									  <input type=text  v_type="string"  v_must=1 v_minlength=1  v_name="һ����Ŀ"  name=fee_code value="" maxlength=10 size="40" >
									  <input class="button" type="button" name="query_feecode" onclick="queryFeeCode()" value="ѡ��">
									</TD>
	  							</tr>
	  						<tr bgcolor="#F5F5F5" height="22">
	  								<TD width="16%">������Ŀ�</TD>
	  								<TD width="84%">
									  <input type=text  v_type="string"  v_must=0 v_minlength=0  v_name="��Ŀ��ϸ"  name=detail_code maxlength=5 size="40" value=""></input>
									  <input class="button" type="button" name="query_detailcode" onclick="queryDetailCode()" value="ѡ��">
									</TD>
	  							</tr>
	  							<!--
								<tr bgcolor="#F5F5F5" height="22">
	  								<TD width="16%">����˳��</TD>
	  								<TD width="84%">
									  <input type=text  v_type="0_9"  v_must=1 v_minlength=0 v_maxlength=5 v_name="����˳��"  name=pay_order maxlength=5  value="0">
									  </input>
									</TD>
	  							</tr>
	  						-->
	  						
								<tr bgcolor="#F5F5F5" height="22">
	  								<TD width="16%">���ѱ��ʣ�</TD>
	  								<TD width="84%">
									  <input type=text  v_type="string"  v_must=1 v_minlength=0 v_maxlength=5 v_name="���ѱ���"  name=fee_rate maxlength=5 value="1"></input>&nbsp;<font color="red">(0-1)
									</TD>
	  							</tr>
								
								<TR bgcolor="#F5F5F5">
	  								<TD height="30" align="center" colspan="2">
	          					 	    <input name="lastButton" type="button" class="button" value="���" onClick="if (check(form1)) addDetail()">
	          					 	    &nbsp;
	          					 	    <input name="nextButton" type="button" class="button" value="���" onClick="reset()" >
	          					 	    &nbsp;
	  								</TD>
	  							</TR>
						    </table>	  							
	  					</TD>
	  	        	</TR>
	            </TBODY>
	          	</TABLE>
	          	<table width="100%" align="center" id="mainFour" bgcolor="#FFFFFF" cellspacing="1" border="0">
	  				<tr bgcolor="#649ECC" height="22">
	  					<TD width="4%"><b>ѡ��<b></TD>
	  					<TD width="8%"><b>һ����Ŀ<b></TD>
	  					<TD width="8%"><b>����˳��<b></TD>
	  					<TD width="8%"><b>���ѱ���<b></TD>
	  					<TD width="8%"><b>��Ŀ��ϸ<b></TD>	
	  				</tr>
					<%
	  					for(int i=0;i<recordNum2;i++)
						{
					%> 
						<tr bgcolor="F5F5F5" height="20"> 
							<td height="20"><input type="checkbox" name="checkbox1" size= "4" checked></td>
                			<td height="20"><input type="text" name="fee_codes" size="40"  readonly value="<%=result2[i][2]%>"></td>
                			<td height="20"><input type="text" name="pay_orders" size="8"  readonly value="<%=result2[i][3]%>"></td>
                			<td height="20"><input type="text" name="fee_rates" size="8"  readonly value="<%=result2[i][4]%>"></td>
                			<td height="20"><input type="text" name="detail_codes" size="40"  readonly value="<%=result2[i][5]%>"></td>
			    		</tr>
			    	<%
						}	
					%>
	  			</table>
				<TABLE width="100%" border=0 align="center" cellSpacing=1 bgcolor="#FFFFFF">
	  			  <TR bgcolor="#F5F5F5">
	  				<TD height="30" align="center">
	          	 	    <input name="nextButton" type="button" class="button" value="ȷ��" onClick="submitAdd()" >
	          	 	    &nbsp;
	          	 	    <input name="reset" type="button" class="button" value="ȡ������" onClick="window.opener.form1.yearInfoButt.disabled=false;window.close()" >
	          	 	    &nbsp;
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

