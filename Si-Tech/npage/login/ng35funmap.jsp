<%
/********************
 version v2.0
 开发商 si-tech
 create hejwa 2013-1-8  
 站点地图
********************/
%>
              
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%

String workNo     = (String)session.getAttribute("workNo");
String regionCode = (String)session.getAttribute("regCode");

String funcArray[] = new String[37];
funcArray[0]  = "0|9999|func0|系统|0|#|0|";
funcArray[1]  = "1|0|func1|开通/暂停|0|#|0|";
funcArray[2]  = "2|0|func2|申请/取消|0|#|0|";
funcArray[3]  = "4|0|func4|缴费|0|#|0|";
funcArray[4]  = "3|0|func3|注册/注销|0|#|0|";
funcArray[5]  = "5|0|func5|查询|0|#|0|";
funcArray[6]  = "6|0|func6|变更|0|#|0|";
funcArray[7]  = "7|0|func7|修改|0|#|0|";
funcArray[8]  = "8|0|func8|补办|0|#|0|";
funcArray[9]  = "9|1|1214|综合变更|2|s1213/f1213.jsp|0|";
funcArray[10] = "10|1|1446|改号通知|2|s5061/s1446.jsp?op_code=1446|0|";
funcArray[11] = "11|2|func9|数据业务|0|#|0|";
funcArray[12] = "12|2|func10|促销活动|0|#|0|";
funcArray[13] = "13|11|1930|统一查询退订|2|s1920/f1930.jsp|0|";
funcArray[14] = "14|11|9113|用户信息服务功能受理|2|s9113/f9113_1.jsp|0|";
funcArray[15] = "15|12|7162|充值有礼|2|s7162/f7162_1.jsp|0|";
funcArray[16] = "16|12|1143|积分换机|2|s1141/f1143_login.jsp|0|";
funcArray[17] = "17|3|1102|帐户开户|1|innet/f1102_1.jsp|0|";
funcArray[18] = "18|3|1100|客户开户|1|sq100/sq100_1.jsp|0|";
funcArray[19] = "19|4|1300|号码缴费|1|s1300/s1300.jsp|0|";
funcArray[20] = "20|4|1588|神州行余额转帐|2|s1300/s1588.jsp|0|";
funcArray[21] = "21|5|func11|消费情况|0|#|0|";
funcArray[22] = "22|5|func12|服务信息|0|#|0|";
funcArray[23] = "23|22|1500|综合信息查询|1|query/f1500_1.jsp|0|";
funcArray[24] = "24|22|1506|号码信息查询|1|query/f1506_1.jsp|0|";
funcArray[25] = "25|22|1505|SIM信息查询|1|query/f1505_1.jsp|0|";
funcArray[26] = "26|21|1556|明细帐单查询|2|query/s1556_new.jsp|0|";
funcArray[27] = "27|21|1528|交费信息查询|1|query/s1528_new.jsp|0|";
funcArray[28] = "28|6|func13|资费|0|#|";
funcArray[29] = "29|6|func14|业务|0|#|";
funcArray[30] = "30|28|127a|主资费预约取消|2|s1170/f1170Main.jsp?op_code=127a|0|";
funcArray[31] = "31|28|7123|家庭服务计划|1|bill/f7123_main.jsp|0|";
funcArray[32] = "32|29|1234|用户密码修改|2|s1234/f1234_main.jsp|0|";
funcArray[33] = "33|29|1210|客户资料变更|1|s1210/s1210Login.jsp|1|";
funcArray[34] = "34|7|1121|普通开户冲正|2|s1170/f1170Main.jsp?op_code=1121|0|";
funcArray[35] = "35|7|1310|缴费冲正|1|s1300/s1310.jsp|0|";
funcArray[36] = "36|8|1138|发票补打|1|s1244/f1244_main.jsp|0|";

%> 
<wtc:service name="sGetWorkDataNew" routerKey="region" routerValue="<%=regionCode%>"  outnum="10" >
	<wtc:param value="<%=workNo%>" />
  	<wtc:param value="1" />
  	<wtc:param value="99999" />
  	<wtc:param value="999" />
	</wtc:service>
<wtc:array id="func" scope="end"/>	
<%
int h = 0;
for(int j=0;j<funcArray.length;j++){
	if(!funcArray[j].split("\\|")[5].equals("#")){
		for(int i=0;i<func.length;i++){
				if(funcArray[j].split("\\|")[2].equals(func[i][1])){
					h++;
					break;
				}
	  }
	  if(h==0){//没找到
	  	funcArray[j] = "";
	  }else{
	  	h = 0;
	  }
  }
}
%>	
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE>站点地图</TITLE>
<link href="../../nresources/default/css/ng35.css" rel="stylesheet" type="text/css"></link>	
<script src="<%=request.getContextPath()%>/njs/system/jquery-1.3.2.min.js" type="text/javascript"></script>
<SCRIPT language=JavaScript>
//打开节点模块

