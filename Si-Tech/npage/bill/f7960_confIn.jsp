<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.1.8
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page language="java" import="java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import="java.io.*"%>

<%              
  String opCode = request.getParameter("opcode");
  String opName = request.getParameter("opName");
  String iPhoneNo = request.getParameter("srv_no");
            
  String loginNo = (String)session.getAttribute("workNo");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode=orgCode.substring(0,2);
  
  SPubCallSvrImpl co = new SPubCallSvrImpl();
	String  inputParsm [] = new String[1];	
  String prtSql="select lpad(to_char(nvl(max(sale_code),0)+1),4,'0') sale from sColorRingSaleCfg";
  inputParsm[0]=prtSql;
  //paraStr[0]=(((String[][])co1.fillSelect(prtSql))[0][0]).trim();
%>
	<wtc:service name="sPubSelect" routerKey="regioncode" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:param value="<%=inputParsm[0]%>"/>	
	</wtc:service>	
	<wtc:array id="tempArr"  scope="end"/>
<%
  	String Sale_code=tempArr[0][0];
%> 
<%
	String inputArry[] = new String[1];
	String nowtime ="";
	String Tmsql="select sysdate from dual";
	inputArry[0] = Tmsql;
%> 
<wtc:service name="sPubSelect" retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:param value="<%=inputArry[0]%>"/>	
	</wtc:service>	
	<wtc:array id="tempArr1"  scope="end"/>
<%
	String beginTime = tempArr1[0][0].substring(0,8);
%>		
<head>
<title>���ñ�����</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
 
