<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: ���ⷴ��
�� * �汾: v1.0
�� * ����: 2009��10��10��
�� * ����: wangzn
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
 
    String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
	String opCode="2035";
	String opName="��Ա��ϵ";
	String memberNo = request.getParameter("memberNo")==null?"":request.getParameter("memberNo");
	String productId = request.getParameter("productId")==null?"":request.getParameter("productId");
	String operType=request.getParameter("operType")==null?"":request.getParameter("operType");
	String tMemberProperty=request.getParameter("tMemberProperty")==null?"":request.getParameter("tMemberProperty");
	System.out.println("tMemberProperty="+tMemberProperty);
	System.out.println("memberNo="+memberNo);
	System.out.println("productId="+productId);
	System.out.println("operType="+operType);
	
	
	
	String sqlStr = "select character_id,character_name,character_value from dproductSignOtherAdd where product_id = '?' and member_no = '?' ";
	
	

%>
<wtc:pubselect name="sPubSelect" outnum="3" routerKey="region" routerValue="<%=regionCode%>">
    <wtc:sql><%=sqlStr%></wtc:sql>
    <wtc:param value="<%=productId%>"/>
    <wtc:param value="<%=memberNo%>"/>
</wtc:pubselect>
<wtc:array id="rows"  scope="end" />
	
	
<wtc:service name="s9104Qry" outnum="8" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=productId%>"/>
	<wtc:param value="2"/>
	<wtc:param value="<%=memberNo%>"/>
</wtc:service>
<wtc:array id="result" start="2" length="6" scope="end" />


<html xmlns="http://www.w3.org/1999/xhtml">	
<head>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<title><%=opName%></title>
</head>

<script language="javascript">
	onload=function() {
		var operType=<%=operType%>;	
	 	if(operType=="1"){
	 		document.getElementById("qryPage").style.display="inline";
	 	}
	 	var tMemberProperty = "<%=tMemberProperty%>";
	 	//alert(tMemberProperty);
	 	if(tMemberProperty!=""&&tMemberProperty!="undefined"){
	 		var arr = tMemberProperty.split("~");
	 		var con = new Array();
	 		for(var i=0;i<arr.length-1;i++){
	 			var content = new Array();
	 			content = arr[i].split("^");
	 			con[i]=content;
	 		}
	 		
	 		var characterIds = document.all.characterId;
  	  var characterValues = document.all.characterValue;
	 	  //alert(con.length);
	 		for(var j=0;j<con.length;j++){
	 			if(typeof(characterIds.length)=="undefined"){//����ֻ��һ������
	 				characterValues.value=con[j][2];
	 			}else{
	 			  for(var k=0;k<characterIds.length;k++){
	 				  if(characterIds[k].value==con[j][0]){
	 				  	characterValues[k].value=con[j][2];
	 				  }
	 			  }
	 		  }
	 		}

	 	}else{//û�д�������
	 		//alert('else');
	 	}
	 	
		//2011/11/11 wanghfa��� start
		for(var i=0;i<document.getElementsByName("characterId").length;i++){
			var characterCheckObj = document.getElementsByName("characterCheck")[i];
			var characterIdObj = document.getElementsByName("characterId")[i];
			var characterNameObj = document.getElementsByName("characterName")[i];
			var characterValueObj = document.getElementsByName("characterValue")[i];
			if (characterIdObj.value == "1017") {
				characterValueObj.v_type = "phone";
			} else if (characterIdObj.value == "1020") {
				//characterValueObj.value = "111111";
				//characterValueObj.readOnly = true;
			} else if (characterIdObj.value == "1021") {
			/*
				var hasVoiceMthdPacket = new AJAXPacket("f2035_ajax_hasVoiceMthd.jsp","���Ժ�......");
				hasVoiceMthdPacket.data.add("productId","<%=productId%>");
				hasVoiceMthdPacket.data.add("iValue",i);
				core.ajax.sendPacket(hasVoiceMthdPacket, doHasVoiceMthdPacket);
				hasVoiceMthdPacket=null;
				*/
			}
		}
		//2011/11/11 wanghfa��� end
	}
	
	function doHasVoiceMthdPacket(packet) {	//2011/11/11 wanghfa���
		var retValue = packet.data.findValueByName("retValue");
		var i = packet.data.findValueByName("iValue");
		if (retValue == "01") {
			document.getElementsByName("characterValue")[i].v_must = "1";
		}
	}

