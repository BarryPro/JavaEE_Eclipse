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
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
	request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Ͷ���˷�ͳ�Ʋ�ѯ</title>
<%
    String opCode="e633";
	String opName="�������մ�ӡ��Ʊ";	
	String phoneNo = (String)request.getParameter("activePhone");
    String workNo=(String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String regionCode=(String)session.getAttribute("regCode");
	String dateStr=new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    Date date = new Date();
    String yearMonth = Integer.parseInt(new java.text.SimpleDateFormat("yyyyMM").format(date))-1 +"";
	//s1300viewBean viewBean = new s1300viewBean();//ʵ����viewBean
    ArrayList retArray = new ArrayList();
    String [][] result = new String[][]{};
    String sqlStr = "";
    int recordNum = 0;
	String rowNum = "16";
%>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/common/common.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/common/date/date.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/rpc/src/core_c.js"></script>
<script language="JavaScript"  src="<%=request.getContextPath()%>/page/s1400/pub.js"></script>
<script language="javascript">
function getnBankCode()
{
	//���ù���js�õ����д���
    var pageTitle = "���д����ѯ";
    var fieldName = "���д���|��������|";
    var sqlStr = "13" ;
	var s_condition="";//��ѯ����
    
    s_condition="region_code=<%=regionCode%>";
	var jsdiscode = document.form1.SDisCode.options[document.form1.SDisCode.selectedIndex].value;
	if(jsdiscode.substring(2,4) != '%%'){
        sqlStr ="14";
		s_condition="region_code=<%=regionCode%>,s_dis_code="+jsdiscode.substring(2,4);
	}

	if(document.form1.bank2.value != "")
    {
        sqlStr ="15";
		s_condition="region_code=<%=regionCode%>"+",s_bank_code="+document.form1.bank1.value;
    }
    
   // sqlStr = sqlStr + "order by bank_code" ;
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "2|0|1|";
    var retToField = "bank2|Name2|";
    nPubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,s_condition);
}

function nPubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,s_condition)
{   
	//������ѯ
    var path = "<%=request.getContextPath()%>/page/s1800/fPubSimpSel_new.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
	//xl add ����
	path = path +"&tj="+s_condition;
    retInfo = window.showModalDialog(path);
    
    if (retInfo == "notfound") {
       rdShowMessageDialog("�޴����д��룬����������!");
       document.form1.bank2.focus();
       return false;
    }
    
    //window.open(path);
    if(typeof(retInfo)=="undefined")
    {   return false;   }
    var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    //alert(retInfo);
    while(chPos_field > -1)
    {
        obj = retToField.substring(0,chPos_field);
        //alert(obj);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0,chPos_retInfo);
        document.all(obj).value = valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");
    }
}

function getBankCode()
{  	
  	//���ù���js�õ����д���
    var pageTitle = "���д����ѯ";
    var fieldName = "���д���|��������|";
	var sqlStr = "13" ;
	var s_condition="";//��ѯ����
    
    s_condition="region_code=<%=regionCode%>";
    var jsdiscode = document.form1.SDisCode.options[document.form1.SDisCode.selectedIndex].value;

	if(jsdiscode.substring(2,4) != '%%'){
       // sqlStr = sqlStr + " and DISTRICT_CODE ='" +  jsdiscode.substring(2,4) + "'";
		sqlStr ="14";
		s_condition="region_code=<%=regionCode%>,s_dis_code="+jsdiscode.substring(2,4);
	}

	if(document.form1.bank1.value != "")
    {
        //sqlStr = sqlStr + " and bank_code = '" + document.form1.bank1.value + "'";
		sqlStr ="15";
		s_condition="region_code=<%=regionCode%>"+",s_bank_code="+document.form1.bank1.value;
	}
    
    //sqlStr = sqlStr + "order by bank_code" ;
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "2|0|1|";
    var retToField = "bank1|Name1|";
    PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,s_condition);
}

