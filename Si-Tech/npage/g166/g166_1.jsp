<%
/********************
 version v2.0
������: si-tech
*
*liuxmc
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
		String opCode = "g166";
		String opName = "����Ʊ����";
		String login_no = (String)session.getAttribute("workNo");
	  String sqlStr1 = "select region_code||group_id,region_name from sregioncode where region_code<=13 order by region_code";
		String sqlStr = "select region_code||district_code||group_id,district_name from sdiscode where use_flag='Y' and district_code!='99' order by district_code";
%>
<wtc:pubselect name="TlsPubSelBoss" outnum="2" retmsg="return_msg" retcode="return_code">
			<wtc:sql><%=sqlStr%></wtc:sql>
		  </wtc:pubselect>
<wtc:array id="return_result" scope="end"/>	 

<wtc:pubselect name="TlsPubSelBoss" outnum="2" retmsg="return_msg1" retcode="return_code1">
			<wtc:sql><%=sqlStr1%></wtc:sql>
		  </wtc:pubselect>
<wtc:array id="return_result1" scope="end"/>	 	

<%
   String case_options = "";
   String mode_options ="<option value=>--��ѡ��--</option>";
   for(int i=0;i<return_result.length;i++)
   {
     case_options += "<option value="+return_result[i][0]+">"+return_result[i][1]+"</option>";
   }
   
      for(int i=0;i<return_result1.length;i++)
   {
     mode_options += "<option value="+return_result1[i][0]+">"+return_result1[i][1]+"</option>";
   }
%>
<HTML>
<HEAD>
<script language="JavaScript">

  var modetypecode = new Array();//ģ�����
  var modetypename = new Array();//ģ������
  var casetypecode = new Array();//������ʹ���
  var casetypename = new Array();//�����������
  <%
  for(int m=0;m<return_result.length;m++)
  {
		out.println("casetypecode["+m+"]='"+return_result[m][0]+"';\n");
		out.println("casetypename["+m+"]='"+return_result[m][1]+"';\n");
  }
  for(int m=0;m<return_result1.length;m++)
  {
		out.println("modetypecode["+m+"]='"+return_result1[m][0]+"';\n");
		out.println("modetypename["+m+"]='"+return_result1[m][1]+"';\n");
  }
  %>
  
function getCase(control,controlToPopulate)
{
	for (var q=controlToPopulate.options.length;q>=0;q--) controlToPopulate.options[q]=null;
//  myEle = document.createElement("option") ;
//    myEle.value = control.value;
//      myEle.value = "00";
//        myEle.text = control.options[control.selectedIndex].text;
//        controlToPopulate.add(myEle) ;
	for ( x = 0 ; x < casetypecode.length  ; x++ )
   {
      if ( casetypecode[x].substr(0,2) == control.value.substr(0,2) )
      {
        myEle = document.createElement("option") ;
        myEle.value = casetypecode[x] ;
        myEle.text = casetypename[x] ;
        controlToPopulate.add(myEle) ;
      }
   }
   var users = document.getElementsByName("busyType2");
  for(i=0;i<users.length;i++){
   if(users[i].checked)
   var radioFlag = users[i].value;
  }
	if (radioFlag ==3){
		document.all.s_in_CaseTypeCode.options.length = 0;
		document.all.yingyt.options.length = 0;
		var varItem = new Option("--����ѡ--", 0);  
		var varItem1 = new Option("--����ѡ--", 0);    
    document.all.s_in_CaseTypeCode.options.add(varItem);
    document.all.yingyt.options.add(varItem1);
		}else if (radioFlag ==2){
		document.all.yingyt.options.length = 0;
		var varItem1 = new Option("--����ѡ--", 0);    
    document.all.yingyt.options.add(varItem1);
		}
}

function commit(){
	var fplx=document.frm.fplx.value;
	if(document.frm.invoice_id.value=="")  {
     rdShowMessageDialog("��������ʼ��Ʊ����!");
     document.frm.invoice_id.value = "";
     document.frm.invoice_id.focus();
     return false;
  }
  
  
	if(document.frm.invoice_no.value=="")  {
     rdShowMessageDialog("��������ֹ��Ʊ����!");
     document.frm.invoice_no.value = "";
     document.frm.invoice_no.focus();
     return false;
  }
  
 

  
  /*��Ҫ���ݵ�ѡ��ť ���ж�
  if(document.frm.s_in_ModeTypeCode.value =="")  {
     rdShowMessageDialog("��ѡ���������!");
     document.frm.s_in_ModeTypeCode.value = "";
     document.frm.s_in_ModeTypeCode.focus();
     return false;
  }
  if(document.frm.s_in_CaseTypeCode.value =="")  {
     rdShowMessageDialog("��ѡ����������!");
     document.frm.s_in_CaseTypeCode.value = "";
     document.frm.s_in_CaseTypeCode.focus();
     return false;
  }
  if(document.frm.yingyt.value =="")  {
     rdShowMessageDialog("��ѡ��Ӫҵ��!");
     document.frm.yingyt.value = "";
     document.frm.yingyt.focus();
     return false;
  }*/
  if(document.frm.s_in_ModeTypeCode.value =="")  
  {
      document.frm.s_in_ModeTypeCode.value ="000000";
  }
  if(document.frm.s_in_CaseTypeCode.value =="")  
  {
      document.frm.s_in_CaseTypeCode.value ="000000";
  }
  if(document.frm.yingyt.value =="")
  {
	  document.frm.yingyt.value ="000000";
  }	  
	document.frm.submit();
	            
}


 function sel1() {
 	document.all.s_in_CaseTypeCode.options.length = 0;
		document.all.yingyt.options.length = 0;
 	var varItem = new Option("--����ѡ--", 0);    
 		var varItem1 = new Option("--����ѡ--", 0);    
 		document.all.s_in_CaseTypeCode.options.add(varItem);
    document.all.yingyt.options.add(varItem1);
	document.getElementById("ds").disabled=false;
	document.getElementById("qxmc").disabled=true;
	document.getElementById("yyt").disabled=true;
 }

 function sel2(){
 	document.all.s_in_CaseTypeCode.options.length = 0;
		document.all.yingyt.options.length = 0;
 		var varItem = new Option("--��ѡ��--", 0);    
 		var varItem1 = new Option("--����ѡ--", 0);    
 		document.all.s_in_CaseTypeCode.options.add(varItem);
    document.all.yingyt.options.add(varItem1);
	document.getElementById("ds").disabled=false;
	document.getElementById("qxmc").disabled=false;
	document.getElementById("yyt").disabled=true;
	
 }
 
 function sel3(){
 	document.all.s_in_CaseTypeCode.options.length = 0;
		document.all.yingyt.options.length = 0;
 	var varItem = new Option("--��ѡ��--", 0);    
 		var varItem1 = new Option("--��ѡ��--", 0);    
 		document.all.s_in_CaseTypeCode.options.add(varItem);
    document.all.yingyt.options.add(varItem1);
	document.getElementById("ds").disabled=false;
	document.getElementById("qxmc").disabled=false;
	document.getElementById("yyt").disabled=false;
 }
