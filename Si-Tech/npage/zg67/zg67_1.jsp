 <%
	/********************
	 version v2.0
	������: si-tech
	update:zhangshuaia@2009-08-10 ҳ�����,�޸���ʽ
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page language="java" import="java.sql.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="org.apache.log4j.Logger"%>

<html>
	<head> 
	<title>Ͷ���˷ѹ���</title>
	<%@ include file="../../npage/s4140/head_4141_1_javascript.htm" %>
<%
  	String opCode = "zg67";		
	String opName = "����������ҵ���˷ѽ���";	//header.jsp��Ҫ�Ĳ���
	
	String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
	
	String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String org_Code = (String)session.getAttribute("orgCode");
    String regionCode = org_Code.substring(0,2);
    String groupId = (String)session.getAttribute("groupId");
    //xl add for 800001
	String region_code_new="";
	//work_no="801001";
	
 
%>
	<wtc:sequence name="TlsPubSelBoss" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
<%
    String sysAccept = seq;
    System.out.println("sysAccept="+sysAccept);

 
String tfywSql = "9";
%>
 
<%
	String sqlBillType="10";
%>
 
	
	<wtc:service name="sBossDefSqlSel"   outnum="2">
   		<wtc:param value="<%=sqlBillType%>"></wtc:param>
   	</wtc:service>
  	<wtc:array id="sBillTypeStr" scope="end"/>

	<wtc:service name="sBossDefSqlSel"  outnum="2">
   		<wtc:param value="<%=tfywSql%>"></wtc:param>
   	</wtc:service>
  	<wtc:array id="stflxStr" scope="end"/>
	 
<%
	String contextPath = request.getContextPath();
%>

<link href="<%= contextPath %>/css/sc.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript" src="<%= contextPath %>/js/common/date/iOffice_Popup.js"></SCRIPT>
<SCRIPT language="JavaScript" src="<%= contextPath %>/js/common/redialog_res/redialog.js"></SCRIPT>
<SCRIPT language="JavaScript" src="<%= contextPath %>/js/common/common_check.js"></SCRIPT>
<SCRIPT language="JavaScript" src="<%= contextPath %>/js/common/common_util.js"></SCRIPT>

<script language=javascript>
function fPopUpCalendarDlg(ctrlobj)
{
	if(N)
	{
		showx = 220 ; // + deltaX;
		showy = 220; // + deltaY;
	}
	else
	{
		showx = event.screenX - event.offsetX - 4 - 210 ; // + deltaX;
		showy = event.screenY - event.offsetY + 18; // + deltaY;
	}
	newWINwidth = 210 + 4 + 18;
	if(N)
	{
		window.top.captureEvents (Event.CLICK|Event.FOCUS);
		window.top.onclick=IgnoreEvents;
		window.top.onfocus=HandleFocus;
		winPopupWindow.args = ctrlobj;
		winPopupWindow.returnedValue = new Array();
		winPopupWindow.args = ctrlobj;
		newWINwidth = 202;
		winPopupWindow.win = window.open("/js/common/date/CalendarDlg.htm","CalendarDialog","dependent=yes,left="+showx + ",top=" + showy + ",width="+newWINwidth + ",height=182px" )
		winPopupWindow.win.focus()
		return winPopupWindow;
	}
	else
	{
		retval = window.showModalDialog("/js/common/date/CalendarDlg.htm", "", "dialogWidth:197px; dialogHeight:210px; dialogLeft:"+showx+"px; dialogTop:"+showy+"px; status:no; directories:yes;scrollbars:no;Resizable=no; ");
	}
	if(retval != null)
	{
		ctrlobj.value = retval;
	}
	else
	{
		//alert("canceled");
	}
}
</script>
<!--20091220 end -->

<script language=javascript>
	
	

 
function docomm()
{
	//alert("document is "+trim(document.all.acceptno.value).length);
	if (document.all.phoneno1.value == "")
	{
		rdShowMessageDialog("������Ʒ��û�����!");
		return;
	}
	if(document.all.phoneno1.value.length <11)
    {
		rdShowMessageDialog("�Ʒ��û����볤��ӦΪ11λ����!");
		return;
	}
	if (document.all.acceptno.value == "")
	{
		rdShowMessageDialog("������Ͷ�ߵ�����ˮ!");
		return;
	}
	if(document.all.acceptno.value.length <15)
    {
		rdShowMessageDialog("Ͷ�ߵ�����ˮ����ӦΪ15λ����!");
		return;
	}
	if(document.all.dj.value=="")
	{
		rdShowMessageDialog("�����뵥��!");
		return;
	}
	if(document.all.sl.value=="")
	{
		rdShowMessageDialog("����������!");
		return;
	}
	//xl add for huxl �ǿ����� begin
	if (document.all.spEnterCode.value == "")
	{
		rdShowMessageDialog("SP��ҵ���벻����Ϊ��!");
		return;
	}
	if(document.all.spTranCode.value=="")
	{
		rdShowMessageDialog("Spҵ����벻����Ϊ��!");
		return;
	}
	if(document.all.spname.value=="")
	{
		rdShowMessageDialog("Sp��ҵ���Ʋ�����Ϊ��!");
		return;
	}
	//end �ǿ� 
	//var ThirdClass_new =
	
	var tflx= document.all.UnPayLevel[document.all.UnPayLevel.selectedIndex].value;
	var sum_money =  document.all.dj.value*document.all.sl.value;
	var sum_pc_money =  document.all.dj.value*document.all.sl.value*tflx;

	/*xl add for fanyan
		���⹤�� �޶�300
		80��ͷ �޶�150
		������ ����--�Ǿͻ���300
	*/
	var s_login_flag="";
	var s_money_flag="";
	if("<%=work_no%>"=="801001"||"<%=work_no%>"=="800107"||"<%=work_no%>"=="800227"||"<%=work_no%>"=="800219"||"<%=work_no%>"=="800236"||"<%=work_no%>"=="800294")//fanyanȷ������ô�ھ�
	{
		s_login_flag="1";
	}
	else if("<%=work_no.substring(0,2)%>"=="80")
	{
		s_login_flag="2";
	}
	else
	{
		s_login_flag="3";
	}
	//alert("falg is "+s_login_flag);
	
	if(s_login_flag=="1" &&sum_pc_money>300)
	{
		rdShowMessageDialog("�˷��ܽ����Դ���300Ԫ!");
		return;
	}
	else if(s_login_flag=="2" &&sum_pc_money>150)
	{
		rdShowMessageDialog("�˷��ܽ����Դ���150Ԫ!");
		return;
	}
	else if(s_login_flag=="3" &&sum_pc_money>300)
	{
		rdShowMessageDialog("�˷��ܽ����Դ���300Ԫ!");
		return;
	}
	
	document.all.backMoney.value=sum_money;
	document.all.backMoney1.value=sum_money;
	document.all.compMoney.value=sum_pc_money;
	document.all.op_note.value = document.all.phoneno1.value+"�˷�:"+sum_pc_money;
	var	prtFlag = rdShowConfirmDialog("�����˷ѽ��"+sum_pc_money+"Ԫ,�Ƿ�ȷ���˷�?");
	if (prtFlag==1)
	{
		frm.action="zg67_2.jsp";
		frm.submit();
	}
	else
	{
		return false;
	}
	
}




