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
<%@ page import="java.io.*"%>

<%            
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName"); 	
  String iPhoneNo = request.getParameter("srv_no");
            
  String loginNo = (String)session.getAttribute("workNo");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = (String)session.getAttribute("regCode");
 
%>

<head>
<title>�����ñ�����޸�</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language="JavaScript">
<!--
 
  onload=function()
  {
   	self.status="";
   }

  function queryRegionCode()
{
	var regionCode = "<%=regionCode%>";
	var pageTitle = "�ʷѲ�ѯ";
    var fieldName = "��������|��������";//����������ʾ���С����� 
    var sqlStr ="select  region_code, region_name from(select a.region_code region_code , a.region_name region_name from sRegionCode a, sProdLoginCtrl b where decode(b.region_code,'99',b.region_code,a.region_code) = b.region_code and b.login_no ='" + document.all.loginNo.value + "' union select a.region_code region_code , a.region_name region_name from sRegionCode a where region_code ='"+ regionCode+ "') where rownum < 14 order by region_code " ;
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "0|1";//�����ֶ�
    var retToField = "region_code|region_name";//���ظ�ֵ����    
    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
	//window.open("f7960_qryRegionCode.jsp?clear_sm_code=1&clear_mode_use=1","","height=400,width=400,scrollbars=yes");
}	
  function formCommit()
  {
	  	//alert(document.all.end_time.value+"|"+document.all.begin_time.value);	
	  	if(document.all.end_time.value ==""){ 
	  		rdShowMessageDialog("����ʱ�䲻��Ϊ�գ������룡");
			document.all.end_time.focus();
			return;
		}
		form1.submit();
		document.all.end_time.value;	
  }


  function salechage()
{ 
  
  	document.all.commit.disabled=true;
  	//���ù���js
  	var regionCode = "<%=regionCode%>";
    var pageTitle = "Ӫ������Ϣ";
    var fieldName = "�ʷѴ���|�ʷ�����|���ʷѴ���|�����ʷѴ���|��һ���ʷ�|��ʼʱ��";//����������ʾ���С����� 
    var sqlStr = "select sale_code,sale_name,mode_code,color_mode,next_mode,to_char(begin_time,'yyyymmdd') from SCOLORRINGSALECFG where region_code='"+regionCode+"'";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "0|1|2|3|4|5";//�����ֶ�
    var retToField = "sale_code|sale_name|mode_code|color_mode|next_mode|begin_time";//���ظ�ֵ����
    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));  
    document.all.commit.disabled=false;
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
			<tr>
			<td class="blue">��������</td>
			<td>	
				<input class="hidden" type=text  v_type="string" size="8" v_must=0 v_minlength=0 v_maxlength=10 v_name="��������"  name=region_code value="���ѡ��"  maxlength=20 readonly></input><font color="#FF0000">*</font>
				<input class="button" type="button" name="query_regioncode" onclick="queryRegionCode()" value="ѡ��">
			</td>  
			<td class="blue">��������</td>  	
			<td>	
				<input name="region_name" type="text" class="InputGrey" id="region_name" maxlength=20 size="30" v_must=1 v_minlength=1 v_maxlength=30>    
        	</td>
        </tr>
        <tr>    
            <td class="blue">
            	Ӫ������
            </td>
            <td>
            	<input type="text" name="sale_code" id="sale_code" size="9" class="button" maxlength=4 readonly>   
            	<input class="button" type="button" name="query_regioncode" onclick="salechage()" value="ѡ��">       
            </td>   
            <td class="blue">
            	Ӫ��������
            </td>
            <td>
				<input name="sale_name" type="text" class="InputGrey" id="sale_name" size="30" maxlength=80 readonly>
			</td>	
		</tr>
		<tr>
			<td class="blue">
				���ʷѴ���
			</td>
            <td>
				<input name="mode_code" type="text" class="InputGrey" id="mode_code" readonly>
			</td>
     	 	<td class="blue">
       		 �������
      		</td>
      		<td>
				<input name="color_mode" type="text" class="InputGrey" id="color_mode" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">
				ȡ�����ʷѴ���
			</td>
			<td>
				<input name="next_mode" type="text" class="InputGrey" id="next_mode" readonly >
			</td>					
            <td class="blue">
            	��ʼ����
            </td>
            <td>
            	<input type="text" name="begin_time" id="begin_time" class="InputGrey" readonly>
			</td>            
        </tr>
        <tr>
            <td class="blue">
            	��������(YYYYMMDD)
            </td>
            <td>
				<input name="end_time" type="text" class="button" id="end_time" size="9" maxlength=8 >
			</td>
			<td>
				<input name="1" type="hidden" class="InputGrey" id="1" >
			<td>
				<input name="op_flag" type="hidden" class="InputGrey" id="op_flag" value='u'>
			</td>
		</tr>
		<tr>
			<td id="footer" colspan="4">
				<div align="center">
                &nbsp;
				<input name="commit" id="commit" type="button" class="b_foot"   value="��һ��" onClick="formCommit();" disabled >
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
			
			<input type="hidden" name="return_page" value="/npage/bill/f7960_confLog.jsp?opName=<%=opName%>&opCode=7969">
</div>		
 <%@ include file="/npage/include/footer.jsp" %>   	
</form>
</body>
</html>
