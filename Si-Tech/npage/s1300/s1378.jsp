<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>

<%@ page contentType="text/html; charset=GB2312" %>
<%@ page errorPage="/page/common/errorpage.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="com.sitech.boss.amd.viewbean.*" %>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue" %>
<%@ page import="java.util.*"%>

<%	
	//==============================获取营业员信息
    ArrayList arr = (ArrayList)session.getAttribute("allArr");
    String[][] baseInfo = (String[][])arr.get(0);
    String workno = baseInfo[0][2];
    String workname = baseInfo[0][3];
	String org_code = baseInfo[0][16];
	String belongName = baseInfo[0][16];
	String[][] pass = (String[][])arr.get(4);
	String nopass = pass[0][0];
	//String phone_no = baseInfo[0][7];
	//联系信息
    String phone_no = "";
    String id_no = "";
	String region_name = "";
    String district_name = "";
	String owner_name = "";
	String use_time = "";
	String delete_time = "";
	String owner_idno = "";
	String owner_phone = "";
	String owner_unit = "";
	String owner_address = "";
	String owner_zip = "";
	String contact_person = "";
	String contact_phone = "";
	String contact_idno = "";
	String sm_code = "";
	String delete_own_count = "0";
    
	if (request.getParameter("phone_no") != null) {
	    phone_no = request.getParameter("phone_no");
	}	
	if (request.getParameter("id_no") != null) {
	    id_no = request.getParameter("id_no");
	}
	if (request.getParameter("region_name") != null) {
	   region_name = request.getParameter("region_name");
	}
	if (request.getParameter("district_name") != null) {
	    district_name = request.getParameter("district_name");
	}
	if (request.getParameter("owner_name") != null) {
	    owner_name = request.getParameter("owner_name");
	}
	if (request.getParameter("use_time") != null) {
	    use_time = request.getParameter("use_time");
	}
	if (request.getParameter("delete_time") != null) {
	    delete_time = request.getParameter("delete_time");
	}
	if (request.getParameter("owner_idno") != null) {
	    owner_idno = request.getParameter("owner_idno");
	}
	if (request.getParameter("owner_phone") != null) {
	    owner_phone = request.getParameter("owner_phone");
	}
	if (request.getParameter("owner_unit") != null) {
	    owner_unit = request.getParameter("owner_unit");
	}
	if (request.getParameter("owner_address") != null) {
	    owner_address = request.getParameter("owner_address");
	}
	if (request.getParameter("owner_zip") != null) {
	    owner_zip = request.getParameter("owner_zip");
	}
	if (request.getParameter("contact_person") != null) {
	    contact_person = request.getParameter("contact_person");
	}
	if (request.getParameter("contact_phone") != null) {
	    contact_phone = request.getParameter("contact_phone");
	}
	if (request.getParameter("contact_idno") != null) {
	    contact_idno = request.getParameter("contact_idno");
	}	
	if (request.getParameter("sm_code") != null) {
	    sm_code = request.getParameter("sm_code");
	}
    if (request.getParameter("delete_own_count") != null) {
	    delete_own_count = request.getParameter("delete_own_count");
	}
%>

<HTML>
<HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="JavaScript" src="/js/common/redialog/redialog.js"></script>
<script language="JavaScript" src="/js/common/common_check.js"></script>
<script language="JavaScript" src="/js/common/common.js"></script>
<title>黑龙江BOSS-欠费催缴</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="/css/jl.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE="JavaScript">
<!--
var tndDeletePay = new Array();
<% for (int i = 0; i < Integer.parseInt(delete_own_count); i++) { %>
    tndDeletePay[<%=i%>] = new Array();
    tndDeletePay[<%=i%>][0] = '<%=request.getParameter("bill_year" + i)%>';
	tndDeletePay[<%=i%>][1] = '<%=request.getParameter("bill_month" + i)%>';
	tndDeletePay[<%=i%>][2] = '<%=request.getParameter("owe_money" + i)%>';
	tndDeletePay[<%=i%>][3] = '<%=request.getParameter("late_fee" + i)%>';
	tndDeletePay[<%=i%>][4] = '<%=request.getParameter("owe_money_total" + i)%>';
	tndDeletePay[<%=i%>][5] = '<%=request.getParameter("cash_pay" + i)%>';
	tndDeletePay[<%=i%>][6] = '<%=request.getParameter("payed_status" + i)%>';    
<% } %>