function clearnew()
{
	document.all.phone_no.value="";
	document.all.begin_tm.value="";
	document.all.begin_tm.value="";
	document.all.phone_no.disabled=false;	
}

function getInfo_code()
{
	if(((document.all.phoneno1.value).trim()).length<1)
	{
  	rdShowMessageDialog("�Ʒ��û����벻��Ϊ�գ�");
 	  return;
  }
  else
  {
	  	//���ù���js
	  	var regionCode = "<%=regionCode%>";
	    var pageTitle = "Sp��Ϣѡ��";
	    var fieldName = "�ֻ�����|��ҵ����|ҵ�����|�״ζ���ʱ��|������ˮ|����ʱ��|����ʱ��|��������|";//����������ʾ���С�����
	    var sqlStr = "select phone_no,spid,bizcode,substr(first_order_date,1,8),login_accept,substr(opr_time,1,8),substr(end_time,1,8),first_login_no from ddsmpordermsg where phone_no='"+document.frm.phoneno1.value+"' ";
	    var selType = "S";    //'S'��ѡ��'M'��ѡ
	    var retQuence = "8|0|1|2|3|4|5|6|7|";//�����ֶ�
	    var retToField = "phoneno1|spEnterCode|spTranCode|useing_time|sp_login_accept|op_time|end_time|sp_login_no|";//���ظ�ֵ����
	    if(MySimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,80));
	}
}

function MySimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,dialogWidth)
{
    var path = "<%=request.getContextPath()%>/npage/public/fPubSimpSel_4141.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
    retInfo = window.showModalDialog(path,"","dialogWidth:"+dialogWidth);
    if(retInfo ==undefined)
    {   return false;   }
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
	return true;
}

