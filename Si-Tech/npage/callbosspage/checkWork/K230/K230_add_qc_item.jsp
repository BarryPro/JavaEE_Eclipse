<%
  /*
   * ����: ��ӿ�����ҳ��
�� * �汾: 1.0.0
�� * ����: 2008/11/05
�� * ����: mixh
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%
	String opCode = "K230";
	String opName = "��ӿ�����";
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
/*---------------���ҳ�洫�ݲ�����ʼ-------------------*/
String object_id      = WtcUtil.repNull(request.getParameter("object_id"));
String content_id     = WtcUtil.repNull(request.getParameter("content_id"));
String father_node_id = WtcUtil.repNull(request.getParameter("father_node_id"));
String current_node_id= WtcUtil.repNull(request.getParameter("current_node_id"));
/*---------------���ҳ�洫�ݲ�������-------------------*/
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
String myParams="";
String tmpSelect = "";
String tmp = "";

if("0".equals(current_node_id)){
	tmpSelect = "disabled";
	tmp = "selected";
	father_node_id="0";
}
%>
<%
	String tmpSql = "select is_scored from dqccheckitem where item_id=:current_node_id ";
	myParams = "current_node_id="+current_node_id;
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="8">
<wtc:param value="<%=tmpSql%>"/>
<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="tmpList" scope="end"/>
	
<%
		String tmpVal = "";
		if(tmpList.length>0){
	  		tmpVal = tmpList[0][0];
		}
%>	
<%
/*zhengjiang 20091004 add start*/
String countNum = "0";
//if("0".equals(current_node_id)){
	String countSql = "select to_char(nvl(sum(high_score),0)) from dqccheckitem "
										+" where parent_item_id=:father_node_id "
										+" and object_id=:object_id "
										+" and contect_id=:content_id "//;	//��ѯ����ǰ���ڵ��Ӧ�ķ�����		
										+" and bak1<>'N'";//�˴���Ҫȷ���Ƿ����
	myParams = "father_node_id="+father_node_id+",object_id="+object_id+",content_id="+content_id;		
	
	System.out.println("-------------countSql: "+countSql);							
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
<wtc:param value="<%=countSql%>"/>
<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="countList" scope="end"/>
<%
	if(countList.length>0){
		countNum = countList[0][0];
	}
//}	
%>
<%
	String currentCountNum = "0";
	String sumCurrent = "0";
	if(!"0".equals(current_node_id)){//�жϵ�ǰ�ڵ��Ƿ�Ϊ���ڵ�
		String sumCurrentSql = "select to_char(nvl(sum(high_score),0)) from dqccheckitem "
										+" where parent_item_id=:current_node_id "
										+" and object_id=:object_id "
										+" and contect_id=:content_id "//;	//�ѵ�ǰ�ڵ�Ϊ���ڵ����߷��ܺ�
										+" and bak1<>'N'";//�˴���Ҫȷ���Ƿ����
	  
		String currentCountSql = "select to_char(high_score) from dqccheckitem where " 
														+" item_id=:current_node_id "
														+" and object_id=:object_id "
														+" and contect_id=:content_id ";//��ѯ��ǰ�ڵ�ķ�������
		myParams = "current_node_id="+current_node_id+",object_id="+object_id+",content_id="+content_id;
		
%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
			<wtc:param value="<%=sumCurrentSql%>"/>
			<wtc:param value="<%=myParams%>"/>
		</wtc:service>
		<wtc:array id="sumCurrentSqlList" scope="end"/>
<%
		if(sumCurrentSqlList.length>0){
			sumCurrent = sumCurrentSqlList[0][0];
		}
%>		
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
			<wtc:param value="<%=currentCountSql%>"/>
			<wtc:param value="<%=myParams%>"/>
		</wtc:service>
		<wtc:array id="currentCountList" scope="end"/>
<%
		
		if(currentCountList.length>0){
			currentCountNum = currentCountList[0][0];
		}
	}
	/*zhengjiang 20091004 add end*/
%>
<html>
<head>
<title>��ӿ�����</title>
<meta http-equiv=Content-Type content="text/html; charset=GBK">
<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/njs/si/validate_pack.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
<script>
	
