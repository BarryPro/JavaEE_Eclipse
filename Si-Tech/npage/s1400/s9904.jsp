<%
/********************
version v2.0
������: si-tech
update:anln@2009-02-24 ҳ�����,�޸���ʽ
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = request.getParameter("opCode");
	String opName = (String)request.getParameter("opName");	
	String belongName =  (String)session.getAttribute("orgCode");
	String sOrgCode =  (String)session.getAttribute("orgCode");
    	String regionCode= (String)session.getAttribute("regCode");
    	
    	//s1300viewBean viewBean = new s1300viewBean();//ʵ����viewBean
    	ArrayList retArray = new ArrayList();
    	String [][] result = new String[][]{};
    	String sqlStr = "";
    	int recordNum = 0;
	String rowNum = "16";
   	String dateStr=new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    
	//ȡ�ϸ���
	Calendar calendar = new GregorianCalendar();
    	int year = calendar.get(Calendar.YEAR);
    	int month = calendar.get(Calendar.MONTH);
        
	Date date = new Date();
    	date.setYear(year-1900);
    	date.setMonth(month - 1);
    	String yearMonth = new java.text.SimpleDateFormat("yyyyMM").format(date);
%>

<HTML>
<HEAD>
<SCRIPT type="text/javascript">
onload=function(){	
}
function doProcess(packet)
{
    var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode");
    var BoldNum = packet.data.findValueByName("BoldNum");

    if(retCode == "000000"){
	document.form1.TTotalRecord.value = BoldNum;
    }
    else{
	rdShowMessageDialog("��ѯʧ��",0);
    }	
}


function DoValid()
{
  with(document.form1)
  {
  	
    if (bank1.value == ""){
      bank1.value="0";
    }
    if (TPrintDate.value == ""){
      rdShowMessageDialog("��ӡ���ڲ���Ϊ��!");
      return false;
    }
    else if (!forDate(TPrintDate)){
      return false;
    }   
     
    if (TConSignDate.value == ""){
      rdShowMessageDialog("ί�����ڲ���Ϊ��!");
      return false;
    }
    else if (!forDate(TConSignDate)){
      		return false;
    }    
    if ((TBeginContract.value == "" ) ||( TEndContract.value == "" ) )
    {
      rdShowMessageDialog("��ͬ���벻��Ϊ��!");
      return false;
    }
    else if (isNaN(TBeginContract.value) )
    {
    	rdShowMessageDialog("��ˮ����ֻ��������!");
      	return false;
    }
    
    if (SBillDate.value == "" ){
      rdShowMessageDialog("�������²���Ϊ��!");
      return false;
    }else if (!forDate(SBillDate)){    	
      	return false;
    }
    return true;
  }
}
//-----------------------------------------------------

function getPostBankCode()
{  	
  	//���ù���js�õ����д���
    var pageTitle = "���д����ѯ";
    var fieldName = "���д���|��������";
	var sqlStr = "select POST_BANK_CODE,BANK_NAME from sPostCode " +
                "where REGION_CODE = '" +  "<%=sOrgCode.substring(0,2)%>" + "' " ;

	if(document.form1.bank1.value != "")
    {
        sqlStr = sqlStr + " and post_bank_code = '" + document.form1.bank1.value + "'";
    }
    
    sqlStr = sqlStr + "order by post_bank_code" ;
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "0|1";
    var retToField = "bank1|Name1";
    PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
}

function sel2()
{
	document.all.busy_type.value = "2";
	document.all.Submit1.disabled=true;
	document.all.preview.disabled=false;
	document.all.printer.disabled=false;
}


function DoCfm() {
	getAfterPrompt();
	if (DoValid()) {
		document.form1.action="s9904Cfm.jsp";
		form1.submit();
	}
} 

</script>

<title>������BOSS-���ɵ������յ�</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="<%=request.getContextPath()%>/css/jl.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<FORM action="" method="post" name="form1" >
	<%@ include file="/npage/include/header.jsp" %>  
	<div class="title">
		<div id="title_zi">������Ϣ</div>
	</div> 
	<input type="hidden" value="" name="hString">
	<input type="hidden" value="" name="hType">
	<input type="hidden" value="<%=sOrgCode%>" name="unitCode">
	<input type="hidden" value="1" name="busy_type">
	<input type="hidden" value="<%=opCode%>" name="opCode">
	<input type="hidden" value="<%=opName%>" name="opName">

	<table  cellspacing="0" >
		<tbody> 
			<tr> 		
				<td width="13%" class="blue">��������</td>
				<td width="30%"> 
					<input type="radio" name="busyType"  value="2" checked onclick="sel2()">���ɵ������յ�
				</td>
				<td>����<%=belongName%></td>
			</tr>
		</tbody> 
	</table>
	<br>
      	<div class="title">
		<div id="title_zi">ҵ����Ϣ</div>
	</div> 
        <table  cellspacing=0 >
		<tr> 
			<td width="16%" nowrap class="blue">��ӡ����</td>
			<td width="30%"> 
				<input type="text" name="TPrintDate" v_format="yyyyMMdd" v_type="date" maxlength="8" value="<%=dateStr%>" onblur="checkElement(this)">
			</td>
			<td width="17%" nowrap class="blue">ί������</td>
			<td width="37%"> 
				<input type="text" name="TConSignDate" v_format="yyyyMMdd"  maxlength="8" value="<%=dateStr%>" onblur="checkElement(this)" >
			</td>
		</tr>
		  <tr> 
			<td width="16%" nowrap class="blue">��������</td>
			<td width="30%">
				  <input type="text" name="SBillDate" maxlength="6" v_format="yyyyMM" onKeyPress="return isKeyNumberdot(0)" value="<%=yearMonth%>" onblur="checkElement(this)">
			</td>
			<td width="17%" nowrap class="blue"> ���ش���</td>
			<td width="37%"> 
				<select size="1" name="SDisCode" >
				<%
						sqlStr ="select REGION_CODE||DISTRICT_CODE,REGION_CODE||DISTRICT_CODE||'-->'||DISTRICT_NAME from  SDISCODE where region_code = '?' order by district_code";
						try
						{
							//retArray = viewBean.QueryCode("2",sqlStr);
						%>
							<wtc:pubselect name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
								<wtc:sql><%=sqlStr%></wtc:sql>
	              <wtc:param value="<%=sOrgCode.substring(0,2)%>"/>						
								</wtc:pubselect>
							<wtc:array id="result1" scope="end" />
						<%
							System.out.println(result1[0][0]);							
							recordNum = result1.length;
							result = result1;								
							for(int i=0;i<recordNum;i++){
								out.print("<option class=button value='" + result[i][0] + "'>" + result[i][1] + "</option>");
							}
						}catch(Exception e){
							
						}
						%>
				</select>
			</td>
		</tr>
		<tr > 
			<td width="16%" nowrap class="blue">��ҵ����</td>
			<td width="30%">
				  <select size="1" name="enter_code" >
				<%
					sqlStr ="select to_char(enter_code) from scontotalcfg where region_code = '?' and district_code='?'";
					System.out.println("sqlStr="+sqlStr);
					try
					{
						//retArray = viewBean.QueryCode("1",sqlStr);
					%>
						<wtc:pubselect name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
							<wtc:sql><%=sqlStr%></wtc:sql>
						<wtc:param value="<%=sOrgCode.substring(0,2)%>"/>
							<wtc:param value="<%=sOrgCode.substring(2,4)%>"/>
						</wtc:pubselect>
						<wtc:array id="result2" scope="end" />
					<%	
					
						recordNum = result2.length;
						result = result2;
						for(int i=0;i<recordNum;i++){
							out.print("<option class=button value='" + result[i][0] + "'>" + result[i][0] + "</option>");
						}
					}catch(Exception e){
						
					}
					%>
				</select>
			</td>
			<td width="17%" nowrap class="blue">���ô���</td>
			<td width="37%"> 
				<select size="1" name="oper_type" >
				<%
					sqlStr ="select to_char(oper_type) from scontotalcfg where region_code = '?' and district_code='?'";
					try
					{
						//retArray = viewBean.QueryCode("1",sqlStr);
					%>
						<wtc:pubselect name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode3" retmsg="retMsg3" outnum="1">
							<wtc:sql><%=sqlStr%></wtc:sql>
						<wtc:param value="<%=sOrgCode.substring(0,2)%>"/>
							<wtc:param value="<%=sOrgCode.substring(2,4)%>"/>
						</wtc:pubselect>
						<wtc:array id="result3" scope="end" />
					<%
						recordNum = result3.length;
						result = result3;
						for(int i=0;i<recordNum;i++){
							out.print("<option class=button value='" + result[i][0] + "'>" + result[i][0] + "</option>");
						}
					}catch(Exception e){
						
					}
					%>
				</select>			
			</td>
		</tr>
		<tr> 
			<td width="16%" nowrap class="blue">�ַ����д���</td>
			<td colspan="3"> 
				<input name=bank1 size=12 maxlength="12">
				<input name=Name1 size=13 onkeydown="if(event.keyCode==13)getPostBankCode();">
				<input name=bank1CodeQuery class="b_text" type=button id="bankCodeQuery" style="cursor:hand" onClick="getPostBankCode()" value=��ѯ>
			</td>		
		</tr>
		<tr id="bat_id" > 
			<td width="16%" nowrap class="blue">��ʼ��ͬ����</td>
			<td width="30%"> 
				<input type="text" name="TBeginContract" maxlength="14" onKeyPress="return isKeyNumberdot(0)">
			</td>
			<td  width="17%" nowrap class="blue">������ͬ����</td>
			<td  width="37%"> 
				<input type="text" name="TEndContract" maxlength="14" onKeyPress="return isKeyNumberdot(0)">
			</td>
		</tr>    
		<TR> 
			<TD noWrap  width="16%" class="blue">��ע</TD>
			<TD noWrap colspan="3"> 
				<input type="text"  readonly class="InputGrey" name="operNote" size="50" maxlength="60">
			</TD>
		</TR>      
        </table>
		  
	<TABLE cellSpacing="0" >          
		<TBODY> 
			<TR> 
				<TD id="footer">              
					<input type="button" class="b_foot" name="Submit1" value="ȷ��"  onClick="DoCfm()">
					&nbsp;
					<input type="reset" class="b_foot" name="return1" value="���">
					&nbsp;
					<input type="button" class="b_foot" name="return" value="�ر�" onClick="removeCurrentTab()">           
				</TD>
			</TR>
		</TBODY> 
	</table>
	<%@ include file="/npage/include/footer.jsp" %>   
</FORM>
</body>
</html>