function accountbackfee()
{
	var varFeeMoney = document.all.backMoney.value; //�˷ѽ��
	
	var varFeeFlag = 0;  //�˷ѵ���˫��
	 
	
	if (document.all.UnPayLevel.value == 0)
	{
		rdShowMessageDialog("��ѡ���˷�����!");
		return;
	}
	else
	{
		if (document.all.UnPayLevel.value == 1)
		{
			varFeeFlag = 1;
	 
			document.all.feeflag.value=1;
		}else{
			varFeeFlag = 2;
	 
			document.all.feeflag.value=2;
		}	
	}
	/*
	if (document.all.UnPayKind.value == 0)
	{
		rdShowMessageDialog("��ѡ���˷�����!");
		return;
	}
	*/
	
	
	var dj = document.all.dj.value;
	var sl = document.all.sl.value;
	if(dj=="")
	{
		rdShowMessageDialog("�����뵥��!");
		return;
	}
	if(sl=="")
	{
		rdShowMessageDialog("����������!");
		return;
	}
	/*
	document.all.compMoney.value = varFeeFlag*dj*sl;
	document.all.backMoney.value = document.all.compMoney.value ;
	document.all.backMoney1.value=document.all.backMoney.value;
	document.all.phoneNo.value=document.all.phoneno1.value;
	*/
	var tflx= document.all.UnPayLevel[document.all.UnPayLevel.selectedIndex].value;
	var sum_money =  document.all.dj.value*document.all.sl.value;
	var sum_pc_money =  document.all.dj.value*document.all.sl.value*tflx;

	//alert(sum_money+" and tflx is "+tflx);
	/*if(sum_pc_money>300)
    {
		rdShowMessageDialog("�˷��ܽ����Դ���300Ԫ!");
		document.all.confirm.disabled=true;
		return;
	}*/
	document.all.confirm.disabled=false;
	document.all.backMoney.value=sum_money;
	document.all.backMoney1.value=sum_money;
	document.all.compMoney.value=sum_pc_money;
}


</script>

<style type="text/css">
	<!--
    body {
      margin:0;
      padding:0;
      font:  12px/1.5em Verdana;
    }
		
    #tabsJ {
      float:left;
      width:100%;
      background:#f6f6f6;
      font-size:93%;
      line-height:normal;
    }
    #tabsJ ul {
      margin:0;
      padding:10px 10px 0 5px;
      list-style:none;
    }
    #tabsJ li {
      display:inline;
      margin:0;
      padding:0;
    }
    #tabsJ a {
      float:left;
      background:url("/nresources/default/images/tableftJ.gif") no-repeat left top;
      margin:0;
      padding:0 0 0 5px;
      text-decoration:none;
      cursor:hand;
    }
    #tabsJ a span {
      float:left;
      display:block;
      background:url("/nresources/default/images/tabrightJ.gif") no-repeat right top;
      padding:5px 15px 4px 6px;
      color:#24618E;
    }
    /* Commented Backslash Hack hides rule from IE5-Mac \*/
    #tabsJ a span {
    	float:none;
    }
    /* End IE5-Mac hack */
    #tabsJ a:hover span {
      color:#FFF;
    }
    #tabsJ a:hover {
      background-position:0% -42px;
    }
    #tabsJ a:hover span {
      background-position:100% -42px;
    }

    #tabsJ .current a {
      background-position:0% -42px;
    }
    #tabsJ .current a span {
			font: bold;
      background-position:100% -42px;
      color:#FFF;
    }

	
	-->
	</style>