<script language="JavaScript">
 
  onload=function()
  {    
  	//document.all.phoneNo.focus();
   	self.status="";
   }
 
  function queryRegionCode()
{
	var pageTitle = "�ʷѲ�ѯ";
    var fieldName = "��������|��������";//����������ʾ���С����� 
    var sqlStr ="select  region_code, region_name from sRegionCode where region_code between '01' and '13' order by region_code " ;
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "0|1";//�����ֶ�
    var retToField = "region_code|region_name";//���ظ�ֵ����    
    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
	//window.open("f7960_qryRegionCode.jsp?clear_sm_code=1&clear_mode_use=1","","height=400,width=400,scrollbars=yes");
}	
	
 function queryModeCode()
{
	var regionCode = document.form1.region_code.value;	
	var modeCode=document.form1.mode_code.value;	
	var pageTitle = "�ʷѲ�ѯ";
    var fieldName = "���ʷѴ���|���ʷ�����|��־|";//����������ʾ���С����� 
    var sqlStr ="SELECT a.offer_id,a.offer_name,a.offer_type FROM product_offer a, region b, sregioncode c where a.offer_id = b.offer_id and c.region_code='" + document.form1.region_code.value + "' and a.offer_id like '";
    sqlStr = sqlStr+codeChg("%" + modeCode + "%").trim() ;
    sqlStr = sqlStr+"' and a.offer_type='10' order by a.offer_id"  ;
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "3|0|1|2|";//�����ֶ�
    var retToField = "mode_code|mode_name|mode_flag|";//���ظ�ֵ����    
    if(PubSimpSelTwo(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

 function queryColorCode()
{
	var mode_code=document.form1.color_mode.value;	
	var pageTitle = "�ʷѲ�ѯ";
    var fieldName = "�ʷѴ���|�ʷ�����|��־";//����������ʾ���С����� 
    //var sqlStr ="select a.product_code,trim(b.mode_name),a.mode_bind from scolormode a, sbillmodecode b where a.region_code='" + document.form1.region_code.value + "' and a.region_code=b.region_code and a.product_code =b.mode_code and mode_code like '%" + mode_code+ "%' and a.mode_bind='1' and color_type='01'" ;
    var sqlStr = "select a.product_code,trim(b.offer_name),a.mode_bind from scolormode a, PRODUCT_OFFER b where a.region_code='" + document.form1.region_code.value + "' and a.product_code =b.offer_id and offer_id like '%" + mode_code+ "%' and a.mode_bind='1' and color_type='01'";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "0|1|2";//�����ֶ�
    var retToField = "color_mode|color_name|color_flag";//���ظ�ֵ����   
    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}
	
function queryNextMode()
{	
 	var mode_code=document.form1.next_mode.value;	
	var pageTitle = "�ʷѲ�ѯ";
    var fieldName = "�ʷѴ���|�ʷ�����";//����������ʾ���С����� 
    //var sqlStr ="select a.mode_code,trim(c.mode_name) from sbillmodenormal a,sBillModeCode b,sBillModeCode c where a.region_code='" + document.form1.region_code.value + "' and a.mode_code like '%" + mode_code+ "%' and a.region_code=b.region_code and a.sm_code=b.sm_code and a.region_code=c.region_code and a.mode_code=c.mode_code and b.mode_code='" + document.form1.mode_code.value + "' " ;
    /*
    var sqlStr="select a.mode_code,trim(c.offer_name) from sbillmodenormal a,product_offer b,product_offer c,band d where a.region_code='" + document.form1.region_code.value + "' AND b.band_id=d.band_id and a.mode_code like '%" + mode_code+ "%' and a.sm_code = d.sm_code and a.mode_code=c.offer_id and b.offer_id='" + document.form1.mode_code.value + "'";
    */
    var sqlStr="select a.offer_z_id,trim(b.offer_name) from product_offer_relation a,product_offer b where a.offer_a_id='" + document.form1.mode_code.value + " 'and a.relation_type_id=2 and a.offer_z_id=b.offer_id";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "0|1";//�����ֶ�
    var retToField = "next_mode|next_name";//���ظ�ֵ����
    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}	
  //--------2---------��ѯ���ʷ�ר�ú���-------------
function PubSimpSelTwo(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/public/fPubSimpSel_1270.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType + "&opCode=7969";  
    retInfo = window.showModalDialog(path,"","dialogWidth:60");
    if(retInfo ==undefined)      
    {   return false;   }
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


function codeChg(s)
{
  var str = s.replace(/%/g, "%25").replace(/\+/g, "%2B").replace(/\s/g, "+"); // % + \s
  str = str.replace(/-/g, "%2D").replace(/\*/g, "%2A").replace(/\//g, "%2F"); // - * /
  str = str.replace(/\&/g, "%26").replace(/!/g, "%21").replace(/\=/g, "%3D"); // & ! =
  str = str.replace(/\?/g, "%3F").replace(/:/g, "%3A").replace(/\|/g, "%7C"); // ? : |
  str = str.replace(/\,/g, "%2C").replace(/\./g, "%2E").replace(/#/g, "%23"); // , . #
  return str;
}

  function form1Cfm()
  {
		if(document.all.sale_code.value.length==0){
			rdShowMessageDialog("������Ӫ�������룡");
 			document.all.sale_code.focus();
 			return;
 		}
 		else if(document.all.sale_name.value==""){
			rdShowMessageDialog("������Ӫ�������ƣ�");
 			document.all.sale_name.focus();
 			return;
 		}
		else if(document.all.mode_code.value.length==0){
			rdShowMessageDialog("��ѡ���Ʒ���룡");
 			document.all.mode_code.focus();
 			return;
		}
		else if(document.all.mode_name.value.length==0){
			rdShowMessageDialog("��������ȷ�����ʷѴ��룬Ȼ�󰴲�ѯ���߲�����ֱ�ӽ��в�ѯ��");
 			document.all.mode_code.focus();
 			return;
		}
		else if(document.all.color_mode.value.length==0){
			rdShowMessageDialog("��ѡ������Ʒ���룡");
 			document.all.color_mode.focus();
 			return;
		}
		else if(document.all.color_name.value.length==0){
			rdShowMessageDialog("��������ȷ�Ĳ����Ʒ���룬�ٵ��ѯ���߲�����ֱ�ӽ��в�ѯ��");
 			document.all.color_mode.focus();
 			return;
		}
        else if(document.all.next_mode.value.length==0){
			rdShowMessageDialog("��ѡ����һ����Ʒ���룡");
 			document.all.next_mode.focus();
 			return;
 		}
 		else if(document.all.next_name.value.length==0){
			rdShowMessageDialog("��������ȷ�Ĳ�Ʒ���룬Ȼ����ѯ���߲�����ֱ�ӽ��в�ѯ��");
 			document.all.next_mode.focus();
 			return;
 		}
 		else if(document.all.begin_time.value.length==0){
			rdShowMessageDialog("������ҵ��ͨʱ�䣡");
 			document.all.begin_time.focus();
 			return;
 		}else if(document.all.begin_time.value.length < 8){
			rdShowMessageDialog("ҵ��ͨʱ������");
 			document.all.begin_time.focus();
 			return;
 		}	
 		else if(document.all.end_time.value.length==0){
			rdShowMessageDialog("������ҵ�����ʱ�䣡");
 			document.all.end_time.focus();
 			return;
 		}else if(document.all.end_time.value.length < 8){
			rdShowMessageDialog("ҵ�����ʱ������");
 			document.all.end_time.focus();
 			return;
 		}	
 		else if(document.all.end_time.value < document.all.begin_time.value)
 		{
 			rdShowMessageDialog("ҵ�����ʱ�䲻��С�ڿ�ͨʱ�䣡");
 			document.all.end_time.focus();
 			return;	
 		}
 		else 
 		document.all.action="f7960_Cfm.jsp";
        form1.submit();
  }
  

</script>

</head>

<body>
	<form name="form1" method="post" action="f7960_Cfm.jsp" onKeyUp="chgFocus(form1)">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>	
	<table cellspacing="0">
		<tr>
			<td class="blue">��������</td>
			<td>	
				<input class="button" type=text  v_type="string" size="8" v_must=0 v_minlength=0 v_maxlength=10 v_name="��������"  name=region_code value="���ѡ��"  maxlength=20 readonly></input><font color="#FF0000">*</font>
				<input class="button" type="button" name="query_regioncode" onclick="queryRegionCode()" value="ѡ��">
			</td>  
			<td class="blue">��������</td>  	
			<td>	
				<input name="region_name" type="text" class="InputGrey" id="region_name" maxlength=20 size="30" v_must=1 v_minlength=1 v_maxlength=30 readonly>    
        	</td>
        </tr>
        <tr>    
            <td class="blue">
            	Ӫ��������
            </td>
            <td>
            	<input type="text" name="sale_code" id="sale_code" class="InputGrey" maxlength=4 value="<%=Sale_code%>" readonly>          
            </td>   
            <td class="blue">
            	Ӫ��������
            </td>
            <td>
				<input name="sale_name" type="text" class="button" id="sale_name" maxlength=60 size="30" v_must=1 v_minlength=1 v_maxlength=30  >
			</td>	
		</tr>
		<tr>
			<td class="blue">
				���ʷѴ���
			</td>
            <td>
				<input name="mode_code" type="text" class="button" id="mode_code" size="9" maxlength=8 >
				<input class="button" type="button" name="query_modecode" onclick="queryModeCode()" value="��ѯ">
			</td>
			<td class="blue">���ʷ�����</td>  	
			<td>	
				<input name="mode_name" type="text" class="InputGrey" id="mode_name" maxlength=30 size="30" v_must=1 v_minlength=1 v_maxlength=30 readonly >
				<input name="mode_flag" type="hidden" class="button" id="mode_flag" maxlength=30 size="30" v_must=1 v_minlength=1 v_maxlength=30 readonly >    
        	</td> 
        </tr>
        <tr> 
     	 <td class="blue">
       		 �������
      	</td>
      		<td>
				<input name="color_mode" type="text" class="button" id="color_mode" size="9" maxlength=8 >
				<input class="button" type="button" name="query_colorcode" onclick="queryColorCode()" value="��ѯ">
			</td>
			<td class="blue">�����ʷ�����</td>  	
			<td>	
				<input name="color_name" type="text" class="InputGrey" id="color_name" maxlength=30 size="30" v_must=1 v_minlength=1 v_maxlength=30 readonly >    
        		<input name="color_flag" type="hidden" class="button" id="color_flag"  v_must=1 v_minlength=1  readonly >
        	</td> 
        </tr>
        <tr>
			<td class="blue">
				ȡ�����ʷѴ���
			</td>
			<td>
				<input name="next_mode" type="text" class="button" id="next_mode" size="9" maxlength=8 >
				<input class="button" type="button" name="query_nextmode" onclick="queryNextMode()" value="��ѯ">
			</td>
			<td class="blue">�ʷ�����</td>  	
			<td>	
				<input name="next_name" type="text" class="InputGrey" id="next_name" maxlength=30 size="30" v_must=1 v_minlength=1 v_maxlength=30 readonly>    
        		<input name="next_flag" type="hidden" class="button" id="next_flag"  v_must=1 v_minlength=1 readonly> 
        	</td> 
		</tr>
		<tr>	
            <td class="blue">
            	��ʼ����(YYYYMMDD)
            </td>
            <td>
            	<input type="text" name="begin_time" id="begin_time" class="InputGrey" value="<%=beginTime%>" maxlength=8 size="8" readonly>
			</td>            
            <td class="blue">
            	��������(YYYYMMDD)
            </td>
            <td>
				<input name="end_time" type="text" class="button" id="end_time" maxlength=8 size="8" >
				<input name="op_flag" type="hidden" class="InputGrey" id="op_flag" value='a'>
			</td>
		</tr>	
			<td colspan="4" id="footer"> 
				<div align="center"> 
                &nbsp; 
				<input name="commit" id="commit" type="button" class="b_foot"  value="ȷ��" onClick="form1Cfm();" >
                &nbsp; 
                <input name="reset" type="reset" class="b_foot" value="���" >
                &nbsp; 
                <input name="close" onClick="removeCurrentTab();" type="button" class="b_foot" value="�ر�">
                &nbsp; 
                <input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="����">
				</div>
			</td>
		</tr>
	</table>
<div name="licl" id="licl">			
			<input type="hidden" name="iOpCode" value="7969">
			<input type="hidden" name="loginNo" value="<%=loginNo%>">
			<input type="hidden" name="orgCode" value="<%=orgCode%>">			
																												
			<input type="hidden" name="return_page" value="/npage/bill/f7960_confLog.jsp?opName=<%=opName%>&opCode="7969"">	
			<input type="hidden" name="ipAddr" value="<%=(String)session.getAttribute("ipAddr")%>" >	
</div>				
			<%@ include file="/npage/include/footer.jsp" %>        	
</form>
</body>
</html>
