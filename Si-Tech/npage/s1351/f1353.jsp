<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-15 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.util.DateTrans"%>
<%
		String opCode = "2121";
		String opName = "个人用户统一账单";
		String workno = (String)session.getAttribute("workNo");
		String workname = (String)session.getAttribute("workName");
		String org_code = (String)session.getAttribute("orgCode");
	
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String dateStr1 = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		String date1="";
		String date2="";
		DateTrans dt=new DateTrans();
		date1=dt.getYear()+""+dt.getMonth();
		dt.addMonth(-1);
		date2=dt.getYear()+""+dt.getMonth();
		dt.addMonth(1);


		    //String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String[] mon = new String[]{"","","","","",""};

  Calendar cal = Calendar.getInstance(Locale.getDefault());
	cal.set(Integer.parseInt(dateStr.substring(0,4)),
                      (Integer.parseInt(dateStr.substring(4,6)) - 1),Integer.parseInt(dateStr.substring(6,8)));
	for(int i=0;i<=5;i++)
      {
              if(i!=5)
              {
                mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
                cal.add(Calendar.MONTH,-1);
              }
              else
                mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
      }
%>
<HTML>
<HEAD>
<script language="JavaScript">


function doProcess(packet){
	 var temp= packet.data.findValueByName("temp");
	
	
	 selectChange(null,frm[eval('moban')],temp);			
  
  
}
//-----实现动态的选择列表-------------
	function selectChange(control, controlToPopulate,  valueArray)
	{	   	
	   	// Empty the second drop down box of any choices

	   

	   	for ( var j = 0 ; j < valueArray.length; j++)
	   	{
	   	     var option =new Option(valueArray[j],valueArray[j]);  
	   	     controlToPopulate.add(option);   
	   	}
	}//end selectChange()

function showMarketingDetail(IsMarketing) {
	 
    var h=450;
    var w=500;
   	var t=screen.availHeight/2-h/2;
	  var l=screen.availWidth/2-w/2;
    var mphone_no=document.frm.phoneNo.value;
	  var prop = "dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
    var path="s1300_MarketMsg.jsp?phoneNo="+mphone_no+"&MarketCounts="+IsMarketing;
	  var returnValue = window.showModalDialog(path,"",prop);
	  //var returnValue = window.open(path,"",prop);
}

function findModual1() {
	 
    var h=450;
    var w=500;
   	var t=screen.availHeight/2-h/2;
	  var l=screen.availWidth/2-w/2;
    var mphone_no=document.frm.phoneNo.value;
	  var prop = "dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
    var path="s1300_MarketMsg.jsp?phoneNo="+mphone_no+"&MarketCounts="+IsMarketing;
	  var returnValue = window.showModalDialog(path,"",prop);
	  //var returnValue = window.open(path,"",prop);
}

function check_HidPwd()
{
  if(document.frm.phoneNo.value=="")
  {
     rdShowMessageDialog("请输入服务号码!");
     document.frm.phoneNo.focus();
     return false;
  }
  

  if( document.frm.phoneNo.value.length != 11 )
  {
     rdShowMessageDialog("服务号码只能是11位!");
     document.frm.phoneNo.value = "";
     document.frm.phoneNo.focus();
     return false;
  }
	            
	var phone_no = document.all.phoneNo.value;
  var busy_type = "1";
	var checkPwd_Packet = new AJAXPacket("../s1351/findModual.jsp","正在查询模板，请稍候......");
	checkPwd_Packet.data.add("phone_no",phone_no);

	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet=null;
}

 
var h=480;
var w=650;
var t=screen.availHeight/2-h/2;
var l=screen.availWidth/2-w/2;
var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";

