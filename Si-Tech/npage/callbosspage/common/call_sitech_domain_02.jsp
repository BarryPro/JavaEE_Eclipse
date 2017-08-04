<%@page contentType="text/html;charset=GB2312"%>
<%@include file=callinclude.jsp"%>
<HTML>
	<HEAD>
		<TITLE>New Document</TITLE>

	</HEAD>
	
<script type='text/javascript'
	src='<%=dwrUrl %>/interface/logService.js'></script>
<script type='text/javascript'
	src='<%=dwrUrl %>/engine.js'></script>
<script type='text/javascript'
	src='<%=dwrUrl %>/util.js'> </script>
	<script type='text/javascript'
	src='../js/ajaxService.js'> </script>
	
	<script type='text/javascript'
	src='<%=request.getContextPath() %>/dwr/interface/commonService.js'></script>
	<BODY>
		<form name="form1">
			同步： <input type='text' name="dwrValue" value="">
			<input type="button" value="dwr" onclick="getLogOne()">
			<input type="button" value="dwr_obj" onclick="getObj()">
			<input type="button" value="dwr_value" onclick="alert(v_data)">
			<input type="button" value="插入日志" onclick="addLog();">
		</form>
	</BODY>
</HTML>
<script>
function getLogOne(){
  ajaxService.executeRemoteService(logService,"getOne",null,"<%=dwrUrl%>");
}

function getObj(){
dwr.engine.setActiveReverseAjax(true);
dwr.engine.setRpcType(dwr.engine.ScriptTag);
  // DWREngine.setMethod(dwr.engine.ScriptTag); 
  logService._path = "http://10.204.16.104:7001/sitechcallcenter/dwr"
  var vo={}
  vo.contact_id="ddddd";
  vo.contact_accept="aaaaa";
  dwr.engine.setAsync(false);
  logService.getObjct(vo,function(_item){vo=_item;alert(vo.contact_id)});
  alert(vo.contact_id);
  dwr.engine.setAsync(true); 
}
function addLog(){
 var ajaxService=new AJAXService();
 var vo={}
 vo.op_code="testop";
 vo.login_no="test_login";
 vo.ip_adr='<%=request.getRemoteAddr()  %>'
 //ajaxService.executeLocalService(commonService,"saveLog",vo,true);
 ajaxService.executeLocalLog("testop1","test_login1",'<%=request.getRemoteAddr()  %>','');
 //ajaxService=null;
}
</script>
