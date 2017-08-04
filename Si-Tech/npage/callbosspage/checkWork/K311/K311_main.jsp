<%
  /*
   * 功能: 抽取条数定义
   * 版本: 1.0
   * 日期: 2009/8/21
   * 作者: luping
   * 版权: si-tech
  */
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	/*midify by guozw 20091114 公共查询服务替换*/
	String myParams="";
	
	String opCode = "K311";
	String opName = "抽取条数定义";
	request.setCharacterEncoding("GBK");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode=org_code.substring(0,2);
	String workNo = (String)session.getAttribute("workNo");
	
	String[][] result = new String[][] {};
	String nodeId = request.getParameter("nodeId");
	String sqlStr = "SELECT id,to_char(count),belonggroup,description FROM dserialNoCount ORDER BY id";
	
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="6">
	<wtc:param value="<%=sqlStr%>" />
</wtc:service>
<wtc:array id="queryList" start="0" length="5" scope="end" />
<%
result = queryList; 
//System.out.println(result.length);
%>
<html>
	<head>
		<title>抽取条数定义</title> 
		
	<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>

<script language="javascript">
	var prevclick = "";
	function tdop(){
		event.srcElement.style.color='red';
		if(prevclick != "" && prevclick != event.srcElement.id)
			document.all[""+prevclick].style.color = "#003399";
		prevclick = event.srcElement.id;				
	}
	
	function add_data(){
		var etime=new Date();
        var h=420;
        var w=500;
        var t=screen.availHeight/2-h/2;
        var l=screen.availWidth/2-w/2;
        var cssv = "dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:yes;location:no;status:yes;help:no";
        var retValue = "";
        retValue = window.showModalDialog("K311_update.jsp?op=add" ,"",cssv);
		if(typeof(retValue) != "undefined"){
			retValue = trim(retValue);
			if(retValue != ""){
				var arr = retValue.split("~");
				if(arr[0] == "000000"){
					var tr = document.all.ErrTable.insertRow();
					var td1 = tr.insertCell();
					var td2 = tr.insertCell();
					td1.id="tdata"+(arr[1]==""?"  ":arr[1]);
					td1.name=arr[2]==""?"  ":arr[2];
					td1.innerText = arr[2]==""?"  ":arr[2];

					
					td2.name = arr[3]==""?"  ":arr[3];
					td2.innerText = arr[3]==""?"  ":arr[3];
					td1.className = "blue";
					td2.className = "blue";
					tr.color="red";
					td1.style.cursor = "hand";
					td1.onclick = function(){
						tdop(this);
					}
					td1.onmouseover = function(){
						this.style.backgroundColor="#ececec";
					}
					td1.onmouseout = function(){
						this.style.backgroundColor="#F7F7F7";
					}
					document.form1.data_rows.value = parseInt(document.form1.data_rows.value) + 1;
				}
			}
		}        			
	}
	
	function mod_data(){
		
		if(prevclick.indexOf("tdata")==-1){
			similarMSNPop("请选择修改抽取条数！");
		}else{
			var id = trim(document.all[""+prevclick].id.substr(5));
			var count = trim(document.all[""+prevclick].name);
			var description = trim(document.all[""+prevclick].nextSibling.name);
			var param = "&id=" + id +
									"&count=" + count +
									"&description=" + description ;
									
	        var h=420;
	        var w=500;
	        var t=screen.availHeight/2-h/2;
	        var l=screen.availWidth/2-w/2;
	        var cssv = "dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:yes;location:no;status:yes;help:no";
	        var retValue = "";
	        retValue = window.showModalDialog("K311_update.jsp?op=update" + param ,"",cssv);
			if(typeof(retValue) != "undefined"){
				retValue = trim(retValue);
				if(retValue != ""){
					var arr = retValue.split("~");
					if(arr[0] == "000000"){
						document.all[""+prevclick].innerText = arr[2]==""?"  ":arr[2];
						document.all[""+prevclick].name = arr[2]==""?"  ":arr[2];
						document.all[""+prevclick].nextSibling.innerText = arr[3]==""?"  ":arr[3];
						document.all[""+prevclick].nextSibling.name = arr[3]==""?"  ":arr[3];
					}
				}
			}  
		} 				
	}
	
	function del_data(){
		if(prevclick.indexOf("tdata")==-1){
				similarMSNPop("请选择要删除的抽取条数！");
		}else{
				var myPacket = new AJAXPacket("K311I_AddMod.jsp","正在提交，请稍候......");
				myPacket.data.add("retType","delete");
				myPacket.data.add("id",trim(document.all[""+prevclick].id.substr(5)));
				core.ajax.sendPacket(myPacket,doProcess,true);
				myPacket=null;
		}		
}
	
	
	function doProcess(packet)
	{
		var retType = packet.data.findValueByName("retType");		
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");		
		
		if(retCode=='000000')
		{
			similarMSNPop("删除成功" + "[" + retCode + "]");
			for(var k=0;k<document.all["ErrTable"].firstChild.childNodes.length;k++){
				if(document.all["ErrTable"].firstChild.childNodes[k].firstChild.id == prevclick){
					document.all["ErrTable"].deleteRow(k);
				}
			}
			prevclick = "";
		}
		else{
			similarMSNPop("删除失败"+"[" + retCode + "]");	
		}
	}				
	
	function ltrim(s){
	 return s.replace( /^\s*/, ""); 
	} 
	function rtrim(s){
	 return s.replace( /\s*$/, ""); 
	} 
	function trim(s){
	 return rtrim(ltrim(s)); 
	}						
</script>
	</head>
	<body>
		<form name="form1" method="POST">
			<div id="Operation_Table" style="width: 100%;">
				<div class="title"><div id="title_zi"><div style="float:left">抽取条数定义</div>
					<div style="float:right">
						<!--input type="button" name="add" class="b_foot" value="新增" onclick="add_data()" disabled /-->
						<input type="button" name="mod" class="b_foot" value="修改" onclick="mod_data()"/>
						<!--input type="button" name="del" class="b_foot" value="删除" onclick="del_data()" disabled /-->
					</div>
					</div>
				</div>
				
				<table id="ErrTable" cellspacing="0">
					<tr>
						<th align="left" class="blue" width="5%" ><nobr> 抽取条数 </th>
						<th align="left" class="blue" width="5%" ><nobr> 备注 </th>
					</tr>
<%
	int i = 0;
	for(i=0;i<result.length;i++){	
%>
					<tr >
						
						<td id="tdata<%=result[i][0]%>" class="blue"  name="<%=result[i][1]%>" style="cursor:hand" onclick="tdop(this)" onmouseover="javascript:this.style.backgroundColor='#ececec';" onmouseout="javascript:this.style.backgroundColor='#F7F7F7'">
							<%=(result[i][1]==null||result[i][1].equals(""))?"&nbsp;&nbsp;":result[i][1]%>
						</td name="<%=result[i][3]%>">
						<td name="<%=result[i][3]%>" class="blue">	
							<%=(result[i][3]==null||result[i][3].equals(""))?"&nbsp;&nbsp;":result[i][3]%>
						</td>
					
					</tr>
<%
	}
%>
				</table>
				<input type="hidden" name="data_rows" value="<%=i%>"/>
			</div>
		</form>
	</body>
</html>
