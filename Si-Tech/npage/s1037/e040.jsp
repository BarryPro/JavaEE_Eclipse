<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ����Ԥ��� 8379
   * �汾: 1.0
   * ����: 2010/3/12
   * ����: sunaj
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/common/popup_window.jsp" %>
<%
	request.setCharacterEncoding("GBK");
%>
<%
String querysql = "select to_char(region_code),region_name from sregioncode ";
String sql_belong="select to_char(district_code),to_char(region_code),district_name from sdiscode ";
%>
<wtc:pubselect name="TlsPubSelBoss"  retcode="retCode3" retmsg="retMsg3" outnum="2">
	<wtc:sql><%=querysql%></wtc:sql>
	</wtc:pubselect>
		
	<wtc:array id="result0" start="0" length="2" scope="end" />
<%	
	
	if(result0==null||result0.length==0){
		//System.out.println("888888888888888888888888weikong");
		 
		%>
		<script language="javascript">
			 
			rdShowMessageDialog("����δ�ܳɹ�,������Ϣ�����б���ϢΪ��!");
			//history.go(-1); 
		</script>
	<%}
 %>
<wtc:pubselect name="TlsPubSelBoss"  retcode="retCode4" retmsg="retMsg4" outnum="3">
	<wtc:sql><%=sql_belong%></wtc:sql>
	</wtc:pubselect>
<wtc:array id="result01" start="0" length="3" scope="end" />
<%	
	
	if(result01==null||result01.length==0){
		//System.out.println("888888888888888888888888weikong");
		 
		%>
		<script language="javascript">
			rdShowMessageDialog("����δ�ܳɹ�,������Ϣ�����ر���ϢΪ��!"+"<%=retMsg4%>");
			history.go(-1); 
		</script>
	<%}
 %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>������BOSS-��ͨ8λTD��������������Ϣ¼��</title>
<%
    //String opCode="8379";
	//String opName="����Ԥ���";
	
    String opCode="e040";
	String opName="��ͨ8λTD��������������Ϣ¼��";
	 
    String workNo=(String)session.getAttribute("workNo");
    String regionCode=(String)session.getAttribute("regCode");
   
%>

 
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language="javascript">
 function getData(){
	alert("��ȡ�ϸ��¼�¼");
 }
 
  //����ȫ�ֱ���
  var regionCode = new Array();// ����
  var  belongName = new Array();// ����
  var  belongCode = new Array();// ���� 
<%
	//System.out.println("qweqwe1888888888888888888888888888881111111111111lengt is "+result0.length+" and result0  is "+result0[0][0]);
	/*if(result0.length >0){
		for(int m=0;m<result0.length;m++)
		  {
			out.println("project_code["+m+"]='"+result0[m][0]+"';\n");
			out.println("transin_fee["+m+" ]='"+result0[m][1]+"';\n");
			//out.println("transin_fee1["+m+"]='"+result0[m][2]+"';\n");
		  }
	}
	else{
	//System.out.println("qweqwe9888800000000000000000111");
	}*/
	//����
	if(result01.length >0){
		for(int m1=0;m1<result01.length;m1++)
		  {
			out.println("belongCode["+m1+"]='"+result01[m1][0]+"';\n");
			out.println("regionCode["+m1+"]='"+result01[m1][1]+"';\n");
			out.println("belongName["+m1+"]='"+result01[m1][2]+"';\n");
			 
		  }
	}
	else{
	//System.out.println("qweqwe9888800000000000000000111");
	}


%> 
 
/* xl ��̨�Ӻ��Ļ��� selectid projeccode trans_Fee*/
 function chkType(choose,controlToPopulate,belongCodeArray,regionCodeArray,belongNameArray)
 {
 	var myEle ;
    var x ;
    for (var q=controlToPopulate.options.length;q>=0;q--) controlToPopulate.options[q]=null;
    myEle = document.createElement("option") ;
    myEle.value = "";
    myEle.text ="--��ѡ��--";
    controlToPopulate.add(myEle) ;
    for ( x = 0 ; x < regionCodeArray.length  ; x++ )
    {
      if ( regionCodeArray[x] == choose.value )
      {
        myEle = document.createElement("option") ;
        myEle.value = belongCodeArray[x] ;
        myEle.text = belongNameArray[x] ;
        controlToPopulate.add(myEle) ;
      }
    }
  } 
 
 
