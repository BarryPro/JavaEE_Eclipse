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
<%@ page import="java.text.*" %> 
<%@ page import="java.util.*" %>
<%
String opCode = "zg23";
String opName = "增值税专票开具申请";
String workno = (String)session.getAttribute("workNo");
String contextPath = request.getContextPath();
 

%> 
<HTML>
<HEAD>
<script language="JavaScript">
function docheck()
{
	var phone_no = document.frm.phone_no.value;
	if(phone_no=="")
	{
		rdShowMessageDialog("请输入手机号码!");
	}
	else
	{
		var checkPwd_Packet = new AJAXPacket("../zg12/zg12_check.jsp","正在进行查询，请稍候......");
		checkPwd_Packet.data.add("phone_no",phone_no);
		checkPwd_Packet.data.add("flag","1");//按手机号码查询
		core.ajax.sendPacket(checkPwd_Packet);
		checkPwd_Packet=null;
	}
	
} 

	
function doProcess(packet)
{
	var s_zf = packet.data.findValueByName("s_zf"); 
	var s_tax_no = packet.data.findValueByName("s_tax_no"); 
	var s_qry_flag= packet.data.findValueByName("s_qry_flag"); 
	var s_contract_no = packet.data.findValueByName("s_contract_no");
	var s_contract_name= packet.data.findValueByName("s_contract_name");
	var s_flag = packet.data.findValueByName("s_flag");
	var s_flag_new="";//N代表用新接口查询总分的 O用老接口无总分
	var s_zf_flag="";//判断查询的是总的 还是分的 Y D N
	var oCustId = packet.data.findValueByName("oCustId");
	//alert("s_flag is "+s_flag+" and oCustId is "+oCustId+" and s_qry_flag is "+s_qry_flag+" and s_tax_no is "+s_tax_no);
	//alert("s_zf is "+s_zf);
	if(s_flag=="Y")
	{
		if(s_zf=="Y")//有上层 目前是分支关系
		{
			 var	prtFlag = rdShowConfirmDialog("用户存在总分关系,目前是分支,是否进入总机构选择?");
			 if (prtFlag==1)
			 {
			 		//选择 调用新接口
			 		//alert("调用新接口进行选择!");
			 		s_flag_new="N";//new
			 		
			 }
			 else
			 {
			 		s_flag_new="O";//调用老的借口
			 }	
	
		}
		else if(s_zf=="D")//有分支 目前是总的
		{
			 var	prtFlag = rdShowConfirmDialog("用户存在总分关系,目前是总机构,是否进入分支选择?");
			 if (prtFlag==1)
			 {
			 		//选择 调用新接口
			 		//alert("调用新接口进行选择!");
			 		s_flag_new="N";//new
			 		
			 }
			 else
			 {
			 		s_flag_new="O";//调用老的借口
			 }
		}
		else//肯定是N了 跟zhouwy确认下 是否有s_flag_new!="N"的情况?测试号码 20210058797
		{
			//alert("s_flag_new is "+s_flag_new);
			/*
			if(s_flag_new!="N")
			{
				alert("应该报错了！！");
			}
			else
			{
				s_flag_new="O";
			}*/
			s_flag_new="O";
		}	
		if(s_flag_new=="O")
		{
			var h=480;
			var w=650;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
			//alert("1");
			//1.查询cust_id 让用户去选
			returnValue = window.showModalDialog('../zg12/getContractByCustId.jsp?cust_id='+oCustId+"&tax_no="+s_tax_no+"&qry_flag=1","",prop);
			//alert(returnValue);
			document.frm.tax_contract_no.value=returnValue.split(",")[6];
			document.frm.tax_name.value=returnValue.split(",")[2];
			document.frm.tax_no1.value=returnValue.split(",")[1];
			document.frm.tax_address.value=returnValue.split(",")[3];
			document.frm.tax_phone.value=returnValue.split(",")[4];
			document.frm.tax_khh.value=returnValue.split(",")[5];
			//2.根据cust_Id 让cust_id去选手机号码
			returnValue = window.showModalDialog('../zg12/getCount.jsp?cust_id='+oCustId,"",prop);
			//alert("2?phone_no="+returnValue);
			document.frm.action="zg23_2.jsp?s_flag=0&phone_no="+returnValue;
			//alert("test?"+document.frm.action);
			document.frm.submit();
		}
		else//通过新增的getByLevel.jsp去选择
		{
				var h=480;
				var w=650;
				var t=screen.availHeight/2-h/2;
				var l=screen.availWidth/2-w/2;
				var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
				//alert("1");
				//1.查询cust_id 让用户去选
				returnValue = window.showModalDialog('../zg12/getByLevel.jsp?cust_id='+oCustId+"&qry_flag="+s_zf,"",prop);
				document.frm.tax_contract_no.value=returnValue.split(",")[6];
				document.frm.tax_name.value=returnValue.split(",")[2];
				document.frm.tax_no1.value=returnValue.split(",")[1];
				document.frm.tax_address.value=returnValue.split(",")[3];
				document.frm.tax_phone.value=returnValue.split(",")[4];
				document.frm.tax_khh.value=returnValue.split(",")[5];
				//2.根据cust_Id 让cust_id去选手机号码
				returnValue = window.showModalDialog('../zg12/getCount.jsp?cust_id='+oCustId,"",prop);
				//alert("2?phone_no="+returnValue);
				document.frm.action="zg23_2.jsp?s_flag=0&phone_no="+returnValue;
				//alert("test?"+document.frm.action);
				document.frm.submit();
		}
	}
	else
	{
			alert("税务登记号码不存在，请重新输入!");
			return false;
	}	
	
}

 
 
  function doclear() {
 		frm.reset();
 }


 function inits()
 {
	 //document.getElementById("query_id").disabled=true;
	
 }
 function sel1()
 {
	window.location.href='zg23_1.jsp';
 }
 function sel2()
 {
	 window.location.href='zg23_tax.jsp';
 }
 function sel3()
 {
	 window.location.href='zg23_3172.jsp';
 }
 </script> 
 
