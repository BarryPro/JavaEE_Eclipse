   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-17
********************/
%>
              
<%
  String opCode = "5275";
  String opName = "������������";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=gb2312"%>

<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>

<%@ page import="java.util.*"%>

<%
//---------------------------------java������------------------------------------
//��ȡsession��Ϣ
	    
	    String regionCode = (String)session.getAttribute("regCode");
	
	//-----------------------��������--------------------------
	String sqlStr="";
	
      sqlStr ="select region_code,region_name from sRegionCode where region_code='?' Order By region_code";

	
  //	retList = impl.sPubSelect("2",sqlStr,"region",regionCode);
%>

		<wtc:pubselect name="TlsPubSelBoss" outnum="2" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
  	 <wtc:param value="<%=regionCode%>"/>
 	  </wtc:pubselect>
	 <wtc:array id="result_t1" scope="end"/>

<%
  	String[][] retListString = result_t1;

	//----------------------���ҳ���������������---------------------------
  	String sqlStr1 = "select to_char(t.min_pay),to_char(t.max_pay),to_char(t.allow_abackfee),to_char(t.allow_abackhours),to_char(t.allow_abackdays) from  sAgtOtherPara t where t.region_code = '?'";
	
  	//retList1 = impl.sPubSelect("5",sqlStr1,"region",regionCode);
%>

		<wtc:pubselect name="TlsPubSelBoss" outnum="5" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr1%></wtc:sql>
  	 <wtc:param value="<%=retListString[0][0]%>"/>
 	  </wtc:pubselect>
	 <wtc:array id="result_t2" scope="end"/>

<%  	

  	String[][] retListString1 = result_t2;
	String min_pay = "";
	String max_pay = "";
	String allow_abackfee = "";
	String allow_abackhours = "";
	String allow_abackdays = "";

	if(retListString1.length != 0){
		System.out.println(retListString1[0][0]);
		System.out.println(retListString1[0][1]);
		System.out.println(retListString1[0][2]);
		System.out.println(retListString1[0][3]);
		System.out.println(retListString1[0][4]);
		min_pay = retListString1[0][0];
		max_pay = retListString1[0][1];
		allow_abackfee = retListString1[0][2];
		
		allow_abackhours = retListString1[0][3];
		allow_abackdays = retListString1[0][4];

		/* edit by zhaorh
		**int hours_index=allow_abackhours.indexOf(".");
		**int days_index=allow_abackdays.indexOf(".");
		**allow_abackhours=allow_abackhours.substring(0,hours_index);
		**allow_abackdays=allow_abackdays.substring(0,days_index);
		*/
	}
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>������������</title>
<%//-----------------------------------js����-------------------------------------%>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language=javascript>

	//--------------------------------�ύ��------------------------------------
	function commit(){
		if(checkcommit()){
			form1.action="f5275_Cfm.jsp";
			form1.submit();
			return true;
		}
	}
	
	//---------------------------------��ձ�---------------------------------------
	function resetJSP(){
		for(i=0;i<document.form1.elements.length;i++){
			if (document.form1.elements[i].type=="text"){
				document.form1.elements[i].value = "";
			}
		}
	}

	//------------------------------------��֤------------------------------------------
	function checkcommit(){

		if(!checkElement(document.form1.sales_region)){
			return false;
		}else if(!checkElement(document.form1.min_pay)){
			return false;
		}else if(!checkElement(document.form1.max_pay)){
			return false;
		}else if(document.form1.min_pay.value - document.form1.max_pay.value > 0){
			rdShowMessageDialog("���γ�ֵ��С���ܴ��ڵ��γ�ֵ�����");
			return false;
		}else if(!checkElement(document.form1.allow_abackfee)){
			return false;
		}else if(!checkElement(document.form1.allow_abackhours)){
			return false;
		}else if(!checkElement(document.form1.allow_abackdays)){
			return false;
		}else{
			return true;
		}
	}
</script>
</head>
<body onMouseDown="hideEvent()" onKeyDown="hideEvent()">

<form name="form1" method="post">
	<%@ include file="/npage/include/header.jsp" %>                         


	<div class="title">
		<div id="title_zi">������������</div>
	</div>
	

        <table cellspacing="0">
          
          <tr > 
            <td width="20%" height="24"  class="blue">����</td>
            <td width="30%"> 
			<select name="sales_region"  v_name="����" v_type="string" v_must="1">
			<%
				for(int i=0;i < retListString.length;i ++){
			%>
              <option value='<%=retListString[i][0]%>'><%=retListString[i][1]%></option>
			<%
				}
			%>
            </select>
		     <font class="orange">*</font>            
			</td>
            <td width="20%" height="24" >&nbsp;</td>
            <td width="30%">&nbsp;</td>
          </tr>
          <tr > 
            <td width="20%"   class="blue">���γ�ֵ��С���</td>
            <td width="30%"> 
              <input name="min_pay" type="text"  id="min_pay" maxlength="14" v_name="���γ�ֵ��С���" v_type="float" v_must="1" value='<%=min_pay%>' >
		     <font class="orange">*</font>           
			</td>
            <td   class="blue">���γ�ֵ�����</td>
            <td width="30%">
				<input name="max_pay" type="text"  id="max_pay" maxlength="14" v_name="���γ�ֵ��С���" v_type="float" v_must="1" value='<%=max_pay%>'>
			 <font class="orange">*</font>
			</td>
          </tr>
		  
		  <tr > 
            <td width="20%"  class="blue">�����Զ����������:</td>
            <td width="30%"> 
              <input name="allow_abackfee" type="text"  id="allow_abackfee" maxlength="14" v_name="�����Զ����������" v_type="float" v_must="1" value='<%=allow_abackfee%>'>
		     <font class="orange">*</font>           
			</td>
            <td   class="blue">�����Զ��������Сʱ��</td>
            <td width="30%"> 
              <input name="allow_abackhours" type="text"  id="allow_abackhours" maxlength="14" v_name="�����Զ��������Сʱ��" v_type="int" v_must="1" value='<%=allow_abackhours%>'>
		     <font class="orange">*</font>           
			</td>
          </tr>

		  <tr > 
            <td width="20%"   class="blue">�����˹������������</td>
            <td width="30%"> 
              <input name="allow_abackdays" type="text"  id="allow_abackdays" maxlength="14" v_name="�����˹������������" v_type="int" v_must="1" value='<%=allow_abackdays%>'>
		     <font class="orange">*</font>           
			</td>
            <td >&nbsp;</td>
            <td>&nbsp;</td>
          </tr>

          <tr > 
            <td colspan="4" id="footer"> 
              <div align="center"> 
                <input name="submit1" type="button" class="b_foot" value="ȷ��" onClick="commit()">
                &nbsp; 
                <input name="reset" type="button"  class="b_foot" value="���" onClick="resetJSP()">
                &nbsp; 
                <input name="back" onClick="removeCurrentTab()" class="b_foot" type="button"  value="����">
                &nbsp; </div>
            </td>
          </tr>
        </table>


  <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
