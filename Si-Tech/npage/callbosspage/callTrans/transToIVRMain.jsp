


<HTML>
<HEAD>
<TITLE>转自动服务</TITLE>
<OBJECT id='locator' classid=CLSID:76A64158-CB41-11D1-8B02-00600806D9B6 VIEWASTEXT></OBJECT>
<OBJECT id='varMacObject' classid=CLSID:75718C9A-F029-11d1-A1AC-00C04FB6C223></OBJECT>
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
function transToIVR(){
	var ret = window.opener.cCcommonTool.TransToIVR(0, 3, 105);
	if(ret == 0){
		//add by fangyuan 增加操作成功后的状态与按钮明暗控制
       window.opener.buttonType("K029");
	     window.opener.cCcommonTool.setOp_code("K029");
	}
}
//-->
</script>

</HEAD>
<BODY>


<form  name="formbar" method="post">

<div id="Main">
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
	<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">
	<div id="Operation_Title"><B><font face="Arial"></font>呼叫转移</B></div>
    <div id="Operation_Table">
    <div class="title">转自动服务</div>  
    <table width="100%" border="0" cellpadding="0" cellspacing="0" id=tb0>
      <tr>
         <td class="blue">地市</td>
         <td>
         	<select id="org_id">
         	 <option>--全部--</option>
         	</select>
         </td>
        <td class="blue">班组</td>
        <td> 
            <select id="org_id">
             <option>--全部--</option>
            </select>
        </td>
        <td class="blue">状态</td>
        <td> 
            <select id="staffstatus">
             <option>--全部--</option>
            </select>
        </td>
        <td class="blue">刷新间隔时间</td>
        <td> 
        <input name="flashTime" maxlength=8 index="27"  v_must=1 v_maxlength=8 v_type="integer" size="8">秒<font class="orange">*</font>
        </td>
        <td class="blue">显示行数</td>
        <td> 
        <input name="endNum" maxlength=8 index="27"  v_must=1 v_maxlength=8 v_type="date" size="8"><font class="orange">*</font>
        </td>
      </tr>
      </table>
      <table id="dataTable" width="100%" border="0" cellpadding="0" cellspacing="0" id=tb0>
      <tr>
       <iframe id="frameright" name="frameright" scrolling=auto src="transToIVRList.jsp" width=100%height=100% frameBorder=0 marginheight=0 marginwidth=0></iframe>
      </tr>
      </table>
      
      <table width="100%"  border="0" cellpadding="0" cellspacing="0">
        <tr> 
    
          <td align="right"> 
            <span style="align:left">
            <input name="called_no" size="8"><font class="orange">*</font>
            </span>
            <span style="align:right">
            <input class="b_foot" name="button" type="button" value="刷新" onclick="statusRefresh();return false;">
            <input class="b_foot" name="button" type="button" value="呼叫" onclick="transToIVR()">
       		<input class="b_foot" name="back" type="button" onclick="" value="取消"  >
       		</span>
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
</div>

</form>
</BODY>
</HTML>
 
<script>
<!--
  function statusRefresh(){
    document.formbar.action="callinnerList.jsp"
    document.formbar.target="frameright";
    document.formbar.submit();
  }
  
  function internalHelp(){
    window.opener.cCcommonTool.InternalHelpEx(0, 105, 1);
  }  
  
  
//-->
</script>