function sel4(){
	 
	/*
	document.all.yingyt.options.length = 0;
		var varItem1 = new Option("--����ѡ--", 0);    
		document.all.yingyt.options.add(varItem1);
		//����
		document.all.s_in_ModeTypeCode.options.length = 0;
		var varItem2 = new Option("--����ѡ--", 0);    
		document.all.s_in_ModeTypeCode.options.add(varItem2);
		//����
		document.all.s_in_CaseTypeCode.options.length = 0;
		var varItem3 = new Option("--����ѡ--", 0);    
		document.all.s_in_CaseTypeCode.options.add(varItem3);*/
	document.getElementById("ds").disabled=true;
	document.getElementById("qxmc").disabled=true;
	document.getElementById("yyt").disabled=true;
		
 }

 function doclear() {
 		frm.reset();
 }
 
function select_yyt()
{var users = document.getElementsByName("busyType2");
  for(i=0;i<users.length;i++){
   if(users[i].checked)
   var radioFlag = users[i].value;
  }
	 
	 if (radioFlag ==2){
		document.all.yingyt.options.length = 0;
		var varItem1 = new Option("--����ѡ--", 0);    
    document.all.yingyt.options.add(varItem1);
	}else{
	var region_code = document.all.s_in_ModeTypeCode[document.all.s_in_ModeTypeCode.selectedIndex].value.substring(0,2);
	var district_code = document.all.s_in_CaseTypeCode[document.all.s_in_CaseTypeCode.selectedIndex].value.substring(4);
	var myPacket = new AJAXPacket("e673_select.jsp","���ڻ��Ӫҵ����Ϣ�����Ժ�......");
	//alert(region_code+"&"+district_code);

//	var sqlStr = "select region_code||district_code||town_code,town_code||'-- >'||TOWN_NAME from sTownCode where region_code = '"+region_code+"' and district_code = '"+district_code+"' Order By town_code";
	var sqlStr = "select a.group_id,a.group_id||'-->'||b.group_name from dchngroupinfo a,dchngroupmsg b where a.parent_group_id = '"+district_code+"'and a.group_id = b.group_id and root_distance = 4 and b.is_active = 'Y'";
	myPacket.data.add("sqlStr",sqlStr);
	core.ajax.sendPacket(myPacket);
	myPacket = null;
	}
}
function jsAddItemToSelect(objSelect, objItemText, objItemValue) {        
    //�ж��Ƿ����        
          
        var varItem = new Option(objItemText, objItemValue);      
        objSelect.options.add(varItem);     
        alert("�ɹ�����");     
          
}        

function doProcess(packet)
{	 
    var triListdata = packet.data.findValueByName("tri_list");  
    //alert(triListdata);
	document.all("yingyt").length=0;
	document.all("yingyt").options.length=triListdata.length;//triListdata[i].length;
	for(j=0;j<triListdata.length;j++)
	{
		document.all("yingyt").options[j].text=triListdata[j][1];
		document.all("yingyt").options[j].value=triListdata[j][0];
	}//Ӫҵ�������
	document.all("yingyt").options[0].selected=true;	  
}

 </script> 
 
