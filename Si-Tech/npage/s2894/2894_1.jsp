<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
	//��ȡ�û�session��Ϣ	
	String workNo   = WtcUtil.repNull((String)session.getAttribute("workNo"));                 //����
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));              //��������
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String ip_Addr  = WtcUtil.repNull((String)session.getAttribute("ipAddr"));	
	String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));                   //��½����	
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
			
	Logger logger = Logger.getLogger("2894_1.jsp");
	String op_name="SI/ECҵ���Ʒ��ϵά��";
	String opCode = "2894";
	String opName = op_name;

%>	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base target="_self">
<title><%=op_name%></title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

<script language=javascript>
	onload=function(){
	changebizType();
	}
	
	function queryEC()
	{		
		
		var bizCode 	= document.all.bizCode.value;
		var spCode 	= document.all.spCode.value;
		var bizType 	= document.all.bizType.value;
		document.middle.location="s2894QueryEC.jsp?a=1"
			+ "&bizType=" + bizType
			+ "&spCode=" + spCode
			+ "&bizCode=" + bizCode;


	}	
function addEC()
{
	window.open("s2894AddEC.jsp?height=600,width=400,scrollbars=yes");

}

	function queryEC1()
	{		
		
		var bizCode 	= document.all.bizCode.value;
		var spCode 	= document.all.spCode.value;
		var bizType 	= document.all.bizType.value;
		document.middle.location="f3052QueryList1.jsp?a=1"
			+ "&bizType=" + bizType
			+ "&spCode=" + spCode
			+ "&bizCode=" + bizCode;


	}	
function addEC1()
{
	window.open("s2894AddEC1.jsp?height=600,width=400,scrollbars=yes");
}

function changebizType()
{
	var rbiztype = document.form1.bizType.value;

		if(rbiztype=="0")
	{
		$("#biznameA").css("display","");
    $("#biznameM").css("display","none");
	}
	else{		
		$("#biznameA").css("display","none");
    $("#biznameM").css("display","");
	}
	
}
</script>

</head>

<body>
<form action="" name="form1"  method="post">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">SI/ECҵ���Ʒ��ϵά��</div>
</div>
<table cellspacing=0>
	  <tr>
	  <TD class='blue'>ҵ������</TD>
        <TD colspan="3">
            <select id="bizType" name="bizType" onChange="changebizType()">
						    <option value="1">����MAS</option> 
              	<option value="0">ADC</option> 
						</select> <font class='orange'>*</font>							
					</TD>	
				
	  </tr>	
    <tr>
        <TD  class='blue'><span id='biznameA' style='display:none;'>SI��ҵ����</span>
        	<span id='biznameM' style='display:none;'>���ű���</span></TD>
        <TD >
            <input type=text name=spCode v_type=int v_must=0 v_maxlength=6></input> 
            <font class='orange'>*</font>
        </TD>
        <TD  class='blue'>ҵ�����</TD>
        <TD >
            <input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=10 name=bizCode maxlength=10 value="" />
            <font class='orange'>*</font>
        </TD>
    </tr>
</table>
		
<TABLE cellspacing="0">	    
    <TR id="footer"> 
     	<TD> 
     	    <input name="queryAcBtn" style="cursor:hand" type="button" class="b_foot_long" value="��ѯ�������ʷ�" onClick="queryEC();">
     	    <input name="newAcBtn"   style="cursor:hand" type="button" class="b_foot_long" value="�������ʷ�" onClick="addEC();">
     	    <input name="queryAcBtn" style="cursor:hand" type="button" class="b_foot_long" value="��ѯ��Ա�ʷ�" onClick="queryEC1();">
     	    <input name="newAcBtn"   style="cursor:hand" type="button" class="b_foot_long" value="������Ա�ʷ�" onClick="addEC1();">
     	    <input name="" type="button" style="cursor:hand" class="b_foot" value="��  ��" onClick="removeCurrentTab();" >
	 	  </TD>
   </TR>
</TABLE> 
<IFRAME frameBorder=0 id=middle name=middle scrolling="auto"  
style="HEIGHT: 350px; VISIBILITY: inherit; WIDTH: 100%; Z-INDEX: 1">
</IFRAME>

<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
