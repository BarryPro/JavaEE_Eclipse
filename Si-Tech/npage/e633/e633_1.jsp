<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 赠送预存款 8379
   * 版本: 1.0
   * 日期: 2010/3/12
   * 作者: sunaj
   * 版权: si-tech
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
<title>投诉退费统计查询</title>
<%
    String opCode="e633";
	String opName="集团托收打印发票";	
	String phoneNo = (String)request.getParameter("activePhone");
    String workNo=(String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String regionCode=(String)session.getAttribute("regCode");
	String dateStr=new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    Date date = new Date();
    String yearMonth = Integer.parseInt(new java.text.SimpleDateFormat("yyyyMM").format(date))-1 +"";
	//s1300viewBean viewBean = new s1300viewBean();//实例化viewBean
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
	//调用公共js得到银行代码
    var pageTitle = "银行代码查询";
    var fieldName = "银行代码|银行名称|";
    var sqlStr = "13" ;
	var s_condition="";//查询条件
    
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
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "2|0|1|";
    var retToField = "bank2|Name2|";
    nPubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,s_condition);
}

function nPubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,s_condition)
{   
	//公共查询
    var path = "<%=request.getContextPath()%>/page/s1800/fPubSimpSel_new.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
	//xl add 条件
	path = path +"&tj="+s_condition;
    retInfo = window.showModalDialog(path);
    
    if (retInfo == "notfound") {
       rdShowMessageDialog("无此银行代码，请重新输入!");
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
  	//调用公共js得到银行代码
    var pageTitle = "银行代码查询";
    var fieldName = "银行代码|银行名称|";
	var sqlStr = "13" ;
	var s_condition="";//查询条件
    
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
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "2|0|1|";
    var retToField = "bank1|Name1|";
    PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,s_condition);
}

function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,s_condition)
{   //公共查询
    var path = "<%=request.getContextPath()%>/page/s1800/fPubSimpSel_new.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
	//xl add 条件
	path = path +"&tj="+s_condition;
    retInfo = window.showModalDialog(path);
	//retInfo = window.open(path,"newwindow","height=450, width=700,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
    
    if (retInfo == "notfound") {
       rdShowMessageDialog("无此银行代码，请重新输入!");
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
      rdShowMessageDialog("打印日期不能为空!");
      return -1;
    }
    else if (isValidTime(TPrintDate.value) != 0)
    {
      rdShowMessageDialog("打印日期时间格式不对，应为：\nYYYYMMDD HH:MM:SS!");
      TPrintDate.focus();
      return -1;
    }

    if (TConSignDate.value == "")
    {
      rdShowMessageDialog("委托日期不能为空!");
      return -2;
    }
    else if (isValidTime(TConSignDate.value) != 0)
    {
      rdShowMessageDialog("委托日期时间格式不对，应为：\nYYYYMMDD HH:MM:SS!");
      TConSignDate.focus();
      return -1;
    }
    if ((TBeginContract.value == "" ) ||( TEndContract.value == "" ) )
    {
      rdShowMessageDialog("流水号码不能为空!");
      return -2;
    }
    else if ( isNaN(TBeginContract.value) )
    {
    	rdShowMessageDialog("流水号码只能是数字!");
      	return -2;
    }
    if (  SBillDate.value == ""  )
    {
      rdShowMessageDialog("出账年月不能为空!");
      return -2;
    }
    else if (isValidYYYYMM(SBillDate.value) != 0)
    {
      rdShowMessageDialog("出账年月时间格式不对，应为：YYYYMM ");
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
	<input type="hidden" name="opname" value = "集团托收打印发票" >
	<%@ include file="/npage/include/header.jsp" %>

<div id="Operation_Table0"> 
<div class="title">
	<div id="title_zi">集团托收打印发票</div>
</div>	 
	<table cellspacing="0" id="tabList">
	 <table  >
        <tbody> 
              <tr > 
                
            <td width="16%">操作类型：</td>
                
            <td width="32%"> 
              <input type="radio" name="busyType"  value="1" checked onclick="sel2()">托收单打印
			        <input type="radio" name="busyType"  value="0"  onclick="sel1()">托收单补打
		    	 </td>
			     
                
           
                 
        </tbody> 
      </table>  
		<table width=98% height=25 border=0 align="center" cellspacing=1 bgcolor="#FFFFFF">
          <tr  > 
            <td width="16%" nowrap>打印日期：</td>
            <td width="30%"> 
              <input type="text" name="TPrintDate" maxlength="8" class="button" value="<%=dateStr%>">
            </td>
            <td width="17%" nowrap>委托日期：</td>
            <td width="37%"> 
              <input type="text" name="TConSignDate" maxlength="8" class="button" value="<%=dateStr%>" >
            </td>
          </tr>
		  <tr  > 
            <td width="16%" nowrap>出帐年月：</td>
            <td width="30%">
			  			<input type="text" name="SBillDate" maxlength="6" class="button" onKeyPress="return isKeyNumberdot(0)" value="<%=yearMonth%>">
            </td>
            <td width="17%" nowrap> 区县代码：</td>
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
											out.print("<option class=button value='"+regionCode+"%%"+"'>"+regionCode+"-->不区分</option>");
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
            <td width="16%" nowrap>开始银行代码：</td>
            <td width="30%"> 
              <input name=bank1 size=12 class="button" maxlength="12">
              <input name=Name1 size=13 class="button" onkeydown="if(event.keyCode==13)getBankCode();">
              <input name=bank1CodeQuery type=button class="b_foot" id="bankCodeQuery" style="cursor:hand" onClick="getBankCode()" value=查询>
            </td>
            <td width="17%" nowrap>结束银行代码：</td>
            <td width="37%"> 
              <input name=bank2 size=12 class="button" maxlength="12">
              <input name=Name2 size=13 class="button" onkeydown="if(event.keyCode==13)getPostCode();">
              <input name=bank2CodeQuery type=button class="b_foot" id="postCodeQuery" style="cursor:hand" onClick="getnBankCode()" value=查询>
            </td>
          </tr>
          <tr id="bat_id" > 
            <td width="16%" nowrap>开始流水号码：</td>
            <td width="30%"> 
              <input type="text" name="TBeginContract" maxlength="11" class="button" onKeyPress="return isKeyNumberdot(0)">
            </td>
            <td   width="17%" nowrap>结束流水号码：</td>
            <td   width="37%"> 
              <input type="text" name="TEndContract" maxlength="11" class="button" onKeyPress="return isKeyNumberdot(0)">
            </td>
          </tr>
		  <TR> 
            <TD  >备注：</TD>
            <TD colspan=3> 
              <input type="text"  class="button" name="operNote" size="50" maxlength="60">
            </TD>
          </TR>
          <TR height=25 > 
            <TD  >说明：</TD>
            <TD colspan=3 > 
              打印时，请先设置纸张大小为10英寸×4英寸，否则打印位置不齐。
            </TD>
          </TR>
		  </table>
	 
		 <input type="hidden" value="" name="busy_type">
		<tr >
			 
			<TD noWrap  colspan="2"> 
              <div align="center"> 
              
                &nbsp;
                
				<input type="button" name="preview" class="b_foot" value="预览"  onClick="dopreview()"> 
			 
                &nbsp;
                <input type="button" name="printer" class="b_foot" value="打印" onClick="doprint()">
                &nbsp;
                <input type="reset" name="return1" class="b_foot" value="清除">
                &nbsp;
                <input type="button" name="return" class="b_foot" value="关闭" onClick="window.close()">
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
 
 