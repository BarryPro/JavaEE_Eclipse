<%
/********************
 version v2.0
 ������ si-tech
 create hejwa 2013-1-8  
 վ���ͼ
********************/
%>
              
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%

String workNo     = (String)session.getAttribute("workNo");
String regionCode = (String)session.getAttribute("regCode");

String funcArray[] = new String[37];
funcArray[0]  = "0|9999|func0|ϵͳ|0|#|0|";
funcArray[1]  = "1|0|func1|��ͨ/��ͣ|0|#|0|";
funcArray[2]  = "2|0|func2|����/ȡ��|0|#|0|";
funcArray[3]  = "4|0|func4|�ɷ�|0|#|0|";
funcArray[4]  = "3|0|func3|ע��/ע��|0|#|0|";
funcArray[5]  = "5|0|func5|��ѯ|0|#|0|";
funcArray[6]  = "6|0|func6|���|0|#|0|";
funcArray[7]  = "7|0|func7|�޸�|0|#|0|";
funcArray[8]  = "8|0|func8|����|0|#|0|";
funcArray[9]  = "9|1|1214|�ۺϱ��|2|s1213/f1213.jsp|0|";
funcArray[10] = "10|1|1446|�ĺ�֪ͨ|2|s5061/s1446.jsp?op_code=1446|0|";
funcArray[11] = "11|2|func9|����ҵ��|0|#|0|";
funcArray[12] = "12|2|func10|�����|0|#|0|";
funcArray[13] = "13|11|1930|ͳһ��ѯ�˶�|2|s1920/f1930.jsp|0|";
funcArray[14] = "14|11|9113|�û���Ϣ����������|2|s9113/f9113_1.jsp|0|";
funcArray[15] = "15|12|7162|��ֵ����|2|s7162/f7162_1.jsp|0|";
funcArray[16] = "16|12|1143|���ֻ���|2|s1141/f1143_login.jsp|0|";
funcArray[17] = "17|3|1102|�ʻ�����|1|innet/f1102_1.jsp|0|";
funcArray[18] = "18|3|1100|�ͻ�����|1|sq100/sq100_1.jsp|0|";
funcArray[19] = "19|4|1300|����ɷ�|1|s1300/s1300.jsp|0|";
funcArray[20] = "20|4|1588|���������ת��|2|s1300/s1588.jsp|0|";
funcArray[21] = "21|5|func11|�������|0|#|0|";
funcArray[22] = "22|5|func12|������Ϣ|0|#|0|";
funcArray[23] = "23|22|1500|�ۺ���Ϣ��ѯ|1|query/f1500_1.jsp|0|";
funcArray[24] = "24|22|1506|������Ϣ��ѯ|1|query/f1506_1.jsp|0|";
funcArray[25] = "25|22|1505|SIM��Ϣ��ѯ|1|query/f1505_1.jsp|0|";
funcArray[26] = "26|21|1556|��ϸ�ʵ���ѯ|2|query/s1556_new.jsp|0|";
funcArray[27] = "27|21|1528|������Ϣ��ѯ|1|query/s1528_new.jsp|0|";
funcArray[28] = "28|6|func13|�ʷ�|0|#|";
funcArray[29] = "29|6|func14|ҵ��|0|#|";
funcArray[30] = "30|28|127a|���ʷ�ԤԼȡ��|2|s1170/f1170Main.jsp?op_code=127a|0|";
funcArray[31] = "31|28|7123|��ͥ����ƻ�|1|bill/f7123_main.jsp|0|";
funcArray[32] = "32|29|1234|�û������޸�|2|s1234/f1234_main.jsp|0|";
funcArray[33] = "33|29|1210|�ͻ����ϱ��|1|s1210/s1210Login.jsp|1|";
funcArray[34] = "34|7|1121|��ͨ��������|2|s1170/f1170Main.jsp?op_code=1121|0|";
funcArray[35] = "35|7|1310|�ɷѳ���|1|s1300/s1310.jsp|0|";
funcArray[36] = "36|8|1138|��Ʊ����|1|s1244/f1244_main.jsp|0|";

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
	  if(h==0){//û�ҵ�
	  	funcArray[j] = "";
	  }else{
	  	h = 0;
	  }
  }
}
%>	
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE>վ���ͼ</TITLE>
<link href="../../nresources/default/css/ng35.css" rel="stylesheet" type="text/css"></link>	
<script src="<%=request.getContextPath()%>/njs/system/jquery-1.3.2.min.js" type="text/javascript"></script>
<SCRIPT language=JavaScript>
//�򿪽ڵ�ģ��

