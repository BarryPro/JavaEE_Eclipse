<%
/********************
*version v3.0
*开发商: si-tech
*
*fengss
*1104,1238等模块使用过的弹出对话框
*
********************/
	String opName = WtcUtil.repNull(request.getParameter("opName"));
	String opCode = WtcUtil.repNull(request.getParameter("opCode"));

%>
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);

	String phoneNo=request.getParameter("phoneNo");
	String servOrderId=request.getParameter("servOrderId");
%>
<HTML>
<HEAD>
<TITLE>打印</TITLE>
</HEAD> 
<%@ include file="splitStr.jsp" %>

<SCRIPT type="text/javascript">

function controlDisplay(){
	if(load2()){
		document.all.display1.style.display="";
		document.all.display2.style.display="none";
	}else{
		window.setTimeout(controlDisplay,100);
	}
	
}

function load2(){
	var ret=true;
	try{
		document.all.printctrl.Setup(0);
	}catch(e){
		ret=false;
	}finally{
		return ret;
	}
}


function doProcess(packet)
{	
  //RPC处理函数findValueByName
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("errCode"); 
	var retMessage = packet.data.findValueByName("errMsg");	
  
	var fColor = 0*65536+0*256+0;  
	self.status="";

	if((retCode).trim()==""){
		rdShowMessageDialog("调用"+retType+"服务时失败！");
		return false;
	}

	if(retType == "subprint"){
			if(retCode=="000000"){	
				
				var index=-1;
				var pageSize=210;
				var impResultArr = packet.data.findValueByName("impResultArr");
				var plusResultArr = packet.data.findValueByName("plusResultArr");
				var num = impResultArr.length;   //总行数  
				var page=(parseInt((maxNum(impResultArr))/pageSize))+1;
				page=(parseInt((maxNum(impResultArr)+(50*(page-1)))/pageSize))+1;
				try{
					for(var j=0;j<page;j++){
						printctrl.Setup(0);
						printctrl.StartPrint();
						printctrl.PageStart();
						//打印页码
						printctrl.PrintText(90,37,"宋体",10,fColor,10,"第"+(j+1)+"页(总共"+page+"页)");
						var x,y;
						//打印头尾
						for(i=0;i<plusResultArr.length;i++){
							x=parseInt(plusResultArr[i][3]);
							y=parseInt(plusResultArr[i][2]);

							if(plusResultArr[i][1]=="6"){
								//alert(plusResultArr[i][4]);
								var rect="";
								rect+=x+","+y+","+(190)+","+y+",|";
								printctrl.PrintLines(rect,
									0, //颜色
									plusResultArr[i][4],//线粗
									0 //线类型
								);
							}else{
								if(plusResultArr[i][6]=="Y"){
									printctrl.PrintText(x,y,plusResultArr[i][12],plusResultArr[i][4],fColor,10,plusResultArr[i][10]);
								}else{
									printctrl.PrintText(x,y,plusResultArr[i][12],plusResultArr[i][4],fColor,10,plusResultArr[i][10]);
								}
								
							}
						}
						
						//打印内容
						var deleteHead=0;
						if(j!=0)
							deleteHead=impResultArr[0][2];
						var lastIndex=index+1;
						for(i=index+1;i<impResultArr.length && ((impResultArr[i][2]-impResultArr[lastIndex][2])+50)<pageSize;i++){
							index=i;
							x=parseInt(impResultArr[i][3]);
							y=parseInt(impResultArr[i][2]);
							if(j!=0){
								y=y-parseInt(impResultArr[lastIndex][2])+50;//调整行，调到每页的第一行
							}
							if(impResultArr[i][1]=="6"){
								var rect=x+","+y+","+(190)+","+y+",|";
								printctrl.PrintLines(rect,
									0, //颜色
									impResultArr[i][4],//线粗
									1 //线类型
								);
							}else{
								if(impResultArr[i][6]=="Y"){
									impResultArr[i][6]=10;
								}else{
									impResultArr[i][6]=1;
								}
								printctrl.PrintText(x,y,impResultArr[i][12],impResultArr[i][4],fColor,impResultArr[i][6],impResultArr[i][10]);
							}

						}	
						printctrl.PageEnd();
						printctrl.StopPrint();
						window.close();

					}
				}catch(e){
					alert(e.message);
				}
				
				
			}else{
				rdShowMessageDialog("错误代码："+retCode+"错误信息："+retMessage);

				window.close(); 
			}
		
		}
		

	if(retType == "noprint"){
		if(retCode!="000000"){
			rdShowMessageDialog("错误代码："+retCode+"错误信息："+retMessage);	
		}
		window.returnValue="continueSub";
		window.close();
	}
}
function maxNum(arr){
	var max=0;
	for(var i=0;i<arr.length;i++){
		if(parseInt(arr[i][2])>max){
			max=parseInt(arr[i][2]);
		}
	}
	return max;
}



//合并打印
function doSubPrint()
{	
	
	//调用合并打印程序	
	var subprint_Packet = new AJAXPacket("fPubSaveSubPrint.jsp","正在打印，请稍候......");
	subprint_Packet.data.add("retType","subprint");
	subprint_Packet.data.add("phoneNo",'<%=phoneNo%>');
	subprint_Packet.data.add("billType",'1');
	subprint_Packet.data.add("servOrderId",'<%=servOrderId%>');
	core.ajax.sendPacket(subprint_Packet);
	subprint_Packet=null;	 		
}
//预览
function doJPreview(){
	
	//var property="height=891,width=730,top=0,left=0,toolbar=no,menubar=no,scrollbars=yes,resizable=yes";
	var property="dialogWidth=650px;dialogHeight=800px;resizable=yes;scroll=yes;";
	var path="printJPreview.jsp?";

	path+="SphoneNo="+"<%=phoneNo%>";
	path+="&opCode="+"<%=opCode%>";
	path+="&billType="+"1";
	path+="&servOrderId="+"<%=servOrderId%>";
	window.showModalDialog(path,"print_preview",property);
}
function doNothing()
{
	window.close();
}

</SCRIPT>
<!--**************************************************************************************-->
<body style="overflow-x:hidden;overflow-y:hidden">
<div id="operation">

<FORM method=post name="spubPrint">
<center>合并打印免填单</center>
<div id="display2">
	<center><font color=red>打印控件加载中....</font>
	<input class="b_foot_long"  onclick="doJPreview()" type="button"  value="打印预览">
	<input class="b_foot" name=commit onClick="doNothing()"  type=button value="不打印">
	</center>
</div>
<div id="display1" style="display:none">
	<div class="input">
		<div align="center">
			<input class="b_foot" name=commit onClick="doSubPrint()"  type=button value="合并打印">
			<input class="b_foot_long"  onclick="doJPreview()" type="button"  value="打印预览">
			<input class="b_foot" name=commit onClick="doNothing()"  type=button value="不打印">
	    </div>
	    <br>   
	 </div>
</div>
</FORM>
<OBJECT
classid="clsid:0CBD5167-6DF3-45C4-AC69-852C6CB75D32"
codebase="/ocx/PrintEx.cab#version=1,1,0,3" style="display:none;"
id="printctrl"
VIEWASTEXT>
</OBJECT>

<div id="operation">
</BODY>
<script>
controlDisplay();//控制显示,注意：不要改变位置。
</script>
</HTML>    