function grpClose(){
		window.opener = null;
		window.close();
}
//�������¼
function clearValue(){
		var e = document.forms[0].elements;
		for(var i=0;i<e.length;i++){
				var tid = e[i].id;
			  if(e[i].type!="select-one"&&e[i].type=="text"&&tid!=""){
				  	if(!(document.getElementById(tid).disabled)&&!(document.getElementById(tid).readOnly)){
					  		e[i].value="";
					  }
				}
				if(e[i].type=="select-one"&&tid!=""){
						document.getElementById(e[i].id).options[0].selected = true;
				}
		 }
}
//�ж���߷���ͷ�
function check_score(low_score,high_score)
{
    var notANumber = 2;
    var notLogic   = -1;
    var success    = 0;
    var re = /^[-]?\d+[.]?\d*$/;
    if(!((re.test(low_score))&&re.test(high_score)))
    {
        return notANumber;
    }else
         //if((parseInt(low_score) < 0)||(parseInt(high_score) < 0)||(parseInt(low_score) > parseInt(high_score)))
         if((parseInt(high_score) < 0)||(parseInt(low_score) > parseInt(high_score)))
    {
        return notLogic;
    }
    notANumber = null;
    notLogic   = null;
    return success
}


//�ж��Ƿ�������
function isNumber(ee){
	if(!ee) return false;
	
  if(isNaN(ee)){
	  	similarMSNPop("Ȩ�ر���Ϊ���֣�");
	  	document.getElementById("weight").value="";
	  	document.getElementById("weight").focus();
  }
  
  if(ee<=0){
	  	similarMSNPop("Ȩ�ر�������㣡");
	  	document.getElementById("weight").value="";
	    document.getElementById("weight").focus();
  }
  
  var tmpPos = ee.lastIndexOf('.');
  var subWeightLength = ee.substr(tmpPos).length;
  
  if(subWeightLength>3){
	    similarMSNPop("Ȩ�����ֻ��������С��λ��");
	    document.getElementById("weight").value="";
	    document.getElementById("weight").focus();
  }	
  return true;
}

/*�Է���ֵ���д���*/
function doProcessAddQcItem(packet){
		var retType = packet.data.findValueByName("retType");
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		var item_id = packet.data.findValueByName("item_id");
		if(retType=="submitQcItem" && retCode == "000000"){
				var parWin          = window.dialogArguments;
				var itemName        = document.getElementById("item_name").value;		    
				var isScore         = document.getElementById("isScore").value;
				var parent_item_id  = document.getElementById("parent_item_id").value;
				var nodeType        = document.getElementById("nodeType").value;
				var father_node_id  = document.getElementById("father_node_id").value;
				var current_node_id = document.getElementById("current_node_id").value;
				
				if(parent_item_id!=0){
						parWin.tree.setUserData(parent_item_id.trim(),"isleaf",'N');
			  }
			  
				parWin.tree.insertNewItem(parent_item_id.trim(), item_id.trim(), itemName.trim(), 0, 0, 0, 0, 'SELECT');
				parWin.tree.setUserData(item_id.trim(),"isleaf",'Y');
				parWin.tree.setUserData(item_id.trim(),"isscored",isScore);
				parWin.tree.setUserData(item_id.trim(),"object_id",'<%=object_id%>');
					        
				/*
				if(rdShowConfirmDialog("��ӿ�����ɹ����Ƿ�������",2) != 1){
						window.close();
				}	
				*/
				similarMSNPop("��ӿ���ɹ���");
        //added by liujied 
        //setTimeout("grpClose()",2500);
        grpClose();
		}else{
				similarMSNPop("��ӿ���ʧ�ܣ�");
				return false;
		}
}

/**
  *
  *��ӿ�����
  *
  */