function printCommit() {
   if( document.frm.phone_no.value.length == 0){
		rdShowMessageDialog("请输入正确的服务号码！");
		document.frm.phone_no.focus();
		return false;
   }

   if( document.frm.owe_year.value.length == 0){
		rdShowMessageDialog("欠费年不能为空，请重新输入！");
		document.frm.owe_year.focus();
		return false;
	} else if (document.frm.owe_year.value.length != 4){
	    rdShowMessageDialog("欠费年要为4位数字，请重新输入！");
		document.frm.owe_year.focus();
		return false;
	} else if (document.frm.owe_year.value.indexOf('0') == 0) {
	    rdShowMessageDialog("欠费年不能以0开头，请重新输入！");
		document.frm.owe_year.focus();
		return false;
	}

	if( document.frm.owe_month.value.length == 0){
		rdShowMessageDialog("欠费月不能为空，请重新输入！");
		document.frm.owe_month.focus();
		return false;
	} else if (document.frm.owe_month.value < 1 || document.frm.owe_month.value > 12) {
	    rdShowMessageDialog("欠费月必须在1-12之间，请重新输入！");
		document.frm.owe_month.focus();
		return false;
	}

	if( document.frm.owe_fee_pay.value.length == 0){
		rdShowMessageDialog("交欠费不能为空，请重新输入！");
		document.frm.owe_fee_pay.focus();
		return false;
	}

	if( document.frm.delay_fee_pay.value.length == 0){
		rdShowMessageDialog("交滞纳金不能为空，请重新输入！");
		document.frm.delay_fee_pay.focus();
		return false;
	}

    document.frm.submit();
}

function doSearch(){	
	if( document.frm.phone_no.value.length == 0){
		rdShowMessageDialog("请输入正确的服务号码！");
		document.frm.phone_no.focus();
		return false;
	}
	//alert("1");
    getidno();
	//alert("finish~~");
	//document.frm.action = "<%=request.getContextPath()%>/page/s1300/getDeleteOwe.jsp";
	document.frm.action = "getDeleteOwe.jsp";
	document.frm.submit();
}

function getidno()
{  	
  	//调用公共js得到银行代码
	
    var pageTitle = "欠费催缴用户查询";
    var fieldName = "用户ID|地市名称|用户姓名|";
    var service_no = document.frm.phone_no.value;
	var subservice_no = service_no.substring(0, 1);
	//alert("2 "+subservice_no);
	var sqlStr = "";
	if (subservice_no == "9") {
	   sqlStr = "select to_char(id_no),region_name,owner_name from tna_delete_owe where phone_no='"+document.frm.phone_no.value+"' and payed_status='0' group by id_no,region_name,owner_name";
    } else {
	   sqlStr = "select to_char(id_no),region_name,owner_name from tnd_delete_owe where phone_no='"+document.frm.phone_no.value+"' and payed_status='0' group by id_no,region_name,owner_name";
	}

    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "2|0|1|";
    var retToField = "id_no|";
    PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
}

