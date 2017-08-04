<%@page contentType="text/html;charset=GB2312"%>
<%@ include file="callinclude.jsp"%>
<script type='text/javascript'
	src='../js/ajaxXML.js'> </script>
<HTML>
	<HEAD>
		<TITLE>New Document</TITLE>

	</HEAD>
	<script type='text/javascript'src='../js/ajaxXML.js'> </script>
	<BODY>
		<form name="form1">
			<select name="t_wf_dcasemsg.accept_type" condition="" textField="CALL_CAUSE_ID" valueField="FULL_NAME" tableName="scallcausecfg" iniValue="2"
				onchange="">
				<option value="">«Î—°‘Ò...</option>
			</select>
			<input type="button" value="œ¬¿≠" onclick="iniSel(document.all('t_wf_dcasemsg.accept_type'))">
			
		</form>
	</BODY>
</HTML>
<script>

iniSel(document.all("t_wf_dcasemsg.accept_type"));
/*
function iniSel(selectob){
     var pars="&textField="+selectob.textField+"&valueField="+selectob.valueField+"&tableName="+selectob.tableName+"&condition="+selectob.condition+"&selctName="+selectob.name
     var ret=getXMLData('/sitechcallcenter/npage/callbosspage/common/serverajaxProxy.jsp?url=/callpage/common/serverajaxCodeInfo.jsp'+pars);
     //alert(ret);
     if(ret!=null){
	     for(var i=0;i<ret.length;i++){
	       var toption = new Option(ret[i][1], ret[i][0]);
	       selectob.options.add(toption);
	       inivalue=selectob.getAttribute("iniValue");
	       if(inivalue!=null&&inivalue!=''){
  		     if(ret[i][0]==inivalue){
  		      selected=i+1;
  		     }
  	       }
	     }
	 }    
}
*/
</script>