var funArray =new Array();//����ڵ�����
//�ڵ��ʼ�� 
//funArray[i] = "id|parentId|opcode|opname|openflag|jspPath|valideVal";
/*
funArray[0]  = "0|9999|func0|ϵͳ|0|#|0|";
funArray[1]  = "1|0|func1|��ͨ/��ͣ|0|#|0|";
funArray[2]  = "2|0|func2|����/ȡ��|0|#|0|";
funArray[3]  = "4|0|func4|�ɷ�|0|#|0|";
funArray[4]  = "3|0|func3|ע��/ע��|0|#|0|";
funArray[5]  = "5|0|func5|��ѯ|0|#|0|";
funArray[6]  = "6|0|func6|���|0|#|0|";
funArray[7]  = "7|0|func7|�޸�|0|#|0|";
funArray[8]  = "8|0|func8|����|0|#|0|";
funArray[9]  = "9|1|1214|�ۺϱ��|2|s1213/f1213.jsp|0|";
funArray[10] = "10|1|1446|�ĺ�֪ͨ|2|s5061/s1446.jsp?op_code=1446|0|";
funArray[11] = "11|2|func9|����ҵ��|0|#|0|";
funArray[12] = "12|2|func10|�����|0|#|0|";
funArray[13] = "13|11|1930|ͳһ��ѯ�˶�|2|s1920/f1930.jsp|0|";
funArray[14] = "14|11|9113|�û���Ϣ����������|2|s9113/f9113_1.jsp|0|";
funArray[15] = "15|12|7162|��ֵ����|2|s7162/f7162_1.jsp|0|";
funArray[16] = "16|12|1143|���ֻ���|2|s1141/f1143_login.jsp|0|";
funArray[17] = "17|3|1102|�ʻ�����|1|innet/f1102_1.jsp|0|";
funArray[18] = "18|3|1100|�ͻ�����|1|sq100/sq100_1.jsp|0|";
funArray[19] = "19|4|1300|����ɷ�|1|s1300/s1300.jsp|0|";
funArray[20] = "20|4|1588|���������ת��|2|s1300/s1588.jsp|0|";
funArray[21] = "21|5|func11|�������|0|#|0|";
funArray[22] = "22|5|func12|������Ϣ|0|#|0|";
funArray[23] = "23|22|1500|�ۺ���Ϣ��ѯ|1|query/f1500_1.jsp|0|";
funArray[24] = "24|22|1506|������Ϣ��ѯ|1|query/f1506_1.jsp|0|";
funArray[25] = "25|22|1505|SIM��Ϣ��ѯ|1|query/f1505_1.jsp|0|";
funArray[26] = "26|21|1556|��ϸ�ʵ���ѯ|2|query/s1556_new.jsp|0|";
funArray[27] = "27|21|1528|������Ϣ��ѯ|1|query/s1528_new.jsp|0|";
funArray[28] = "28|6|func13|�ʷ�|0|#|";
funArray[29] = "29|6|func14|ҵ��|0|#|";
funArray[30] = "30|28|127a|���ʷ�ԤԼȡ��|2|s1170/f1170Main.jsp?op_code=127a|0|";
funArray[31] = "31|28|7123|��ͥ����ƻ�|1|bill/f7123_main.jsp|0|";
funArray[32] = "32|29|1234|�û������޸�|2|s1234/f1234_main.jsp|0|";
funArray[33] = "33|29|1210|�ͻ����ϱ��|1|s1210/s1210Login.jsp|1|";
funArray[34] = "34|7|1121|��ͨ��������|2|s1170/f1170Main.jsp?op_code=1121|0|";
funArray[35] = "35|7|1310|�ɷѳ���|1|s1300/s1310.jsp|0|";
funArray[36] = "36|8|1138|��Ʊ����|1|s1244/f1244_main.jsp|0|";
*/

