<%@page contentType="text/html;charset=GBK"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<HTML>
<HEAD>
<TITLE>����ϵͳ����</TITLE>
<META http-equiv=Content-Type content="text/html; charset=gb2312">

<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/block/jquery.blockUI.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/njs/si/validate_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>

<script type='text/javascript'	src='../js/ajaxXML.js'> </script>
</HEAD>
<%
  String endNum="80";//request.getParameter("endNum");
%>
<BODY>
<FORM  name=formbar>
<table width="100%" border="0" align="center"  cellpadding="0" cellspacing="0">
  <tr>
	<td valign="top">
    <div id="Operation_Table">
      <table id="dataTable" width="100%" border="0" cellpadding="0" cellspacing="0" id=tb0>
      <tr>
        <td class="blue">ѡ��</td>
        <td class="blue">����</td>
        <td class="blue">����</td>
        <td class="blue">BOSS����</td>
        <td class="blue">״̬</td>
        <td class="blue">����</td>
        <td class="blue">����</td>
        <td class="blue">�೤</td>
      </tr>
      <tr>
        <td class="blue"><input type="checkbox" name="" value=""/></td>
        <td class="blue">101</td>
        <td class="blue">ʡ����</td>
        <td class="blue">101</td>
        <td class="blue">����</td>
        <td class="blue">������</td>
        <td class="blue">ȫ��ͨ</td>
        <td class="blue">�೤</td>
      </tr> 
      <tr>
        <td class="blue"><input type="checkbox" name="" value=""/></td>
        <td class="blue">102</td>
        <td class="blue">ʡ����</td>
        <td class="blue">101</td>
        <td class="blue">����ͨ��</td>
        <td class="blue">̷�ɷ�</td>
        <td class="blue">VIP</td>
        <td class="blue">��ͨ��Ա</td>
      </tr>
      <tr>
        <td class="blue"><input type="checkbox" name="" value=""/></td>
        <td class="blue">103</td>
        <td class="blue">ʡ����</td>
        <td class="blue">103</td>
        <td class="blue">����</td>
        <td class="blue">С���</td>
        <td class="blue">ȫ��ͨ</td>
        <td class="blue">�೤</td>
      </tr>
      <tr>
        <td class="blue"><input type="checkbox" name="" value=""/></td>
        <td class="blue">104</td>
        <td class="blue">ʡ����</td>
        <td class="blue">104</td>
        <td class="blue">����</td>
        <td class="blue">���Գ�Ա</td>
        <td class="blue">ȫ��ͨ</td>
        <td class="blue">�೤</td>
      </tr>                       
      </table>
    </div>
    <br/>          
    </td>
  </tr>
</table>

</FORM>
</BODY>
</HTML>
<%--  
 <script>
   var url="<%=request.getContextPath() %>/npage/callbosspage/common/serverajaxProxy.jsp"
   var parurl="?url=/callpage/staffstatus/serverajaxStaffStatus.jsp";
   var pars="&endNum=<%=endNum%>&class_id=<%=StringUtils.defaultString(request.getParameter("class_id")) %>&org_id=<%=StringUtils.defaultString(request.getParameter("org_id")) %>&staffstatus=<%=StringUtils.defaultString(request.getParameter("staffstatus")) %>"   
   var ret=getXMLData(url+parurl+pars);
   alert(ret);
   
   fillDataTable(ret,document.getElementById("dataTable"))
   function fillDataTable(retData,tableid){
      alert("retData");
      for(var i=0;i<retData.length;i++){
        //������
        var tr=tableid.insertRow();
        tr.insertCell().innerHTML="<input type='checkbox' name='staff' onclick='signCall_no(this)' value='"+retData[i][0]+"'>"
        for(var j=0;j<7;j++){
          //���ӱ��
          tr.insertCell().innerHTML=retData[i][j]
        }
      }
   }
   function signCall_no(ob){
     var els=document.all("staff")
     for(var i=0;i<els.length;i++){
       if(els[i]!=ob){
        els[i].checked=false;
       }
     }
     if(ob.checked){
      parent.document.all("called_no").value=ob.value;
     }else{
      parent.document.all("called_no").value="";
     }
   }
   
 </script>
--%>