<title>������BOSS-��Ʊ��Ϣ��ѯ��¼��</title>
</head>
<BODY onload="sel4()">
<form action="zytb_2.jsp" method="post" name="frm">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">��Ʊͳ����Ϣ��¼��</div>
		</div> 

  <table cellspacing="0">
    <tr>
    	<td class="blue" width="15%">���ط�ʽ</td>
        <td> 
          <input name="busyType2" type="radio" onClick="sel1()" value="3" >���б���Ʊ���� 
          <input name="busyType2" type="radio" onClick="sel2()" value="2">���ر���Ʊ���� 
          <input name="busyType2" type="radio" onClick="sel3()" value="1">Ӫҵ������Ʊ���� 
          <input name="busyType2" type="radio" onClick="sel4()" value="0" checked>ӪҵԱ����Ʊ����
      </td>
      <td class="blue" width="8%">��Ʊ����</td>
		<td> 
		  <select name="fplx" >
				<option value="1">�ƶ���Ʊ</option>
				<option value="2">��ͨ��Ʊ</option>
		  </select> 
		</td>
    </tr>
	
  </table>

  
  <table cellspacing="0">
    <tr>
    	<td align="left" class="blue" width="15%">��Ʊ����:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="invoice_id" size="10" maxlength="8" onKeyPress="return isKeyNumberdot(0)"><font color="#FF0000">*</font>
      </td>
      <td align="left" class="blue" width="15%">����Ʊ����:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="invoice_no" size="10" maxlength="8" onKeyPress="return isKeyNumberdot(0)"><font color="#FF0000">*</font>
      </td>
      <td align="left" class="blue" width="50%"><input type="button" class="b_foot" value="��ѯ" onclick="doquery()">
      </td>      
    </tr>
    
    <tr>
    	<td align="left" class="blue" width="15%" >��&nbsp;&nbsp;��&nbsp;&nbsp;��&nbsp;&nbsp;��:&nbsp;&nbsp;&nbsp;
        <select name="s_in_ModeTypeCode" id="ds" onchange="getCase(this,s_in_CaseTypeCode)" >
          	<%=mode_options%>                   
          </select><font color="#FF0000">*</font>
      </td>
      <td align="left" class="blue" width="15%">��&nbsp;&nbsp;��&nbsp;&nbsp;��&nbsp;&nbsp;��:&nbsp;&nbsp;&nbsp;
        <select name="s_in_CaseTypeCode" onchange="select_yyt()" id="qxmc">
          </select><font color="#FF0000">*</font>
      </td>
      <td align="left" class="blue" width="50%">Ӫҵ��:&nbsp;
        <select name="yingyt" style=width:80% id="yyt">
          </select><font color="#FF0000">*</font>
      </td>     
    </tr>
  </table>
           
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
             <!-- <input type="button" name="query" class="b_foot" value="���ر���" onclick="bjdh()" >-->
          &nbsp;
			  <input type="button" name="query" class="b_foot" value="��Ʊ����" onclick="commit()" >
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="���" onclick="doclear()" >
          &nbsp;
		  <input type="button" name="return2" class="b_foot" value="�ر�" onClick="removeCurrentTab()" >
       </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>
<script language="javascript">
	function doquery()
	{
		var temp=document.getElementsByName("busyType2");
		/*var myPacket = new AJAXPacket("getInvoice.jsp","���ڲ�ѯ�����Ժ�......");
		for (i=0;i<temp.length;i++)
		{
			if(temp[i].checked)
			{
			   myPacket.data.add("verifyType",temp[i].value);
			}

		}
		core.ajax.sendPacket(myPacket);
		myPacket = null;
		*/
		/*xl Ӫҵ����ѡ��ֵ*/
		var objSel = document.getElementById("yyt");
		var qxmc = document.getElementById("qxmc");
		var qxmcvalue = qxmc.value.substr(4,5);
		var ds = document.getElementById("ds");
		//alert("test "+qxmc.value.substr(4,5) );	
		var h=480;
		var w=650;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight "+300+"px; dialogWidth "+500+"px; dialogLeft "+l+"px; dialogTop "+t+"px;toolbar no; menubar no; scrollbars yes; resizable no;location no;status no";
		var str = ""; 
		for (i=0;i<temp.length;i++)
		{
			if(temp[i].checked)
			{
			    
			   str = window.showModalDialog('getInvoice1.jsp?utype='+temp[i].value+"&yyt="+objSel.value+"&qxmc="+qxmcvalue+"&ds="+ds.value,"",prop);
			    
			}

		}
		if(str == null &&temp[i].value!="0" ){
		   rdShowMessageDialog("�˼�����û���ҵ���¼��ĵ��ط�Ʊ��");
		   return false;
		} 
		
		if(str.length == 0) {
			rdShowMessageDialog("��û��ѡ����ط�Ʊ��" );
			return false;
		 }
		 document.all.invoice_id.value=str[0];
		 document.all.invoice_no.value = str[1]; 
 
		 return true;

		 

	}
	/*
	function doProcess(packet)
	{
		var incoiceid = packet.data.findValueByName("incoiceid");
	 
	}*/
</script>