function saveto()
{
	  var retValue="";
		var retFlag = false;
		
	  //var characterChecks = document.all.characterCheck;
	  var characterCheckObjs = document.getElementsByName("characterCheck");
	  if(characterCheckObjs.length == 0){//0����¼�����
	  	window.returnValue=retValue;
    	window.close();
    	
	  } else {//������¼�����
	  	for(var i = 0;i<characterCheckObjs.length;i++){
			  if(characterCheckObjs[i].value==1&&characterCheckObjs[i].checked==false){
			  	rdShowMessageDialog("��ѡ���������!");
			  	return;
			  }
		  }
			//2011/11/10 wanghfa��� start
		  var characterValue1018 = "";
		  var characterCheck1024 = false;
		  var characterCheck1025 = false;
		  for(var i=0;i<document.getElementsByName("characterId").length;i++){
				var characterCheckObj = document.getElementsByName("characterCheck")[i];
				var characterIdObj = document.getElementsByName("characterId")[i];
				var characterNameObj = document.getElementsByName("characterName")[i];
				var characterValueObj = document.getElementsByName("characterValue")[i];

    		if(characterCheckObj.checked==true){
					if (characterIdObj.value == "1018") {
						characterValue1018 = characterValueObj.value;
					} else if (characterIdObj.value == "1024") {
						characterCheck1024 = true;
					} else if (characterIdObj.value == "1025") {
						characterCheck1025 = true;
					}
    		}
		  }
		  for(var i=0;i<document.getElementsByName("characterId").length;i++){
				var characterCheckObj = document.getElementsByName("characterCheck")[i];
				var characterIdObj = document.getElementsByName("characterId")[i];
				var characterNameObj = document.getElementsByName("characterName")[i];
				var characterValueObj = document.getElementsByName("characterValue")[i];
				
				if (characterIdObj.value == "1019") {
					if (characterValue1018 == "1") {
						if (characterCheckObj.checked != true) {
							rdShowMessageDialog("��������Ϊ�̻�ʱ������ѡ��Ա��EMAIL��ַ��", 1);
							return false;
						}
						characterValueObj.v_must = "1";
					} else {
						characterValueObj.v_must = "";
					}
				} else if (characterIdObj.value == "1021" && characterValueObj.v_must == "1" && characterCheckObj.checked != true) {
					rdShowMessageDialog("���������ܣ�����ѡ��CentrexID��", 1);
					return false;
				}
				
    		if(characterCheckObj.checked==true){
					characterValueObj.v_must = "1";
					if (characterIdObj.value == "1023") {
						if (characterValueObj.value == "0") {
							if (characterCheck1024 == true && characterCheck1025 == true) {
								rdShowMessageDialog("�������ͱ�������ͬʱѡ��", 1);
								return false;
							} else if (characterCheck1024 == false && characterCheck1025 == false) {
								rdShowMessageDialog("�������ͱ�������ѡ������һ����", 1);
								return false;
							}
						}
					} else if (characterIdObj.value == "1024") {
						characterValueObj.v_type = "money";
					} else if (characterIdObj.value == "1025") {
						characterValueObj.v_type = "int";
						if (!checkElement(characterValueObj)) {
							return false;
						}
						if (parseInt(characterValueObj.value) > 100 || parseInt(characterValueObj.value) < 0) {
							rdShowMessageDialog("��������������0-100��������", 1);
							return false;
						}
					}
					
					if (!checkElement(characterValueObj)) {
						return false;
					}
					
				//2011/11/10 wanghfa��� end
					retValue += document.all.characterId[i].value+"^";
					retValue += document.all.characterName[i].value+"^";
					retValue += document.all.characterValue[i].value+"~";
					retFlag = true;
    	  }else{
					characterValueObj.v_must = "";
    	  }
    	}
	  }
		
		window.returnValue=retValue;
    window.close();
   
}
	function chooseAll(){
		var characterChecks = document.all.characterCheck;
		if(typeof(characterChecks)=="undefined"){//0����¼�����
	  	return false;
	  }else if(typeof(characterChecks.length)=="undefined"){//1����¼�����
	  	characterChecks.checked=true;
	  }
	  
		for(var i = 0;i<characterChecks.length;i++){
			
			characterChecks[i].checked=true;
		}
	}
	function chooseNone(){
		var characterChecks = document.all.characterCheck;
		if(typeof(characterChecks)=="undefined"){//0����¼�����
	  	return false;
	  }else if(typeof(characterChecks.length)=="undefined"){//1����¼�����
	  	characterChecks.checked=false;
	  }
		var characterChecks = document.all.characterCheck;
		for(var i = 0;i<characterChecks.length;i++){
			characterChecks[i].checked=false;
		}
	}
	
