<%
  /*
   * ����: ���/�޸İ汾ά����¼
�� * �汾: 1.0.0
�� * ����: 2008/11/05
�� * ����: mixh
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%
	String opCode = "K074";
	String opName = "���/�޸İ汾ά����¼";
	    /*midify by yinzx 20091113 ������ѯ�����滻*/
    String myParams="";
    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
/*---------------���ҳ�洫�ݲ�����ʼ-------------------*/
String kf_longin_no = (String) session.getAttribute("workNo");
String op_type = WtcUtil.repNull(request.getParameter("op_type"));
String updatelog_id = WtcUtil.repNull(request.getParameter("updatelog_id"));
/*---------------���ҳ�洫�ݲ�������-------------------*/
String module_id = "";
String version_no = "";
String version_remark = "";
String context = "";
String op_titel = "���";
if(op_type.equals("modify")){
	op_titel = "�޸�";
%>
<%
	String tmpSql = "select to_char(MODULE_ID),VERSION_NO,VERSION_REMARK,CONTEXT from DCALLUPDATELOG where UPDATELOG_ID=:vupdatelog_id ";
	myParams="vupdatelog_id="+updatelog_id;
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="6">
<wtc:param value="<%=tmpSql%>"/>
<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="tmpList" scope="end"/>
	
<%
		if(tmpList.length>0){
	  		module_id = tmpList[0][0];
	  		version_no = tmpList[0][1];
	  		version_remark = tmpList[0][2];
	  		context = tmpList[0][3];
		}
}
%>	

<html>
<head>
<title><%=op_titel%>�汾ά����¼</title>
<meta http-equiv=Content-Type content="text/html; charset=GBK">
<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/block/jquery.blockUI.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/njs/si/validate_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>
<script type="text/javascript" language="javascript" src="/njs/si/base.js"></script>
<SCRIPT type="text/javascript" language=javascript src="/njs/si/ajax.js"></SCRIPT>

<script>
	function saveCondition(){
		if('<%=module_id%>'!=''){
			document.formbar.module_id.value = "<%=module_id%>";
	  }
		document.formbar.version_no.value = "<%=version_no%>";
		document.formbar.version_remark.value = "<%=version_remark%>";
		document.formbar.login_no.value = "<%=kf_longin_no%>";
		document.formbar.context.value = "<%=context%>";
	}
	function formSubmit(){
		var op_type = document.formbar.op_type.value;
		var updatelog_id = document.formbar.updatelog_id.value;
		var module_id = document.formbar.module_id.value;
		var version_no = document.formbar.version_no.value;
		var version_remark = document.formbar.version_remark.value;
		var context = document.formbar.context.value;
		if(version_no==''&&version_remark==''&&context==''){
			rdShowMessageDialog('����д����һ�����ݣ�',2);	
			return;
		}
		var url_k074_add="/npage/callbosspage/k074/k074_addModify.jsp?updatelog_id="+updatelog_id+"&op_type="+op_type
		+"&module_id="+module_id+"&version_no="+version_no+"&version_remark="+version_remark+"&context="+context;   
    asyncGetText(url_k074_add,doSubmit); 
	}
	function doSubmit(txt){
		var returnStr = txt.split("|");
		var op_type = "�޸�";
		if(returnStr[0]=='add'){
			op_type = "���";
		}
		if(returnStr[1]=='Y'){
			rdShowMessageDialog(op_type+'�ɹ���',2);			
			opener.document.sitechform.submit();
		}else{
			rdShowMessageDialog(op_type+'ʧ�ܣ�',2);	
		}
		window.close();
	}
</script>

</head>

<body onload="saveCondition()">
<form  name="formbar">
<input type="hidden" name="op_type" id="op_type" value="<%=op_type%>"/>
<input type="hidden" name="login_no" id="login_no" value="<%=kf_longin_no%>"/>
<input type="hidden" name="updatelog_id" id="updatelog_id" value="<%=updatelog_id%>"/>


<div id="Main">
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
	<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">
	<div id="Operation_Title"><B><%=op_titel%>�汾ά����¼</B></div>
    <div id="Operation_Table" style="width: 100%;"><!-- guozw20090828 -->
    <div class="title"></div>
    
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
      	<td width=16% class="blue">ģ��</td>
        <td width="34%" > 
        <select name="module_id" id="module_id"><font color=red>*</font>
				<wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
					<wtc:sql>select to_char(MODULE_ID) , MODULE_NAME from DCALLMODULE order by MODULE_NAME</wtc:sql>
				</wtc:qoption>			  	
        </select>
        </td>
         <td width=16% class="blue">�汾��</td>
         <td width="34%">
		        <input id="version_no" name="version_no" value=""/>
         </td>        
      </tr>   
      <tr>
      	<td width=16% class="blue">�汾����</td>
        <td colspan="3" > 
        <input size="60" id="version_remark" name="version_remark" value=""/>
        </td>    
      </tr>    
      <tr>
      	<td width=16% class="blue">�汾����</td>
        <td colspan="3" > 
        <textarea  id="context" name="context"  rows="5" cols="60" ></textarea>
        </td>    
      </tr>                                    
      </table>
      
      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td id="footer"  align=center> 
           <input class="b_foot" name="submit" type="button" value="ȷ��" onclick="formSubmit()">
       		<input name="delete_value" type="reset" class="b_foot"  id="reset" value="����">
       		<input class="b_foot" name="back" type="button" onclick="window.close();" value="�ر�"  >
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