function submitQcItem()
{
		var weight          = document.getElementById("weight").value;
    var low_score       = document.getElementById("low_score").value;
    var high_score      = document.getElementById("high_score").value;
    var item_name       = document.getElementById("item_name").value;
    var formula         = document.getElementById("formula").value;
    
    if(weight == ''){
			similarMSNPop("û�����뿼����Ȩ�أ�");
			return false;
		}
		
		if( low_score== ''){
				similarMSNPop("û�����뿼������ͷ֣�");
				return false;
		}
	
		if( high_score== ''){
				similarMSNPop("û�����뿼������߷֣�");
				return false;
		}
                if( check_score(low_score,high_score) == 2){
                                similarMSNPop("��߷ֺ���ͷֱ��������֣�");
				return false;
                }
                if( check_score(low_score,high_score) == -1){
                                similarMSNPop("��߷ֱ��������ͷ�����߷ֲ���С���㣡");
				return false;
                }
		
		if( item_name== ''){
				similarMSNPop("û�����뿼�������ƣ�");
				return false;
		}
		
		//added by tangsong 20100409 ��֤����
		var flag = checkElement(document.all("item_name"));
		if (!flag) {
			similarMSNPop("����ֵ�Ƿ���");
			return false;
		}
		
		if(formula == ''&&""==document.getElementById("forId").style.display){
				similarMSNPop("û�����뿼������㹫ʽ��");
				return false;
		}
		//zhengjiang 20091004 start
		var tempCount = '<%=countNum%>';
		var sumCurrent = '<%=sumCurrent%>';
		var currentNodeId = '<%=current_node_id%>';
		var parentid = '<%=father_node_id%>';
		//var currentParentId = document.getElementById("parent_item_id").value;
		var nodeType = document.getElementById("nodeType").value;//�ڵ�����
		var totalCount = parseInt(tempCount)+parseInt(high_score);//��ǰ�ڵ��Ӧ�ĸ��ڵ��·������޵��ܺ�+�����ڵ��������
		/*	guozw2010-01-26
		if(0==currentNodeId){
			if(totalCount>100){
				similarMSNPop("�����ܺͳ����˷���涨�ķ�����");
				return false;
			}
		}else if(0==parentid && "1"==nodeType){
			if(totalCount>100){
				similarMSNPop("�����ܺͳ����˷���涨�ķ�����");
				return false;
			}
		}else{
		  totalCount = parseInt(sumCurrent) + parseInt(high_score);
			var currentCountNum = '<%=currentCountNum%>';
			if(totalCount>currentCountNum){
				similarMSNPop("�����ܺͳ����˷���涨�ķ�����");
				return false;
			}
		}
		*/
		//zhengjiang 20091004 end
    var chkPacket       = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K230/K230_do_add_qc_item.jsp","���Ժ�...");
    var parent_item_id  = document.getElementById("parent_item_id").value;
    var object_id       = document.getElementById("object_id").value;
    var content_id      = document.getElementById("content_id").value;
    var is_leaf         = document.getElementById("is_leaf").value;
    var note            = document.getElementById("note").value;
    var isDefault       = document.getElementById("isDefault").value;
    var isScore         = document.getElementById("isScore").value;
    //added by liujied ���˵������������еĿո�
    note = note.replace(/\s/g,"");
   
    chkPacket.data.add("retType","submitQcItem");
    chkPacket.data.add("parent_item_id", parent_item_id);
    chkPacket.data.add("object_id", object_id);
    chkPacket.data.add("contect_id", content_id);
    chkPacket.data.add("is_leaf", is_leaf);
    chkPacket.data.add("item_name", item_name);
    chkPacket.data.add("low_score", low_score);
    chkPacket.data.add("high_score", high_score);
    chkPacket.data.add("weight", weight);
    chkPacket.data.add("formula", formula.split("+").join("%2B"));
    chkPacket.data.add("note", note);
		chkPacket.data.add("isDefault", isDefault);
		chkPacket.data.add("isScore", isScore);
		chkPacket.data.add("crete_login_no", "<%=(String)session.getAttribute("kfWorkNo")%>");	
    core.ajax.sendPacket(chkPacket,doProcessAddQcItem,true);
		chkPacket =null;
}

/**
  *
  *�ı�ڵ������涯����
  */
function changeNodeType(nodeType){
		var parent_item_id  = document.getElementById("parent_item_id");
		var father_node_id  = document.getElementById("father_node_id").value;
		var current_node_id = document.getElementById("current_node_id").value;
		
		if(nodeType == 1){
				parent_item_id.value = father_node_id;
		}
		
		if(nodeType == 2){
				parent_item_id.value = current_node_id;
		}	
}

/**
  *�ж��Ƿ���ʾ���㹫ʽ
  */
function formulaJudge(){
		var tmpVal = document.getElementById("isScore").value;
		
		if("N"==tmpVal){
				document.getElementById("forId").style.display="";
				document.getElementById("formula").value="x+y";
				//document.getElementById("formula").disabled=false;
		}
		if("Y"==tmpVal){
				document.getElementById("forId").style.display="none";
				document.getElementById("formula").value="";
				//document.getElementById("formula").disabled=true;
		}
}

/**
  *У����㹫ʽ
  */
function verify(){
	var time =new Date();
	var formula = document.getElementById('formula').value;
	window.showModalDialog("K230_verify_formula.jsp?time=" + time+"&formula="+formula.split("+").join("%2B"),"","");
}
</script>

</head>

