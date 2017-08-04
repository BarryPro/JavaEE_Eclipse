<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 宽带补收
   * 版本: 1.0
   * 日期: 2011/7/15
   * 作者: xiaoliang
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>宽带补收</title>

<%
    //String opCode="8379";
	//String opName="赠送预存款";
	
    //String opCode=request.getParameter("opCode");
	//String opName=request.getParameter("opName");	
	//String phoneNo = (String)request.getParameter("activePhone");
    String workNo=(String)session.getAttribute("workNo");
    String regionCode=(String)session.getAttribute("regCode");
    String[][] favInfo=(String[][])session.getAttribute("favInfo");
	boolean workNoFlag=false;
	if(workNo.substring(0,1).equals("k"))
		workNoFlag=true;


    // xl 原e031
	ArrayList arr = (ArrayList)session.getAttribute("allArr");
    String[][] baseInfo = (String[][])arr.get(0);
    String workno = baseInfo[0][2];
    String workname = baseInfo[0][3];
	String belongName = baseInfo[0][16];

	String opCode = "e031"  ;
	String opName = "宽带补收"  ;
	String dateStr=new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	Calendar cal = Calendar.getInstance(Locale.getDefault());
    cal.set(Integer.parseInt(dateStr.substring(0,4)),(Integer.parseInt(dateStr.substring(4,6))-1),Integer.parseInt(dateStr.substring(6,8)));
    String mon = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
	// xl end of 原e031
%>

 
 

<script language="JavaScript">
<!--

function form_load()
{
form.sure.disabled=true;
form.phoneno.focus();
}

function doQry()
{
	if(document.form.phoneno.value==""){
  		rdShowMessageDialog("宽带号码不能为空!");
  		document.form.phoneno.focus();
		return false;
  	}
	var myPacket = new AJAXPacket("getKdNo_new.jsp","正在查询客户，请稍候......");
		myPacket.data.add("contractNo",(document.all.phoneno.value).trim());
		myPacket.data.add("busyType",1);
		myPacket.data.add("return_page","e031.jsp");
		core.ajax.sendPacket(myPacket);
		myPacket=null;
	
}
 function doProcess(packet)
 {
     
	var contract_new=packet.data.findValueByName("contract_out");
	var phone_new=packet.data.findValueByName("phone_new"); 
	document.all.contractno.value=contract_new;
	document.getElementById("pno").value= phone_new;
	//alert("phone_new is "+phone_new);
	var s_sm_code = packet.data.findValueByName("s_sm_code"); 
	//alert("s_sm_code is "+s_sm_code);
	document.getElementById("sm_code").value= s_sm_code;
	var i_dp = packet.data.findValueByName("i_dp");
	//alert(i_dp);
	/*if(s_sm_code=="kh") 
	{
		rdShowMessageDialog("单品需在zg66进行宽带补收!");
		return false;
	}
	else
	{
		 docheck(); 
	}*/
   docheck(); 
 }

function docheck()
{
	
 
if( form.billmonth.value.length<6) {
rdShowMessageDialog("\请输入正确的归属年月,格式为YYYYMM !!")
document.form.billmonth.focus();
return false;
}
else if( form.billmonth.value.substring(0,4)<"1990"||form.billmonth.value.substring(0,4)>"2020") {
rdShowMessageDialog("\输入的年份错误，请重新输入 !!")
document.form.billmonth.focus();
return false;
}
else if( form.billmonth.value.substring(4)<"01"||form.billmonth.value.substring(4)>"12") {
rdShowMessageDialog("\输入的月份错误，请重新输入 !!")
document.form.billmonth.focus();
return false;
}
else {
	var h=480;
	var w=650;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+300+"px; dialogWidth:"+500+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
	//rdShowMessageDialog("test phoneNo is "+document.getElementById("pno").value);
	var str=window.showModalDialog('getCount_e031.jsp?phoneNo='+document.getElementById("pno").value,"",prop);
	//alert("!! "+str);
    // getCount_bs.jsp 查询e031宽带补收的
	if( typeof(str) != "undefined" ){
		if (parseInt(str)==0) {
	   		rdShowMessageDialog("没有找到对应的帐号！");
	   		return false; }
	   	else {
			//alert("str is "+str);
			document.form.contractno.value = str;
			document.form.action="e031_select1.jsp";
			form.submit();
			return true; }
	}
}
}

 