</script>	

<body>
<%@ include file="/npage/include/header_pop.jsp" %>  
	<form name="form_sublist" method="POST">
		 <table cellspacing="0" border="0" cellpadding="0" >
			 <tr >
	        <td class="blue">�������</td>   
	        <td >
	        	<input type="text" name="productId" value="<%=productId%>" readonly >
	        </td>   
	        <td class="blue">��Ա����</td>   
	        <td >
	          <input type="text" name="memberNo" value="<%=memberNo%>" readonly >
	        </td>   
	     </TR>
		 </table>
		
		 <div class="title"><div id="title_zi">��Ա�����б�</div></div>
     <table cellspacing="0" border="0" cellpadding="0" id="memberTab" >
		 	<tr>
		 		 <th>���Ա���</th>
		 		 <th>������</th>
		 		 <th>����ֵ</th>
		 		 <th>�Ƿ����</th>
		 	</tr>	 
		 	<tr> 

		 <%
		 for(int i = 0;i<result.length;i++){
		 %>
		  <tr>
		  <td><input type="hidden" name="characterId"  value="<%=result[i][0]%>" ><input type="checkbox" name="characterCheck" value="<%=result[i][2]%>" 
		    <%if(!"".equals(result[i][5])){%>
		     checked 
		    <%}%>
		    <%if(!"0".equals(result[i][2])){%>
		     disabled 
		    <%}%>
		    ><%=result[i][0]%></td>
		  <td><input type="hidden" name="characterName"  value="<%=result[i][1]%>" ><%=result[i][1]%></td>
		  <td>
			  <%
		  	if (result[i][4].equals("0")) {
		  		%>
				  <input type="text" name="characterValue" value="<%=result[i][5]%>" size="40" 
				  <%if("1".equals(result[i][3])){%>
						readOnly 
		    	<%}%>
		  		>
		  		<%
		  	} else if (result[i][4].equals("1")) {
		  		sqlStr = "select character_value, character_show from sBbossMemberCharacterValue where character_id = '" + result[i][0] + "' order by character_order";
		  		%>
					<wtc:pubselect name="sPubSelect" outnum="3" routerKey="region" routerValue="<%=regionCode%>">
						<wtc:sql><%=sqlStr%></wtc:sql>
					</wtc:pubselect>
					<wtc:array id="options"  scope="end" />
				  <select name="characterValue"
				  <%if("1".equals(result[i][3])){%>
						disabled 
		    	<%}%>
				  >
						<%
						for (int j = 0; j < options.length; j ++) {
							%>
					  	<option value="<%=options[j][0]%>" 
					  		<%if (result[i][5].equals(options[j][0])) {%>
					  			out.print("selected");
					  		<%}%>
					  	><%=options[j][1]%></option>
							<%
						}
						%>
				  </select>
		  		<%
		  	}
		    %>
		  </td>
		  <td><input type="hidden" name="characterMust"  value="<%=result[i][2]%>" ><%if("0".equals(result[i][2])){%>�Ǳ���<%}else{%>����<%}%></td>
		  </tr>
		 <%}%> 
		</table>
		<table cellspacing="0" border="0" cellpadding="0" >
		 <tr>
		 	 <td colspan="5" align="center" id="footer" >
		 	 	 <input class="b_foot" type=button name=checkAll value="ȫѡ" onClick="chooseAll()">
		 	 	 <input class="b_foot" type=button name=checkNone value="ȡ��ȫѡ" onClick="chooseNone()" >
		 	 	 <input class="b_foot" type=button name=qryPage value="ȷ��" onClick="saveto()">
		 	 	 <input class="b_foot" type=button name=back value="�ر�" onClick="window.close()" >
		 	 </td>
		 </tr>	
	  </table>	
		
	</form>
<%@ include file="/npage/include/footer_pop.jsp" %> 
</body>
</html>
