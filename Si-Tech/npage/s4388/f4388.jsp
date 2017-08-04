<%
    /********************
     * @ OpCode    :  4388
     * @ OpName    :  ��ʡVPMN����
     * @ CopyRight :  si-tech
     * @ Author    :  wangzn
     * @ Date      :  2010-1-26 14:57:49
     * @ Update    :  niuhr 2010-04-06
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.GregorianCalendar" %>
<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
%>

<%
    String opCode = "4388";
    String opName = "��ʡVPMN����";
    
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
		
		
		String sqlStrl = "SELECT distinct fee_index,fee_index_name FROM dAcrossVpmnFeeDeploy";
		
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCodel" retmsg="retMsgl" outnum="2">
		<wtc:sql><%=sqlStrl%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="resultl" scope="end" />
			
<% String sqlStr2 = "SELECT b.offer_id,b.offer_name,a.fee_index FROM dacrossvpmnfeedeploy a,product_offer b WHERE a.other_value1 = b.offer_id ORDER BY a.fee_index"; %>		
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="3">
		<wtc:sql><%=sqlStr2%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result2" scope="end" />

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
 <title>��ʡVPMN����</title>
 <script type=text/javascript>
    function resetJsp(){
        window.location='f4388.jsp';
    }
   /* function selectChange(){
    	  var fee_indexadd = document.form1.fee_indexadd;
    	  var hasChild = 0;
    	  var val = document.form1.fee_index.options[document.form1.fee_index.selectedIndex].value;
    	  var feeIndexAdd = [
    	  <%for(int i=0; i<result2.length;i++ ){%>
    	  	 {self:'<%=result2[i][0]%>',name:'<%=result2[i][1]%>',father:'<%=result2[i][2]%>'}
    	  <%
    	     if(i!=result2.length-1){%>
    	     ,
    	    <%}
    	  }%>];
    	  
    	  for(var i = 0; i<feeIndexAdd.length;i++ ){
		      
		      if(val==feeIndexAdd[i].father){
		          hasChild++;
		          fee_indexadd.length=hasChild;
		          fee_indexadd.options[hasChild-1].text = feeIndexAdd[i].self+'->'+feeIndexAdd[i].name;
		          fee_indexadd.options[hasChild-1].value = feeIndexAdd[i].self;
		       }
		    }
		    if(hasChild==0){
		    	fee_indexadd.length=1;
		    	fee_indexadd.options[0].text='';
		    	fee_indexadd.options[0].value ='0';
		    }
    }  */ 
    
    var params = "";
    function getGroupName(){
    	var op_type = document.form1.op_type.options[document.form1.op_type.selectedIndex].value;
    	if(!checkElement(document.getElementById('group_no'))){
				return false;
			} 
			var group_no = document.getElementById('group_no').value;
			params = group_no+"|";
			//var sqlStr = "SELECT boss_vpmn_code,unit_name  FROM dgrpcustmsg  WHERE boss_vpmn_code = '"+group_no+"'";
			var sqlStr = "90000160";
			var selType = "S";    //'S'��ѡ��'M'��ѡ
			var retQuence = "0|1|";//�����ֶ�
			var fieldName = "ʡ�ڼ��ű��|ʡ�ڼ�������|";//����������ʾ���С�����
      var pageTitle = "ʡ�ڼ�����Ϣ��ѯ";
      var retToField="group_no|group_name|";
      if(op_type=='u'||op_type=='d'){

      	sqlStr = "90000161";
      	selType = "S"; 
      	retQuence = "0|1|2|3|4|5|";
      	fieldName = "ʡ�ڼ��ű��|ʡ�ڼ�������|��ʡ���ű��|��ʡ��������|��ʡ�ʷѱ��|��ʡ�ʷ�����|";
      	pageTitle = "��ʡ�����ʷ����ò�ѯ";
      	retToField="group_no|group_name|acr_group_no|acr_group_name|fee_index_dis|fee_index_name_dis|";
      }
	 	  var path = "/npage/public/fPubSimpSel.jsp";
      path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
      path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
      path = path + "&selType=" + selType;
      path += "&params="+params;
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
		  }
      //getFeeIndex();
    }
    function getArcGroupName(){
    	var op_type = document.form1.op_type.options[document.form1.op_type.selectedIndex].value;
    	if(!checkElement(document.getElementById('acr_group_no'))){
				return false;
			}
			var acr_group_no = document.getElementById('acr_group_no').value;
			params = acr_group_no+"|";
			var sqlStr = "90000162";
			var selType = "S";    //'S'��ѡ��'M'��ѡ
			var retQuence = "0|1|";//�����ֶ�
			var fieldName = "��ʡ���ű��|��ʡ��������|";//����������ʾ���С�����
      var pageTitle = "��ʡ������Ϣ��ѯ";
      var retToField="acr_group_no|acr_group_name|";
      if(op_type=='u'||op_type=='d'){
      	
      	sqlStr = "90000163";
      	selType = "S"; 
      	retQuence = "0|1|2|3|4|5|";
      	fieldName = "ʡ�ڼ��ű��|ʡ�ڼ�������|��ʡ���ű��|��ʡ��������|��ʡ�ʷѱ��|��ʡ�ʷ�����|";
      	pageTitle = "��ʡ�����ʷ����ò�ѯ";
      	retToField="group_no|group_name|acr_group_no|acr_group_name|fee_index_dis|fee_index_name_dis|";
      }
	 	  var path = "/npage/public/fPubSimpSel.jsp";
      path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
      path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
      path = path + "&selType=" + selType;
      path += "&params="+params;
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
      }
		  
    }
    function doSubmit(){
    	//var op_type = document.form1.op_type.options[document.form1.op_type.selectedIndex].value;
    	if(!check(form1)){
    		return;
    	}

    	if(rdShowConfirmDialog("ȷ��Ҫ�ύ��")==1)
			{ 
				loading();
				form1.action="f4388_sub.jsp";
				form1.submit();
			}
    }
    function changeOpType(){
    	
    	clearText();
    	document.getElementById('fee_dis').style.display = 'none';
    	//wuxy alter 20110714
    	document.getElementById('fee_tr').style.display = 'none';
    	var op_type = document.form1.op_type.options[document.form1.op_type.selectedIndex].value;
    	if(op_type=='d'){
    		document.getElementById('fee_tr').style.display = 'none';
    	}
    	setReadOnly();
    	
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
    function setReadOnly(){
    	document.getElementById('group_name').readOnly = true;
    	document.getElementById('acr_group_name').readOnly = true;
    	document.getElementById('fee_index_dis').readOnly = true;
    	document.getElementById('fee_index_name_dis').readOnly = true;
    }
    
    var vFeeIndexCodeTmp = "";
    onload=function(){
        vFeeIndexCodeTmp = $("#fee_index").html();
    }
    /*chendx 20100726 Ϊ�����������ӿ��� 
    function getFeeIndex(){
        var vAcrGroupNo = $("#acr_group_no").val();
        if(vAcrGroupNo.length >= 6){
            if(vAcrGroupNo == '6002002500'){
                $("#fee_index").empty();
                $("<option value='77'>77->����ʡ������0.20Ԫ�����γ�;</option>").appendTo("#fee_index");
            }else{
                $("#fee_index").empty();
                $(vFeeIndexCodeTmp).appendTo("#fee_index");
                $("#fee_index").find("option[value='77']").remove(); 
            }
        }else{
            $("#fee_index").empty();
            $(vFeeIndexCodeTmp).appendTo("#fee_index");
        }
    }*/
 </script>
</head>
<body>
<form name="form1" action="" method="post">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">��ʡVPMN����</div>
</div>
<table cellspacing=0>
    <tr>
        <td class='blue' nowrap width='18%'>��������</td>
        <td><select id='op_type' name='op_type' onchange='changeOpType();'>
        	<option value='a' selected>����</option>
        <!--	<option value='u'>�޸�</option>-->
        	<option value='d'>ɾ��</option></select></td> 
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
    	<td class='blue' nowrap width='18%'>��ʡ���ű��</td>
    	<td><input type='text' name='group_no' id='group_no' v_must='1' v_name='group_no' v_type='0_9'/>
    		  <font class='orange'>*</font>
    		  <input type='button' class='b_text' name='groupNo_qry' id='groupNo_qry' value='��ѯ' onClick="getGroupName();" />
    	</td>  
    	<td class='blue' nowrap width='20%'>��ʡ��������</td>
    	<td><input type='text' name='group_name' id='group_name' Class="InputGrey" readOnly size="30" /></td>
     
    <tr>
    		<td class='blue' nowrap width='18%'>��ʡ���ű��</td>
    	  <td><input type='text' name='acr_group_no' id='acr_group_no' v_must='1' v_name='acr_group_no' v_type='0_9'/>
    		  <font class='orange'>*</font>
    		  <input type='button' class='b_text' name='acrGroupNo_qry' id='acrGroupNo_qry' value='��ѯ' onClick="getArcGroupName();" />
    	  </td> 
    	  <td class='blue' nowrap width='20%'>��ʡ��������</td>
    	  <td><input type='text' name='acr_group_name' id='acr_group_name' Class="InputGrey" readOnly size="30" /></td>
    </tr>
    <tr id='fee_dis' style = 'display:none'>
    	<td class='blue' nowrap width='18%'>��ʡ�ʷѱ��</td>
    	<td><input type='text' name='fee_index_dis' id='fee_index_dis' Class="InputGrey" readOnly /></td>
    	<td class='blue' nowrap width='18%'>��ʡ�ʷ�����</td>
    	<td><input type='text' name='fee_index_name_dis' id='fee_index_name_dis' Class="InputGrey" readOnly /></td>
    	
    </tr>
    
    <tr id='fee_tr' style = 'display:none'><!--wuxy alter 20110714 ���ؼƷ�Ǩ����Ŀ��������ֵ���ڴ����������� -->
    	<td class='blue' nowrap width='18%'>��ʡ�ʷ�</td>
    	<td>
    	<select id='fee_index' name='fee_index' >
    		<%for(int i = 0;i<resultl.length;i++){%>
    			<option value='<%=resultl[i][0]%>'><%=resultl[i][0]%>-&gt;<%=resultl[i][1]%></option>
    		<%}%>
    		
    	</select></td> 

    </tr>
    	

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



<input type="hidden" name="ReqPageName" value="f4388">
<input type="hidden" name="workno" value=<%=workNo%>>
<input type="hidden" name="regionCode" value=<%=regionCode%>> 
<input type="hidden" name="unitCode" value=<%=orgCode%>>
<input type="hidden" id=in6 name="belongCode" value=<%=belongCode%>>  
<input type="hidden" name="workName" value=<%=workName%> >
</form>
 <script type=text/javascript>
 	//selectChange();
 	</script>
</body>
</html>