//-->
</script>
</HEAD>
<BODY  onLoad="form_load()">
<FORM   method=post name=form>
<%@ include file="/npage/include/header.jsp" %>
 <input type="hidden" name="phoneNo" id = "pno"  value="" > 
 <input type="hidden" name="sm_code" id = "sm_code"  value="" >
  <div class="title">
			<div id="title_zi">铁通宽带补收</div>
  </div>
  <table width="767" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
        
        
       
        <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center"  >
          <tr>
            <td width="45%"> <br>
              <table width=100% height=25 border=0 align="center" cellspacing=2 cellpadding="4">
                <tbody>
                <tr  >
                  <td width="13%" class="blue">操作类型：</td>
                  <td width="35%">
                    <select name = "optype" size = "1">
                      <option value = "1" selected>单个号码费用正补收</option>
                    </select>
                  </td>
                  <td width="13%"></td>
                  <td width="39%" class="blue">部门：<%=belongName%></td>
                </tr>
                </tbody>
              </table>
              <table width=100% height=25 border=0 align="center" cellspacing=2>
                <tr  >
                  <td width="13%" class="blue">宽带号码：</td>
                  <td width="35%">
                    <input type="text"   name="phoneno" maxlength="25" onkeydown="if(event.keyCode==13)form.billmonth.focus()" >
                  </td>
                  <td width="13%" align="left" class="blue">归属年月：</td>
                  <td width="39%">
                    <input type="text"   value="<%=mon%>" name="billmonth" readonly>
                    <!--<input type="button" name=sure22 class="b_foot" value=查询 onClick="docheck">
					-->
					<input type="button" name=sure22 class="b_foot" value=查询 onClick="doQry()">
                  </td>
                </tr>
                <tr  >
                  <td width="13%" class="blue">帐户号码：</td>
                  <td width="35%">
                    <input type="text" readonly  name="contractno" value="">
                  </td>
                  <td width="13%" class="blue">客户名称：</td>
                  <td width="39%">
                    <input type="text" readonly name="textfield7"  >
                  </td>
                </tr>
                <tr  >
                  <td width="13%" class="blue">运行状态： </td>
                  <td width="35%">
                    <input type="text" readonly   name="textfield5">
                  </td>
                  <td width="13%" class="blue">客户信息：</td>
                  <td width="39%">
                    <input type="text" readonly name="textfield72"  >
                  </td>
                </tr>
				
              </table>
              <table width="100%" height=25 border=0 align="center" cellspacing=2>
                <tr  >
                  <td colspan="4" class="blue">以下为可调整的费用信息：</td>
               	</tr>


                <tr  >
                  <td>
                    <div align="center" class="blue">费用名称</div>
                  </td>
                  <td>
                    <div align="center" class="blue">金额</div>
                  </td>
                </tr>
              </table>
              <table width=100% height=25 border=0 align="center" cellspacing=1 cellpadding="4">
                <tbody>
                <tr  >
                  <td width=13% class="blue">金额总计：</td>
                  <td width="87%">
                    <input type="text"   name="total_pay" readonly value="">
                  </td>
                </tr>
                <tr  >
                  <td width="13%" class="blue">备注信息：</td>
                  <td width="87%">
                    <input type="text"    name="TOpNote" maxlength="60" size="60">
                  </td>
                </tr>
                </tbody>
              </table>
              <table width="100%" border=0 align=center cellpadding="4" cellspacing=1>
                <tbody>
                <tr  >
                  <td colspan="4" align="center" id="footer"> 
                    <input class="b_foot" type=button name=sure   value=确认>
                    <input type="button" name=reset class="b_foot" value=关闭 onClick="window.close()">
                    &nbsp; </td>
                </tr>
                </tbody>
              </table>
          
            </td>
          </tr>
        </table>
        <br>
      </td>
    </tr>
  </table>
 </FORM>
</BODY></HTML>
