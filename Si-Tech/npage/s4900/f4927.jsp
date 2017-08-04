<%
    /*************************************
    * 功  能: 应收资金管理系统@营业员上交款录入
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2011-12-9
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String opCode=request.getParameter("opCode");
    String opName=request.getParameter("opName");
    String work_no=(String)session.getAttribute("workNo");
    String loginName =(String)session.getAttribute("workName");
    String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
	boolean workNoFlag=false;
	if(work_no.substring(0,1).equals("k"))
	{
	     workNoFlag=true;
	}  

	java.util.Date  d=new  java.util.Date();
	java.text.SimpleDateFormat  dformat=new  java.text.SimpleDateFormat("yyyyMMdd");
	String  dateandtime=dformat.format(d);

	//缴款类型
	String sqlPayType = " select t1.pay_type,t1.pay_name from swpaytype t1  where t1.is_valid =1 ";
%>	
	<wtc:service name="TlsPubSelCrm" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2"> 
        <wtc:param value="<%=sqlPayType%>"/>
    </wtc:service>
    <wtc:array id="payTypeStr"  scope="end"/>
<%
    //System.out.println("sqlPayType====="+sqlPayType);

	//营业款类型 wanghfa修改sql 2011/5/12 9:27
	String sqlMoneyType = "select c.money_type, c.money_name"
    + " from DBCUSTADM.dchngroupmsg     a,"
    + "      dbchnadn.schnclasstypecode b,"
    + "      smoneytype                 c,"
    + "      dloginmsg                  d"
    + " where a.class_code = b.class_code"
    + "  and b.class_type = c.class_type"
    + "  and a.group_id = d.group_id"
    + "  and d.login_no =:vWorkNo"
    + "  and c.op_code = '4927'"
    + " order by c.money_type";
	String sqlVar1 = " vWorkNo=" + work_no;

 %>   
	<wtc:service name="TlsPubSelCrm" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="2">
		<wtc:param value="<%=sqlMoneyType%>"/>
		<wtc:param value="<%=sqlVar1%>"/>
	</wtc:service>
	<wtc:array id="moneyTypeStr" scope="end"/>
<%    
	//System.out.println("sqlMoneyType====="+sqlMoneyType);
	//System.out.println(moneyTypeStr.length);
	
%>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>营业员上交款录入</title>
    </head>
<body>
<form name="frm" method="POST" action="f4927Cfm.jsp" >
    <%@ include file="/npage/include/header.jsp" %>
        	<div class="title">
        		<div id="title_zi">营业员上交款录入</div>
        	</div>
      <table cellspacing="0">
         <tr>
            <td>营业款类型：</td>
            <td>
            	 <SELECT id="money_type" name="money_type" v_must="1" onchange="changeMoneyType()" >
			     <% 
			        for(int j=0;j<moneyTypeStr.length;j++){
			     %>
  		            <option value="<%=moneyTypeStr[j][0]%>">
  		                <%=moneyTypeStr[j][1]%>
  		            </option>
                 <%} %>
                 </select>
                    <font color="#FF0000">*</font>
            </td>
            <td>交款类型：</td>
            <td>
            	 <select size=1 name="pay_type" id="pay_type" onchange="changePayType()" >
            	 	<% 
            	 	    for(int i=0;i<payTypeStr.length;i++){ 
            	 	%>
            	 	   <option value="<%=payTypeStr[i][0]%>">
            	 	        <%=payTypeStr[i][1]%>
            	 	   </option>
            	 	<%}%>
			 	 </select>
			 	 <font color="#FF0000">*</font>
			</td>
	   </tr>
       <tr id="byhand1" style="visibility:hidden;display:none;" >
            <td>支票号：</td>
	        <td>
	            <input name="check_no" id="check_no" type="text" class="button" maxlength="25"  v_type="0_9" v_name="支票号" v_must=1  />
	            <font color="#FF0000">*</font>
	        </td>
			<td>支票单位：</td>
	        <td>
	            <input name="bank_cust" id="bank_cust" type="text" class="button" maxlength="50" v_name="支票单位"  size=30  v_must=1 />
	            <font color="#FF0000">*</font>
	        </td>
       </tr>
       <tr id="byhand2" style="visibility:hidden;display:none;">
            <td >帐&nbsp;&nbsp;号：</td>
	        <td>
	        	<input name="account_id" id="account_id" type="text" class="button" maxlength="25"  v_type="0_9" v_name="帐号" v_must=1  />
	        	<font color="#FF0000">*</font>
	        </td>
	 	    <td>是否开通业务：</td>
	        <td>
	        	<input type="radio" name="is_user" value="1" checked >是
	        	<input type="radio" name="is_user" value="0">否
	       <font color="#FF0000">*</font></td>
	   </tr>
	   <tr id="byhand3" style="visibility:hidden;display:none;" >
	   	 <td>开户银行代码：</td>
	     <td>
	        <input name="begin_account" id="begin_account" type="text" class="button" maxlength="20"  v_type="0_9" v_name="开户银行代码" v_must=1  />
	        <font color="#FF0000">*</font>
	     </td>
		 <td colspan="2">&nbsp;</td>
	   </tr>
        <tr>
           <td>营业款归属日期：</td>
	        <td>
	            <input type="text" onblur='if(!/^\d{8}$/.test(value))select()' v_name="营业款归属日期"  class="button" name="total_date" value="<%=dateandtime%>" v_format="yyyyMMdd" readOnly maxlength="8" />
	            <font color="#FF0000">*</font>
	        </td>
            <td>上交金额：</td>
            <td><input type="text"  name="pay_money" id="pay_money" v_maxlength="30" v_must="1" v_name="上交金额" v_type="money" onblur="checkElement(this)"/> (元)
                <font color="#FF0000">*</font>
            </td>
        </tr>

      		<tr>
                <td colspan="4" align="center" id="footer">
                    <input type="button" id="confirm" name="confirm" class="b_foot" value="保存" onClick="doCfm(this)" />   
                    <input type="button" id="back"  name="back"  class="b_foot" value="清除" onClick="location.reload();" /> 
                    <input type="button" id="qryP"  name="qryP"  class="b_foot" value="关闭" onClick="removeCurrentTab();" />
                </td>
            </tr>
        <tr>
        	 <td colspan="4" ><font color="#FF0000">注：同一个厅同一天内不能重复录入同一支票号(被退回后可重复录入，待审批、审批通过后，不可重复录入)</font> </td>
        </tr>
  </table>
   <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
<script language="JavaScript">

function changePayType()
{
    if (document.frm.pay_type.value=="2")  //等于支票需要录入支票号
    {	document.getElementById("byhand1").style.visibility="visible";
        document.getElementById("byhand1").style.display="";
        document.getElementById("byhand2").style.visibility="visible";
        document.getElementById("byhand2").style.display="";
        document.getElementById("byhand3").style.visibility="visible";
        document.getElementById("byhand3").style.display="";
    }
    else
    {
        document.getElementById("byhand1").style.visibility="hidden";
        document.getElementById("byhand1").style.display="none";
        document.getElementById("byhand2").style.visibility="hidden";
        document.getElementById("byhand2").style.display="none";
        document.getElementById("byhand3").style.visibility="hidden";
        document.getElementById("byhand3").style.display="none";
    }
}
function changeMoneyType()
{
	if (document.frm.money_type.value=="3") //等于补交款可修改营业款归属日期
	{
		document.frm.total_date.readOnly = false;
	}
	else
	{
		document.frm.total_date.value = <%=dateandtime%>;
		document.frm.total_date.readOnly = true;

	}
}
function doCfm(subButton)
{
 	var paymoney=$("#pay_money").val();
 	var pay_type = $("#pay_type").val();
 	var bank_cust = $("#bank_cust").val();
 	var total_date = $("#total_date").val();
 	var money_type = $("#money_type").val();

	var temp ;
		if(pay_type=="2")
		{
			if(!check(document.frm)) return false;
			if (bank_cust.length==0)
			{
				rdShowMessageDialog("支票单位是必填项，请务必添写");
				document.frm.total_date.focus();
				return false;
			}
		}

		if(money_type=="3")
		{
			checkTimeFormat();
			if(document.frm.total_date.length == 0)
			{
				rdShowMessageDialog("营业款归属日期是必填项，请务必添写");
				document.frm.total_date.focus();
				return false;
			}
			else if ( total_date > <%=dateandtime%> )
			{
				rdShowMessageDialog("补交款中营业款归属日期不可大于今天");
				document.frm.total_date.focus();
				return false;
			}

		}

		if( paymoney=='')
		{
		   rdShowMessageDialog("上交金额不能为空，请重新输入 !");
		   document.frm.pay_money.focus();
		   return false;
		}else if(!checkElement(document.frm.pay_money)) {	//wanghfa添加 2011/5/12 9:52 上交金额不能为负
		   document.frm.pay_money.focus();
		   return false;
		if(!check(frm)) return false;}

        
        
		if ( paymoney.indexOf(".")!=-1)
		{
			temp =  paymoney.substring(paymoney.indexOf(".")+1,paymoney.length);
			if ( temp.length > 2 )
			{
				rdShowMessageDialog("上交金额小数点后只能输入2位！");
				pay_money.focus();
				return false;
			}
		}
	//liyan 20090704 add 按钮变灰
	if(rdShowConfirmDialog("本次缴费金额<b><font color='red' size='5'>"+paymoney+"</font></b>元，是否确定缴费？") == 1){
		document.frm.confirm.disabled="true";
		document.frm.submit();
		return true;
	}
 

}

  //校验时间格式
function checkTimeFormat(){
    if(!forDate(document.frm.total_date)){
    	rdShowMessageDialog("营业款归属日期格式不正确，正确格式为YYYYMMDD");
				document.frm.total_date.focus();
				return false;
    }
}
</script>