<%
/********************
 version v2.0
������: si-tech
*
*update:jiangjian@2011-11-07 ҳ�����,�޸���ʽ
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
	String opName = "ѡ������С��Ȩ������";
	String workno = (String)session.getAttribute("workNo");
	String workname = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String region_code1 = org_code.substring(0,2);		
	String flag = request.getParameter("flag");
	String flag2 = request.getParameter("flag2");
	
	 /* ȡ������ˮ */
    String sysAccept = request.getParameter("sysAccept");
    System.out.println("return           - ��ˮ��"+sysAccept);
    System.out.println("---------------------------------------------------------");

    if(sysAccept == null || sysAccept.equals("") )
    {
	    %>
	        <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=region_code1%>"  id="seq"/>
	    <%
    	sysAccept = seq;
    }
    System.out.println("#           - ��ˮ��"+sysAccept);
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
		rdShowMessageDialog("��ѡ���ļ���",0);
		return false;
	}
	else{
        var uploadfile = document.all.vpmnPosFile.value;
    	var ext = "*.txt";
    	var file_name = uploadfile.substr(uploadfile.lastIndexOf(".")); 
    	if(ext.indexOf("*"+file_name)==-1){   
            rdShowMessageDialog("����ֻ֧��txt��ʽ�ļ�(*.txt)��",0);  
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
<title>������BOSS-��ͨ�ɷ�</title>
</head>
<body leftmargin="2" topmargin="2" marginwidth="0" marginheight="0" onload="load()">
<form action="" method="post" name="frm" ENCTYPE="multipart/form-data"> 
	<input type="hidden" name="flag1" value=1>
	<%@ include file="/npage/include/header.jsp" %>  
  
  <div class="title">
			<div id="title_zi">ѡ������С��Ȩ������</div>
  </div>
  <table cellspacing="0">
    <tr>
    	<td class="blue" width="15%">���÷�ʽ</td>
        <td> 
          <input name="busyType2" type="radio" onClick="sel1()" value="1" >offer_id���� 
          <input name="busyType2" type="radio" onClick="sel2()" value="1" checked>��������
      </td>
      
    </tr>
  </table>
 <div class="title">
	<div id="title_zi"></div>
</div>
<table cellspacing=0>
    <TR>
        <TD align="left" class=blue width=18%>¼���ļ�</TD>	   
        <TD colspan='3'> 
            <input type="file" name="vpmnPosFile" id="vpmnPosFile" class="button" style='border-style:solid;border-color:#7F9DB9;border-width:1px;font-size:12px;' />
        </TD>
    </TR>
    <tr>
        <td colspan="6"> 
            &nbsp;&nbsp;�ļ���ʽ˵��<br>
            &nbsp;&nbsp; �ϴ��ļ��ı���ʽΪ��ʾ�����£�<br>
            &nbsp;&nbsp; 5λoffer_id 2Ϊ���д��� 4λrate_code 4λflag_code С��10λgroup_id: 19084|01|a4aK|a4aK|11111
            <br>
            &nbsp;&nbsp; 
            <b>
            <br>&nbsp;&nbsp; ע����ʽ�е�ÿһ�����������ڿո�,��ÿһ�������"|"�����ߣ�Ϊ��������ļ��в�������ڿ��У�ÿ�����200����
            </b> 
        </td>
    </tr>
</table>

<table cellSpacing="0">
    <tr> 
      <td id="footer"> 
          <input type="button" id="upload1" name="upload1" class="b_foot" onclick="upload()" value="�ϴ�"  >
          &nbsp;
          <input type="button" id="audit1" name="audit1" class="b_foot" onclick="audit()" value="У��" disabled>
           &nbsp;
          <input type="button" id="check1" name="check1" class="b_foot" onclick="check()" value="����" disabled>

       </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>


</body>
</HTML>