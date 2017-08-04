<%
/********************
 version v2.0
开发商: si-tech
*
*update:jiangjian@2011-11-07 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%

    boolean flag1 = false;
    String operCode=request.getParameter("flag1");
	String offer_id = "";
	if(operCode==null)
	{
	  flag1 = false;
	}
	else
	{
	  flag1 = true;
	  offer_id=request.getParameter("offer_id");
	}
    String opCode = "g508";
	String opName = "选择入网小区权限配置";
	String workno = (String)session.getAttribute("workNo");
	String workname = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String region_code1 = org_code.substring(0,2);		
	String flag = request.getParameter("flag");
	String flag2 = request.getParameter("flag2");
	
	 /* 取操作流水 */
    String sysAccept = request.getParameter("sysAccept");
    System.out.println("return           - 流水："+sysAccept);
    System.out.println("---------------------------------------------------------");

    if(sysAccept == null || sysAccept.equals("") )
    {
	    %>
	        <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=region_code1%>"  id="seq"/>
	    <%
    	sysAccept = seq;
    }
    System.out.println("#           - 流水："+sysAccept);
    System.out.println("######################################################################");
 
%>
<HTML>
<HEAD>
<script language="JavaScript">
<!--	

function goto()
{
  window.open(url);
}
function check()
{
	document.all.check1.disabled=true;
	frm.action="g508_5.jsp?sysAccept="+"<%=sysAccept%>";
	frm.submit();
}
function audit()
{
	document.all.audit1.disabled=true;
	frm.action="g508_4.jsp?sysAccept="+"<%=sysAccept%>";
	frm.submit();
}
function upload()
{
	var uploadfile = document.all.vpmnPosFile.value;
	if(uploadfile == "")
	{
		rdShowMessageDialog("请选择文件！",0);
		return false;
	}
	else{
        var uploadfile = document.all.vpmnPosFile.value;
    	var ext = "*.txt";
    	var file_name = uploadfile.substr(uploadfile.lastIndexOf(".")); 
    	if(ext.indexOf("*"+file_name)==-1){   
            rdShowMessageDialog("程序只支持txt格式文件(*.txt)！",0);  
            return false;  
        }
	}
	document.all.audit1.disabled=false;
	frm.action="g508_upload.jsp?sysAccept="+"<%=sysAccept%>";	
	frm.submit();
}
function load(){
	if("<%=flag%>"=="1")
	{
		document.all.audit1.disabled=false;
	}
	if("<%=flag2%>"=="1")
	{
		document.all.check1.disabled=false;
	}
}
function sel1() {	 
	window.location.href='g508_1.jsp';
}
function sel2(){
	window.location.href='g508_3.jsp';
}
 
-->
	   
 </script> 
<title>黑龙江BOSS-普通缴费</title>
</head>
<body leftmargin="2" topmargin="2" marginwidth="0" marginheight="0" onload="load()">
<form action="" method="post" name="frm" ENCTYPE="multipart/form-data"> 
	<input type="hidden" name="flag1" value=1>
	<%@ include file="/npage/include/header.jsp" %>  
  
  <div class="title">
			<div id="title_zi">选择入网小区权限配置</div>
  </div>
  <table cellspacing="0">
    <tr>
    	<td class="blue" width="15%">配置方式</td>
        <td> 
          <input name="busyType2" type="radio" onClick="sel1()" value="1" >offer_id配置 
          <input name="busyType2" type="radio" onClick="sel2()" value="1" checked>批量配置
      </td>
      
    </tr>
  </table>
 <div class="title">
	<div id="title_zi"></div>
</div>
<table cellspacing=0>
    <TR>
        <TD align="left" class=blue width=18%>录入文件</TD>	   
        <TD colspan='3'> 
            <input type="file" name="vpmnPosFile" id="vpmnPosFile" class="button" style='border-style:solid;border-color:#7F9DB9;border-width:1px;font-size:12px;' />
        </TD>
    </TR>
    <tr>
        <td colspan="6"> 
            &nbsp;&nbsp;文件格式说明<br>
            &nbsp;&nbsp; 上传文件文本格式为，示例如下：<br>
            &nbsp;&nbsp; 5位offer_id 2为地市代码 4位rate_code 4位flag_code 小于10位group_id: 19084|01|a4aK|a4aK|11111
            <br>
            &nbsp;&nbsp; 
            <b>
            <br>&nbsp;&nbsp; 注：格式中的每一项均不允许存在空格,且每一项必须以"|"（竖线）为间隔符。文件中不允许存在空行，每次最多200条。
            </b> 
        </td>
    </tr>
</table>

<table cellSpacing="0">
    <tr> 
      <td id="footer"> 
          <input type="button" id="upload1" name="upload1" class="b_foot" onclick="upload()" value="上传"  >
          &nbsp;
          <input type="button" id="audit1" name="audit1" class="b_foot" onclick="audit()" value="校验" disabled>
           &nbsp;
          <input type="button" id="check1" name="check1" class="b_foot" onclick="check()" value="配置" disabled>

       </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>


</body>
</HTML>