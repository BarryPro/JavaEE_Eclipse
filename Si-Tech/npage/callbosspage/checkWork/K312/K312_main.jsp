<%
  /*
   * 功能: 接触日期定义
   * 版本: 1.0
   * 日期: 2009/8/21
   * 作者: luping
   * 版权: si-tech
  */
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = "K312";
	String opName = "接触日期定义";
  request.setCharacterEncoding("gb2312");
  String myParams="";
  String org_code = (String)session.getAttribute("orgCode");
  String regionCode=org_code.substring(0,2);
  String workNo = (String)session.getAttribute("workNo");

  String[][] result = new String[][] {};
	String nodeId = request.getParameter("nodeId");
	String sqlStr = "SELECT id,to_char(mindate),to_char(maxdate),to_char(getcount),description,dateflag,decode(dateflag,'0','上月','1','本月') FROM dserialnodate "
	+ " ORDER BY mindate";
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="8">
	<wtc:param value="<%=sqlStr%>" />
</wtc:service>
<wtc:array id="queryList" start="0" length="7" scope="end" />
<%
	result = queryList; 
%>

<%
		//zengzq add 090907  获取日期
		/*DateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		Date nowDate = new Date();
		String   preLastDate = "";   
		String   nowLastDate = "";   
		//获取上一月份最后一天日期
		Calendar   ca   =   Calendar.getInstance();   
		ca.setTime(nowDate);   //   someDate   为你要获取的那个月的时间   
		ca.set(Calendar.DAY_OF_MONTH,   1);   
		ca.add(Calendar.DAY_OF_MONTH,   -1);   
		Date   lastDate   =   ca.getTime(); 
		preLastDate = formatter.format(lastDate);
   
		//获取当前月份最后一天日期
		ca.setTime(nowDate);   //   someDate   为你要获取的那个月的时间   
		ca.set(Calendar.DAY_OF_MONTH,   1);  
		Date   firstDate   =   ca.getTime();  
		ca.add(Calendar.MONTH,   1);   
		ca.add(Calendar.DAY_OF_MONTH,   -1);   
		lastDate   =   ca.getTime(); 
		nowLastDate = formatter.format(lastDate);
		*/
