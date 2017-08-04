<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: sp增值业务套餐
   * 版本: 1.0
   * 日期: 2009/09/22
   * 作者: dujl
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%
	request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>sp增值业务套餐</title>
<%
	
    String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");	
	String phoneNo = (String)request.getParameter("activePhone");
    String workNo=(String)session.getAttribute("workNo");
    String regionCode=(String)session.getAttribute("regCode");
    String[][] favInfo=(String[][])session.getAttribute("favInfo");
    
    String sqlStr="";
	int recordNum=0;
	int i=0;
%>

  </script>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language="javascript">
onload=function()
{
	var opCode = "<%=opCode%>";
	if(opCode=="9896")
	{
		document.all.opFlag[0].checked=true;
		opchange();		
	}
	if(opCode=="9897")
	{
		document.all.opFlag[1].checked=true;  
		opchange();			
	}
}

function chkType()
{
	document.all.sale_code.value ="";
	document.all.sale_name.value ="";
	document.all.prepay_pay.value ="";
	document.all.pay_Type.value ="";
	document.all.consume_term.value ="";
}
function getInfo_code()
{
	if(document.all.saleType.value == "")
	{
		rdShowMessageDialog("营销案类别不能为空！");
		return false;
	}
	
	//调用公共js
	var regionCode = "<%=regionCode%>";
	var pageTitle = "营销方案选择";
	var fieldName = "营销案代码|营销案名称|预存话费金额|消费时长|";//弹出窗口显示的列、列名
	var sqlStr = "select sale_code,sale_name,prepay_pay,consume_term from sSpSaleCode where region_code='"+regionCode+"' and flag='Y' and sale_type='"+document.frm.saleType.value+"'";
	var selType = "S";    //'S'单选；'M'多选
	var retQuence = "4|0|1|2|3|";//返回字段
	var retToField = "sale_code|sale_name|prepay_pay|consume_term|";//返回赋值的域
	if(MySimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,80));
	
	var arrSaleType = document.frm.saleType.value.split("-->")
	document.frm.saleType1.value = arrSaleType[0];
}

function MySimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,dialogWidth)
{
    var path = "<%=request.getContextPath()%>/npage/public/fPubSimpSel.jsp";
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

//----------------验证及提交函数-----------------
function doCfm(subButton)
{
	controlButt(subButton);			//延时控制按钮的可用性
	
	var radio1 = document.getElementsByName("opFlag");
	for(var i=0;i<radio1.length;i++)
	{
		if(radio1[i].checked)
		{
			var opFlag = radio1[i].value;
			if(opFlag=="one")
			{
				if(document.all.sale_name.value=="")
				{
					rdShowMessageDialog("请输入营销案代码！")
					return;
				}
				
				frm.action="f9896_1.jsp";
				document.all.opcode.value="9896";
			
			}else if(opFlag=="two")
			{
				if(document.all.backaccept.value=="")
				{
					rdShowMessageDialog("请输入业务流水！")
					return;
				}
				frm.action="f9897_1.jsp";
				document.all.opcode.value="9897";
			}
		}
  }
	frm.submit();	
	return true;
}
 function controlButt(subButton){
	subButt2 = subButton;
    subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
  }
function opchange()
{
	if(document.all.opFlag[0].checked==true) 
	{
		document.all.backaccept_id.style.display = "none";
		document.all.sale_id.style.display = "";
	}
	else 
	{
		document.all.backaccept_id.style.display = "";
		document.all.sale_id.style.display = "none";
	}

}
</script>
</head>
<body>
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
 	<input type="hidden" name="opcode" >
 	<input type="hidden" name="sale_code" >
 	<input type="hidden" name="prepay_pay" >
 	<input type="hidden" name="consume_term" >
 	<input type="hidden" name="saleType1" value="">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">选择操作类型</div>
	</div>
<table cellspacing="0">
	<tr> 
		<td class="blue" width="20%">操作类型</td>
		<td colspan="3">
			<input type="radio" name="opFlag" value="one" onclick="opchange()">申请&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="two" onclick="opchange()">冲正
		</td>
	</tr>    
	<tr> 
		<td class="blue">手机号码 </td>
		<td colspan="3"> 
			<input type="text" size="12" name="srv_no" value="<%=activePhone%>" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 maxlength="11" index="0" class="InputGrey" readOnly>
				<font color="orange">*</font>
		</td>
	</tr>
	<tr style="display:none" id="backaccept_id"> 
		<td class="blue">业务流水</td>
		<td colspan="3">
			<input class="button" type="text" name="backaccept" v_must=1 >
				<font color="orange">*</font>
		</td>
	</tr>
	<tr id="sale_id">
		<td class="blue">营销案类别</td>
		<td>
			<select id=saleType name=saleType onChange="chkType()">
		    <%	
		    	sqlStr ="select trim(a.sale_type),trim(a.type_name) from sSpSaleCode a where a.region_code='"+regionCode+"' and flag='Y' group by trim(a.sale_type),trim(a.type_name) ";
		    	String[] inParas1 = new String[2];
		    	
		    	inParas1[0] = "select trim(a.sale_type),trim(a.type_name) from sSpSaleCode a where a.region_code=:region_code and flag='Y' group by trim(a.sale_type),trim(a.type_name) ";
				inParas1[1] = "region_code="+regionCode;
				System.out.println("sqlStr === "+ sqlStr);
%>
			<wtc:service name="TlsPubSelCrm"  outnum="2" retcode="retCode1" retmsg="regMsg1">
				<wtc:param value="<%=inParas1[0]%>"/>
				<wtc:param value="<%=inParas1[1]%>"/> 
			</wtc:service>
			<wtc:array id="result" scope="end"/>
<%
				recordNum = result.length;
				for(i=0;i<recordNum;i++)
				{
					out.println("<option class='button' value='" + result[i][0] + "'>" + result[i][0]+"-->"+result[i][1] + "</option>");
				}
		   %>
		   </select>
		   <input class="b_text" type="button" name="qryId_No" value="查询" onClick="getInfo_code()" >
		</td>
		<td class="blue">营销案代码</td>
		<td>
			<input class="InputGrey" type="text" name="sale_name" id="sale_name" readonly>
		</td>
	</tr> 
	<tr> 
		<td colspan="4" align="center" id="footer"> 
			<input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">    
			<input class="b_foot" type=button name=back value="清除" onClick="frm.reset()">
			<input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab();">
		</td>
	</tr>
</table>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