</head>
<body>
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
<input type="hidden" id="qryValue" value="1" >
<input type="hidden" name="ReqPageName" id="ReqPageName" value="s1210Login">
<input type="hidden" name="op_code" id="op_code" value="<%=opCode%>">
<input type="hidden" name="sysAccept" value="<%=sysAccept%>">
<input type="hidden" name="backMoney1" value="">
<input type="hidden" name="phoneNo" value="">
<input type="hidden" name="op_note" value="">
<!--xl add for ����or˫��-->
<input type="hidden" name="feeflag" value="">
	<%@ include file="/npage/include/header.jsp" %>     	
	<div class="title">
		<div id="title_zi">����/����ҵ���˷� </div>
	</div>
	
	<table>
 		
		<tr> 
	        <td class=blue nowrap>�Ʒ��û�����</td>
	        <td nowrap> 
	            <input type="text" name="phoneno1" v_must=1  v_type="mobphone" onBlur="if(this.value!=''){if(checkElement(this)==false){return false;}}" maxlength=11 >
	            <font class="orange">*</font>              
	        </td>
	        <td class=blue nowrap>Ͷ�ߵ�����ˮ</td>
	        <td nowrap> 
	            <input type="text" name="acceptno" v_must=1   onBlur="if(this.value!=''){if(checkElement(this)==false){return false;}}" maxlength=15 size="30" onKeyPress="return isKeyNumberdot(0)"  >
	            <font class="orange">*</font>
	        </td>
	    </tr>
	    <tr> 
	        <td nowrap class=blue>�˷�����</td>
	        <td nowrap colspan="3"> 
	            <select name="UnPayLevel" class="button">
	            	
	                <option value="1" checked>��������</option>
	                <option value="2">˫������</option>
	            </select>
	            <font class="orange">*</font>
	        </td>
			<!--
	        <td nowrap class=blue>�˷�����</td>
	        <td nowrap> 
	            <select name="UnPayKind" class="button">
	            	<option value="1" selected>����ҵ��</option>
	                <option value="2" >����ҵ��</option>
	            </select>
	            <font class="orange">*</font>
	        </td>
			-->
	    </tr>
		
		<tr> 
	        <td nowrap class=blue>�˷�ҵ��</td>
	        <td nowrap> 
	            <select name="tfyw" class="button">
	            	<%
						for(int i = 0 ; i < stflxStr.length ; i ++)
						{
							%>
							<option value="<%=stflxStr[i][0]%>"><%=stflxStr[i][1]%></option>
							<%
						}
					%>
	            </select>
	            <font class="orange">*</font>
	        </td>
	        <td nowrap class=blue>�Ʒ�����</td>
			<td>
				<select size=1 name=jflx  >
					  <%for(int i = 0 ; i < sBillTypeStr.length ; i ++)
						{
						if(sBillTypeStr[i][1].equals("����/�����Ʒ�")){
							%>
							<option value="<%=sBillTypeStr[i][0]%>" selected >
				
								  <%=sBillTypeStr[i][1]%></option>
							<%
						}else{
							%>
							<option value="<%=sBillTypeStr[i][0]%>">
				
									 <%=sBillTypeStr[i][1]%></option>
							<%
							}
						}
					  %>
				</select>
			</td>
	    </tr>	
		
	   
	    <tr class="blue" id="spinfo"> 
	        <td nowrap class=blue>Sp��ҵ���� </td>
	        <td nowrap>
							<input name="spEnterCode" type="text" id="spEnterCode" >
							<font class="orange">*</font>
	            <input class="b_text" type="button" name="qryId_No" value="��ѯ" onClick="getInfo_code()" >
				
	        </td>
	        <td nowrap class=blue>Spҵ�����</td>
	        <td nowrap> 
	            <input type="text" name="spTranCode"  id="spTranCode" >
				
	        </td>
	    </tr>

		<tr class="blue" id="spname_show"> 
	        <td nowrap class=blue>Sp��ҵ���� </td>
	        <td nowrap colspan=3>
					<input name="spname" type="text" id="spnameid" >
			</td>
	    </tr>

		
		
		<tr class="blue"  id="sptime5">
					<td class="blue">����</td>
	        <TD>
							<input name="dj" type="text"  id="dj" onKeyPress="return isKeyNumberdot(1)">
	        </TD>		
	        <td nowrap class=blue>����</td>
					<td>
						<input name="sl" type="text" id="sl" onKeyPress="return isKeyNumberdot(0)">
					</td>
	    </tr>
		<!--xl add end-->
		
		<tr id="add_mon"> 
	        <td nowrap class=blue>�˷��ܽ��</td>
	        <td nowrap> 
	            <input type="text" name="backMoney" maxlength="10" value=""  readonly onKeyPress="return isKeyNumberdot(1)" >
	            &nbsp;<input type=button class="b_text" name="buttonclick" style="cursor:hand" onClick="accountbackfee()" value=���� >
	        </td>
			

	        <td nowrap class=blue>�⳥���</td>
	        <td nowrap> 
	            <input class="InputGrey" type="text" name="compMoney" value="" readonly >
	        </td>
	    </tr>
		
	</table>
	
	
	
	<table  cellspacing="0" >
	<tr>
		<td id="footer">     
   			<input type=button name="confirm"class="b_foot" disabled  value="ȷ��" onClick="docomm()">    
  			<input type=button name=back value="���" class="b_foot" onmouseup="clearnew()" onClick="clearnew()">
	  		<input type=button name=qryP value="�ر�" class="b_foot" onClick="removeCurrentTab();">             
		</td>
	</tr>
	</table>
<%@ include file="/npage/include/footer.jsp" %>   
</form>
</body>
</html>
<script language="javascript">
	 
	
</script>