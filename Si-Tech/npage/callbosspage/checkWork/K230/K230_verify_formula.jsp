<%
  /*
   * ����: У����㹫ʽ����ȷ��
�� * �汾: 1.0.0
�� * ����: 2008/11/05
�� * ����: mixh
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%
	String opCode = "K230";
	String opName = "���¿�����";
%>
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	String formula = WtcUtil.repNull(request.getParameter("formula"));
%>
<html>
<head>
<title>���㹫ʽУ��</title>
<meta http-equiv=Content-Type content="text/html; charset=GBK">
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
<META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">

<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/block/jquery.blockUI.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/njs/si/validate_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
<script>

function grpClose(){
window.opener = null;
window.close();
}

/*�Է���ֵ���д���*/
function doProcessupdateQcItem(packet)
{
	//alert("Begin call doProcessupdateQcItem()......");

	//alert("End call doProcessupdateQcItem()......");
}

/**
  *
  *��ӱ���������
  *
  */
function updateQcItem()
{
	var formula    = document.getElementById("formula").value;
	var test_value = document.getElementById("test_value").value;
	
	if(formula == ''){
		similarMSNPop("���㹫ʽΪ�գ��޷�У�飡");
		return false;
	}
	
	if(test_value == ''){
		similarMSNPop("����ֵΪ�գ��޷�У�飡");
		return false;
	}
	
	
	
	var addend = formula.split('+');
	var result = test_value.split(',');
	var count1 = 0;
	var count2 = 0;
	if(addend.length == 1){
		similarMSNPop("���㹫ʽ���벻��ȷ���޷�У�飡");
		return false;
	}
	
	if(result.length == 1){
		similarMSNPop("���Բ������벻��ȷ���޷�У�飡");
		return false;
	}		
	for(var i=0;i<addend.length;i++){
		if(''!=addend[i].trim()&&addend[i].trim()!=null){
			count1++;
		}
	}
	for(var i=0;i<result.length;i++){
		if(''!=result[i].trim()&&result[i].trim()!=null){
			if(!isNaN(result[i].trim())){
				count2++;
			}
			
		}
	}
	if(count1 != count2){
		similarMSNPop("���Բ������벻��ȷ���޷�У�飡");
		return false;
	}
	
	var addresult = 0;
	for(var i = 0; i < result.length; i++){
		addresult += parseInt(result[i]);
	}
	similarMSNPop('���Խ��Ϊ��' + addresult + ' ����ͨ����');
}

</script>

</head>
<body>

<form  name="formbar">
<div id="Main">
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
	<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">
	<div id="Operation_Title"><B><font face="Arial"></font>���¿�����</B></div>
    <div id="Operation_Table" style="width: 100%;"><!-- guozw20090828 -->
    <div class="title"></div>  
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
      
      <tr>
      	<td width=16% class="blue">���㹫ʽ</td>
        <td width="34%"> 
        	<input id="formula" name="formula" value="<%=formula%>"/>
        </td>               
      </tr>
      <tr>
      	<td width=16% class="blue">���Բ���</td>
        <td width="34%"> 
        	<input id="test_value" name="test_value" value=""/><nobr>
        	&nbsp;(���Բ����ð�Ƕ��Ÿ���)
        </td>                
      </tr>      
      </table>

      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td id="footer"  align=center> 
            <input class="b_foot" name="submit" type="button" value="����" onclick="updateQcItem()">
       		<input class="b_foot" name="back" type="button" onclick="grpClose();" value="�ر�"  >
        </td>
       </tr>  
     </table>
    </div>
    <br/>          
    </td>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="RightFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerRight.jpg" width="20" height="45" /></td>
  </tr>
        
  <tr>
    <td><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeftDown.gif" width="20" height="20" /></td>
    <td valign="bottom">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#D8D8D8">
      <tr>
        <td height="1"></td>
      </tr>
    </table>
    </td>
    <td><img src="<%=request.getContextPath()%>/nresources/default/images/CornerRightDown.gif" width="20" height="20" /></td>
  </tr>
</table>

</div>

</form>
</body>
</html>
 