function findModual()
{
	if(document.frm.phoneNo.value=="")
  {
      rdShowMessageDialog("请输入服务号码!");
     	document.frm.phoneNo.focus();
     	return false;
  }
  

  if( document.frm.phoneNo.value.length != 11 )
  {
     rdShowMessageDialog("服务号码只能是11位!");
     document.frm.phoneNo.value = "";
     document.frm.phoneNo.focus();
     return false;
  }
  
   document.frm.action="queryModual.jsp?phoneno="+document.frm.phoneNo.value;
   document.frm.submit();
} 

 function sel1() {
 		window.location.href='s1300.jsp';
 }

 function sel2(){
    window.location.href='s1300_2.jsp';
 }

 function sel3() {
    window.location.href='s1300_3.jsp';
 }

 function sel4() {
    window.location.href='s1300_4.jsp';
 }
 function sel5() {
    window.location.href='s1300_5.jsp';
 }

 function doclear() {
 		frm.reset();
 }


function querylast()
{
			var opcode = document.all.op_code.value;
		  var returnValue="-1";
			if(frm.phoneNo.value.length<11  )
			{
			     rdShowMessageDialog("请输入正确的服务号码！");
			     document.frm.phoneNo.focus();
			     return "-1";
	    }
 		    returnValue = window.showModalDialog('getCount.jsp?phoneNo='+document.frm.phoneNo.value,"",prop);
	  
			if(returnValue==null){
			 
					rdShowMessageDialog("没有找到对应的帐号！");
					document.frm.phoneNo.focus();
					return "-1";
			  }
			  if(returnValue=="")
			 {
					rdShowMessageDialog("你没有选择帐号！");
					document.frm.phoneNo.focus();
					return "-1";
			  }
		    document.frm.contractno.value = returnValue;   
 


		  	 returnValue=window.showModalDialog('getlast.jsp?phoneNo='+document.frm.phoneNo.value+'&contractno='+document.frm.contractno.value+'&yearmonth='+document.frm.yearmonth.value+'&op_code='+document.frm.op_code.value,"",prop);
	  
 			if( returnValue==null )
	    {
					 
					rdShowMessageDialog("查询失败，该号码今天未做业务！");

					document.all.contractno.value="";
					document.frm.phoneNo.focus();
					return "-1";
		  }
 			
			document.frm.water_number.value=returnValue;
			return "1";
}

function doreprint()
{
       if(document.frm.phoneNo.value=="")
  {
      rdShowMessageDialog("请输入服务号码!");
     	document.frm.phoneNo.focus();
     	return false;
  }
  

  if( document.frm.phoneNo.value.length != 11 )
  {
     rdShowMessageDialog("服务号码只能是11位!");
     document.frm.phoneNo.value = "";
     document.frm.phoneNo.focus();
     return false;
  }
   	if(parseFloat(document.frm.beginDate.value)<190001)
      	{
		    rdShowMessageDialog("帐务年月不能小于1900年！",0);
		    return;
	      }
    document.frm.action='printModual.jsp?phoneno='+document.frm.phoneNo.value+'&yearmonth='+document.frm.beginDate.value+'&workno='+document.frm.workno.value+'&org_code='+document.frm.org_code.value+'&moren=moren';
    document.frm.submit();
}

-->
 </script> 
 
<title>黑龙江BOSS-普通缴费</title>
</head>
<BODY>
<form action="" method="post" name="frm">
	
		<input type="hidden" name="workno"  value="<%=workno%>">
		<input type="hidden" name="org_code"  value="<%=org_code%>">
		
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">个人用户统一账单</div>
		</div>

  
  
  <table cellspacing="0">
    <tr> 
      <td class="blue" width="15%">服务号码</td>
      <td> 
        <input class="button"type="text" name="phoneNo" size="20" maxlength="11"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) check_HidPwd();">
       
      </td>
      <td class="blue">打印年月</td>
      <td> 
       	<input name="beginDate" type="text" v_format="yyyyMM"  class="input-write" value="<%=mon[1]%>" maxlength="6">
       
      </td>
    </tr>
  </table>
           
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="查询模板" onclick="findModual()" >
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="清除" onclick="doclear()" >
          &nbsp;
          <input type="button" name="reprint"  class="b_foot" value="默认模板" onclick="doreprint()">
          &nbsp;
		  <input type="button" name="return2" class="b_foot" value="关闭" onClick="this.window.close()" >
          &nbsp;
		  <input type="button" name="return3" class="b_foot" value="配置" onClick="javascript:window.location='/npage/s1351/queryDeModual.jsp'" >
       </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>