<%
int j = 0;
for(int i=0 ;i<funcArray.length;i++){
	if(!funcArray[i].equals("")){
		out.print("funArray["+(j++)+"] = \""+funcArray[i]+"\";");
	}
}
%>
var startTop    = 40;        //���ڵ���ʼλ�� ��
var bleft       = 38;				 //����Ԫ�صĲ��� ��
var lineHigth   = 40;        //���߸߶�
var distance    = 70;        //��ͬ�ڵ�ļ��
var parDistan   = 70;        //ͬ�ڵ�ļ�࣬����Ԫ�ؼ��

var h_width     = 92;//��Ԫ�ؿ�
var h_higth     = 24;//��Ԫ�ظ�
var s_width     = 34;//��Ԫ�ؿ�
var s_higth     = 88;//��Ԫ�ظ�

var maxLeft     = 0;//��¼�����λ��
var livFlag     = 0;//Ĭ��ͬ�㣬��ͬ���Ϊ1
var tid_left_Array = new Array();  //��¼���λ��
var tid_line_Array = new Array();  //�����߼�¼�ӽڵ�λ��



function tofunc(openflag,opcode,title,targetUrl,valideVal){
	parent.tofuncMain(openflag,opcode,title,targetUrl,valideVal);
}
var divHtml =  "";
		//���ڵ��µ�����
$(document).ready(function(){
	createFuncMap(0);// �Ӹ��ڵ㿪ʼ
	$("#List_DV").html(divHtml);
});
//���Ϊ��ǰ�ڵ�ID 
/* ���
 * tid ����ǰ�ڵ�ID
 */
