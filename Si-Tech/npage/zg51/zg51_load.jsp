<%
/********************
 version v2.0
开发商: si-tech
*
*huangqi
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
		String opCode = "zg51";
		String opName = "测试卡限额设定";
		String orgCode     = (String)session.getAttribute("orgCode");
		String regionCode  = orgCode.substring(0,2);
		String workno      = (String)session.getAttribute("workNo");
		String workname    = (String)session.getAttribute("workName");
		String nopass      = (String)session.getAttribute("password");

		String[] inParam = new String[2];
		inParam[0]="select region_code,region_name from sregioncode order by region_code asc ";
		
%>
	<wtc:service name="TlsPubSelBoss"  outnum="2" >
		<wtc:param value="<%=inParam[0]%>"/> 
	</wtc:service>
	<wtc:array id="region_arr" scope="end" />
<HTML>
<HEAD>
<script language="JavaScript">
 function inits(){
 	
 }
 function docheck()
 {
	var phoneNo = document.getElementById("phone_no").value;
	if(phoneNo=="")
	{
		rdShowMessageDialog("请输入手机号码！");
		return false;
	}
	else
	{
		//document.frm.action="zg51_2.jsp?phoneNo="+phoneNo;
		//document.frm.submit();
		var checkPwd_Packet = new AJAXPacket("zg51_check.jsp","正在进行查询，请稍候......");
		checkPwd_Packet.data.add("phoneNo",phoneNo);
		core.ajax.sendPacket(checkPwd_Packet);
		checkPwd_Packet=null;
	}
 }
  
function doProcess(packet)
{
	var checkresult = packet.data.findValueByName("checkresult");
	var phoneNo = packet.data.findValueByName("phoneNo");

	if(checkresult=="Y")
	{		
		document.frm.action="zg51_2.jsp?phoneNo="+phoneNo;
		document.frm.submit();
	}
	else
	{
		alert("此号码不是测试卡号码，请重新输入!");
		return false;
	}
}	 
 


 
 
  function doclear() {
 		frm.reset();
 }

 function sel1()
 {
	window.location.href='zg51_1.jsp';
 }
 function sel2()
 {
	 window.location.href='zg51_load.jsp';
 } 
 
	function doUpload(){
		if(form.feefile.value.length<1)
		{rdShowMessageDialog("数据文件错误，请重新选择数据文件！");
			document.form.feefile.focus();
			return false;
		}
		else {
			document.form.action="zg51_4.jsp";
			document.form.submit();
			document.form.sure.disabled=true;
			document.form.reset.disabled=true;
			return true;
		}	
	}


-->
 </script> 
 
<title>黑龙江BOSS-普通缴费</title>
</head>
<BODY onload="inits()">
<form action="" method="post" name="form" ENCTYPE="multipart/form-data" >
		<%@ include file="/npage/include/header.jsp" %>  
			<table cellspacing="0">
        <tbody>
            <tr>
                <td class="blue" width="15%">操作方式</td>
                <td colspan="3">
                	<q vType="setNg35Attr">
                    <input name="busyType1" type="radio" onClick="sel1()" value="1" size="20">
                    手机号单条查询
                    </q>
                    <q vType="setNg35Attr">
                    <input name="busyType2" type="radio" onClick="sel2()" value="2" checked>
                    手机号批量导入
                    </q>
                     
                </td>
            </tr>
        </tbody>
    </table>
    
     
  	<div class="title">
			<div id="title_zi">批量导入</div>
		</div>
	<table cellspacing="0">  
	<tr > 
      <td class="blue">请导入文件： </td>
     	<td> 
			  <input type="file" name="feefile" class="button">
		  </td>      
  </tr>
  </table>
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
        <input class="button" name=sure type=button value=确认 onClick="doUpload()">
        <input class="button" name=reset type=reset value=关闭 onClick="window.close()">
          &nbsp;
         
      </td>
    </tr>
    
     <tr > 
                <td colspan="2">说明：<br>
                  &nbsp;&nbsp;&nbsp;1、数据文件的类型为：txt文本。<br>
                  &nbsp;&nbsp;&nbsp;2、数据文件的内容格式为：<br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号码(11位)|流量上限(单位：G)|金额上限(单位：元)；单位不用填写；中间用符号"|"分隔，<br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;如： <br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13512345679|5|30<br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13512345680|2|10<br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13512345681|10|40</td>
     </tr>
              
              
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>