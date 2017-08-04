<%
/********************
 version v2.0
 开发商: si-tech
 update hejw@2009-2-12
********************/
%>
<%
  String opCode = "3187";
  String opName = "帐户关系维护";
%>              


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
	
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>  
<%@ page import="org.apache.log4j.Logger"%>
<%
	Logger logger = Logger.getLogger("f3172_1.jsp");
	
	//yyyyMM形式的上月日期
	
	GregorianCalendar cal=new GregorianCalendar();
  cal.setTime(new java.util.Date());     
  cal.add(GregorianCalendar.MONTH,-1);
  String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	
	//读取用户session信息
	String workNo   = (String)session.getAttribute("workNo");               //工号
	String workName = (String)session.getAttribute("workName");              	//工号姓名
	String org_code = (String)session.getAttribute("orgCode");							//机构代码	
	String nopass  = (String)session.getAttribute("password"); 									//密码
	String op_name = "一点支付帐户关系维护";
	String regionCode= (String)session.getAttribute("regCode");
	//得到页面参数
	
	
	
	String action=request.getParameter("action");			//提交到本页面
	int nextFlag=1;
	String contract_no = "";
	String retListString1 [][] = new String[][]{}; 
	
	if (action!=null&&action.equals("select")){
	
			contract_no = request.getParameter("contract_no");//支付帐户号
			
			String sqlStr1="";
			//wuxy alter 20090209 添加end_date
			sqlStr1 ="select c.user_name,a.CONTRACT_NO,b.BANK_CUST,a.all_flag,a.cycle_money,a.begin_date,a.end_date,a.pay_order from dconconmsg a,dconmsg b,dgrpusermsg c where a.CONTRACT_PAY='"+contract_no+
			            "' and a.CONTRACT_NO=b.CONTRACT_NO and a.valid_flag='0' and b.CONTRACT_NO=c.account_id  and a.end_date>=to_char(sysdate,'yyyymmdd') "
			          +" order by a.pay_order ";

			ArrayList acceptList = new ArrayList();
			//acceptList = impl.sPubSelect("6",sqlStr1,"region",regionCode);
%>

		<wtc:pubselect name="sPubSelect" outnum="8" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr1%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>

<%			
			String errCode=code;
			String errMsg= msg;
			
			if(!errCode.equals("000000"))
			{
				%>        
			    <script language='jscript'>
			       rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
			       history.go(-1);
		      </script> 
				<%  
			}			
			if(errCode.equals("000000"))
			{
							
				nextFlag = 2;
				retListString1 = result_t;
				if(retListString1.length==0){
				%>        
			    <script language='jscript'>
			       rdShowMessageDialog("该支付帐户没有绑定被支付帐户！",0);
			       history.go(-1);
		      </script> 
				<% 
				}
			} // end if(errCode == 0)
		}//end if (action!=null&&action.equals("select"))
%>
<html>
<head>
<base target="_self">
<title>一点支付帐户关系维护</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">

