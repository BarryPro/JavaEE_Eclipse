<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: ���ⷴ��
�� * �汾: v1.0
�� * ����: 2008��10��25��
�� * ����: leimd
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
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
	String regionCode = session.getAttribute("regCode");
	
	
	String sqlStr = "select character_id,character_name,character_value from dproductSignOtherAdd where product_id = '?' and member_no = '?' ";
	
	

%>
<wtc:pubselect name="sPubSelect" outnum="3" routerKey="region" routerValue="<%=regionCode%>">
    <wtc:sql><%=sqlStr%></wtc:sql>
    <wtc:param value="<%=productId%>"/>
    <wtc:param value="<%=memberNo%>"/>
</wtc:pubselect>
<wtc:array id="rows"  scope="end" />

	
<html xmlns="http://www.w3.org/1999/xhtml">	
<head>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<title><%=opName%></title>
</head>

<script language="javascript">
	onload=function()
  	{
  		var operType=<%=operType%>;	
  	 	if(operType=="1"){
  	 		document.getElementById("qryPage").style.display="inline";
  	 	}
  	 	var tMemberProperty = "<%=tMemberProperty%>";
  	 	if(tMemberProperty!=""&&tMemberProperty!="undefined"){
  	 		var arr = tMemberProperty.split("@");
  	 		var con = new Array();
  	 		for(var i=0;i<arr.length-1;i++){
  	 			var content = new Array();
  	 			content = arr[i].split("*");
  	 			con[i]=content;
  	 		}
  	 	    for(var j=0;j<con.length;j++){
			    var tab = document.getElementById("memberTab");	
				var t_row =tab.insertRow(-1);
				var t_cell1=t_row.insertCell(0);
				var t_cell2=t_row.insertCell(1);
				var t_cell3=t_row.insertCell(2);
				var t_cell4=t_row.insertCell(3);
				
			    t_cell1.innerHTML="<input type=\"text\" name=\"characterId\" value='"+con[j][0]+"' v_must=\"1\" v_type=\"string\"  >";
			    t_cell2.innerHTML="<input type=\"text\" name=\"characterName\" value='"+con[j][1]+"' v_must=\"1\" v_type=\"string\"  >";	
			    t_cell3.innerHTML="<input type=\"text\" name=\"characterValue\" value='"+con[j][2]+"' v_must=\"1\" v_type=\"string\"  >";
			    t_cell4.innerHTML="<input type=\"button\" name=\"b_del\" value=\"ɾ��\" class=\"b_text\" onclick=\"delColumn(this)\" >";  	 	    		
  	 	    }

  	 	}
  	}
	function saveto()
	{
		if(!check(form_sublist)){			
			return;
		}
		var retValue="";
		var retFlag = false;

		if(document.getElementById("characterId") == null){
		    rdShowMessageDialog("��δ��ӳ�Ա����!");
        }else{
    		if(typeof (document.all.characterId.length) =="undefined" ){
    			if(typeof (document.all.characterId.value) =="undefined"){
    				
    				retFlag = false;
    			}else{
    				retValue += document.all.characterId.value+"*";
    				retValue += document.all.characterName.value+"*";
    				retValue += document.all.characterValue.value+"@";
    				retFlag = true;
    			}
    			
    		}else{
    			for(var i=0;i<document.all.characterId.length;i++){
    				retValue += document.all.characterId[i].value+"*";
    				retValue += document.all.characterName[i].value+"*";
    				retValue += document.all.characterValue[i].value+"@";
    				retFlag = true;
    			}			
    		}
    		if(retFlag){
    			window.returnValue=retValue;
    			window.close();
    		}else{
    			rdShowMessageDialog("��ѡ���Ա����!");
    		}
        }
	}
	function addColumn(){
	    var tab = document.getElementById("memberTab");	
			var t_row =tab.insertRow(-1);
			var t_cell1=t_row.insertCell(0);
			var t_cell2=t_row.insertCell(1);
			var t_cell3=t_row.insertCell(2);
			var t_cell4=t_row.insertCell(3);
		  //var t_cell5=t_row.insertCell(4);
		  //var t_cell6=t_row.insertCell(5);
		  //t_cell1.innerHTML="<input type=\"text\" name=\"productId\" value=\"<%=productId%>\" v_must=\"1\" v_type=\"string\" readonly >";
		  //t_cell2.innerHTML="<input type=\"text\" name=\"memberNo\" value=\"<%=memberNo%>\" v_must=\"1\" v_type=\"string\" readonly >";
		    t_cell1.innerHTML="<input type=\"text\" name=\"characterId\" value=\"\" v_must=\"1\" v_type=\"string\"  >";
		    t_cell2.innerHTML="<input type=\"text\" name=\"characterName\" value=\"\" v_must=\"1\" v_type=\"string\"  >";	
		    t_cell3.innerHTML="<input type=\"text\" name=\"characterValue\" value=\"\" v_must=\"1\" v_type=\"string\"  >";
		    t_cell4.innerHTML="<input type=\"button\" name=\"b_del\" value=\"ɾ��\" class=\"b_text\" onclick=\"delColumn(this)\" >";
	}
	function delColumn(obj){
		  var td = obj.parentNode;
		  var tr = td.parentNode;
		  tr.parentNode.removeChild(tr);
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
		 		 <th>&nbsp;</th>
		 	</tr>	 
		 	<tr> 
		 	<% 
		 	  for(int i =0;i<rows.length;i++)
		 	  {
		 	%>
		  <td><input type="text" name="characterId" id="characterId" value="<%=rows[i][0]%>" ></td>
		  <td><input type="text" name="characterName" id="characterName" value="<%=rows[i][1]%>" ></td>
		  <td><input type="text" name="characterValue" id="characterValue" value="<%=rows[i][2]%>" ></td>
		  <td><input type="button" name="b_del" value="ɾ��" class="b_text" onclick="delColumn(this)"></td>
		</tr>	   
		 <%}%> 
		</table>
		<table cellspacing="0" border="0" cellpadding="0" >
		 <tr>
		 	 <td colspan="5" align="center" id="footer" >
		 	 	 <input class="b_foot" type=button name=qryPage value="����" onClick="addColumn()" style="display:none">
		 	 	 <input class="b_foot" type=button name=qryPage value="ȷ��" onClick="saveto()">
		 	 	 <input class="b_foot" type=button name=back value="�ر�" onClick="window.close()" >
		 	 </td>
		 </tr>	
	  </table>	
		
	</form>
<%@ include file="/npage/include/footer_pop.jsp" %> 
</body>
</html>