var funArray =new Array();//定义节点数组
//节点初始化 
//funArray[i] = "id|parentId|opcode|opname|openflag|jspPath|valideVal";
/*
funArray[0]  = "0|9999|func0|系统|0|#|0|";
funArray[1]  = "1|0|func1|开通/暂停|0|#|0|";
funArray[2]  = "2|0|func2|申请/取消|0|#|0|";
funArray[3]  = "4|0|func4|缴费|0|#|0|";
funArray[4]  = "3|0|func3|注册/注销|0|#|0|";
funArray[5]  = "5|0|func5|查询|0|#|0|";
funArray[6]  = "6|0|func6|变更|0|#|0|";
funArray[7]  = "7|0|func7|修改|0|#|0|";
funArray[8]  = "8|0|func8|补办|0|#|0|";
funArray[9]  = "9|1|1214|综合变更|2|s1213/f1213.jsp|0|";
funArray[10] = "10|1|1446|改号通知|2|s5061/s1446.jsp?op_code=1446|0|";
funArray[11] = "11|2|func9|数据业务|0|#|0|";
funArray[12] = "12|2|func10|促销活动|0|#|0|";
funArray[13] = "13|11|1930|统一查询退订|2|s1920/f1930.jsp|0|";
funArray[14] = "14|11|9113|用户信息服务功能受理|2|s9113/f9113_1.jsp|0|";
funArray[15] = "15|12|7162|充值有礼|2|s7162/f7162_1.jsp|0|";
funArray[16] = "16|12|1143|积分换机|2|s1141/f1143_login.jsp|0|";
funArray[17] = "17|3|1102|帐户开户|1|innet/f1102_1.jsp|0|";
funArray[18] = "18|3|1100|客户开户|1|sq100/sq100_1.jsp|0|";
funArray[19] = "19|4|1300|号码缴费|1|s1300/s1300.jsp|0|";
funArray[20] = "20|4|1588|神州行余额转帐|2|s1300/s1588.jsp|0|";
funArray[21] = "21|5|func11|消费情况|0|#|0|";
funArray[22] = "22|5|func12|服务信息|0|#|0|";
funArray[23] = "23|22|1500|综合信息查询|1|query/f1500_1.jsp|0|";
funArray[24] = "24|22|1506|号码信息查询|1|query/f1506_1.jsp|0|";
funArray[25] = "25|22|1505|SIM信息查询|1|query/f1505_1.jsp|0|";
funArray[26] = "26|21|1556|明细帐单查询|2|query/s1556_new.jsp|0|";
funArray[27] = "27|21|1528|交费信息查询|1|query/s1528_new.jsp|0|";
funArray[28] = "28|6|func13|资费|0|#|";
funArray[29] = "29|6|func14|业务|0|#|";
funArray[30] = "30|28|127a|主资费预约取消|2|s1170/f1170Main.jsp?op_code=127a|0|";
funArray[31] = "31|28|7123|家庭服务计划|1|bill/f7123_main.jsp|0|";
funArray[32] = "32|29|1234|用户密码修改|2|s1234/f1234_main.jsp|0|";
funArray[33] = "33|29|1210|客户资料变更|1|s1210/s1210Login.jsp|1|";
funArray[34] = "34|7|1121|普通开户冲正|2|s1170/f1170Main.jsp?op_code=1121|0|";
funArray[35] = "35|7|1310|缴费冲正|1|s1300/s1310.jsp|0|";
funArray[36] = "36|8|1138|发票补打|1|s1244/f1244_main.jsp|0|";
*/

<%
int j = 0;
for(int i=0 ;i<funcArray.length;i++){
	if(!funcArray[i].equals("")){
		out.print("funArray["+(j++)+"] = \""+funcArray[i]+"\";");
	}
}
%>
var startTop    = 40;        //根节点起始位置 上
var bleft       = 38;				 //所有元素的参照 左
var lineHigth   = 40;        //竖线高度
var distance    = 70;        //不同节点的间距
var parDistan   = 70;        //同节点的间距，并列元素间距

var h_width     = 92;//横元素宽
var h_higth     = 24;//横元素高
var s_width     = 34;//竖元素宽
var s_higth     = 88;//竖元素高

var maxLeft     = 0;//记录最左侧位置
var livFlag     = 0;//默认同层，不同层改为1
var tid_left_Array = new Array();  //记录左侧位置
var tid_line_Array = new Array();  //画横线记录子节点位置