<script language="JavaScript"> 

	function doQuery()
	{
		
		if(!forNonNegInt(document.form1.contract_no))
		return false;
		
		document.form1.action = "f3187_1.jsp?action=select";
		document.form1.submit(); 
	}
	
		function queryAccount()
	{		
		/**
		if (!forIdCard(document.all.idCard))
    {
    	return false;
    }
	  else{   */		
			var pageTitle = "支付帐户信息";
		  var fieldName = "帐号|帐户名称|";
			var sqlStr = "";
	    var selType = "S";    //'S'单选；'M'多选
	    var retQuence = "2|0|1|";
	    var retToField = "contract_no|accountName|";		    	
	    if(pubSimpSelAccount(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));			
	  //}	
	}
	
	function pubSimpSelAccount(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
	{	    
    var path = "f3187_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType+"&idCard="+document.all.idCard.value;
    retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
		return true;
	}
	
		function getvaluecust(retInfo)
	{
	    var retToField = "contract_no|accountName|";
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
	}

function modify(){
	getAfterPrompt();
	var contractNo="";
	var contractPay=document.all.contract_no.value;
	if(document.all.selRad.length==undefined){
		if(document.all.selRad.checked){
			contractNo=document.all.selRad.value;
		}
	}
	else{
		for(i=0;i<document.all.selRad.length;i++){
			if(document.all.selRad[i].checked){
				contractNo=document.all.selRad[i].value;
			}
		}
	}
	if(contractNo!=""){
		 
		 window.open("f3187_modify.jsp?contractNo="+contractNo+"&contractPay="+contractPay,"newwindow","height=450, width=1000,top=50,left=100,scrollbars=yes, resizable=no,location=no, status=yes");
	}
	else{
		rdShowMessageDialog("请先选择一个被支付帐户！",0);
	}
}


function del(){
	getAfterPrompt();
      var contractNo="";
			var contractPay=document.all.contract_no.value;
			if(document.all.selRad.length==undefined){
				if(document.all.selRad.checked){
					contractNo=document.all.selRad.value;
				}
			}
			else{
				for(i=0;i<document.all.selRad.length;i++){
					if(document.all.selRad[i].checked){
						contractNo=document.all.selRad[i].value;
					}
				}
			}
			if(contractNo!=""){
				if(rdShowConfirmDialog('确定删除该条帐户关系吗')==1)
   			{
					 form1.action=("f3187_delSub.jsp?contractNo="+contractNo+"&contractPay="+contractPay);
					 form1.submit();
				}
			}
			else{
				rdShowMessageDialog("请先选择一个被支付帐户！",0);
			}
}


</script>
</head>

<body>
		
<form name="form1"  method="post">
	<%@ include file="/npage/include/header.jsp" %>                         


	<div class="title">
		<div id="title_zi">帐户关系维护</div>
	</div>


			<TABLE cellspacing="0" >
				<input type="hidden" name="workNo"   value="<%=workNo%>">
				<input type="hidden" name="noPass"   value="<%=nopass%>">
				<input type="hidden" name="org_code"   value="<%=org_code%>">
				<input type="hidden" name="opcode"   value="3172">				
				<%
      	if(nextFlag==1)
      	{%>
				<TR  id="line_1" align="center">
          <TD align="left" width="18%" colspan="1" class="blue">证件号码 </TD>
          <TD align="left" colspan=3>
            	<input type="text"  v_type="idcard"  v_must="1"  v_name="证件号码" name="idCard" maxlength="18">&nbsp;&nbsp;
            	<input  class="b_text"  id="querybutton" name=querybutton type=button value=查询支付帐户 onClick="queryAccount();" style="cursor:hand" <% if(nextFlag==2){out.println("disabled");} %>>
          </TD>
        </TR>
  
        <TR  id="line_1" align="center">
			  	 <td align="left" width="18%" colspan="1" class="blue">支付帐号</td>
	         <td align="left" colspan=3> 
	             <input   type="text"  v_type="0_9"  v_must=1 v_minlength=11 v_maxlength=14 v_name="支付帐户号"  name="contract_no"  value="<%=contract_no%>" <% if(nextFlag==2){out.println("readonly");} %> maxlength="14"  onkeydown="if(event.keyCode==13)queryAccount()" >
	             <font class="orange">*</font>
	             <input type="button" class="b_text"  style="cursor:hand"  name="checkButt"  value="查询支付关系" onClick="doQuery()" <% if(nextFlag==2){out.println("disabled");} %>>
	             <input type="hidden" name="accountName">
	             
	         </td>
      	</TR>

      	<TR  align="center"> 
		         	<TD height="30" align="center" colspan=4> 
		         	    <input name="cfmButton" id="cfmButton" style="cursor:hand" type="button"  value="清除" onClick="form1.reset()" class="b_foot">
		         	    <input name="backButton" onClick="removeCurrentTab();" style="cursor:hand" type="button"  value="关闭" class="b_foot">
				 			</TD>
		    </TR>
		  </table>
	      <%
	      }
	      %>
	      	<%
	      if(nextFlag==2)//查询后结果
	      {
	      %>

	    <TABLE cellspacing="0" >
        <TR  id="line_1" align="center">
			  	 <td align="left" width="18%" colspan="1" class="blue">支付帐号</td>
	         <td align="left" colspan=6> 
	             <input   type="text"  v_type="0_9"  v_must=1 v_minlength=11 v_maxlength=14 v_name="支付帐户号"  name="contract_no"  value="<%=contract_no%>" <% if(nextFlag==2){out.println("readonly");} %> maxlength="14"  onkeydown="if(event.keyCode==13)queryAccount()" >
	             <font class="orange">*</font>
	             <input type="button" class="b_text"  style="cursor:hand"  name="checkButt"  value="查询支付关系" onClick="doQuery()" <% if(nextFlag==2){out.println("disabled");} %>>
	             <input type="hidden" name="accountName">
	             
	         </td>
	         
      	</TR>
      	
	     <TR  >
	      	<TD colspan=9 class="blue">被支付帐户信息</TD>
	      </TR>
	      <TR  >
	      	<Th  >选择</Th>
	        <Th  >集团产品名称</Th>
	      	<Th  >支付帐号</Th>
	      	<Th   >帐户名称</Th>
	      	<Th   >全额标志</Th>
	      	<Th   >定额金额</Th>
	      	<Th   >开始日期</Th>
	      	<Th   >结束日期</Th>
	        <TD   >付费顺序</TD>
	      </TR>
	      <%
     		for(int i=0;i<retListString1.length;i++)
     		{
     		%>
		      <TR  >
		      	<TD><input type="radio" name="selRad" value="<%=retListString1[i][1]%>"></TD>
		      	<TD ><%=retListString1[i][0]%></TD>
		      	<TD ><%=retListString1[i][1]%></TD>
		      	<TD ><%=retListString1[i][2]%></TD>

		      	<TD >
		      		<% 
		      		if("1".equals(retListString1[i][3])){
		      			out.println("全额交费");
		      		}
		      		else{
		      			out.println("定额交费");
		      		}
		      	%>
		      	</TD>
		      	<TD >
		      		<% 
		      		if("1".equals(retListString1[i][3])){
		      			out.println("--");
		      		}
		      		else{
		      			out.println(retListString1[i][4]);
		      		}
		      	%>		      		
		      	</TD>
		      	<TD ><%=retListString1[i][5]%></TD>
		      	<TD ><%=retListString1[i][6]%></TD>
		      	<TD ><%=retListString1[i][7]%></TD>

		      </TR>
	      <%
	     	 }
	      %>


				<TR > 
		         	<TD height="30" align="center" id="footer" colspan=9 > 
		         			<input  name="previous" style="cursor:hand" type=button value="修改" onclick="modify()" class="b_foot">
			 						 &nbsp;
		         	    <input name="cfmButton" id="cfmButton" style="cursor:hand" type="button"  value="删除" class="b_foot" onClick="del()">
		         	    &nbsp; 
		         	    <input name="backButton" onClick="history.go(-1);" style="cursor:hand" type="button"  value="返回" class="b_foot" >
		         	    &nbsp; 
				 			</TD>
		    </TR>

		<%
		 }
		%>
		</TD>
	</TR>
</TABLE>
 <%@ include file="/npage/include/footer.jsp" %>
 </form>
</body>

</html>