<title>黑龙江BOSS-普通缴费</title>
</head>
<BODY onload="inits()">
<form action="" method="post" name="frm">
		
		<%@ include file="/npage/include/header.jsp" %>   
  	 
	<table cellspacing="0">
    <div class="title">
        <div id="title_zi">请选择查询方式</div>
    </div>
	
	<table cellspacing="0">
        <tbody>
            <tr>
                <td class="blue" width="15%">查询方式</td>
                <td colspan="3">
                	<q vType="setNg35Attr">
                    <input name="busyType1" type="radio" onClick="sel1()" value="1" checked>
                    按手机号码查询
                    </q>
                    <q vType="setNg35Attr">
                    <input name="busyType2" type="radio" onClick="sel2()" value="2">
                    按纳税人识别号码查询
                    </q>
					<q vType="setNg35Attr">
                    <input name="busyType3" type="radio" onClick="sel3()" value="3">
                    一点支付专票开具
                    </q>
                     
                </td>
            </tr>
        </tbody>
    </table>

	 
  <table cellSpacing="0">	 
	 <tr>
		<td class="blue" width="15%">手机号码</td>
		 
		<td colspan="3">
			<input type="text" name="phone_no" maxlength=11  onKeyPress="return isKeyNumberdot(0)" >
		</td>
	 </tr>
<input type="hidden" name="tax_contract_no">
<input type="hidden" name="tax_name">
<input type="hidden" name="tax_no1">
<input type="hidden" name="tax_address">
<input type="hidden" name="tax_phone">
<input type="hidden" name="tax_khh">
  </table>
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
	  <input type="button" id="query_id" name="query" class="b_foot" value="查询" onclick="docheck()" >
          &nbsp;
		    <input type="button" name="return1" class="b_foot" value="清除" onclick="doclear()" >
          &nbsp;
		      <input type="button" name="return2" class="b_foot" value="关闭" onClick="removeCurrentTab()" >
	  <!--
	  <input type="button" id="test" name="test" class="b_foot" value="测试展示pay_note" onclick="do_paynote()" >
	  <input type="button" id="query_id" name="export" class="b_foot" value="javabeantest" onclick="doTest()" >
		   <input type="button" id="query_id" name="export" class="b_foot" value="导出" onclick="doExport()" >	
		   <input type="button" id="imp_id" name="import" class="b_foot" value="导入" onclick="doImport()" >	
           <input type="button" id="query_id" name="query" class="b_foot" value="查询" onclick="docheck()" >
          &nbsp;
		    <input type="button" name="return1" class="b_foot" value="清除" onclick="doclear()" >
          &nbsp;
		      <input type="button" name="return2" class="b_foot" value="关闭" onClick="removeCurrentTab()" >
			  -->
      </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>