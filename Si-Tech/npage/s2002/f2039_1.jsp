<%
  /*
   * ����: ���ⷴ��
�� * �汾: v1.0
�� * ����: 2008��10��25��
�� * ����: piaoyi
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd>
<HTML xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>

<%
	response.setHeader("Pragma","No-Cache");
	response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0);
  
  /****************************************
  Session��ȡ��ʽ�仯��
  *****************************************/
  String workNo = (String)session.getAttribute("workNo");
  String workName = (String)session.getAttribute("workName");
  String ip_Addr = (String)session.getAttribute("ipAddr");
  String org_code = (String)session.getAttribute("orgCode");
  String nopass = (String)session.getAttribute("password");
  String regionCode = org_code.substring(0,2);
  
  String opCode="2039";
  String opName="��Ʒ��Ʒ���������ʷѶ�Ӧ��ϵ";
  Logger logger = Logger.getLogger("f2039_1.jsp");
%>

<html>
<head>
<title><%=opName%></title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link href="s2002.css" rel="stylesheet" type="text/css">
<script language=javascript>
function queryEC()
{		
	var PospecType 	= document.all.PospecType.value;
	var PospecNum 	= document.all.PospecNum.value;
	document.all.postProNum.value=document.all.PospecProNum.value;
	var PospecProNum=document.all.postProNum.value;
	/*if(PospecNum=="")
	{
		rdShowMessageDialog("��������Ʒ�����룡");
 	 	document.all.PospecNum.focus();
 	 	return;
	}*/
	if(PospecType=="1")
	{
	//	document.middle.location="s2039QueryPro.jsp?PospecNum=" + PospecNum
	//	+ "&PospecProNum=" + PospecProNum;
	window.open("s2039QueryPro.jsp?PospecNum=" + PospecNum + "&PospecProNum=" + PospecProNum,"","height=768,width=1024","toolbar = 0");
	}
	else
	{
	//	document.middle.location="s2039QueryPro1.jsp?PospecNum=" + PospecNum
	//	+ "&PospecProNum=" + PospecProNum;
		window.open("s2039QueryPro1.jsp?PospecNum=" + PospecNum + "&PospecProNum=" + PospecProNum,"","height=768,width=1024","toolbar = 0");
	}

	//tabBusi.style.display="";
}
	
function queryEC1()
{
	var PospecNum 	= document.all.PospecNum.value;
	document.all.postProNum.value=document.all.PospecProNum.value;
	var PospecProNum=document.all.postProNum.value;
//	document.middle.location="s2039QueryList.jsp?PospecNum=" + PospecNum
//			+ "&PospecProNum=" + PospecProNum;
	//tabBusi.style.display="";
	window.open("s2039QueryList.jsp?PospecNum=" + PospecNum + "&PospecProNum=" + PospecProNum,"","height=768,width=1024","toolbar = 0");
}
	
function addEC1()
{
	window.open("s2039AddMode.jsp?height=768,width=1024,scrollbars=yes","","height=768,width=1024","toolbar = 0");
}

function queryCha()
{
	if(document.all.PospecNum.value.trim()==""&&document.all.PospecProNum.value.trim()=="")
	{
		rdShowMessageDialog("��������Ʒ��������Ʒ�����룡");
 	 	document.all.PospecNum.focus();
 	 	return;
	}
	var PospecNum 	= document.all.PospecNum.value;
	document.all.postProNum.value=document.all.PospecProNum.value;
	var PospecProNum=document.all.postProNum.value;
	 // document.middle.location="s2039QueryCha.jsp?PospecNum=" + PospecNum
	//		+ "&PospecProNum=" + PospecProNum;
  window.open("s2039QueryCha.jsp?PospecNum=" + PospecNum + "&PospecProNum=" + PospecProNum,"","height=768,width=1024","toolbar = 0");
}

function setCha()
{
	if(document.all.PospecNum.value.trim()==""&&document.all.PospecProNum.value.trim()=="")
	{
		rdShowMessageDialog("��������Ʒ��������Ʒ�����룡");
 	 	document.all.PospecNum.focus();
 	 	return;
	}
	var PospecNum 	= document.all.PospecNum.value;
	document.all.postProNum.value=document.all.PospecProNum.value;
	var PospecProNum=document.all.postProNum.value;
	// document.middle.location="s2039setCha.jsp?PospecNum=" + PospecNum
	//		+ "&PospecProNum=" + PospecProNum;
	window.open("s2039setCha.jsp?PospecNum=" + PospecNum + "&PospecProNum=" + PospecProNum,"","height=768,width=1024","toolbar = 0");
}
	
