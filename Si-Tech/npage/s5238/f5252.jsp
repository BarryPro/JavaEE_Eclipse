<%
   /*
   * ����: ���˲�Ʒ�ۺ���Ϣ��ѯ
�� * �汾: v1.0
�� * ����: 2007/03/29
�� * ����: hexy
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
	String op_name ="��Ʒ�ۺ���Ϣ��ѯ";
	String op_code ="5252";

	//��ȡ�û�session��Ϣ
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arrSession.get(0);
	String workNo   = baseInfo[0][2];									//����
	String workName = baseInfo[0][3];									//��������
	String org_code = baseInfo[0][16];
	String ip_Addr  = request.getRemoteAddr();
	String[][] pass = (String[][])arrSession.get(4);   
	String nopass  = pass[0][0];                     	//��½����
	String regionCode=org_code.substring(0,2);
	String login_accept="";
	
	
	DateFormat df = new SimpleDateFormat("yyyyMMdd");
	Date d1=new Date();
	String sysdate=df.format(d1);
	
	//��ѯ��ʾ��Ϣ
	String[][] sOut_resouce_type= new String[][]{};
  String[][] sOut_limit_flag	= new String[][]{};
  String[][] sOut_limit_ruler	= new String[][]{};
  String[][] sOut_resouce_code= new String[][]{};
  String[][] sOut_resouce_number= new String[][]{};
  
  String resouce_type		="";
  String limit_flag			="";
  String limit_ruler		="";
  String resouce_code		="";
  String resouce_number	="";
  
	int errCode=0;
  String errMsg="";
  
	//��ȡϵͳ��ˮ
	SPubCallSvrImpl impl = new SPubCallSvrImpl();
	ArrayList retList = new ArrayList();
	String sqlStr="";
	sqlStr ="SELECT sMaxSysAccept.nextval FROM dual";
	retList = impl.sPubSelect("1",sqlStr,"region",regionCode);
	String[][] retListString = (String[][])retList.get(0);
	login_accept=retListString[0][0];
	
%>
<html>
<head>
<title><%=op_name%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../../css/style.css" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_util.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_check.js"></script>
<script language="JavaScript">
//�ж�������Ƿ�Ϊ����
function ischinese()
{
 	var ret=false;
 	var s=document.all.product_code.value;
 	for(var i=0;i<s.length;i++)
 	{
 	 	ret=(s.charCodeAt(i)>=10000);
 	 	if(ret==true)
 	 	{
 	 		rdShowMessageDialog("�����ڲ�Ʒ��������������ģ�");
 	 		document.all.product_code.focus();
 	 		return;
 	 	}
 	}
}

//�ж�������Ƿ�Ϊ����
function optionType()
{
 	if(document.all.option_type.value=="0"){
 		document.all.product_info1.style.display="block";
 		document.all.price_info1.style.display="none";
 		document.all.price_info2.style.display="none";
 		document.all.product_rela1.style.display="none";
 	}else if(document.form1.option_type.value=="1"){
 		document.all.product_info1.style.display="none";
 		document.all.price_info1.style.display="block";
 		document.all.price_info2.style.display="block";
 		document.all.product_rela1.style.display="none";
 	}else if(document.form1.option_type.value=="2"){
 		document.all.product_info1.style.display="block";
 		document.all.price_info1.style.display="none";
 		document.all.price_info2.style.display="none";
 		document.all.product_rela1.style.display="block";
 	}
 	doInit();
}

//ѡ���Ʒ���뼰����
function queryProductCode()
{
	       if(!checkElement("qryLoginNo"))
        {
                document.all.qryLoginNo.focus();
                return;
        }
         if(document.all.beginDate.value!= "")
        {                 
	       if(!checkElement("beginDate"))
        {
                 document.all.beginDate.focus();
                return;
        }
        
        }
        
        if(document.all.endDate.value!= "")
        {                 
	       if(!checkElement("endDate"))
        {
                 document.all.endDate.focus();
                return;
        }
        
        }
       
	var option_type=document.form1.option_type.value;
	var relation_type=document.form1.relation_type.value;
	if(option_type=="2"){//��������Ϊ��Ʒ��ϵ��ʷ��Ϣ
		if(relation_type=="0"){//�������Ϊ"���"
			var sql_str="select  mode_code,mode_name from sBillModeCode where mode_code in(select old_mode from cBillBbChgHis where region_code='<%=regionCode%>'and district_code='"+document.all.district_code.value+"') and region_code ='<%=regionCode%>' ";
		
			if(document.all.product_code.value.length>0&&document.all.product_name.value.length>0){
				sql_str = sql_str+" and mode_code like "+codeChg("'%"+document.all.product_code.value+"%'")+" and mode_name like "+codeChg("'%"+document.all.product_name.value+"%'");
			}else if(document.all.product_code.value.length>0){
				sql_str = sql_str+" and mode_code like "+codeChg("'%"+document.all.product_code.value+"%'");
			}else if(document.all.product_name.value.length>0){
				sql_str = sql_str+" and mode_name like "+codeChg("'%"+document.all.product_name.value+"%'");
			}
		}else if(relation_type=="1"){//�������Ϊ����
			var sql_str="select mode_code,mode_name from sBillModeCode where mode_code in(select mode_code from cBillBaDependHis where region_code='<%=regionCode%>' and district_code="+document.all.district_code.value+") and region_code ='<%=regionCode%>'";
		
			if(document.all.product_code.value.length>0&&document.all.product_name.value.length>0){
				sql_str = sql_str+" and mode_code like "+codeChg("'%"+document.all.product_code.value+"%'")+" and mode_name like "+codeChg("'%"+document.all.product_name.value+"%'");
			}else if(document.all.product_code.value.length>0){
				sql_str = sql_str+" and mode_code like "+codeChg("'%"+document.all.product_code.value+"%'");
			}else if(document.all.product_name.value.length>0){
				sql_str = sql_str+" and mode_name like "+codeChg("'%"+document.all.product_name.value+"%'");
			}
		}
	}else if(option_type=="0"){//��������Ϊ��Ʒ��ʷ��Ϣ
		var sql_str="select  mode_code,mode_name from sBillModeCode where mode_code in(select mode_code from sBillModeCodehis where region_code='<%=regionCode%>') and region_code ='<%=regionCode%>'";
	
		if(document.all.product_code.value.length>0&&document.all.product_name.value.length>0){
			sql_str = sql_str+" and mode_code like "+codeChg("'%"+document.all.product_code.value+"%'")+" and mode_name like "+codeChg("'%"+document.all.product_name.value+"%'");
		}else if(document.all.product_code.value.length>0){
			sql_str = sql_str+" and mode_code like "+codeChg("'%"+document.all.product_code.value+"%'");
		}else if(document.all.product_name.value.length>0){
			sql_str = sql_str+" and mode_name like "+codeChg("'%"+document.all.product_name.value+"%'");
		}
	}
	var title_name="��Ʒ����,��Ʒ����,";
	var element_name="mode_code,mode_name,";
	var element_return="product_code,product_name,";
	var op_name1="��Ʒ����ѡ��";
	var page_name="f5252_List.jsp";
	var param_element="product_code";
	var target_id="meddle2";
	var url="f5252_publicQuery.jsp?element_num=2&return_num=2&op_name1="+op_name1+"&title_name="+title_name+"&element_name="+element_name+"&element_return="+element_return+"&sql_str="+sql_str+"&page_name="+page_name+"&param_element"+param_element+"&target_id="+target_id+"&option_type="+option_type+"&public_flag="+relation_type;
	//escape(url);
	window.open(url,"","height=600,width=400,scrollbars=yes");
	
}

//ѡ���ʷѴ��뼰����
function queryPriceCode()
{
	var price_type=document.form1.price_type.value;
	var sql_str="";
	if(price_type=="0"){
		sql_str="select rate_code,note from sBillRateCode where region_code='<%=regionCode%>' and rate_code in(select rate_code from sBillRateCodehis where region_code='<%=regionCode%>')";
		if(document.all.price_code.value.length>0&&document.all.price_name.value.length>0){
			sql_str = sql_str+" and rate_code like "+codeChg("'%"+document.all.price_code.value+"%'")+" and note like"+codeChg(" '%"+document.all.price_name.value+"%'");
		}else if(document.all.price_code.value.length>0){
			sql_str = sql_str+" and rate_code like "+codeChg("'%"+document.all.price_code.value+"%'");
		}else if(document.all.price_name.value.length>0){
			sql_str = sql_str+" and note like "+codeChg("'%"+document.all.price_name.value+"%'");
		}
	}else if(price_type=="1"){
		sql_str="select month_code,note from sBillMonthCode where region_code='<%=regionCode%>' and month_code in(select month_code from sBillMonthCodeHis where region_code='<%=regionCode%>')";
		if(document.all.price_code.value.length>0&&document.all.price_name.value.length>0){
			sql_str = sql_str+" and month_code like "+codeChg("'%"+document.all.price_code.value+"%'")+" and note like "+codeChg("'%"+document.all.price_name.value+"%'");
		}else if(document.all.price_code.value.length>0){
			sql_str = sql_str+" and month_code like "+codeChg("'%"+document.all.price_code.value+"%'");
		}else if(document.all.price_name.value.length>0){
			sql_str = sql_str+" and note like "+codeChg("'%"+document.all.price_name.value+"%'");
		}
	}else if(price_type=="2"){
		sql_str="select total_code,code_name from sBillTotCode where region_code='<%=regionCode%>' and total_code in(select total_code from sBillTotCodeHis where region_code='<%=regionCode%>')";
		if(document.all.price_code.value.length>0&&document.all.price_name.value.length>0){
			sql_str = sql_str+" and total_code like "+codeChg("'%"+document.all.price_code.value+"%'")+" and code_name like "+codeChg("'%"+document.all.price_name.value+"%'");
		}else if(document.all.price_code.value.length>0){
			sql_str = sql_str+" and total_code like "+codeChg("'%"+document.all.price_code.value+"%'");
		}else if(document.all.price_name.value.length>0){
			sql_str = sql_str+" and code_name like "+codeChg("'%"+document.all.price_name.value+"%'");
		}
	}else if(price_type=="3"){
		rdShowMessageDialog("�Ѿ�ȡ����ҵ���ˣ�");
 		return;
	}else if(price_type=="4"){
		sql_str="select a.function_bill, trim(b.function_name) from sBillFuncFav a, sFuncList b  where a.region_code='<%=regionCode%>' and b.region_code = a.region_code and b.function_code = a.function_code and a.sm_code = b.sm_code and a.function_bill in (select function_bill from sBillFuncFavHis where region_code='<%=regionCode%>') order by a.function_bill";
		if(document.all.price_code.value.length>0&&document.all.price_name.value.length>0){
			sql_str = sql_str+" and a.function_bill like "+codeChg("'%"+document.all.price_code.value+"%'")+" and b.function_name like "+codeChg("'%"+document.all.price_name.value+"%'");
		}else if(document.all.price_code.value.length>0){
			sql_str = sql_str+" and a.function_bill like "+codeChg("'%"+document.all.price_code.value+"%'");
		}else if(document.all.price_name.value.length>0){
			sql_str = sql_str+" and b.function_name like "+codeChg("'%"+document.all.price_name.value+"%'");
		}
	}else if(price_type=="a"){
		sql_str="select a.function_bind, trim(b.function_name) from sBillFuncBind a, sFuncList b  where a.region_code = '<%=regionCode%>' and a.region_code = b.region_code and a.sm_code = b.sm_code and a.function_code = b.function_code and a.function_bind in (select function_bind from sBillFuncBindHis where region_code='<%=regionCode%>') order by a.function_bind";
		if(document.all.price_code.value.length>0&&document.all.price_name.value.length>0){
			sql_str = sql_str+" and a.function_bind like "+codeChg("'%"+document.all.price_code.value+"%'")+" and b.function_name like "+codeChg("'%"+document.all.price_name.value+"%'");
		}else if(document.all.price_code.value.length>0){
			sql_str = sql_str+" and a.function_bind like "+codeChg("'%"+document.all.price_code.value+"%'");
		}else if(document.all.price_name.value.length>0){
			sql_str = sql_str+" and b.function_name like "+codeChg("'%"+document.all.price_name.value+"%'");
		}
	}
	
	
	var title_name="�ʷѴ���,�ʷ�����,";
	var element_name="price_code,price_name,";
	var element_return="price_code,price_name,";
	//var sql_str="select  mode_code,mode_name from sBillModeCode where mode_code in(select mode_code from sBillModeCodehis where region_code='<%=regionCode%>') and region_code ='<%=regionCode%>'";
	
	var op_name1="��Ʒ����ѡ��";
	var page_name="f5252_List.jsp";
	var param_element="product_code";
	var target_id="meddle2";
	var option_type=document.form1.option_type.value;
window.open("f5252_publicQuery.jsp?element_num=2&return_num=2&op_name1="+op_name1+"&title_name="+title_name+"&element_name="+element_name+"&element_return="+element_return+"&sql_str="+sql_str+"&page_name="+page_name+"&param_element"+param_element+"&target_id="+target_id+"&option_type="+option_type+"&public_flag="+price_type,"","height=600,width=400,scrollbars=yes");
	
}
//��պ���
function doInit(){
	var option_type=document.form1.option_type.value;
	if(option_type=="0"){//��������Ϊ��Ʒ��ʷ��Ϣ
		document.all.product_code.value="";
		document.all.product_name.value="";
	}else if(option_type=="1"){//��������Ϊ��Ʒ�ʷ���ʷ��Ϣ
		document.all.price_code.value="";
		document.all.price_name.value="";
	}else if(option_type=="2"){//��������Ϊ��Ʒ��ϵ��ʷ��Ϣ
		document.all.product_code.value="";
		document.all.product_name.value="";
	}
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
                      <td background="/images/jl_background_4.gif"><font color="FFCC00"><strong>��Ʒ��ʷ��Ϣ��ѯ</strong></font></td>
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

  	<TABLE width="98%"  id="mainOne" bgcolor="#FFFFFF" cellspacing="1" border="0" align="center">
	<form name="form1"  method="post">
    <input type="hidden" name="login_accept" value="<%=login_accept%>">
      <TBODY>
      	<TR bgcolor="#F5F5F5">
				<TD>
					<table width="100%" align="center" id="mainFour" bgcolor="#FFFFFF" cellspacing="1" border="0">
						<tr bgcolor="#F5F5F5" height="22">
							<TD>&nbsp;&nbsp;�������ͣ�</TD>
							<TD >
								<select name="option_type" v_name="��������" onChange="optionType()">
									<option value='0' >��Ʒ��ʷ��Ϣ��ѯ</option>
									<option value='1' >�ʷ���ʷ��Ϣ��ѯ</option>
									<option value='2' >��Ʒ��ϵ��ʷ��Ϣ��ѯ</option>
								</select>	
							</TD>
							<TD>&nbsp;&nbsp;�������룺</TD>
							<TD ><font color="red"><input type=text  v_type="string"  v_must=1 v_minlength=2 v_maxlength=2 v_name="��������"  name=region_code  value="<%=regionCode%>" maxlength=2 readonly ></input></font></TD>
						</tr>
						<tr bgcolor="#F5F5F5" height="22">
							<TD>&nbsp;&nbsp;�������ţ�</TD>
							<TD ><font color="red"><input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=6 v_name="��������"  name=qryLoginNo  maxlength=6 ></input></font></TD>
						<TD>&nbsp;&nbsp;�������룺</TD>
							<TD ><font color="red"><input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=4 v_name="��������"  name=qryOpCode  maxlength=4 ></input></font></TD>
						</tr>
  				  
  				  <tr bgcolor="#F5F5F5" height="22">
						<TD>&nbsp;&nbsp;��ʼʱ�䣺</TD>
							<TD ><font color="red"><input type=text  v_type="date"  v_must=0 v_minlength=0 v_maxlength=8 v_name="����ʱ��"  name=beginDate  value="" maxlength=8  ></input> (YYYYMMDD)</font></TD>
						<TD>&nbsp;&nbsp;����ʱ�䣺</TD>
							<TD ><font color="red"><input type=text  v_type="date"  v_must=0 v_minlength=0 v_maxlength=8 v_name="����ʱ��"  name=endDate  value="" maxlength=8 ></input> (YYYYMMDD)</font></TD>
						</tr>
						<tr bgcolor="#F5F5F5" id="product_rela1"  style="display='none'">
							<TD>&nbsp;&nbsp;���ش��룺</TD>
							<TD>
								<select name="district_code" v_name="���ش���" onChange="doInit()">
								<%
									//��ȡ�ʷ�����
									ArrayList retList2 = new ArrayList();  
									String sqlStr2="";
									sqlStr2 ="select district_code,district_name from sDisCode where region_code='"+regionCode+"'";
									retList2 = impl.sPubSelect("2",sqlStr2,"region",regionCode);
									String[][] retListString2 = (String[][])retList2.get(0);
									for(int i=0;i < retListString2.length;i ++)
									{
								%>
										<option value='<%=retListString2[i][0]%>'><%=retListString2[i][1]%></option>
								<%
									}
								%>
								</select>
							</TD>
							<TD>&nbsp;&nbsp;��ϵ���ͣ�</TD>
							<TD>
								<select name="relation_type" v_name="��ϵ����" onChange="doInit()">
									<option value='0' >���</option>
									<option value='1' >����</option>
								</select>
							</TD>
						</tr>
						<tr bgcolor="#F5F5F5" id="product_info1"  style="display='block'">
							<TD>&nbsp;&nbsp;��Ʒ���룺</TD>
							<TD>
							<input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=8 v_name="��Ʒ����"  name=product_code  maxlength=8 onblur="ischinese()"></input><font color="red"></font>
							</TD>
							<TD>&nbsp;&nbsp;��Ʒ���ƣ�</TD>
							<TD>
								<input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=20 v_name="��Ʒ����"  name=product_name  maxlength=20 ></input>
								<input class="button" type="button" name="query_productcode" onclick="queryProductCode()" value="��ѯ">
							</TD>
						</tr>
						<tr bgcolor="#F5F5F5" id="price_info1"  style="display='none'">
							<TD>&nbsp;&nbsp;�ʷ����ͣ�</TD>
							<TD>
								<select name="price_type" v_name="�ʷ�����" onChange="doInit()">
								<%
									//��ȡ�ʷ�����
									ArrayList retList1 = new ArrayList();  
									String sqlStr1="";
									sqlStr1 ="select detail_type,type_name From sBillDetName where detail_type=any('0','1','2','4')";
									retList1 = impl.sPubSelect("2",sqlStr1,"region",regionCode);
									String[][] retListString1 = (String[][])retList1.get(0);
									for(int i=0;i < retListString1.length;i ++)
									{
								%>
										<option value='<%=retListString1[i][0]%>'><%=retListString1[i][1]%></option>
								<%
									}
								%>
								</select>
							</TD>
							<TD></TD>
							<TD></TD>
						</tr>
						<tr bgcolor="#F5F5F5" id="price_info2"  style="display='none'">
							<TD>&nbsp;&nbsp;�ʷѴ��룺</TD>
							<TD>
								<input type=text  v_type="string"  v_must=1 v_minlength=4 v_maxlength=4 v_name="�ʷѴ���"  name=price_code  maxlength=4 onblur="ischinese()"></input><font color="red">(4λ)</font>
							</TD>
							<TD>&nbsp;&nbsp;�ʷ����ƣ�</TD>
							<TD>
								<input type=text  v_type=	"string"  v_must=1 v_minlength=1 v_maxlength=20 v_name="�ʷ�����"  name=price_name  maxlength=20 ></input>
								<input class="button" type="button" name="query_productcode" onclick="queryPriceCode()" value="��ѯ">
							</TD>
						</tr>
					</table>
					<table width="100%" align="center" id="mainTwo" bgcolor="#FFFFFF" cellspacing="1" border="0">
						<tr bgcolor="#F5F5F5" height="22">
							<td colspan="4">
								<IFRAME src="" frameBorder=0 id=middle2 name=meddle2 scrolling="yes" style="HEIGHT: 280; VISIBILITY: inherit; WIDTH: 800; Z-INDEX: 1">
								</IFRAME>
							</td>
						</tr>
					</TABLE>
				</TD>
        </TR>
      </TBODY>
      </TABLE>
      <TABLE width="98%" border=0 align="center" cellSpacing=1 bgcolor="#FFFFFF">
			<TR bgcolor="#F5F5F5">
			<TD height="30" align="center">
				<input name="retcloseButton" type="button" class="button" value="��  ��" onClick="window.close()" >
		 	    &nbsp;
		 	    <input name="closeButton" type="button" class="button"  value="��  ��" onClick="window.close()" >
		 	    &nbsp;
			</TD>
			</TR>
			</TABLE>
	</TD>
</TR>
</TABLE>
</div>
</form>
</body>
</html>