%>
<html>
	<head>
		<title>接触日期定义</title> 
		
	<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
	
		<script language="javascript">
			var prevclick = "";
			function tdop(){
				event.srcElement.style.color='red';
				if(prevclick != "" && prevclick != event.srcElement.id)
					document.all[""+prevclick].style.color = "#003399";
				prevclick = event.srcElement.id;
			}
			
			function numCheck(opType){
					var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K312/K312_getCount.jsp","正在进行取值，请稍候......");
					mypacket.data.add("opType",opType);
					core.ajax.sendPacket(mypacket,doProcess_value,true);
					mypacket=null;
			}
			function doProcess_value(packet){
				var opType = packet.data.findValueByName("opType");
				var getCountResult = packet.data.findValueByName("getCountResult");
				var getTCResult = packet.data.findValueByName("getTCResult");
				if("add"==opType){
					add_data(getCountResult,getTCResult);
				}
				if("mod"==opType){
					mod_data(getCountResult,getTCResult);
				}
			}
			
			function add_data(getCountResult,getTCResult){
				var etime=new Date();
				//抽取条数设置的条数
				var getCountResult = getCountResult;
				var getTCResult = getTCResult;
				if(parseInt(getTCResult)>=parseInt(getCountResult)){
							similarMSNPop("设置的总条数不能超过抽取条数中设置的条数！");
							return;
				}
						//updated by tangsong 20100825 安徽样式下，原窗口有滚动条，去除滚动条
		        //var h=420;
		        var h=450;
		        var w=500;
		        var t=screen.availHeight/2-h/2;
		        var l=screen.availWidth/2-w/2;
		        var cssv = "dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:yes;location:no;status:yes;help:no";
		        var retValue = "";
		        retValue = window.showModalDialog("K312_update.jsp?op=add&getCountResult="+getCountResult+"&getTCResult="+getTCResult ,"",cssv);
				if(typeof(retValue) != "undefined"){
					retValue = trim(retValue);
					if(retValue != ""){
						var arr = retValue.split("~");
						if(arr[0] == "000000"){
							var tr = document.all.ErrTable.insertRow();
						
							var td1 = tr.insertCell();
							var td2 = tr.insertCell();
							var td3 = tr.insertCell();
							var td4 = tr.insertCell();
							td1.id="tdata"+(arr[1]==""?"  ":arr[1]);
							td1.name=arr[2]==""?"  ":arr[2];
							td1.innerText = arr[2]==""?"  ":arr[2];						
							td2.name = arr[3]==""?"  ":arr[3];
							td2.innerText = arr[3]==""?"  ":arr[3];					
							td3.name = arr[4]==""?"  ":arr[4];
							td3.innerText = arr[4]==""?"  ":arr[4];	
							td4.name = arr[5]==""?"  ":arr[5];
							td4.innerText = arr[5]==""?"  ":arr[5];
							td1.className = "blue";
							td2.className = "blue";
							td3.className = "blue";
							td4.className = "blue";
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
							window.location.reload(); 
						}
					}
				}       			
			}
			
			function mod_data(getCountResult,getTCResult){
				if(prevclick.indexOf("tdata")==-1){
					similarMSNPop("请选择修改接触日期！");
				}else{
					var id = trim(document.all[""+prevclick].id.substr(5));
					var mindate = trim(document.all[""+prevclick].name);
					var maxdate = trim(document.all[""+prevclick].nextSibling.name);
					var getcount = trim(document.all[""+prevclick].nextSibling.nextSibling.name);
					var dateflag = trim(document.all[""+prevclick].nextSibling.nextSibling.nextSibling.name);
					var description = trim(document.all[""+prevclick].nextSibling.nextSibling.nextSibling.nextSibling.name);
					//抽取条数设置的条数
					var getCountResult = getCountResult;
					var getTCResult = getTCResult;
					var param = "&id=" + id +
											"&mindate=" + mindate +
											"&maxdate=" + maxdate +
											"&getcount=" + getcount +
											"&dateflag=" + dateflag +
											"&description=" + description +
											"&getCountResult=" + getCountResult +
											"&getTCResult=" + getTCResult ;						
			        //updated by tangsong 20100825 安徽样式下，原窗口有滚动条，去除滚动条
			        //var h=420;
			        var h=450;
			        var w=500;
			        var t=screen.availHeight/2-h/2;
			        var l=screen.availWidth/2-w/2;
			        var cssv = "dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:yes;location:no;status:yes;help:no";
			        var retValue = "";
			        retValue = window.showModalDialog("K312_update.jsp?op=update" + param ,"",cssv);
					if(typeof(retValue) != "undefined"){
						retValue = trim(retValue);
						if(retValue != ""){
							var arr = retValue.split("~");
							if(arr[0] == "000000"){
								document.all[""+prevclick].innerText = arr[2]==""?"  ":arr[2];
								document.all[""+prevclick].name = arr[2]==""?"  ":arr[2];
								document.all[""+prevclick].nextSibling.innerText = arr[3]==""?"  ":arr[3];
								document.all[""+prevclick].nextSibling.name = arr[3]==""?"  ":arr[3];
								document.all[""+prevclick].nextSibling.nextSibling.innerText = arr[4]==""?"  ":arr[4];
								document.all[""+prevclick].nextSibling.nextSibling.name = arr[4]==""?"  ":arr[3];
								document.all[""+prevclick].nextSibling.nextSibling.nextSibling.innerText = arr[5]==""?"  ":arr[5];
								document.all[""+prevclick].nextSibling.nextSibling.nextSibling.name = arr[5]==""?"  ":arr[3];
								window.location.reload();
						}
						}
					}  
				} 	
				
			}
			
			function del_data(){
				if(prevclick.indexOf("tdata")==-1){
						similarMSNPop("请选择要删除的接触日期！");
				}else{
					if(rdShowConfirmDialog("确认删除当前选中的接触日期么？") == 1){
						var myPacket = new AJAXPacket("K312I_AddMod.jsp","正在提交，请稍候......");
						myPacket.data.add("retType","delete");
						myPacket.data.add("id",trim(document.all[""+prevclick].id.substr(5)));
						core.ajax.sendPacket(myPacket,doProcess,true);
						myPacket=null;
					}
				}		
		}
			
			
			function doProcess(packet)
			{
				var retType = packet.data.findValueByName("retType");		
				var retCode = packet.data.findValueByName("retCode");
				var retMsg = packet.data.findValueByName("retMsg");		
				
				if(retCode=='000000'){
					similarMSNPop("删除成功" + "[" + retCode + "]");
					for(var k=0;k<document.all["ErrTable"].firstChild.childNodes.length;k++){
						if(document.all["ErrTable"].firstChild.childNodes[k].firstChild.id == prevclick){
							document.all["ErrTable"].deleteRow(k);
						}
					}
					prevclick = "";
					setTimeout("window.location.reload()",2500);
				}
				else
				{
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
				<div class="title"><div id="title_zi"><div style="float:left">接触日期定义
        </div>
					<div style="float:right">
						<input type="button" name="add" class="b_foot" value="新增" onclick="numCheck('add')"/>
						<input type="button" name="mod" class="b_foot" value="修改" onclick="numCheck('mod')"/>
						<input type="button" name="del" class="b_foot" value="删除" onclick="del_data()"/>
					</div>
					</div>
				</div>
				
				<table id="ErrTable" cellspacing="0">			
					<tr>
						<th align="left" class="blue" width="5%" ><nobr> 起始日期 </th>
						<th align="left" class="blue" width="5%" ><nobr> 结束日期 </th>
						<th align="left" class="blue" width="5%" ><nobr> 抽取条数 </th>
							<th align="left" class="blue" width="5%" ><nobr> 月份 </th>
						<th align="left" class="blue" width="5%" ><nobr> <div align="left">备注 <font color=''>(设置数字对应日期，如1对应1号。-1表示月份最后一天)</font></div> </th>
					</tr>
<%
	int i = 0;
	for(i=0;i<result.length;i++){	
%>
					<tr >
						
						<td id="tdata<%=result[i][0]%>" class="blue"  name="<%=result[i][1]%>" style="cursor:hand" onclick="tdop(this)" onmouseover="javascript:this.style.backgroundColor='#ececec';" onmouseout="javascript:this.style.backgroundColor='#F7F7F7'">
							<%=(result[i][1]==null||result[i][1].equals(""))?"&nbsp;&nbsp;":result[i][1]%>
						</td >
						<td name="<%=result[i][2]%>" class="blue" >	
							<%=(result[i][2]==null||result[i][2].equals(""))?"&nbsp;&nbsp;":result[i][2]%>
						</td>
						<td name="<%=result[i][3]%>" class="blue" >	
							<%=(result[i][3]==null||result[i][3].equals(""))?"&nbsp;&nbsp;":result[i][3]%>
						</td>
						<td name="<%=result[i][5]%>" class="blue" >	
							<%=(result[i][6]==null||result[i][6].equals(""))?"&nbsp;&nbsp;":result[i][6]%>
						</td>
						<td name="<%=result[i][4]%>" class="blue" >	
							<%=(result[i][4]==null||result[i][4].equals(""))?"&nbsp;&nbsp;":result[i][4]%>
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