<body>
<form  name="formbar">
<input type="hidden" name="father_node_id" id="father_node_id" value="<%=father_node_id%>"/>
<input type="hidden" name="current_node_id" id="current_node_id" value="<%=current_node_id%>"/>
<input type="hidden" name="object_id" id="object_id" value="<%=object_id%>"/>
<input type="hidden" name="contect_id" id="content_id" value="<%=content_id%>"/>
<input type="hidden" name="is_leaf" id="is_leaf" value="Y"/>

<div id="Main">
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
	<td valign="top">
	<div id="Operation_Title"><B>��ӿ�����</B></div>
    <div id="Operation_Table" style="width: 100%;"><!-- guozw20090828 -->
    <div class="title"></div>
    
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
      	<td width=16% class="blue">�ϲ�ڵ���</td>
        <td width="34%"> 
        <input name="parent_item_id" id="parent_item_id" value="<%=father_node_id%>" size="8" disabled/>
        </td>
         <td width=16% class="blue">���</td>
         <td width="34%">
		<input id="item_id" value="ϵͳ�Զ�����" disabled/>
         </td>        
      </tr>   
      <tr>
      	<td width="16%" class="blue">�ڵ����</td>
        <td width="34%">
         	<select name="nodeType" onchange="changeNodeType(this.value)"  <%=tmpSelect%> <%if("Y".equals(tmpVal.trim())){out.print("disabled");}%> >
        		<option value="1">ͬ��ڵ�</option>
         		<option value="2" <%=tmp%> >�ӽ��</option>
        	</select>
        </td>
         <td width=16% class="blue">����</td>
         <td width="34%">
		<input id="item_name" value="" v_must="1" v_type="string" onBlur="checkElement(this)" ><font class="orange">*</font>
         </td>
      </tr>      
      <tr>
        <td width=16% class="blue">�Ƿ�������</td>
        <td width="34%">
	 	    <select name="isScore" id="isScore" onChange="javascript:formulaJudge(this.value);">
	 		<option value="Y">��</option>
	 		<option value="N">��</option>
        	</select>    
        </td>
        <td width=16% class="blue">�Ƿ�Ĭ����</td>
        <td width="34%">
         	<select name="isDefault" id="isDefault">
         		<option value="1">��</option>
         		<option value="0">��</option>
        	</select>         	
        </td>      	
      </tr>
      <tr>
         <td width=16% class="blue">��ͷ�</td>
         <td width="34%">
         	<!--zhengjiang 20091005 ��ͷֺ���߷������������onkeyup="value=value.replace(/[^\d]/g,'') " onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"-->
		<input id="low_score" value="" v_must="1" v_type="string" onkeyup="value=value.replace(/[^-?\d+$]/g,'') " onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" onBlur="checkElement(this)" /><font class="orange">*</font>
         </td>
        <td width=16% class="blue">��߷�</td>
        <td width="34%"> 
        <input id="high_score" value="" v_must="1" v_type="string" onkeyup="value=value.replace(/[^\d]/g,'') " onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" onBlur="checkElement(this)" /><font class="orange">*</font>
        </td>
      </tr>
      <tr>
        <td width=16% class="blue">Ȩ��</td>
        <td width="34%"> 
        <!--zhengjiang 20091004 add value="1" readonly="true"-->
        <input id="weight" name="weight" value="1" readonly="true" v_must="1" v_type="string" onBlur="checkElement(this);isNumber(this.value);" /><font class="orange">*</font>
        </td>
        <td width=16% class="blue">����</td>
        <td width="34%"> 
        <input id="note" />
        </td>        
      </tr>      
      <tr id="forId" style="display:none;">
         <td width=16% class="blue">���㹫ʽ</td>
         <td width="34%">
		<input id="formula"  value="" v_must="1" v_type="string" onBlur="checkElement(this)" readonly /><font class="orange">*</font>
        <!--input type="button" name="confirmBtn" class="b_text" value="У��" onClick="verify();"/-->
         </td>
        <td width=16% class="blue">&nbsp;</td>
        <td width="34%"> &nbsp;
        </td>
      </tr>                                      
      </table>
      
      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td id="footer"  align=center> 
            <input class="b_foot" name="submit" type="button" value="ȷ��" onclick="submitQcItem()">
        	<!--input class="b_foot" name="reset1" type="button"  onclick="history.go(0);" value="���"-->
       		<input class="b_foot" name="reset1" type="button"  onclick="clearValue();return false;" value="���">
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