function addEC()
{
	window.open("s2039AddEC.jsp?height=768,width=1024,scrollbars=yes","","height=768,width=1024","toolbar = 0");

}
//add by wangzn
function addDefaultEC()
{
	window.open("s2039SetDefaultEC.jsp?height=768,width=1024,scrollbars=yes","","height=768,width=1024","toolbar = 0");

}
function addMemberCharacter()
{
	window.open("s2039SetMemberCharacter.jsp?height=700,width=400,scrollbars=yes","","height=768,width=1024","toolbar = 0");

}
	
function change_I()
{
	document.all.change_II.checked=true;
	document.all.change_aa.checked=false;
	document.all.PospecType.value="1";
	document.all.PospecProNum.disabled=true;
	
}	
function change_a()
{
	document.all.change_aa.checked=true;
	document.all.change_II.checked=false;
	document.all.PospecType.value="2";
	document.all.PospecProNum.disabled=false;
}

function setMemberType(){
	if(document.all.PospecNum.value.trim()==""&&document.all.PospecProNum.value.trim()=="")
	{
		rdShowMessageDialog("��������Ʒ��������Ʒ�����룡");
 	 	document.all.PospecNum.focus();
 	 	return;
	}
	var PospecNum 	= document.all.PospecNum.value;
	document.all.postProNum.value=document.all.PospecProNum.value;
	var PospecProNum=document.all.postProNum.value;
  window.open("s2039QueryMemberType.jsp?PospecNum=" + PospecNum + "&PospecProNum=" + PospecProNum,"","height=768,width=1024","toolbar = 0");

}
function queryReadOnlyAttr()
{
	if(document.all.PospecNum.value.trim()==""&&document.all.PospecProNum.value.trim()=="")
	{
		rdShowMessageDialog("��������Ʒ��������Ʒ�����룡");
 	 	document.all.PospecNum.focus();
 	 	return;
	}
	var PospecNum 	= document.all.PospecNum.value;
	document.all.postProNum.value=document.all.PospecProNum.value;
	var PospecProNum=document.all.postProNum.value;
	 // document.middle.location="s2039QueryCha.jsp?PospecNum=" + PospecNum
	//		+ "&PospecProNum=" + PospecProNum;
  window.open("s2039QueryReadOnlyAttr.jsp?PospecNum=" + PospecNum + "&PospecProNum=" + PospecProNum,"","height=768,width=1024","toolbar = 0");
}
function queryChaInput(){
	if(document.all.PospecNum.value.trim()==""&&document.all.PospecProNum.value.trim()=="")
	{
		rdShowMessageDialog("��������Ʒ��������Ʒ�����룡");
 	 	document.all.PospecNum.focus();
 	 	return;
	}
	var PospecNum 	= document.all.PospecNum.value;
	document.all.postProNum.value=document.all.PospecProNum.value;
	var PospecProNum=document.all.postProNum.value;
	 // document.middle.location="s2039QueryCha.jsp?PospecNum=" + PospecNum
	//		+ "&PospecProNum=" + PospecProNum;
  window.open("s2039QueryChaInput.jsp?PospecNum=" + PospecNum + "&PospecProNum=" + PospecProNum,"","height=768,width=1024","toolbar = 0");
	
}
function queryChaInputDeploy(){
	if(document.all.PospecNum.value.trim()==""&&document.all.PospecProNum.value.trim()=="")
	{
		rdShowMessageDialog("��������Ʒ��������Ʒ�����룡");
 	 	document.all.PospecNum.focus();
 	 	return;
	}
	var PospecNum 	= document.all.PospecNum.value;
	document.all.postProNum.value=document.all.PospecProNum.value;
	var PospecProNum=document.all.postProNum.value;
  window.open("s2039QueryChaInputDeploy.jsp?PospecNum=" + PospecNum + "&PospecProNum=" + PospecProNum,"","height=768,width=1024","toolbar = 0");
	
}



</script>