function init()
{
  
}
 
 
//commit�ύ
function commit()
{
	var   select_rate   =   document.getElementById("rateid") ;
	var   index   =   select_rate.selectedIndex; 
	var   select_value   =   select_rate.options[index].value;   
	var   select_text     =   select_rate.options[index].text;
	var   select_rate2   =   document.getElementById("quxian") ;
	var   index2   =   select_rate2.selectedIndex; 
	var   select_value2   =   select_rate2.options[index2].value;   
	var   select_text2     =   select_rate2.options[index2].text;
	var select_month = document.getElementById("v_month2") ;
	var month_index = select_month.selectedIndex;
	//alert("month_index is "+month_index);
	var month_text =select_month.options[month_index].text;
	var month_value=select_month.options[month_index].value; 
	//alert("month_text  is "+month_text);
	var dythyhs = document.frm.dythyhs.value;
	var dyttsr = document.frm.dyttsr.value;
	var dyydsr = document.frm.dyydsr.value;

	if(dythyhs == ""){
		rdShowMessageDialog("�����뵱��ͨ���û���!");
		document.frm.dythyhs.focus();
	}
	else if(dyttsr == ""){
		rdShowMessageDialog("�����뵱����ͨҵ������!");
		document.frm.dyttsr.focus();
	}
	else if(dyydsr == ""){
		rdShowMessageDialog("�����뵱���ƶ�ҵ������!");
		document.frm.dyydsr.focus();
	}
	else if(dyydsr == ""){
		rdShowMessageDialog("�����뵱���ƶ�ҵ������!");
		document.frm.dythyhs.focus();
	}
	else if(select_value == "0"){
		rdShowMessageDialog("��ѡ�����!");
		 document.getElementById("rateid").focus();
	}
	else if(select_value2 == "0" || select_value2 == ""){
		rdShowMessageDialog("��ѡ����ж�Ӧ������!");
		 document.getElementById("quxian").focus();
	}
	else
    {
		if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
		{
			document.frm.action="sinsert_e040.jsp?monthId="+month_value+"&select_value="+select_value+"&select_value2="+select_value2;
			document.frm.submit();
		}
		
	}
	
}
function doCheck()
{
	var paymoney;
	var temp ;
	with(document.frm)
	{
		paymoney = payMoney.value;
		if ( paymoney.indexOf(".")!=-1)
			{
				temp =  paymoney.substring(paymoney.indexOf(".")+1,paymoney.length);
 				if ( temp.length> 2 )
				{
					rdShowMessageDialog("�ɷѽ��С�����ֻ������2λ��");
					payMoney.focus();
					return false;
				}
			}
	}
}
 
 
 
function doclear(){
	 document.frm.dythyhs.value= "";
	 document.frm.dyttsr.value= "";
	 document.frm.dyydsr.value= "";
	 document.getElementById("rateid").options[0].selected = true;
	 document.getElementById("v_month2").options[0].selected = true;
	 document.getElementById("quxian").options[0].selected = true;
}
 
function fix_dyttsr()
{
	if(document.frm.dyttsr.value!="")
	{
		var num_fix = parseFloat(document.frm.dyttsr.value);
		document.frm.dyttsr.value = num_fix.toFixed(2);
	}
	
} 
function fix_dyydsr()
{
	if(document.frm.dyydsr.value!="")
	{
		var num_fix = parseFloat(document.frm.dyydsr.value);
		document.frm.dyydsr.value = num_fix.toFixed(2);
	}
	
} 
 
</script>

</head>
<body >
<form name="frm" method="POST" onKeyUp="chgFocus(frm)" >
 	<input type="hidden" name="opcode" value = "e040" >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">��Ϣ¼��</div>
	</div>
<table cellspacing="0">
   
 
   <tr colspan = 2>
    	<td align="left" class="blue"  >�����·�: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<select width=10px name="v_month2" id="v_month2" style= "width:40Px ">
				<option value="01" selected>01</option>
				<option value="02">02</option>
				<option value="03">03</option>
				<option value="04">04</option>
				<option value="05">05</option>
				<option value="06">06</option>
				<option value="07">07</option>
				<option value="08">08</option>
				<option value="09">09</option>
				<option value="10">10</option>
				<option value="11">11</option>
				<option value="12">12</option>
			</select>
        &nbsp;&nbsp;&nbsp;
		</td>
		<td align="left" class="blue"  >����ͨ���û���:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="dythyhs" size="20" onKeyPress="return isKeyNumberdot(0)"   >
        &nbsp;&nbsp;&nbsp;
	
		 	 
   </tr>
  
    <tr colspan = 2>
    	<td align="left" class="blue"  >������ͨҵ������:
        <input class="button" type="text" name="dyttsr" size="20" onKeyPress="return isKeyNumberdot(1)" onblur = fix_dyttsr()    >
        &nbsp;&nbsp;&nbsp;
		</td>
	<td align="left" class="blue"  >�����ƶ�ҵ������:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="dyydsr" size="20" onKeyPress="return isKeyNumberdot(1)" onblur = fix_dyydsr() >
        &nbsp;&nbsp;&nbsp;
		 	 
   </tr>
    <tr colspan = 2>
	 <td align="left" class="blue"  >��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        <select id=rateid name=rate style= "width:130Px " onChange="chkType(this,quxian,belongCode,regionCode,belongName)"  >
				<option value = "0" selected>��ѡ�����</option>
				<%
					if(result0.length > 0){
				 	 
						for(int k =0;k<result0.length;k++)
						{%>
							<option value="<%=result0[k][0]%>"><%=result0[k][1]%></option>
							 
						<%}
					}
					else{
						 %><script language= "javascript">alert("����Ϣ");</script><%
						
					}	
						%>
			</select>
        &nbsp;&nbsp;&nbsp;
    	<td align="left" class="blue"  >��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��:
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<select style= "width:130Px " name="quxian" id="quxian" >
				<option value = "0" selected>��ѡ��</option>
            </select>
		</td>
	 
		 	 
   </tr>
   
</table>
<table cellSpacing="0">
    <tr> 
      <td id="footer"> 
              <input type="button" name="query_do" class="b_foot" value="ȷ��" onclick="commit()" >
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="���" onclick="doclear()" >
          &nbsp;
		   
       </td>
    </tr>
  </table>
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
