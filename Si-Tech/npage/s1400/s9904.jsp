<%
/********************
version v2.0
开发商: si-tech
update:anln@2009-02-24 页面改造,修改样式
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
    	
    	//s1300viewBean viewBean = new s1300viewBean();//实例化viewBean
    	ArrayList retArray = new ArrayList();
    	String [][] result = new String[][]{};
    	String sqlStr = "";
    	int recordNum = 0;
	String rowNum = "16";
   	String dateStr=new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    
	//取上个月
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
	rdShowMessageDialog("查询失败",0);
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
      rdShowMessageDialog("打印日期不能为空!");
      return false;
    }
    else if (!forDate(TPrintDate)){
      return false;
    }   
     
    if (TConSignDate.value == ""){
      rdShowMessageDialog("委托日期不能为空!");
      return false;
    }
    else if (!forDate(TConSignDate)){
      		return false;
    }    
    if ((TBeginContract.value == "" ) ||( TEndContract.value == "" ) )
    {
      rdShowMessageDialog("合同号码不能为空!");
      return false;
    }
    else if (isNaN(TBeginContract.value) )
    {
    	rdShowMessageDialog("流水号码只能是数字!");
      	return false;
    }
    
    if (SBillDate.value == "" ){
      rdShowMessageDialog("出账年月不能为空!");
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
  	//调用公共js得到银行代码
    var pageTitle = "银行代码查询";
    var fieldName = "银行代码|银行名称";
	var sqlStr = "select POST_BANK_CODE,BANK_NAME from sPostCode " +
                "where REGION_CODE = '" +  "<%=sOrgCode.substring(0,2)%>" + "' " ;

	if(document.form1.bank1.value != "")
    {
        sqlStr = sqlStr + " and post_bank_code = '" + document.form1.bank1.value + "'";
    }
    
    sqlStr = sqlStr + "order by post_bank_code" ;
    var selType = "S";    //'S'单选；'M'多选
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

<title>黑龙江BOSS-生成电子托收单</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="<%=request.getContextPath()%>/css/jl.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<FORM action="" method="post" name="form1" >
	<%@ include file="/npage/include/header.jsp" %>  
	<div class="title">
		<div id="title_zi">操作信息</div>
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
				<td width="13%" class="blue">操作类型</td>
				<td width="30%"> 
					<input type="radio" name="busyType"  value="2" checked onclick="sel2()">生成电子托收单
				</td>
				<td>部门<%=belongName%></td>
			</tr>
		</tbody> 
	</table>
	<br>
      	<div class="title">
		<div id="title_zi">业务信息</div>
	</div> 
        <table  cellspacing=0 >
		<tr> 
			<td width="16%" nowrap class="blue">打印日期</td>
			<td width="30%"> 
				<input type="text" name="TPrintDate" v_format="yyyyMMdd" v_type="date" maxlength="8" value="<%=dateStr%>" onblur="checkElement(this)">
			</td>
			<td width="17%" nowrap class="blue">委托日期</td>
			<td width="37%"> 
				<input type="text" name="TConSignDate" v_format="yyyyMMdd"  maxlength="8" value="<%=dateStr%>" onblur="checkElement(this)" >
			</td>
		</tr>
		  <tr> 
			<td width="16%" nowrap class="blue">出帐年月</td>
			<td width="30%">
				  <input type="text" name="SBillDate" maxlength="6" v_format="yyyyMM" onKeyPress="return isKeyNumberdot(0)" value="<%=yearMonth%>" onblur="checkElement(this)">
			</td>
			<td width="17%" nowrap class="blue"> 区县代码</td>
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
			<td width="16%" nowrap class="blue">企业代码</td>
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
			<td width="17%" nowrap class="blue">费用代码</td>
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
			<td width="16%" nowrap class="blue">局方银行代码</td>
			<td colspan="3"> 
				<input name=bank1 size=12 maxlength="12">
				<input name=Name1 size=13 onkeydown="if(event.keyCode==13)getPostBankCode();">
				<input name=bank1CodeQuery class="b_text" type=button id="bankCodeQuery" style="cursor:hand" onClick="getPostBankCode()" value=查询>
			</td>		
		</tr>
		<tr id="bat_id" > 
			<td width="16%" nowrap class="blue">开始合同号码</td>
			<td width="30%"> 
				<input type="text" name="TBeginContract" maxlength="14" onKeyPress="return isKeyNumberdot(0)">
			</td>
			<td  width="17%" nowrap class="blue">结束合同号码</td>
			<td  width="37%"> 
				<input type="text" name="TEndContract" maxlength="14" onKeyPress="return isKeyNumberdot(0)">
			</td>
		</tr>    
		<TR> 
			<TD noWrap  width="16%" class="blue">备注</TD>
			<TD noWrap colspan="3"> 
				<input type="text"  readonly class="InputGrey" name="operNote" size="50" maxlength="60">
			</TD>
		</TR>      
        </table>
		  
	<TABLE cellSpacing="0" >          
		<TBODY> 
			<TR> 
				<TD id="footer">              
					<input type="button" class="b_foot" name="Submit1" value="确认"  onClick="DoCfm()">
					&nbsp;
					<input type="reset" class="b_foot" name="return1" value="清除">
					&nbsp;
					<input type="button" class="b_foot" name="return" value="关闭" onClick="removeCurrentTab()">           
				</TD>
			</TR>
		</TBODY> 
	</table>
	<%@ include file="/npage/include/footer.jsp" %>   
</FORM>
</body>
</html>
