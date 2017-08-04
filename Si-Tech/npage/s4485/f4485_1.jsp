<%
    /********************
     * @ OpCode    :  4485
     * @ OpName    :  全网生效成员关系失败列表
     * @ CopyRight :  si-tech
     * @ Author    :  wangzn
     * @ Date      :  2010-3-18 10:03:36
     * @ Update    :  
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.GregorianCalendar" %>
<%
    String opCode = "4485";
    String opName = "全网生效成员关系失败列表";
    String workNo =(String)session.getAttribute("workNo");
		String workName =(String)session.getAttribute("workName");
		String powerRight =(String)session.getAttribute("powerRight");
		String Role =(String)session.getAttribute("Role");
		String orgCode =(String)session.getAttribute("orgCode");
		String regionCode = orgCode.substring(0,2);
		String groupId =(String)session.getAttribute("groupId");
		String ip_Addr =(String)session.getAttribute("ip_Addr");
		
		
		
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
 <title><%=opName%></title>
 <script type=text/javascript>
 	 var cuPageNum = 1; //当前页数
	 var pageRNum = 20; //每页显示记录数
	 var beginNum = 1;  //开始记录数
	 var endNum = 20;   //结束记录数
	 var sumNum = 20;   //总记录数 初始化为20
	 var sumPageNum = 1;//总页数
 	
 	
 	var params ="";
   function getDeployInfo(){
      if(!checkElement(document.getElementById('unit_id'))){
		  		return false;
	    }
      var unit_id = document.getElementById('unit_id').value;
      params = unit_id+"|";
      var sqlStr = "90000167";
	    var selType = "S";    //'S'单选；'M'多选
		  var retQuence = "0|1|2|3|4|5|";//返回字段
		  var fieldName = "本省集团名称|产品订购编号|全网客户名称|产品规格编码|产品规格名称|本省产品id|";//弹出窗口显示的列、列名
      var pageTitle = "全网产品本省对应关系信息查询";
      var retToField="cust_name|product_id|customer_name|productSpec_number|productSpec_name|id_no|";
      var path = "/npage/public/fPubSimpSel.jsp";
      path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
      path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
      path = path + "&selType=" + selType;
      path += "&params="+params;
      //alert(path);
      var retInfo = window.showModalDialog(path,"","dialogWidth:70;dialogHeight:35;");
      if(retInfo ==undefined){
      	return;
      }
      var chPos_field = retToField.indexOf("|");
      var chPos_retStr;
      var valueStr;
      var obj;
      while(chPos_field > -1)
      {
        obj = retToField.substring(0,chPos_field);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0,chPos_retInfo);
        document.all(obj).value = valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");  
      }	
   	
  }
  
  function getErrMemList(){
  	document.getElementById('memberListDiv').style.display = 'none';
 		var errMemList_Packet = new AJAXPacket("f4485_getErrMemList.jsp","生效成员关系失败列表，请稍候......");
 		errMemList_Packet.data.add("beginNum",beginNum);
 		errMemList_Packet.data.add("endNum",endNum);
 		errMemList_Packet.data.add("id_no",$("#id_no").val());
 		errMemList_Packet.data.add("product_id",$("#product_id").val());
		core.ajax.sendPacket(errMemList_Packet,doGetErrMemList,true);
		errMemList_Packet=null;	
  }
  function doGetErrMemList(packet){
  	var returnCode = packet.data.findValueByName("returnCode"); 
  	var returnMessage = packet.data.findValueByName("returnMessage"); 
  	var resultArray = packet.data.findValueByName("resultArray");
  	var resultCnt = packet.data.findValueByName("resultCnt");
  	if(returnCode=="000000"){
  		if(resultArray.length>0){
  			$("#memberList tr:gt(0)").remove();
  			sumNum = resultCnt;
  			sumPageNum = sumNum/pageRNum;
				if((sumPageNum+"").indexOf(".")!=-1){
					sumPageNum = (sumPageNum+"").substring(0,(sumPageNum+"").indexOf("."));
					sumPageNum = parseInt(sumPageNum)+1;
				}
  		}
  		document.getElementById('memberListDiv').style.display = '';
  		for(var i=0;i<resultArray.length;i++){
  			trObj ="<tr>"+
  						 "<td>"+resultArray[i][0]+"</td>"+
  						 "<td>"+resultArray[i][1]+"</td>"+
  						 "<td>"+resultArray[i][2]+"</td>"+
  						 "<td><input type='button' value='生效' onclick='reOperate(this,\""+resultArray[i][2]+"\")' class='b_text'></td>"+
  						 "</tr>";
  			$("#memberList").append(trObj);			 
  		}
  	}else{
  		rdShowMessageDialog("查询出错["+returnCode+"："+returnMessage+"]");
  	} 
  }
    function changePage(pFlag){
  	//alert("当前页数|"+cuPageNum+"\n每页显示记录数|"+pageRNum+"\n开始记录数|"+beginNum+"\n结束记录数"+endNum+"\n总记录数"+sumNum+"\n总页数"+sumPageNum);
  	if(pFlag=="S"){  																			//点击首页
  		 beginNum = 1;   
  		 endNum = pageRNum;     
  		 cuPageNum = 1;                             
		}else	if(pFlag=="E"){                                 //点击尾页
			beginNum = (sumPageNum-1)*pageRNum+1;
			endNum = sumNum;
			cuPageNum = sumPageNum;
		}else if(pFlag=="P"){                                 //上一页
			if(beginNum-pageRNum<=1){
				changePage("S");	//上一页为首页
			}else{
				beginNum = beginNum - pageRNum+1;
				if(beginNum==0) beginNum = 1;
				endNum = beginNum + pageRNum;	
				cuPageNum = cuPageNum-1;
			}	
		}else if(pFlag=="N"){																	//下一页
			if(endNum+pageRNum>sumNum){
				changePage("E");	//下一页为尾页	
			}else{
				endNum = endNum + pageRNum;
				beginNum = endNum - pageRNum+1; 
				if(beginNum==0) beginNum = 1;
				cuPageNum = cuPageNum+1;
			}
		}	
		
		//alert("beginNum|"+beginNum+"\n"+"endNum|"+endNum);
		getErrMemList();
		setShowPage(sumPageNum,cuPageNum);
  }
  function setShowPage(num1,num2){
  	$("#sumPageSpan").text(num1);
		$("#cuPageSpan").text(num2);
  }
  function reOperate(obj,phone_no){
  	var reOperate_Packet = new AJAXPacket("f4485_cfm.jsp","生效成员关系失败列表，请稍候......");
 		reOperate_Packet.data.add("unit_id",$("#unit_id").val());
 		reOperate_Packet.data.add("productSpec_number",$("#productSpec_number").val());
 		reOperate_Packet.data.add("product_id",$("#product_id").val());
 		reOperate_Packet.data.add("phone_no",phone_no);
 		reOperate_Packet.data.add("id_no",$("#id_no").val());
		core.ajax.sendPacket(reOperate_Packet,reOperateReturn,true);
		errMemList_Packet=null;
  	
  }
  function reOperateReturn(packet){
  	var returnCode = packet.data.findValueByName("returnCode"); 
  	var returnMessage = packet.data.findValueByName("returnMessage"); 
  	
  	if(returnCode=="000000"){
  		rdShowMessageDialog("操作成功！");
  	}else{
  		rdShowMessageDialog("查询出错["+returnCode+"："+returnMessage+"]");
  	}
  	getErrMemList();
  }
 </script>
</head>
<body>
<form name="form1" action="" method="post">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi"><%=opName%></div>
</div>
<input type='hidden' name='id_no' id = 'id_no' value='' />
<table cellspacing=0>
	<tr>
		<td class=blue>本省集团编号</td>
		<td class=blue>
			 <input type='text' name='unit_id' v_must='1' v_name='unit_id' id='unit_id' v_type='0_9'>
	     <font class='orange'>*</font>
    	 <input type='button' class='b_text' name='idNoQry' id='idNoQry' value='查询' onClick="getDeployInfo();" />
	 </td>
	 <td class=blue>本省集团名称</td>
		<td class=blue>
			 <input type='text' name='cust_name' v_must='1' v_name='cust_name' id='cust_name' Class="InputGrey" readOnly />   	 
	 </td>
	</tr>
	<tr>
	 	 <td class=blue>产品订购关系编码</td>
	   <td class=blue>
	   	 <input type='text' name='product_id' v_must='1' v_name='product_id' id='product_id' v_type='0_9' Class="InputGrey" readOnly />   	 
	   </td>
	   <td class=blue>全网客户名称</td>
	   <td class=blue>
			 <input type='text' name='customer_name' v_must='1' v_name='customer_name' id='customer_name' Class="InputGrey" readOnly />   	 
	   </td>
	</tr>
	<tr>
	   <td class=blue>产品规格编码</td>
	   <td class=blue>
	   	 <input type='text' name='productSpec_number' v_must='1' v_name='productSpec_number' id='productSpec_number' v_type='0_9' Class="InputGrey" readOnly />   	 
	   </td>
	   <td class=blue>产品规格名称</td>	
	   <td class=blue>
			 <input type='text' name='productSpec_name' v_must='1' v_name='productSpec_name' id='productSpec_name' Class="InputGrey" readOnly />   	 
	   </td>	
	</tr>   	
</table>
<br/>
<div id="memberListDiv" style="display:none" >
<table cellspacing=0 id="memberList">
	<tr>
		<th>序号</th>
		<th>产品订单号</th>
		<th>失败成员电话号码</th>
		<th>操作</th>
	<tr>
	
</table>
<table>
							  <div  style="font-size:12px" align="center">
			              <a href="#" onClick="changePage('S')"> 首页 </a>
			              <a href="#" onClick="changePage('P')"> 上一页 </a>
			              <a href="#" onClick="changePage('N')"> 下一页 </a>
			              <a href="#" onClick="changePage('E')"> 尾页 </a>
			              &nbsp;&nbsp;共<span id="sumPageSpan"></span>页&nbsp;&nbsp;&nbsp;
			              &nbsp;&nbsp;&nbsp;当前第<span id="cuPageSpan"></span>页
				       	</div>
</table>
</div>   	

<TABLE cellSpacing=0>
    <TR id="footer">        
        <TD align=center>
            <input class="b_foot" name="sure" id="sure" type=button value="查询" onclick="changePage('S');"/>
            <input class="b_foot" name='clear2' id='clear2' type='button' value="清除" onClick="window.location='f4485_1.jsp';" />
       <input class="b_foot" name="close2"  onClick="removeCurrentTab()" type=button value="关闭" />
        </TD>
    </TR>
</TABLE>
<jsp:include page="/npage/common/pwd_comm.jsp"/>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>