function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,s_condition)
{   //������ѯ
    var path = "<%=request.getContextPath()%>/page/s1800/fPubSimpSel_new.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
	//xl add ����
	path = path +"&tj="+s_condition;
    retInfo = window.showModalDialog(path);
	//retInfo = window.open(path,"newwindow","height=450, width=700,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
    
    if (retInfo == "notfound") {
       rdShowMessageDialog("�޴����д��룬����������!");
       document.form1.bank1.focus();
       return false;
    }
    
    //window.open(path);
    if(typeof(retInfo)=="undefined")
    {   return false;   }
    var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    //alert(retInfo);
    while(chPos_field > -1)
    {
        obj = retToField.substring(0,chPos_field);
        //alert(obj);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0,chPos_retInfo);
        document.all(obj).value = valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");
    }
}
//add
function DoValid()
{
  with(document.form1)
  {
    if (bank1.value == "")
    {
      bank1.value="0";
    }
    if (bank2.value == "")
    {
      bank2.value="99999";
    }
    if (TPrintDate.value == "")
    {
      rdShowMessageDialog("��ӡ���ڲ���Ϊ��!");
      return -1;
    }
    else if (isValidTime(TPrintDate.value) != 0)
    {
      rdShowMessageDialog("��ӡ����ʱ���ʽ���ԣ�ӦΪ��\nYYYYMMDD HH:MM:SS!");
      TPrintDate.focus();
      return -1;
    }

    if (TConSignDate.value == "")
    {
      rdShowMessageDialog("ί�����ڲ���Ϊ��!");
      return -2;
    }
    else if (isValidTime(TConSignDate.value) != 0)
    {
      rdShowMessageDialog("ί������ʱ���ʽ���ԣ�ӦΪ��\nYYYYMMDD HH:MM:SS!");
      TConSignDate.focus();
      return -1;
    }
    if ((TBeginContract.value == "" ) ||( TEndContract.value == "" ) )
    {
      rdShowMessageDialog("��ˮ���벻��Ϊ��!");
      return -2;
    }
    else if ( isNaN(TBeginContract.value) )
    {
    	rdShowMessageDialog("��ˮ����ֻ��������!");
      	return -2;
    }
    if (  SBillDate.value == ""  )
    {
      rdShowMessageDialog("�������²���Ϊ��!");
      return -2;
    }
    else if (isValidYYYYMM(SBillDate.value) != 0)
    {
      rdShowMessageDialog("��������ʱ���ʽ���ԣ�ӦΪ��YYYYMM ");
      TConSignDate.focus();
      return -1;
    }
    return 0;
  }
}
function DoCfm()
{
    if (DoValid() == 0)
    {
    	with ( document.form1 )
    	{
			if ( busyType[0].value == "undefined" )
			{
			    hType.value = "2";
			}
			else
			{
			    hType.value = "1";
			}
		}
    }
}
 function sel1()
 {
		document.form1.busy_type.value = "0";
		document.form1.Submit1.disabled=true;
		document.form1.preview.disabled=false;
		document.form1.printer.disabled=false;

 }
 function sel2()
 {
		document.form1.busy_type.value = "1";
		document.form1.Submit1.disabled=true;
		document.form1.preview.disabled=false;
		document.form1.printer.disabled=false;
 }
function formload() {
	 
	document.form1.busy_type.value = "1";
	 
}

function dopreview() {
   if (DoValid() == 0) {
      document.form1.action="e633Cfm.jsp";
      form1.submit();
   }
}

function doprint(){
	if (DoValid() == 0) {
		document.form1.action="e633_print.jsp";
		form1.submit();
	}
}
</script> 
 		
 
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

</head>  
<body>
<form action="" name="form1" method="POST">
 	<input type="hidden" name="opcode" value = "e633" >
	<input type="hidden" name="opname" value = "�������մ�ӡ��Ʊ" >
	<%@ include file="/npage/include/header.jsp" %>

<div id="Operation_Table0"> 
<div class="title">
	<div id="title_zi">�������մ�ӡ��Ʊ</div>