</head>
<body>
<form action="" name="form1"  method="post">
<%@ include file="/npage/include/header.jsp" %>
<input type="hidden" name="PospecType" value="1">
<input type="hidden" name="postProNum" value="">		
<table width="98%" align="center" id="mainThree" bgcolor="#FFFFFF" cellspacing="1" border="0">
		<!--TR>
            <TD width="16%">
              <div align="left">���������ͣ�</div>
            </TD>
            <TD width="34%">
            	<input type="radio" name="change_II" onClick="change_I()" value="3096" checked index="2">
                    ��Ʒ 
              <input type="radio" name="change_aa" onClick="change_a()" value="3523" index="3">
                    ��Ʒ 
            </TD>
            <TD width="16%">
               &nbsp;
            </TD>
            <TD width="34%">
            	  &nbsp;
            </TD>
	  	<TD width="34%" />
    </TR-->
		<tr>
		<TD width="16%" class="blue">��Ʒ�����룺</TD>
	  	<TD  width="34%" class="blue">
		  <input type=text name="PospecNum" v_type="0_9" v_name="��Ʒ������" v_maxlength=9 onblur="checkElement(this)"></input> 
		  <font color="orange">*</font> 
		</TD>
		 
		<TD width="16%" class="blue">��Ʒ�����룺</TD>
	  	<TD width="34%" class="blue">
		    <input type=text  v_type="string" v_minlength=0 v_type="0_9" v_maxlength=7 v_name="��Ʒ������" name=PospecProNum maxlength=7 value="" onblur="checkElement(this)" />
		  <font color="orange">*</font>
		</TD>
	</tr>
	
</table>

<TABLE id="tabBtn" style="display:''" width="98%" align="center" id="mainOne" bgcolor="#FFFFFF" cellspacing="0" border="0" >	    
			    <TR> 
		         	<TD height="12" colspan = "4" align="center"> 
		         	    <input name="queryAcBtn" type="button" class="b_foot_long" value="��ѯ���ʷ�" onClick="queryEC();">
		         	    &nbsp;
		         	    <input name="newAcBtn"   type="button" class="b_foot_long" value="�������ʷ�" onClick="addEC();">
		         	    &nbsp;  
		         	    <input name="setDefaultAcBtn" type="button" class="b_foot_long" value="����ȱʡ�ʷ�" onClick="addDefaultEC(); ">
		         	    &nbsp;  
		         	    <input name="queryAcBtn" type="button" class="b_foot_long" value="��ѯ��Ա�ʷ�" onClick="queryEC1();">
		         	    &nbsp;
		         	    <input name="newAcBtn"   type="button" class="b_foot_long" value="������Ա�ʷ�" onClick="addEC1();">
		         	    &nbsp; 
				 	  </TD>
		       </TR>
		       <tr>
		       	<td height="12" colspan = "4" align="center">
		       				
		         	<!--    <input name="queryChaBtn"   type="button" class="b_foot_long" value="������������" onClick="queryCha();"> 
		         	    &nbsp;  -->
		         	   <!-- <input name="setChaBtn"   type="button" class="b_foot_long" value="�������Թ�ϵ" onClick="setCha();"> -->
		            <input name="setMemberTypeBtn" type="button" class="b_foot_long" value="��Ա��������" onClick="setMemberType();">
		         	    &nbsp;
                  
                   <!--	<input name="setReadOnlyAttrBtn" type="button" class="b_foot_long" value="�����޸���������" onClick="queryReadOnlyAttr();">
		         	    &nbsp;
									<input name="setReadOnlyAttrBtn" type="button" class="b_foot_long" value="������д����old" onClick="queryChaInput();">
		         	    &nbsp;
		         	  -->  
				 	 				<input name="setReadOnlyAttrBtn" type="button" class="b_foot_long" value="������д����" onClick="queryChaInputDeploy();">
		         	    &nbsp;
		         	    <input name="setDefaultAcBtn" type="button" class="b_foot_long" value="��Ա��������" onClick="addMemberCharacter(); ">
		         	    &nbsp; 
		         	    <input name="" type="reset" class="b_foot_long" value="��  ��" >
		         	    &nbsp;
		       		  <!-- <%for(int i=0;i<20;i++){%>&nbsp;<%}%>����ռλ-->
		       		   <input name="" type="button" class="b_foot_long" value="��  ��" onClick="javascript:parent.removeTab('<%=opCode%>');" >
				 	 				&nbsp;
				 	 				
		       	</td>
		      </tr>
		      
</TABLE>
<!--
<div>
	<IFRAME frameBorder=0 id=middle name=middle scrolling="yes"  
	style="HEIGHT: 100%; VISIBILITY: inherit; WIDTH: 100%; Z-INDEX: 1">
	</IFRAME>
</div> -->
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