function tofunc(openflag,opcode,title,targetUrl,valideVal){
	parent.tofuncMain(openflag,opcode,title,targetUrl,valideVal);
}
var divHtml =  "";
		//根节点下的竖线
$(document).ready(function(){
	createFuncMap(0);// 从根节点开始
	$("#List_DV").html(divHtml);
});
//入参为当前节点ID 
/* 入参
 * tid ：当前节点ID
 */
function createFuncMap(tid){
	var childArr = getChildArr(tid);//返回排序的一级子节点数组
	var livNum = getLivNum(tid,0);//确定当前节点层次	
	var clsName = "";
	var vTop  = startTop;  //算出节点高度
		if(livNum==0){
			vTop = startTop;
			clsName = "dhItem";
		}else if(livNum==1){//第一层横着显示文字
			vTop += h_higth+lineHigth*2;
			clsName = "dhItem";
		}else{
			vTop += h_higth*2+lineHigth*livNum*2+(livNum-2)*s_higth;
			clsName = "dvItem";
		}
	if(childArr.length==0){//为叶子节点，将叶子节点位置存储在数组中
		if(maxLeft>bleft){
			bleft = maxLeft;
		}
		var aText = "<a href='javascript:void(0)' onclick='tofunc(\""+getEleById(tid,4)+"\",\""+getEleById(tid,2)+"\",\""+getEleById(tid,3)+"\",\""+getEleById(tid,5)+"\",\""+getEleById(tid,6)+"\")'>"+getEleById(tid,3)+"</a>";//拼装连接
		divHtml += "<div vId='"+tid+"' class='"+clsName+"' style='left:"+bleft+"px;top:"+vTop+"px'>"+aText+"</div>";
		//画向上的线
		var lineLeft = bleft+s_width/2;
		divHtml += "<div class='dvvline' style='height:"+lineHigth+"px;left:"+lineLeft+"px;top:"+(vTop-lineHigth)+"px'></div>";
		tid_line_Array.push(tid+"|"+lineLeft);
		tid_left_Array.push(tid+"|"+bleft);
		setBLeft(0);//设置当前位置，同层
	}else{//先画所有的子节点，确定宽度后画根节点
		var aText = "<a href='javascript:void(0)' >"+getEleById(tid,3)+"</a>";//拼装连接
		for(var i=0;i<childArr.length;i++){
			createFuncMap(getFunArrByI(i,0,childArr));//
		}
		var rleft = getChildLeft(tid,livNum);//取子节点的位置
		bleft = rleft;
		divHtml += "<div vId='"+tid+"' class='"+clsName+"' style='left:"+bleft+"px;top:"+vTop+"px'>"+aText+"</div>";
		var lineInfo = getLineLeft(tid);
		var lineLeftg = lineInfo[0];
		var lineWidth = lineInfo[1];
		if(lineWidth!=0){
			var lineToph = 0;
			if(livNum>1){
				lineToph = vTop+s_higth+lineHigth;
			}else{
				lineLeftg = lineLeftg+1;//修正误差，int类型除法四舍五入可能会造成一定误差
				lineWidth = lineWidth-1;//修正误差
				lineToph = vTop+lineHigth+h_higth;
			}
			divHtml += "<div class='dvhline' style='width:"+lineWidth+"px;left:"+lineLeftg+"px;top:"+lineToph+"px'></div>";
		}
			
		if(livNum>1){//2层以下
			var lineLeft = bleft+s_width/2;
			divHtml += "<div class='dvvline' style='height:"+lineHigth+"px;left:"+lineLeft+"px;top:"+(vTop+s_higth)+"px'></div>";
			divHtml += "<div class='dvvline' style='height:"+lineHigth+"px;left:"+lineLeft+"px;top:"+(vTop-lineHigth)+"px'></div>";
			tid_line_Array.push(tid+"|"+lineLeft);
		}else{
			var lineLeft = bleft+h_width/2;
			var lineTop = vTop + h_higth;
			divHtml += "<div class='dvvline' style='height:"+lineHigth+"px;left:"+lineLeft+"px;top:"+lineTop+"px'></div>";
			if(livNum!=0){//根节点 系统不画向上
				divHtml += "<div class='dvvline' style='height:"+lineHigth+"px;left:"+lineLeft+"px;top:"+(lineTop-lineHigth-h_higth)+"px'></div>";
			}
			tid_line_Array.push(tid+"|"+lineLeft);
		}
		tid_left_Array.push(tid+"|"+bleft);
		setBLeft(1);//设置当前位置，不同层
	}
}
function getLineLeft(tid){
	var rlineInfo = new Array();
	var childArr = getChildArr(tid);//返回排序的一级子节点数组
	var rLeft  = 0;
	var rWidth  = 0;//
	var rWidth1 = 0;//
	var rWidth2 = 0;//
	if(childArr.length==1){
		//只有一个节点，不画横线
	}else{
		for(var i=0;i<tid_line_Array.length;i++){
			if(tid_line_Array[i].split("|")[0]==getFunArrByI(0,0,childArr)){
				rLeft = parseInt(tid_line_Array[i].split("|")[1]);
				rWidth1 = parseInt(tid_line_Array[i].split("|")[1]);
				continue;
			}
			if(tid_line_Array[i].split("|")[0]==getFunArrByI((childArr.length-1),0,childArr)){
				rWidth2 = parseInt(tid_line_Array[i].split("|")[1]);
				continue;
			}
		}
	}
	rlineInfo.push(rLeft);
	rlineInfo.push(rWidth2-rWidth1);
	return rlineInfo;
}
function setBLeft(flag){
	if(livFlag==0){
		bleft = bleft + parDistan;
	}else{
		bleft = bleft + distance;
	}
	if(maxLeft<bleft){
		maxLeft = bleft;
	}
	livFlag = flag;
}
//取子节点的位置,根据vId属性找到子节点，算出根节点应该的位置 tid = 根节点id
function getChildLeft(tid,livNum){
	var rLeft = 0;
	var childArr = getChildArr(tid);//返回排序的一级子节点数组
	if(childArr.length==1){//只有一个节点与子节点的位置相同即可
		for(var i=0;i<tid_left_Array.length;i++){
			if(tid_left_Array[i].split("|")[0]==getFunArrByI(0,0,childArr)){
				rLeft = parseInt(tid_left_Array[i].split("|")[1]);
				break;
			}
		}
	}else{
		//第一个节点的位置加上最后一个节点减去他的一半
		var childId_b_Left = 0;
		var childId_e_Left = 0;
		for(var i=0;i<tid_left_Array.length;i++){
			if(tid_left_Array[i].split("|")[0]==getFunArrByI(0,0,childArr)){
				childId_b_Left = tid_left_Array[i].split("|")[1];
				continue;
			}
			if(tid_left_Array[i].split("|")[0]==getFunArrByI((childArr.length-1),0,childArr)){
				childId_e_Left = tid_left_Array[i].split("|")[1];
				continue;
			}
		}
		rLeft = parseInt(childId_b_Left)+(parseInt(childId_e_Left) - parseInt(childId_b_Left))/2;
	}
	if(livNum==1) rLeft = rLeft-h_width/2+s_width/2;
	return rLeft;
}
//取得id所对应记录内的元素
function getEleById(tid,n){
	var retVal = "";
	for(var i=0; i<funArray.length;i++){
		if(tid==getFunArrByI(i,0)){
			retVal = getFunArrByI(i,n);
			break;
		}
	}
	return retVal;
}
//取得当前节点位于层数，根节点为0  tid=节点id livNum_load=累计层次数值 初始化调用为1
function getLivNum(tid,livNum_load){
	var parentId = getFunArrByI(tid,1);
	var livNum = livNum_load+1;
	if(tid==0){//本身就是根节点
		return 0;
	}else if(parentId==0){//根节点为0
		return livNum;
	}else{//找到父节点的ID，递归
		var newId = tid;
		for(var i=0; i<funArray.length;i++){
			newId = getFunArrByI(i,0);//取得父ID
			if(newId==parentId){
				break;
			}
		}
		return getLivNum(newId,livNum);
	}
}

//取得数组中某一值，方便写法 i=数组的第i项 j=元素
function getFunArrByI(i,j,arr){
	if(typeof(arr)=="undefined"){
		arr = funArray;
	}
	return arr[i].split("|")[j];
}
//取得子节点，按照节点id进行排序
function getChildArr(j){
	var childArr = new Array();
	for(var i=0; i<funArray.length;i++){
		var parentId = getFunArrByI(i,1);
		if(parentId==j){
			childArr.push(funArray[i]);
		}
	}
	//alert("getChildArr#"+childArr+"\n"+childArr.length);
	return storeById(childArr);
}

//按照id进行排序，返回数组
function storeById(arr){
	var tempArr = arr;
	var tmp = 0;
	for(var i=0;i<tempArr.length;i++){
		for(var j=i;j<tempArr.length;j++){
			if(parseInt(tempArr[i].split("|")[0])>parseInt(tempArr[j].split("|")[0])){
				temp = tempArr[i];
				tempArr[i] = tempArr[j];
				tempArr[j] = temp;
			}
		}
	}
	return tempArr;
}
</SCRIPT>
</HEAD>	
<BODY>
<div id="List_DV">
	
</div>
</BODY>
</HTML>