function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{   //公共查询
	//alert("3");
    var path = "fPubSimpSel_1378.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
    retInfo = window.showModalDialog(path);
    
    if (retInfo == "notfound") {
       rdShowMessageDialog("无此用户，请重新输入!");
       document.frm.phone_no.focus();
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

function isKeyNumberdot(ifdot) 
{       
    var s_keycode=(navigator.appname=="Netscape")?event.which:event.keyCode;
	if(ifdot==0) {
		if(s_keycode>=48 && s_keycode<=57) {
			return true;
		} else {
			return false;
		}
    } else if (ifdot==1) {
		if((s_keycode>=48 && s_keycode<=57) || s_keycode==46) {
		      return true;
		} else if(s_keycode==45) {
		    rdShowMessageDialog('不允许输入负值,请重新输入!');
		    return false;
		} else {
		    return false;
		}
    } else if (ifdot==2) {
        if((s_keycode>=48 && s_keycode<=57) || s_keycode==46 || s_keycode==45) {
		      return true;
		} else {
		    return false;
		}
    }
}

function countPay() {
   if( document.frm.phone_no.value.length == 0){
		rdShowMessageDialog("请输入正确的服务号码！");
		document.frm.phone_no.focus();
		return false;
   }


   if( document.frm.owe_year.value.length == 0){
		rdShowMessageDialog("欠费年不能为空，请重新输入！");
		document.frm.owe_year.focus();
		return false;
	} else if (document.frm.owe_year.value.length != 4){
	    rdShowMessageDialog("欠费年要为4位数字，请重新输入！");
		document.frm.owe_year.focus();
		return false;
	} else if (document.frm.owe_year.value.indexOf('0') == 0) {
	    rdShowMessageDialog("欠费年不能以0开头，请重新输入！");
		document.frm.owe_year.focus();
		return false;
	}

	if( document.frm.owe_month.value.length == 0){
		rdShowMessageDialog("欠费月不能为空，请重新输入！");
		document.frm.owe_month.focus();
		return false;
	} else if (document.frm.owe_month.value < 1 || document.frm.owe_month.value > 12) {
	    rdShowMessageDialog("欠费月必须在1-12之间，请重新输入！");
		document.frm.owe_month.focus();
		return false;
	}

	if( document.frm.owe_fee_pay.value.length == 0){
		rdShowMessageDialog("交欠费不能为空，请重新输入！");
		document.frm.owe_fee_pay.focus();
		return false;
	}

	if( document.frm.delay_fee_pay.value.length == 0){
		rdShowMessageDialog("交滞纳金不能为空，请重新输入！");
		document.frm.delay_fee_pay.focus();
		return false;
	}

   var owe_year = jtrim(document.frm.owe_year.value);
   var owe_month = jtrim(document.frm.owe_month.value);
   var owe_fee_pay = jtrim(document.frm.owe_fee_pay.value);
   var delay_fee_pay = jtrim(document.frm.delay_fee_pay.value);
   
   for(i = 0; i < tndDeletePay.length; i++){
       if (tndDeletePay[i][0] == owe_year && tndDeletePay[i][1] == owe_month) {
	       document.frm.owe_fee_pay_choic.value = tndDeletePay[i][2] - owe_fee_pay;
           document.frm.delay_fee_pay_choic.value = tndDeletePay[i][3] - delay_fee_pay;
	       document.frm.fee_pay_total.value = parseFloat(owe_fee_pay) + parseFloat(delay_fee_pay);
		   break;
	   }
   }   
}    
//-->
</SCRIPT>

</head>

<BODY bgColor=#FFFFFF leftmargin="0" topmargin="0" background="/images/jl_background_2.gif">
<FORM action="s1378_2.jsp" method="post" name="frm" >
<input type="hidden" name="sm_code"  value="<%=sm_code%>">
<input type="hidden" name="returnPage"  value="s1378.jsp">
<input type="hidden" name="org_code"  value="<%=org_code%>">
<table width="767" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
      <td background="/images/jl_background_1.gif" bgcolor="#E8E8E8">
        <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr>
          <td align="right" width="45%">
            <p><img src="/images/jl_chinamobile.gif" width="226" height="26"></p>
            </td>
            <td width="55%" align="right"><img src="/images/jl_ico_1.gif" width="13" height="14" hspace="3" align="absmiddle">工号：<%=workno%><img src="/images/jl_ico_1.gif" width="13" height="14" hspace="3" align="absmiddle">操作员：<%=workname%></td>
        </tr>
      </table>
      <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr>
            <td align="right" background="/images/jl_background_3.gif" height="69">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><img src="/images/jl_logo.gif"></td>
                <td align="right"><img src="/images/jl_head_1.gif"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr>
          <td align="right" width="73%">
            <table width="535" border="0" cellspacing="0" cellpadding="0">
              <tr>
                 <td width="42"><img src="/images/jl_ico_2.gif" width="42" height="41"></td>
                <td valign="bottom" width="493">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                     <td background="/images/jl_background_4.gif"><font color="FFCC00"><b>欠费催缴</b></font></td>
                     <td><img src="/images/jl_ico_3.gif" width="389" height="30"></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
          <td width="27%">
            <table border="0" cellspacing="0" cellpadding="4" align="right">
              <tr>
                <td><img src="/images/jl_ico_4.gif" width="60" height="50"></td>
                <td><img src="/images/jl_ico_5.gif" width="60" height="50"></td>
                <td><img src="/images/jl_ico_6.gif" width="60" height="50"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
        <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
          <tr bgcolor="649ECC"> 
            <td colspan="4" nowrap>用户信息：
            </td>            
          </tr>
          
          <tr bgcolor="F5F5F5"> 
            <td width="15%">服务号码：</td>
			
			<td width="35%">
			   <input type="text" name="phone_no" class="button" maxlength="11" value="<%=phone_no%>">
			   <font color="#FF0000"> *</font>
			   <input type="button" class="button" name="Button1" value="查询" onclick="doSearch()">
			</td>
            
			<td width="15%">用户ID：</td>
            <td width="35%">
			   <input type="text" name="id_no" class="button" maxlength="11" value="<%=id_no%>">
			   <font color="#FF0000"> *</font>			   
			</td>
          </tr>
          
		  <tr bgcolor="#E8E8E8"> 
            <td width="15%">用户姓名：</td>
			<td width="35%"> 
			  <input type="text" name="owner_name" readonly class="button" value="<%=owner_name%>">
			</td>
            <td width="15%">地市：</td>
            <td width="35%">
			  <input type="text" name="region_name" readonly class="button" value="<%=region_name%>">
			</td>
          </tr>
          
		  <tr bgcolor="F5F5F5"> 
            <td width="15%">地区：</td>
			<td width="35%">
                <input type="text" name="district_name" readonly class="button" value="<%=district_name%>">
            </td>
            <td width="15%">开户时间：</td>
            <td width="35%">
			   <input type="text" name="use_time" readonly class="button" value="<%=use_time%>">
			</td>
          </tr>

		  <tr bgcolor="#E8E8E8"> 
            <td width="15%">拆机时间：</td>
			<td width="35%"> 
			    <input type="text" name="delete_time" readonly class="button" value="<%=delete_time%>">
			</td>
            <td width="15%">身份证号：</td>
            <td width="35%">
			    <input type="text" name="owner_idno" readonly class="button" value="<%=owner_idno%>">
			</td>
          </tr>

		  <tr bgcolor="F5F5F5"> 
            <td width="15%">用户电话：</td>
			<td width="35%"> 
			   <input type="text" name="owner_phone" readonly class="button" value="<%=owner_phone%>">
			</td>
            <td width="15%">工作单位：</td>
            <td width="35%">
			   <input type="text" name="owner_unit" readonly class="button" value="<%=owner_unit%>">
			</td>
          </tr>

		  <tr bgcolor="#E8E8E8"> 
            <td width="15%">用户地址：</td>
			<td width="35%"> 
			   <input type="text" name="owner_address" readonly class="button" value="<%=owner_address%>">
			</td>
            <td width="15%">邮编：</td>
            <td width="35%">
			   <input type="text" name="owner_zip" readonly class="button" value="<%=owner_zip%>">
			</td>
          </tr>

		  <tr bgcolor="F5F5F5"> 
            <td width="15%">联 系 人：</td>
			<td width="35%">
			   <input type="text" name="contact_person" readonly class="button" value="<%=contact_person%>">
			</td>
            <td width="15%">联系人电话：</td>
            <td width="35%">
			   <input type="text" name="contact_phone" readonly class="button" value="<%=contact_phone%>"> 
			</td>
          </tr>

		  <tr bgcolor="#E8E8E8"> 
            <td width="15%">联系人身份证号：</td>
			<td width="35%"> 
			   <input type="text" name="contact_idno" readonly class="button" value="<%=contact_idno%>"> 
			</td>
            <td width="15%"></td>
            <td width="35%"></td>
          </tr>
       </table>   
	  <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
		  <tr bgcolor="649ECC"> 
            <td colspan="8" nowrap>欠费信息：</td>            
          </tr>
          <tr bgcolor="F5F5F5"> 
            <td colspan="4">
			   <table width="100%" cellspacing="1" border="0" align="center">
                    <tr bgcolor="#E8E8E8"> 
                       <td height=25 nowrap> 
                         <div align="center">欠费年</div>
                       </td>
                       <td nowrap> 
                         <div align="center">欠费月</div>
                       </td>
                       <td nowrap> 
                         <div align="center">欠费金额</div>
                       </td>
                       <td nowrap> 
                         <div align="center">滞纳金</div>
                       </td>
                       <td nowrap> 
                        <div align="center">欠费合计</div>
                       </td>
                       <td nowrap> 
                         <div align="center">已收回金额</div>
                       </td>
                       <td nowrap> 
                         <div align="center">欠费状态</div>
                       </td>
                    </tr>
                    
                    <%for (int i = 0; i < Integer.parseInt(delete_own_count); i++) {%>
                         <tr bgcolor="#E8E8E8"> 
                            <td nowrap> 
                              <div align="center"><%=request.getParameter("bill_year" + i)%></div>
                            </td>
                            <td nowrap> 
                              <div align="center"><%=request.getParameter("bill_month" + i)%></div>
                            </td>
                            <td nowrap> 
                              <div align="center"><%=request.getParameter("owe_money" + i)%></div>
                            </td>
                            <td nowrap> 
                              <div align="center"><%=request.getParameter("late_fee" + i)%></div>
                            </td>
                            <td nowrap> 
                              <div align="center"><%=request.getParameter("owe_money_total" + i)%></div>
                            </td>
                            <td nowrap> 
                              <div align="center"><%=request.getParameter("cash_pay" + i)%></div>
                            </td>
                            <td nowrap> 
                              <div align="center"><%=request.getParameter("payed_status" + i)%></div>
                            </td>
                         </tr>                    
					<%}%>
			   </table>
			</td>
           </tr>
		</table>
		<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
          <tr bgcolor="649ECC"> 
            <td colspan="4" nowrap>交费信息：
            </td>            
          </tr>
          <tr bgcolor="F5F5F5"> 
            <td width="15%">欠费年:</td>
			<td width="35%">
			   <input type="text" name="owe_year" class="button" size="10" maxlength="4" onKeyPress="return isKeyNumberdot(0);">			 
			  <font color="#FF0000"> *</font>
			</td>            
			<td width="15%">欠费月:</td>
            <td width="35%">
			    <input type="text" name="owe_month" class="button" size="10" maxlength="2" onKeyPress="return isKeyNumberdot(0);">					      
			  <font color="#FF0000"> *</font>	   
			</td>
          </tr>
          
		  <tr bgcolor="#E8E8E8"> 
            <td width="15%">交欠费:</td>
			<td width="35%"> 
			  <input type="text" name="owe_fee_pay" class="button" maxlength="22" onKeyPress="return isKeyNumberdot(1);">		      
			 <font color="#FF0000"> *</font>
			</td>
            <td width="15%">交滞纳金:</td>
            <td width="35%">
			   <input type="text" name="delay_fee_pay" class="button" maxlength="22" onKeyPress="return isKeyNumberdot(1);">
			  <font color="#FF0000"> *</font>
			</td>
          </tr>
          
		  <tr bgcolor="F5F5F5"> 
            <td width="15%">欠费优惠:</td>
			<td width="35%">
                <input type="text" name="owe_fee_pay_choic" class="button">
            </td>
            <td width="15%">滞纳金优惠:</td>
            <td width="35%">
			   <input type="text" name="delay_fee_pay_choic" class="button">
			</td>
          </tr>

		  <tr bgcolor="#E8E8E8"> 
            <td width="15%">本次交费合计:</td>
			<td width="35%"> 
			    <input type="text" name="fee_pay_total" class="button">
			    <input type="button" class="button" value="计算" onClick="countPay()">
			</td>
            <td width="15%"></td>
            <td width="35%">
			</td>
          </tr>
		  
		  <tr bgcolor="#F5F5F5"> 
            <td width="15%">备注:</td>
			<td height=25 colspan="7" align="left">
			<input type="text" size="60" name="op_note" class="button"> 
			</td>         
          </tr>
          					
          <tr bgcolor="F5F5F5"> 
            <td colspan="4"> <div align="center"> 
                <input name="confirm" type="button" class="button" value="确认" onClick="printCommit()">
                &nbsp; 
                <input name="reset" type="reset" class="button" value="清除" >
                &nbsp; 
                <input name="back" onClick="window.close()" type="button" class="button" value="返回">
                &nbsp; </div>
			</td>
          </tr>
		</table>
     &nbsp;
	 </td>
   </tr>
</table>
</FORM> 
</body>
</html>