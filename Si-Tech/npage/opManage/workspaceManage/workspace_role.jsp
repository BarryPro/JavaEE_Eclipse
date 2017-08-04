<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<head>
	<%
		response.setHeader("Pragma","No-cache");
		response.setHeader("Cache-Control","no-cache");
		response.setDateHeader("Expires", 0);
		
		String opName="��ɫȨ�޹���";
		
		String workNo = (String)session.getAttribute("workNo");
		String orgCode =  (String)session.getAttribute("orgCode");
		String regionCode = orgCode.substring(0,2);
		String  powerCode = session.getAttribute("powerCode")==null?"":((String)session.getAttribute("powerCode")).trim();//��ɫ����
		 
	%>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
	<title><%=opName%></title>
	<style>	
		#rootTree {
			height: 280px;
			border: 1px solid #95CBDD;
			border-top: 0;
			overflow: auto;
			background-color: #F7F7F7;
			padding: 4px 0px 1px 0px;
			width:100%;
			font: 12px Verdana, Arial, Helvetica, sans-serif,"����"��"����";
		}
	</style>
	<script src="<%=request.getContextPath()%>/njs/extend/mztree/MzTreeView12.js" type="text/javascript"></script>
	<script language="javascript" type="text/javascript">		
		 var roleStr = "";
		
		//��ȡѡ�е����ڵ�		
		function getTreeValue()
		{
		    var treeStr="";		 	    
		    var workspace_role_tree = document.getElementsByName("workspace_role_tree");
		    for(var i=0;i<workspace_role_tree.length;i++){
		    	if(workspace_role_tree[i].checked){
		    		treeStr += workspace_role_tree[i].value +"~";
		    	}
		    }
		    return treeStr;
		}
		
		//select���һ�
		function optionChg(mod1,mod2){
	      var m1=g(mod1);
	      var m2=g(mod2);
	      if(m1.tagName!='SELECT' || m2.tagName!='SELECT'){ 
	          return;
	      }else{
	          if(m1.selectedIndex>-1){
				    for(var i=m1.options.length-1; i>=0; i--){ 
				      if(m1[i].selected == true){
				      	 var varItem = new Option(m1.options[i].text, m1.options[i].value); 
				      	 m2.options.add(varItem);
				         m1.options[i]=null;
				      } 
				   } 
	          }
	      }
	  	}
	  
		function g(o){
			return document.getElementById(o);
	 	}	
	 	
	 	function doSubmit(){
	 		updRoleStr();
	 		var treeStr = roleStr;
	 		if(treeStr==""){
	 			rdShowMessageDialog("��ѡ���ɫ��",1);
	 			return;
	 		}
	 		var optLength = document.getElementById("moduleHide").options.length;
	 		if(optLength==0){
	 			rdShowMessageDialog("��ǰģ��Ϊ�գ�",1);
	 			return;
	 		}
	 		
	 		
	 		//�Ե�ǰ���������װ����~����,��˳����װ����̨��˳���޸�order_idֵ
	 		var optVal = "";
	 		for(var i=0;i<optLength;i++){
	 			var val = document.getElementById("moduleHide").options[i].value;
	 			optVal += val+"~";
	 		}
	 		g("doSet").disabled = "disabled";
	 		var submitPacket = new AJAXPacket("workspace_op.jsp","����ִ��,���Ժ�...");
	      	submitPacket.data.add("opType", "setRole");
	      	submitPacket.data.add("selectValue", optVal);
	      	submitPacket.data.add("treeValue", treeStr);      	
	      	core.ajax.sendPacket(submitPacket,doProcess,true);
	      	delPacket = null; 
	    
	 	}
	 	
	 	
	 	function doProcess(packet)      
 		{
	       var opType = packet.data.findValueByName("opType"); 
	       var retCode = packet.data.findValueByName("retCode"); 
	       var retMsg = packet.data.findValueByName("retMsg"); 
	      
	       if(opType=="setRole"){
       			if(retCode=="000000"){
       				rdShowMessageDialog("ģ���ɫ��Ȩ�ɹ���",2);
       				g("doSet").disabled = "";
       				window.opener.queryTemplate();
       				window.close();
       			}else{
       				rdShowMessageDialog("ģ���ɫ��Ȩʧ��!<br>������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
       				return false;
       			}
       			
       	   }
       }
       
       function upDownFunc(obj,mType){
	      var selectObj = g(obj);
	      var selIndex=selectObj.selectedIndex;
	      if(selIndex==-1){
	      		rdShowMessageDialog("��ѡ��Ҫ�ƶ���ģ��");
	      		return;
	      }
		  var selValue=selectObj.options[selIndex].value;
		  var selText=selectObj.options[selIndex].text;
		  
		  try{
		      if(mType=='up'){
				  selectObj.options[selIndex].value=selectObj.options[selIndex-1].value;
				  selectObj.options[selIndex].text=selectObj.options[selIndex-1].text;
				  selectObj.options[selIndex-1].value=selValue;
				  selectObj.options[selIndex-1].text=selText;
				  selectObj.selectedIndex=selIndex-1;
			  }else{
				   selectObj.options[selIndex].value=selectObj.options[selIndex+1].value;
				   selectObj.options[selIndex].text=selectObj.options[selIndex+1].text;
				   selectObj.options[selIndex+1].value=selValue;
				   selectObj.options[selIndex+1].text=selText;
				   selectObj.selectedIndex=selIndex+1; 
			  }
		  }
		  catch(e){}
	  }
	         
function queryPowerCode(str){
	var path = "/npage/opManage/roleTree/roletree.jsp";
	window.open(path,'_blank','height=600,width=300,scrollbars=yes');
}
function compRoleId(roleStr,retRoleId){
	var retVal = 0;
	var tempArr = roleStr.split("~");
	for(var i=0;i<tempArr.length;i++){
		if(tempArr[i]==retRoleId){
			retVal++;
			break;
		}
	}
	return retVal ;
}
function setRolefunc(retRoleId,retRoleName,retRoleTypeName,retPowerDes){
	//alert("setRolefunc->\nretRoleId|"+retRoleId+"\nretRoleName|"+retRoleName+"\nretRoleTypeName|"+retRoleTypeName+"\nretPowerDes|"+retPowerDes);
	if(compRoleId(roleStr,retRoleId)>0){
		rdShowMessageDialog("���еĽ�ɫ��¼��������ѡ��");
		return;
	}
	var inHtml = "<tr>"+
					"<td width='30%'>"+
					retRoleId+
					"</td>"+
					"<td  width='60%'>"+
					retRoleName+
					"</td>"+
					"<td >"+
					"<input type='button' value='ɾ��' class='b_text' onclick='delTr(this)'>"+
					"</td>"+
				"</tr>";
	$("#roleTab").append(inHtml);
	updRoleStr();
}

function updRoleStr(){
	$("#roleTab tr:gt(0)").each(function(){
		roleStr += $(this).find("td:eq(0)").text().trim()+"~";
	});
}
function delTr(bt){
	$(bt).parent().parent().remove();
	updRoleStr();
}
 	function CHECKKEY(){
 if (event.keyCode == 13 && event.ctrlKey)
 {
 doSubmit();
 }
}
	</script>
</head>
<body ONKEYDOWN="CHECKKEY()">
	<form method="post" name="frm">
	<%@ include file="/npage/include/header_pop.jsp" %>
	
		<div style="width:38%;float:left;margin-right:10px">
			<div class="title" id="div_title">
				<div id="title_zi">
					��ɫѡ��&nbsp;<input type="button" class="b_text" onclick="queryPowerCode('frm')" value="���ӽ�ɫ">
				</div>
			</div>
			<div id="rootTree">
				<table cellspacing="0" id="roleTab">
				<tr>
					<th class="blue">
						��ɫ����
					</th>
					<th class="blue">
						��ɫ����
					</th>
					<th class="blue">
						����
					</th>
				</tr>
				 
			</table>
				</div>
		</div>
	
		<div class="title">
			<div id="title_zi">
				��ɫģ������
			</div>
		</div>
		<div style="float:right;margin-right:10px">
			<table cellspacing="0">
				<tr height="25px">
					<td class="blue">
						��ǰģ�飺
					</td>
					<td class="blue">
						&nbsp;
					</td>
					<td class="blue">
						��ѡģ�飺
					</td>
				</tr>
				<tr>
					<td class="blue">
						<select id="moduleHide" name="moduleHide" multiple="multiple" style="width: 200px;height: 230px;">
						 
						</select>
					</td>
					<td class="blue">
						<input type="button" class="b_text" id="save" name="save"
							value=">>" onClick="optionChg('moduleHide','moduleShow');" />
						<br />
						<br />
						<input type="button" class="b_text" id="save" name="save"
							value="<<" onClick=" optionChg('moduleShow','moduleHide');"/>
					</td>
					<td class="blue">
						<select id="moduleShow" name="moduleShow" multiple="multiple" style="width: 200px;height: 230px;">
						<%	
							String sqlStr2 ="select wkspace_id,wkspace_name from dwkspacemsg where  is_effect='1' ";
          				%>
					 		<wtc:service name="TlsPubSelCrm" outnum="2" routerKey="region" routerValue="<%=regionCode %>">
						 		<wtc:param value="<%=sqlStr2%>" />
					 		</wtc:service>
					 		<wtc:array id="result_t2" scope="end"/>
					 		<%
					 		for(int i=0;i<result_t2.length;i++){
					 			out.print("<option value='"+result_t2[i][0]+"'>"+result_t2[i][1]+" </option>");
					 		}
					 		%>
						</select>
					</td>
				</tr>
				
			</table>
		</div>
			
	</div>		
		
	<div id="Operation_Table">
		<div>		
			<TABLE cellSpacing=0>       
	            <tr> 
	              <td align=center id="footer"> 
	               	<input type="button" class="b_foot" value="ȷ��" id="doSet" name="doSet" onClick="doSubmit()" />
					<input type="button" class="b_foot" value="�ر�" id="clears" name="clears" onClick="window.close();" />
	             </td>
	            </tr>
	        </TABLE>
		</div>

	<%@ include file="/npage/include/footer_pop.jsp" %>
	</form>
</body>
</html>