function createFuncMap(tid){
	var childArr = getChildArr(tid);//���������һ���ӽڵ�����
	var livNum = getLivNum(tid,0);//ȷ����ǰ�ڵ���	
	var clsName = "";
	var vTop  = startTop;  //����ڵ�߶�
		if(livNum==0){
			vTop = startTop;
			clsName = "dhItem";
		}else if(livNum==1){//��һ�������ʾ����
			vTop += h_higth+lineHigth*2;
			clsName = "dhItem";
		}else{
			vTop += h_higth*2+lineHigth*livNum*2+(livNum-2)*s_higth;
			clsName = "dvItem";
		}
	if(childArr.length==0){//ΪҶ�ӽڵ㣬��Ҷ�ӽڵ�λ�ô洢��������
		if(maxLeft>bleft){
			bleft = maxLeft;
		}
		var aText = "<a href='javascript:void(0)' onclick='tofunc(\""+getEleById(tid,4)+"\",\""+getEleById(tid,2)+"\",\""+getEleById(tid,3)+"\",\""+getEleById(tid,5)+"\",\""+getEleById(tid,6)+"\")'>"+getEleById(tid,3)+"</a>";//ƴװ����
		divHtml += "<div vId='"+tid+"' class='"+clsName+"' style='left:"+bleft+"px;top:"+vTop+"px'>"+aText+"</div>";
		//�����ϵ���
		var lineLeft = bleft+s_width/2;
		divHtml += "<div class='dvvline' style='height:"+lineHigth+"px;left:"+lineLeft+"px;top:"+(vTop-lineHigth)+"px'></div>";
		tid_line_Array.push(tid+"|"+lineLeft);
		tid_left_Array.push(tid+"|"+bleft);
		setBLeft(0);//���õ�ǰλ�ã�ͬ��
	}else{//�Ȼ����е��ӽڵ㣬ȷ����Ⱥ󻭸��ڵ�
		var aText = "<a href='javascript:void(0)' >"+getEleById(tid,3)+"</a>";//ƴװ����
		for(var i=0;i<childArr.length;i++){
			createFuncMap(getFunArrByI(i,0,childArr));//
		}
		var rleft = getChildLeft(tid,livNum);//ȡ�ӽڵ��λ��
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
				lineLeftg = lineLeftg+1;//������int���ͳ�������������ܻ����һ�����
				lineWidth = lineWidth-1;//�������
				lineToph = vTop+lineHigth+h_higth;
			}
			divHtml += "<div class='dvhline' style='width:"+lineWidth+"px;left:"+lineLeftg+"px;top:"+lineToph+"px'></div>";
		}
			
		if(livNum>1){//2������
			var lineLeft = bleft+s_width/2;
			divHtml += "<div class='dvvline' style='height:"+lineHigth+"px;left:"+lineLeft+"px;top:"+(vTop+s_higth)+"px'></div>";
			divHtml += "<div class='dvvline' style='height:"+lineHigth+"px;left:"+lineLeft+"px;top:"+(vTop-lineHigth)+"px'></div>";
			tid_line_Array.push(tid+"|"+lineLeft);
		}else{
			var lineLeft = bleft+h_width/2;
			var lineTop = vTop + h_higth;
			divHtml += "<div class='dvvline' style='height:"+lineHigth+"px;left:"+lineLeft+"px;top:"+lineTop+"px'></div>";
			if(livNum!=0){//���ڵ� ϵͳ��������
				divHtml += "<div class='dvvline' style='height:"+lineHigth+"px;left:"+lineLeft+"px;top:"+(lineTop-lineHigth-h_higth)+"px'></div>";
			}
			tid_line_Array.push(tid+"|"+lineLeft);
		}
		tid_left_Array.push(tid+"|"+bleft);
		setBLeft(1);//���õ�ǰλ�ã���ͬ��
	}
}
function getLineLeft(tid){
	var rlineInfo = new Array();
	var childArr = getChildArr(tid);//���������һ���ӽڵ�����
	var rLeft  = 0;
	var rWidth  = 0;//
	var rWidth1 = 0;//
	var rWidth2 = 0;//
	if(childArr.length==1){
		//ֻ��һ���ڵ㣬��������
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
//ȡ�ӽڵ��λ��,����vId�����ҵ��ӽڵ㣬������ڵ�Ӧ�õ�λ�� tid = ���ڵ�id
function getChildLeft(tid,livNum){
	var rLeft = 0;
	var childArr = getChildArr(tid);//���������һ���ӽڵ�����
	if(childArr.length==1){//ֻ��һ���ڵ����ӽڵ��λ����ͬ����
		for(var i=0;i<tid_left_Array.length;i++){
			if(tid_left_Array[i].split("|")[0]==getFunArrByI(0,0,childArr)){
				rLeft = parseInt(tid_left_Array[i].split("|")[1]);
				break;
			}
		}
	}else{
		//��һ���ڵ��λ�ü������һ���ڵ��ȥ����һ��
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
//ȡ��id����Ӧ��¼�ڵ�Ԫ��
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
//ȡ�õ�ǰ�ڵ�λ�ڲ��������ڵ�Ϊ0  tid=�ڵ�id livNum_load=�ۼƲ����ֵ ��ʼ������Ϊ1
function getLivNum(tid,livNum_load){
	var parentId = getFunArrByI(tid,1);
	var livNum = livNum_load+1;
	if(tid==0){//������Ǹ��ڵ�
		return 0;
	}else if(parentId==0){//���ڵ�Ϊ0
		return livNum;
	}else{//�ҵ����ڵ��ID���ݹ�
		var newId = tid;
		for(var i=0; i<funArray.length;i++){
			newId = getFunArrByI(i,0);//ȡ�ø�ID
			if(newId==parentId){
				break;
			}
		}
		return getLivNum(newId,livNum);
	}
}

//ȡ��������ĳһֵ������д�� i=����ĵ�i�� j=Ԫ��
function getFunArrByI(i,j,arr){
	if(typeof(arr)=="undefined"){
		arr = funArray;
	}
	return arr[i].split("|")[j];
}
//ȡ���ӽڵ㣬���սڵ�id��������
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

//����id�������򣬷�������
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