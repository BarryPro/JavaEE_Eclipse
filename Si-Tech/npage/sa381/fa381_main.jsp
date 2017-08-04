
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/common/pwd_comm.jsp" %>

<%
 response.setHeader("Pragma","No-cache");
 response.setHeader("Cache-Control","no-cache");
 response.setDateHeader("Expires", 0);
%>
<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName"); 
%>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
	<script language="javascript" type="text/javascript" 
		src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>  	
    <script language="javascript">
	var recordPerPage = 5; 			//每页记录数50
	var pageNumber = 1;					 //当前页数
	var lastNumber = 0;					 //最后一页的记录数    	
      onload=function(){
        //document.all.cus_pass.disabled = false;
      }
      function doReset(){
      	window.location.href = "fa381_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>"
      }
      
      function chgOperType(){
        var operType = $("#operType").val();
        if(operType=="0"){//订单编号
          $("#operNoTd").text("订单号码");
          $("#tr_tm").hide()
          $("#tr_ord").show()
        }
        else if ( operType=="2" )
        {
        	$("#tr_tm").show()
        	$("#tr_ord").hide()
        }
        else{
          $("#operNoTd").text("手机号码");
          $("#tr_tm").hide();
          $("#tr_ord").show();
        }
      }
      
      function queryInfo(){
      	if (  $("#operType").val()!="2"  )
      	{
      		if(!checkElement(document.all.operNo)) return false;
      	}


        $("#operType").attr("disabled" , true);
        $("#operNo").attr("disabled" , true);
        $("#tm_b").attr("disabled" , true);
        $("#tm_e").attr("disabled" , true);
    		var operType = $("#operType").val();
    		var operNo = $("#operNo").val();
        document.all.qryBtn.disabled = true;
        var myPacket = new AJAXPacket("fa381_ajax_qryInfo.jsp","正在查询信息，请稍候......");
        myPacket.data.add("operType",operType);
        myPacket.data.add("operNo",operNo);
        myPacket.data.add("opCode","<%=opCode%>");
        myPacket.data.add("opName","<%=opName%>");
        myPacket.data.add("tm_b",$("#tm_b").val());
        myPacket.data.add("tm_e",$("#tm_e").val());
        myPacket.data.add("qry_op_code",$("#qry_op_code").val());
        myPacket.data.add("recordPerPage",recordPerPage);
        myPacket.data.add("pageNumber",pageNumber);
        core.ajax.sendPacketHtml(myPacket,doQueryInfo,true);
        getdataPacket = null;
      }
      function doQueryInfo(data) {
        document.all.qryBtn.disabled = false;
        //找到添加表格的div
        var markDiv=$("#gongdans"); 
        //清空原有表格
        markDiv.empty();
        markDiv.append(data);
        $("#operation_pagination").show();
        var totalNum = $("#totalNum").val();
		document.all.recodeNum.value = $("#totalNum").val();
		document.all.nowPage.value= 1;
		
		//pageNumber=1;
		if(totalNum%recordPerPage==0){
			document.frm.tatolPages.value=totalNum/recordPerPage;
			lastNumber=recordPerPage;
		}else{
			document.frm.tatolPages.value=parseInt(totalNum/recordPerPage)+1;
			lastNumber=totalNum%recordPerPage;
		}        
      }
      
      //预占
      function preparedDo(obj,i){
      	//alert();
        //alert(obj.v_orderId);
        var packet = new AJAXPacket("ajax_preparedDo.jsp","正在进行预占处理，请稍等......");
				packet.data.add("orderId",obj.v_orderId); //订单号
				packet.data.add("phoneNo",obj.v_phone); //订单号
				//packet.data.add("phoneStatus",$("#phoneStatus"+i).val());
				core.ajax.sendPacket(packet,function(packet){
					var retCode = packet.data.findValueByName("retCode");
					var retMsg = packet.data.findValueByName("retMsg");
					
					if(retCode == "000000"){
						rdShowMessageDialog("预占成功！",2);
						$("#makeOrderBtn"+i).removeAttr("disabled");
						$("#preparedDoBtn"+i).attr("disabled",true);
						queryInfo();
					}else{
						rdShowMessageDialog( retCode+":"+retMsg , 0 );
					}
				});
      }
      
      //下单
      function makeOrder(obj,i){
        var orderId = obj.v_orderId; //订单平台订单ID
        var phone = obj.v_phone;
        var express = obj.v_comp_id;
        var orderItemId = obj.v_orderItemId;
        var lgst_id = $("#lgst_id_"+i).val();
        	obj.disabled = true
        if(express!="1"){ //非顺丰时候页面输入的  运单号
	        if ( "" == $("#lgst_id_"+i).val().trim() )
	        {
	        	rdShowMessageDialog("物流单号必须输入！",0);
	        	obj.disabled = false
	        	return false;
	        }
        
		 	timeout( i,lgst_id,phone , express , orderId ,"" );
        }
        else //顺丰直接确认
        {
        	timeout( i,"",phone , express , orderId ,"" );
        }
        queryInfo();
      }
      
      function timeout(statusCode,orderNos,phone,express,orderId,orderItemId , contactOrderNos) {
  	    
  	    var packet = new AJAXPacket("ajax_sub_MakeOrder.jsp","正在进行下单处理，请稍等......");
  	    packet.data.add("phone",phone); //服务号码
				packet.data.add("orderId",orderId); //订单平台订单ID
				packet.data.add("orderItemId",orderItemId); //订单平台订单子项ID
				packet.data.add("express",express); //快递
				packet.data.add("contactOrderNos", orderNos); //快递编号
				core.ajax.sendPacket(packet,function(packet){
					var retCode = packet.data.findValueByName("retCode");
					var retMsg = packet.data.findValueByName("retMsg");
					if(retCode == "000000"){
						rdShowMessageDialog("下单操作成功！",2);
						$("#printBtn"+statusCode).removeAttr("disabled");
						$("#makeOrderBtn"+statusCode).attr("disabled",true);
						$("#preparedDoBtn"+statusCode).attr("disabled",true);
					}else{
						rdShowMessageDialog("下单失败！错误代码："+retCode+"<br>错误信息："+retMsg,0);
					}
				});
  		}
  		
  		//打印 直接跳转到miso提供的页面，他们处理打印
  		function printInfo(obj,i){
			var orderId = obj.v_orderId; //订单平台订单ID
			var orderItemId = obj.v_orderItemId; //订单平台订单子项ID
			var phone = obj.v_phone; 
			var express = obj.v_express;
			$("#orderIdHid").val(orderId);
			$("#orderItemIdHid").val(orderItemId);
			$("#phoneHid").val(phone);
			$("#expressHid").val(express);
			var iWidth = window.screen.availWidth-50; //弹出窗口的宽度;
			var iHeight = window.screen.availHeight-50; //弹出窗口的高度;
   			var path="http://10.111.67.140:8086/delivery/waybill"
   				+"?mobile="+obj.v_lnk_pho; // phone
			window.open(path,"newwindow"
				,"height="+iHeight+", width="+iWidth+",top=10,left=10,"
				+"scrollbars=no, resizable=no,location=no, status=no");
       
  		}
      
      /***其他函数中要用到的过滤函数**/
      function codeChg(s)
      {
        var str = s.replace(/%/g, "%25").replace(/\+/g, "%2B").replace(/\s/g, "+"); // % + \s
        str = str.replace(/-/g, "%2D").replace(/\*/g, "%2A").replace(/\//g, "%2F"); // - * /
        str = str.replace(/\&/g, "%26").replace(/!/g, "%21").replace(/\=/g, "%3D"); // & ! =
        str = str.replace(/\?/g, "%3F").replace(/:/g, "%3A").replace(/\|/g, "%7C"); // ? : |
        str = str.replace(/\,/g, "%2C").replace(/\./g, "%2E").replace(/#/g, "%23"); // , . #
        return str;
      }

		function firstPage() //首页
		{
			if(pageNumber-1>0)
			{
				pageNumber = 1;
				document.all.nowPage.value = pageNumber;
				document.all.jump.value = pageNumber;
				queryInfo();
		
			}
		}
		function pageUp()
		{
			if(pageNumber-1>0)
			{
				pageNumber =	pageNumber - 1;		
				document.all.nowPage.value = pageNumber;
				document.all.jump.value = pageNumber;
				queryInfo(); 
			}
		}
		function pageDown()
		{
			if(pageNumber < document.frm.tatolPages.value*1)
			{
				pageNumber =	pageNumber + 1;
				
				document.all.nowPage.value = pageNumber;
				document.all.jump.value = pageNumber;
				queryInfo(); 
			}
		}
		function lastPage()
		{
			if(pageNumber < document.frm.tatolPages.value*1)
			{
				pageNumber =	document.frm.tatolPages.value;
				
				document.all.nowPage.value = pageNumber;
				document.all.jump.value = pageNumber;
				queryInfo();
			 }
		}
		
		function query_jump()
		{
			document.all.jump.value = document.all.jump.value.trim();
			if(document.all.jump.value.trim()=="")
			{
				document.all.jump.value = pageNumber;
				return false;
			}
			if(!forPosInt(document.all.jump))
			{
				document.all.jump.value = pageNumber;
				return false;
			}
			if(document.all.jump.value*1<1 || document.all.jump.value*1>document.all.tatolPages.value)
			{
				document.all.jump.value = pageNumber;
				return false;
			}
			if(document.all.jump.value != pageNumber)
			{
			pageNumber = document.all.jump.value;	
			document.all.nowPage.value = pageNumber;
			queryInfo();
			}
		}		
    </script>
  </head>
  <body>
    <form name="frm" method="POST" action="">
      <%@ include file="/npage/include/header.jsp" %>
      <input type="hidden" id="opCode" name="opCode" value="<%=opCode%>" />
      <input type="hidden" id="opName" name="opName" value="<%=opName%>" />
      <div class="title">
      <div id="title_zi"><%=opName%></div>
      </div>
      <table cellspacing="0" >
        <tr>
          <td class="blue" width="15%">查询条件</td>
          <td colspan = '5'>
              <select align="left" id="operType" name="operType" onchange="chgOperType()">
               	<option class="button" value="1">办理手机号码</option>
                <option class="button" value="0">订单号码</option>
                <option class="button" value="2">下单时间</option>
              </select>
          </td>
        </tr>
        <tr id = "tr_ord" >
          <td width="15%" class="blue" id="operNoTd">手机号码</td>
          <td  colspan = '5'>
            <input type="text" id="operNo" name="operNo" value="" v_must="1" />
          </td>
        </tr>
        <tr id = 'tr_tm' style='display:none'>
          <td width="15%" class="blue" id="">下单开始时间</td>
          <td>
            <input type="text" id="tm_b"  name="tm_b" readOnly onclick="WdatePicker({el:'tm_b',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true,maxDate:'#F{$dp.$D(\'tm_e\')||\'%y-%M-%d\'}',minDate:'#{%y-6}-01-01'})"/>
							<img id = "imgCustStart" 
								onclick="WdatePicker({el:'tm_b',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true,maxDate:'#F{$dp.$D(\'tm_e\')||\'%y-%M-%d\'}',minDate:'#{%y-6}-01-01'})" 
			 					src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">

          </td>

          <td width="15%" class="blue" id="">下单结束时间</td>
          <td>
            <input type="text" id="tm_e"  name="tm_e" readOnly onclick="WdatePicker({el:'tm_e',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true,minDate:'#F{$dp.$D(\'tm_b\')}',maxDate:'%y-%M-%d'})"/>
							<img id = "imgCustEnd" 
								onclick="WdatePicker({el:'tm_e',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true,minDate:'#F{$dp.$D(\'tm_b\')}',maxDate:'%y-%M-%d'})" 
			 					src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">

          </td>      
          <td width="15%" class="blue" id="">操作代码</td>
          <td>
          	<select id = 'qry_op_code' name = 'qry_op_code'>
          		<option value= 'g528'>g528-->省内18元套卡</option>
          		<option value = 'i279' >i279-->移动商城开户</option>
          	</select>
     		</td>       
        </tr>          
      </table>
      <table cellspacing="0">
        <tr>
          <td noWrap id="footer">
            <div align="center">
              <input type="button" id="qryBtn"  name="qryBtn" class="b_foot" value="查询" 
              		onclick="queryInfo()" />		
            &nbsp;
              <input name="back" onClick="doReset()" type="button" class="b_foot"  value="清除">
            &nbsp;
              <input type="button" name="close" class="b_foot" value="关闭" onClick="removeCurrentTab();"/>
            </div>
          </td>
        </tr>
      </table>
      <div id="gongdans">
      </div>	 
		<div  id="operation_pagination" style="display:none">
	 		[<a href="#" onclick="firstPage()"> 首页</a>]
			[<a href="#" onclick="pageUp()" > 上一页</a>]
			[<a href="#" onclick="pageDown()"> 下一页</a>]
			[<a href="#" onclick="lastPage()" > 尾页</a>]
			&nbsp;&nbsp;&nbsp;&nbsp;共&nbsp;
			<input readonly type="text" size="4" class="likebutton2" name="tatolPages" 
				value="1">页
			&nbsp; 当前第&nbsp;
			<input  readonly type="text" size="4" class="likebutton2" name="nowPage" 
				value="1">页 
			&nbsp;&nbsp;转到第&nbsp;
			<input type="text" size="4" name="jump" value="1" 
				onkeydown="if(event.keyCode==13)query_jump()">页
			&nbsp
			<input type="button"class="b_text" name="jump_button" value="跳转" 
				onclick="query_jump();"/>
			&nbsp;&nbsp;共&nbsp;
			<input type="text" readonly size="4" class="likebutton2" 
				name="recodeNum" value="0">条记录
		</div>	
      
      <%@ include file="/npage/include/footer.jsp" %>
    </form>
  </body>
</html>