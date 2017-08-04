<%
    /********************
     * @ OpCode    :  b030
     * @ OpName    :  ��ʡV�����ų�Ա�����ʷѹ���
     * @ CopyRight :  si-tech
     * @ Author    :  zhangyan
     * @ Date      :  2010-7-17 21:14:11
     * @ Update    :  
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.GregorianCalendar" %>
<%
	String opCode = "b030";
	String opName = "��ʡV�����ų�Ա�����ʷѹ���";
	
	String workNo =(String)session.getAttribute("workNo");
	String workName =(String)session.getAttribute("workName");
	String powerRight =(String)session.getAttribute("powerRight");
	String Role =(String)session.getAttribute("Role");
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String groupId =(String)session.getAttribute("groupId");
	String ip_Addr =(String)session.getAttribute("ip_Addr");
	String belongCode =orgCode.substring(0,7);
	String districtCode =orgCode.substring(2,4);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
 <title>��ʡVPMN����</title>
 <script type=text/javascript>
	function resetJsp(){
        window.location='fb030.jsp';
    }	
    function getGroupName(){
    	var op_type = document.form1.op_type.options[document.form1.op_type.selectedIndex].value;
    	if(!checkElement(document.getElementById('group_no'))){
			return false;
		}
		var group_no = document.getElementById('group_no').value;
		
		//var sqlStr = "SELECT boss_vpmn_code,unit_name  FROM dgrpcustmsg  WHERE boss_vpmn_code = '"+group_no+"'";
		var sqlStr = "90000025";
		var selType = "S";    //'S'��ѡ��'M'��ѡ
		var retQuence = "0|1|";//�����ֶ�
		var fieldName = "ʡ�ڼ��ű��|ʡ�ڼ�������|";//����������ʾ���С�����
		var pageTitle = "ʡ�ڼ�����Ϣ��ѯ";
		var retToField="group_no|group_name|";
		if(op_type=='u'||op_type=='d'){
			//sqlStr = "SELECT a.boss_vpmn_code,a.unit_name,b.acr_group_no,b.acr_group_name,c.fee_index,d.fee_index_name FROM dgrpcustmsg a ,dAcrossVpmnUnit b ,dAcrossVpmnRelation c,dAcrossVpmnFeeDeploy d WHERE a.boss_vpmn_code = c.group_no AND b.acr_group_no = c.acr_group_no AND c.fee_index = d.fee_index AND a.boss_vpmn_code='"+group_no+"'";
			sqlStr = "90000026";
			selType = "S"; 
			retQuence = "0|1|2|3|4|5|";
			fieldName = "ʡ�ڼ��ű��|ʡ�ڼ�������|��ʡ���ű��|��ʡ��������|�ʷѱ��|�ʷ�����|";
			pageTitle = "��ʡ�����ʷ����ò�ѯ";
			retToField="group_no|group_name|acr_group_no|acr_group_name|fee_index_dis|fee_index_name_dis|";
		}
		
		var params = group_no + "|";
		
		var path = "fPubSimpSel.jsp";
		path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
		path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
		path = path + "&selType=" + selType;
		path = path + "&params=" + params;
		var retInfo = window.showModalDialog(path,"","dialogWidth:70;dialogHeight:35;");
		if(retInfo ==undefined){
			return;
      	}
         
		var chPos_field = retToField.indexOf("|");
		var chPos_retStr;
		var valueStr;
		var obj;
		while(chPos_field > -1)
		{
			obj = retToField.substring(0,chPos_field);
			chPos_retInfo = retInfo.indexOf("|");
			valueStr = retInfo.substring(0,chPos_retInfo);
			document.all(obj).value = valueStr;
			retToField = retToField.substring(chPos_field + 1);
			retInfo = retInfo.substring(chPos_retInfo + 1);
			chPos_field = retToField.indexOf("|");  
		}
      
		document.getElementById("group_no").readOnly = true;
		if(op_type=='u'||op_type=='d'){
			document.getElementById("acr_group_no").readOnly = true;
			document.getElementById("groupNo_qry").disabled = true;
			document.getElementById("acrGroupNo_qry").disabled = true;
		}		    
    }
    function getArcGroupName(){
		var op_type = document.form1.op_type.options[document.form1.op_type.selectedIndex].value;
		if(!checkElement(document.getElementById('acr_group_no'))){
			return false;
		}
		var acr_group_no = document.getElementById('acr_group_no').value;
		
		var sqlStr = "90000027";
		var selType = "S";    //'S'��ѡ��'M'��ѡ
		var retQuence = "0|1|";//�����ֶ�
		var fieldName = "��ʡ���ű��|��ʡ��������|";//����������ʾ���С�����
		var pageTitle = "��ʡ������Ϣ��ѯ";
		var retToField="acr_group_no|acr_group_name|";
		if(op_type=='u'||op_type=='d'){
			//sqlStr = "SELECT a.boss_vpmn_code,a.unit_name,b.acr_group_no,b.acr_group_name,c.fee_index,d.fee_index_name FROM dgrpcustmsg a ,dAcrossVpmnUnit b ,dAcrossVpmnRelation c,dAcrossVpmnFeeDeploy d WHERE a.boss_vpmn_code = c.group_no AND b.acr_group_no = c.acr_group_no AND c.fee_index = d.fee_index AND b.acr_group_no = '"+acr_group_no+"'";
			sqlStr = "90000028";
			selType = "S"; 
			retQuence = "0|1|2|3|4|5|";
			fieldName = "ʡ�ڼ��ű��|ʡ�ڼ�������|��ʡ���ű��|��ʡ��������|�ʷѱ��|�ʷ�����|";
			pageTitle = "��ʡ�����ʷ����ò�ѯ";
			retToField="group_no|group_name|acr_group_no|acr_group_name|fee_index_dis|fee_index_name_dis|";
		}
		var params = acr_group_no + "|";
		
		var path = "fPubSimpSel.jsp";
		path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
		path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
		path = path + "&selType=" + selType;
		path = path + "&params=" + params;
		
		var retInfo = window.showModalDialog(path,"","dialogWidth:70;dialogHeight:35;");
		if(retInfo ==undefined){
			return;
		}
      
		var chPos_field = retToField.indexOf("|");
		var chPos_retStr;
		var valueStr;
		var obj;
		while(chPos_field > -1)
		{
		obj = retToField.substring(0,chPos_field);
		chPos_retInfo = retInfo.indexOf("|");
		valueStr = retInfo.substring(0,chPos_retInfo);
		document.all(obj).value = valueStr;
		retToField = retToField.substring(chPos_field + 1);
		retInfo = retInfo.substring(chPos_retInfo + 1);
		chPos_field = retToField.indexOf("|");  
		}
		document.getElementById("group_no").readOnly = true;
		if(op_type=='u'||op_type=='d'){
		  document.getElementById("acr_group_no").readOnly = true;
		  document.getElementById("groupNo_qry").disabled = true;
		  document.getElementById("acrGroupNo_qry").disabled = true;
		}    
    }
    //wangleic add 2011-3-21 06:03PM
    function getMemberAppendFee(){
		var acr_group_no = document.getElementById('acr_group_no').value;
		
		var sqlStr = "90000029";
		var selType = "S";    //'S'��ѡ��'M'��ѡ
		var retQuence = "0|1|";//�����ֶ�
		var fieldName = "�ʷѴ���|�ʷ�����|";//����������ʾ���С�����
		var pageTitle = "��Ա��ѡ�����ʷѲ�ѯ";
		var retToField="member_append_fee|member_append_fee1|";
		
		var params = acr_group_no + "|";
		
		if(document.form1.acr_group_no.value == "")
        {
            rdShowMessageDialog("�������ʡ���ű�Ž��в�ѯ��");
            document.form1.acr_group_no.focus();
            return false;
        }
        
		var path = "fPubSimpSel.jsp";
		path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
		path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
		path = path + "&selType=" + selType;
		path = path + "&params=" + params;
		var retInfo = window.showModalDialog(path,"","dialogWidth:70;dialogHeight:35;");
		if(retInfo ==undefined){
			return;
		}
      
		var chPos_field = retToField.indexOf("|");
		var chPos_retStr;
		var valueStr;
		var obj;
		while(chPos_field > -1)
		{
		obj = retToField.substring(0,chPos_field);
		chPos_retInfo = retInfo.indexOf("|");
		valueStr = retInfo.substring(0,chPos_retInfo);
		document.all(obj).value = valueStr;
		retToField = retToField.substring(chPos_field + 1);
		retInfo = retInfo.substring(chPos_retInfo + 1);
		chPos_field = retToField.indexOf("|");  
		}
		document.getElementById("member_append_fee1").readOnly = true;
		document.getElementById("acr_group_no").readOnly = true; 
    }
    
    function doSubmit(){
		var op_type = document.form1.op_type.options[document.form1.op_type.selectedIndex].value;
		if(op_type=='a'||op_type=='u'){
			if(!check(form1)){
				return;
			}
		}
		else{
			if(!checkElement(document.getElementById('group_no'))){
			return false;
			}
			if(!checkElement(document.getElementById('acr_group_no'))){
			return false;
			}
		}
    	if($("#multi_phoneNo").val() == ""){
			rdShowMessageDialog("���벻��Ϊ�գ�",0);
			$("#multi_phoneNo").focus();
			return false;
		}   	
    	if(rdShowConfirmDialog("ȷ��Ҫ�ύ��")==1){ 
			form1.action="fb030_sub.jsp"
			form1.method="post";
			form1.submit();
			loading();
		}
    }
    function changeOpType(){
    	clearText();
    	document.getElementById('offer_id').style.display = '';
    	var op_type = document.form1.op_type.options[document.form1.op_type.selectedIndex].value;

    	if(op_type=='d'){
    		document.getElementById('offer_id').style.display = 'none';
    	}
    	
    	document.getElementById("groupNo_qry").disabled = false;
		document.getElementById("acrGroupNo_qry").disabled = false;
    	
    }
    function clearText(){
    	var objs = form1.all;
    	for(var i = 0;i<objs.length;i++){
    		if(objs[i].type!='undefined'&&objs[i].type=='text'){
    			objs[i].value='';
    			objs[i].readOnly=false;
    		}
    	}
    }
    


 </script>
</head>
<body>
<form name="form1" action="" method="post">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">��ʡV�����ų�Ա�����ʷѹ���</div>
</div>
<table cellspacing=0>
    <tr>
        <td class='blue' nowrap width='18%'>��������</td>
        <td><select id='op_type' name='op_type' onchange='changeOpType();'>
        	<option value='a' selected>���ʷ�</option>
        	<option value='u'>�޸��ʷ�</option>
        	<option value='d'>ɾ���ʷ�</option></select></td> 
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
    	<td class='blue' nowrap width='18%'>��ʡ���ű��</td>
    	<td><input type='text' name='group_no' id='group_no' v_must='1' v_name='group_no' v_type='0_9' />
    		  <font class='orange'>*</font>
    		  <input type='button' class='b_text' name='groupNo_qry' id='groupNo_qry' value='��ѯ' onClick="getGroupName();" />
    	</td>  
    	<td class='blue' nowrap width='18%'>��ʡ��������</td>
    	<td><input type='text' name='group_name' id='group_name' Class="InputGrey" readOnly size="30"/></td>
     
    <tr>
    		<td class='blue' nowrap width='18%'>��ʡ���ű��</td>
    	  <td><input type='text' name='acr_group_no' id='acr_group_no' v_must='1' v_name='acr_group_no' v_type='0_9'/>
    		  <font class='orange'>*</font>
    		  <input type='button' class='b_text' name='acrGroupNo_qry' id='acrGroupNo_qry' value='��ѯ' onClick="getArcGroupName();" />
    	  </td> 
    	  <td class='blue' nowrap width='18%'>��ʡ��������</td>
    	  <td><input type='text' name='acr_group_name' id='acr_group_name' Class="InputGrey" readOnly size="30"/></td>
    <tr id='offer_id'>
    	<td class='blue' nowrap width='18%'>��Ա��ѡ�����ʷ�</td>
    	<td colspan="3">
    	<input type="hidden" id="member_append_fee" name="member_append_fee" value="" />
    	<input type='text' name='member_append_fee1' id='member_append_fee1' v_must='1' v_name='group_no' v_type='0_9' />
    	<input type='button' class='b_text' name='memberAppendFee_qry' id='memberAppendFee_qry' value='��ѯ' onClick="getMemberAppendFee();" />
    	</td> 
    </tr>

    <tr>
        <TD class=blue>����</TD>
        <TD>
            <textarea cols=30 rows=8 name="multi_phoneNo" id="multi_phoneNo" style="overflow:auto" /></textarea>
        </TD>
        <TD colspan='2' class="orange">
            ˵������������֮���á�|������
            <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����֮�䲻���ظ���һ�β��ܳ���50����
            <br>&nbsp;���磺<br><font color=black>
            	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13900000001|<br>
            	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13900000002|<br>
            	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13900000003|<br></font>
        </TD>
    </tr>
    <!--tr id="noticeTr" style="display:none;"><td colspan="4"><span id="notice" style="color:red;"></span></td></tr-->
</table>

<TABLE cellSpacing=0>
    <TR id="footer">        
        <TD align=center>
            <input class="b_foot" name="sure" id="sure" type=button value="ȷ��" onclick="doSubmit();"/>
            <input class="b_foot" name='clear2' id='clear2' type='button' value="���" onClick="resetJsp()" />
            <input class="b_foot" name="close2"  onClick="removeCurrentTab()" type=button value="�ر�" />
        </TD>
    </TR>
</TABLE>
<jsp:include page="/npage/common/pwd_comm.jsp"/>
<%@ include file="/npage/include/footer.jsp" %>



<input type="hidden" name="ReqPageName" value="fb030">
<input type="hidden" name="workno" value=<%=workNo%>>
<input type="hidden" name="regionCode" value=<%=regionCode%>> 
<input type="hidden" name="unitCode" value=<%=orgCode%>>
<input type="hidden" id=in6 name="belongCode" value=<%=belongCode%>>  
<input type="hidden" name="workName" value=<%=workName%> >
<input type="hidden" id="fee_index_dis" name="fee_index_dis" value="" />
<input type="hidden" id="fee_index_name_dis" name="fee_index_name_dis" value="" />
</form>
</body>
</html>