</div>	 
	<table cellspacing="0" id="tabList">
	 <table  >
        <tbody> 
              <tr > 
                
            <td width="16%">�������ͣ�</td>
                
            <td width="32%"> 
              <input type="radio" name="busyType"  value="1" checked onclick="sel2()">���յ���ӡ
			        <input type="radio" name="busyType"  value="0"  onclick="sel1()">���յ�����
		    	 </td>
			     
                
           
                 
        </tbody> 
      </table>  
		<table width=98% height=25 border=0 align="center" cellspacing=1 bgcolor="#FFFFFF">
          <tr  > 
            <td width="16%" nowrap>��ӡ���ڣ�</td>
            <td width="30%"> 
              <input type="text" name="TPrintDate" maxlength="8" class="button" value="<%=dateStr%>">
            </td>
            <td width="17%" nowrap>ί�����ڣ�</td>
            <td width="37%"> 
              <input type="text" name="TConSignDate" maxlength="8" class="button" value="<%=dateStr%>" >
            </td>
          </tr>
		  <tr  > 
            <td width="16%" nowrap>�������£�</td>
            <td width="30%">
			  			<input type="text" name="SBillDate" maxlength="6" class="button" onKeyPress="return isKeyNumberdot(0)" value="<%=yearMonth%>">
            </td>
            <td width="17%" nowrap> ���ش��룺</td>
            <td width="37%"> 
              
			  <select size="1" name="SDisCode" >
                <%
									
									//sqlStr ="select REGION_CODE||DISTRICT_CODE,REGION_CODE||DISTRICT_CODE||'-->'||DISTRICT_NAME from  SDISCODE where region_code = '"+regionCode+"' order by district_code";
									sqlStr ="16";
									String s_tj="s_code="+regionCode;
					        try
					 				{
											%>
								<wtc:service name="sBossDefSqlSel"  outnum="2">
									<wtc:param value="<%=sqlStr%>"/>
									<wtc:param value="<%=s_tj%>"/>
								</wtc:service>
								<wtc:array id="retList" scope="end" />
                      <%
										result = retList;
										recordNum =result.length;
											out.print("<option class=button value='"+regionCode+"%%"+"'>"+regionCode+"-->������</option>");
										for(int i=0;i<recordNum;i++){
											out.print("<option class=button value='" + result[i][0] + "'>" + result[i][1] + "</option>");
										}
									}catch(Exception e){
										//System.out.println("Call queryView Failed!");
									}
								%>
              </select>
            </td>
             
          </tr>
		  <tr  > 
            <td width="16%" nowrap>��ʼ���д��룺</td>
            <td width="30%"> 
              <input name=bank1 size=12 class="button" maxlength="12">
              <input name=Name1 size=13 class="button" onkeydown="if(event.keyCode==13)getBankCode();">
              <input name=bank1CodeQuery type=button class="b_foot" id="bankCodeQuery" style="cursor:hand" onClick="getBankCode()" value=��ѯ>
            </td>
            <td width="17%" nowrap>�������д��룺</td>
            <td width="37%"> 
              <input name=bank2 size=12 class="button" maxlength="12">
              <input name=Name2 size=13 class="button" onkeydown="if(event.keyCode==13)getPostCode();">
              <input name=bank2CodeQuery type=button class="b_foot" id="postCodeQuery" style="cursor:hand" onClick="getnBankCode()" value=��ѯ>
            </td>
          </tr>
          <tr id="bat_id" > 
            <td width="16%" nowrap>��ʼ��ˮ���룺</td>
            <td width="30%"> 
              <input type="text" name="TBeginContract" maxlength="11" class="button" onKeyPress="return isKeyNumberdot(0)">
            </td>
            <td   width="17%" nowrap>������ˮ���룺</td>
            <td   width="37%"> 
              <input type="text" name="TEndContract" maxlength="11" class="button" onKeyPress="return isKeyNumberdot(0)">
            </td>
          </tr>
		  <TR> 
            <TD  >��ע��</TD>
            <TD colspan=3> 
              <input type="text"  class="button" name="operNote" size="50" maxlength="60">
            </TD>
          </TR>
          <TR height=25 > 
            <TD  >˵����</TD>
            <TD colspan=3 > 
              ��ӡʱ����������ֽ�Ŵ�СΪ10Ӣ���4Ӣ�磬�����ӡλ�ò��롣
            </TD>
          </TR>
		  </table>
	 
		 <input type="hidden" value="" name="busy_type">
		<tr >
			 
			<TD noWrap  colspan="2"> 
              <div align="center"> 
              
                &nbsp;
                
				<input type="button" name="preview" class="b_foot" value="Ԥ��"  onClick="dopreview()"> 
			 
                &nbsp;
                <input type="button" name="printer" class="b_foot" value="��ӡ" onClick="doprint()">
                &nbsp;
                <input type="reset" name="return1" class="b_foot" value="���">
                &nbsp;
                <input type="button" name="return" class="b_foot" value="�ر�" onClick="window.close()">
              </div>
            </TD>
		<tr>
		 
		</tr>
		
	</table>
</div>
 
 
 
</table>
 
 
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
<script language="javascript">
 
</script>
 
 