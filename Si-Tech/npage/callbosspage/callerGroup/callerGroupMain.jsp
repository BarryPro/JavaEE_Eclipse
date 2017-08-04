<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,java.util.*,java.io.OutputStream,com.sitech.boss.util.excel.*,java.text.SimpleDateFormat"%>
<html>
<head>
<title>外呼班组对应关系</title>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">

<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/block/jquery.blockUI.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/njs/si/validate_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>

</head>
<%
	/*zengzq 修改服务 改为绑定变量 20091114 start*/
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0,2);
  /*zengzq 修改服务 改为绑定变量 20091114 end*/
%>
<body>


<form name="formbar" method="post" action="insertList.jsp" target="frameright">
<div id="Main">
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
	<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">
	<div id="Operation_Title"><B><font face="Arial"></font>外呼班组对应关系</B></div>
    <div id="Operation_Table">
    <div class="title">外呼班组对应关系</div>  
    <table width="100%" border="0" cellpadding="0" cellspacing="0" id=tb0>
      
  	<td class="blue" > 呼出号码 </td>
      <td >
			  <input name ="phone" type="text" id="phone" size='22' maxlength='20'>
		  </td> 
		  
         <td class="blue">班组</td>
         <td>
         	<select id="class_id" name="class_id"">
         	 <option value="">--请选择--</option>
          <wtc:qoption name="TlsPubSelCrm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
				    <wtc:sql>SELECT class_id,class_id||'-->'||class_name FROM scallclass ORDER BY class_id</wtc:sql>
				  </wtc:qoption>
         	</select>
         </td>
         
    <td class="blue" > 地市 </td>
      <td >
			 <select id="Region_Code" name="Region_Code" size="1" >
      	<option value="" >--所有地市--</option>
				    <wtc:qoption name="TlsPubSelCrm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
				    <wtc:sql>select Region_Code , region_code|| '-->' ||region_name from scallregioncode where valid_flag = 'Y'order by region_code</wtc:sql>
				  </wtc:qoption>
        </select>
      </td>
      </tr>
		  <tr>
        <td class="blue" >备注</td>
        <td colspan = '5'> 
        <input name="note"  id="note" type="text" size='52' maxlength='50' >
        </td>  
      </tr>
      		  <tr>
        <td class="blue" >号码类型</td>
        <td colspan = '5'> 
			 <select id="outflag" name="outflag" size="1" >
        <option value="N" >-- 呼入号码 --</option>			 	
      	<option value="Y" >-- 呼出号码 --</option>
        </select>
        </td>  
      </tr>
     </table>
  
    </div>
    <br/>          
    </td>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="RightFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerRight.jpg" width="20" height="45" /></td>
  </tr>
        
  <tr>
    <td><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeftDown.gif" width="20" height="20" /></td>
    <td valign="bottom">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#D8D8D8">
      <tr>
        <td height="1"></td>
      </tr>
    </table>
    </td>
    <td><img src="<%=request.getContextPath()%>/nresources/default/images/CornerRightDown.gif" width="20" height="20" /></td>
  </tr>
</table>
      <table width="100%"  border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td align="center"> 
            <span style="align:center">
            <input class="b_foot" name="btn_internalcall" type="button" value="提交" onclick="submitInputCheck()">
       		<input class="b_foot" name="back" type="button" onclick="window.close();" value="取消">
       		</span>
          </td>
        </tr>  
      </table>

</div>
</form>
</body>
</html>

<script>

//数据插入
	function callSwich()
	{
		
	    var packet = new AJAXPacket("../../../npage/callbosspage/callerGroup/callGroupInsert.jsp","正在处理,请稍后...");

	    packet.data.add("phone",window.formbar.phone.value);
	    packet.data.add("Classid",window.formbar.class_id.value);
	    packet.data.add("note",window.formbar.note.value);
	    packet.data.add("Region_Code",window.formbar.Region_Code.value);
	    packet.data.add("outflag",window.formbar.outflag.value);
	    core.ajax.sendPacket(packet,doProcessNavcomring,false);
			packet =null;
	}  
  //公共处理回调
function doProcessNavcomring(packet)	 
	 {
	    var retCode = packet.data.findValueByName("retCode"); 
	    var retMsg = packet.data.findValueByName("retMsg"); 
	    	if(retCode=="000000"){
	    		rdShowMessageDialog("处理成功!",'2');
	    		window.formbar.action="list.jsp";
         window.formbar.method='post';
          document.formbar.submit();
          window.close();
	    	}else{
	    		rdShowMessageDialog("处理失败!");
	    		return false;
	    	}
	 }
	 
function submitInputCheck(){
   if( document.formbar.phone.value == ""){
    	   showTip(document.formbar.phone,"呼出号码不能为空"); 
    	   formbar.phone.focus(); 	
    	 return false;
    }
    if(isNaN(document.formbar.phone.value)){
    		showTip(document.formbar.phone,"呼出号码只能是数字"); 
    	   formbar.phone.focus(); 	
    	   return false;
    	}
     if(document.formbar.class_id.value == ""){
		     showTip(document.formbar.class_id,"请选择班组"); 
    	   formbar.class_id.focus(); 	
    	   return false;
    }


callSwich();
    	
}
</script>




