<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<HTML>
<HEAD>
<TITLE>�ⲿ����</TITLE>
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


<script type="text/javascript">
<!--

//-->
</script>

</HEAD>
<BODY>


<form  name="formbar" method="post">
    <div id="Operation_Table"> 
    <table width="90%" border="0" cellpadding="0" cellspacing="0" id=tb0>
      <tr>
         <td class="blue">�绰���룺</td>
         <td>
         	<input name ="callPhoneNum1" type="text" id="callPhoneNum1"  value="">
         </td>
      </tr>
      </table>

      
      <table width="90%"  border="0" cellpadding="0" cellspacing="0">
        <tr> 
    
          <td align="center"> 
            
            <span style="align:center">
            
            <input class="b_foot" name="button" type="button" value="����" onclick="outHelp()">
       		<input class="b_foot" name="back" type="button" onclick="closewin();" value="ȡ��"  >
       		</span>
          </td>
       </tr>  
     </table>
    </div>
   

</form>
</BODY>
</HTML>
 
<script>
<!--
  function closewin(){
   window.close();
  }
  
  function outHelp(){
  var temp1=document.getElementById("callPhoneNum1").value;
  if(temp1=='')
  {
 // alert("��ѡ��绰����");
 rdShowMessageDialog("��ѡ��绰����!",1);
  return false;
  }
  window.opener.cCcommonTool.TransOutEx(temp1,3);
  window.close();
  }  
  
  
//-->
</script>


