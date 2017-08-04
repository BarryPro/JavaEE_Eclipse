
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
	var recordPerPage = 5; 			//ÿҳ��¼��50
	var pageNumber = 1;					 //��ǰҳ��
	var lastNumber = 0;					 //���һҳ�ļ�¼��    	
      onload=function(){
        //document.all.cus_pass.disabled = false;
      }
      function doReset(){
      	window.location.href = "fa381_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>"
      }
      
      function chgOperType(){
        var operType = $("#operType").val();
        if(operType=="0"){//�������
          $("#operNoTd").text("��������");
          $("#tr_tm").hide()
          $("#tr_ord").show()
        }
        else if ( operType=="2" )
        {
        	$("#tr_tm").show()
        	$("#tr_ord").hide()
        }
        else{
          $("#operNoTd").text("�ֻ�����");
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
        var myPacket = new AJAXPacket("fa381_ajax_qryInfo.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
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
        //�ҵ���ӱ���div
        var markDiv=$("#gongdans"); 
        //���ԭ�б��
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
      
      //Ԥռ
      function preparedDo(obj,i){
      	//alert();
        //alert(obj.v_orderId);
        var packet = new AJAXPacket("ajax_preparedDo.jsp","���ڽ���Ԥռ�������Ե�......");
				packet.data.add("orderId",obj.v_orderId); //������
				packet.data.add("phoneNo",obj.v_phone); //������
				//packet.data.add("phoneStatus",$("#phoneStatus"+i).val());
				core.ajax.sendPacket(packet,function(packet){
					var retCode = packet.data.findValueByName("retCode");
					var retMsg = packet.data.findValueByName("retMsg");
					
					if(retCode == "000000"){
						rdShowMessageDialog("Ԥռ�ɹ���",2);
						$("#makeOrderBtn"+i).removeAttr("disabled");
						$("#preparedDoBtn"+i).attr("disabled",true);
						queryInfo();
					}else{
						rdShowMessageDialog( retCode+":"+retMsg , 0 );
					}
				});
      }
      
      //�µ�
      function makeOrder(obj,i){
        var orderId = obj.v_orderId; //����ƽ̨����ID
        var phone = obj.v_phone;
        var express = obj.v_comp_id;
        var orderItemId = obj.v_orderItemId;
        var lgst_id = $("#lgst_id_"+i).val();
        	obj.disabled = true
        if(express!="1"){ //��˳��ʱ��ҳ�������  �˵���
	        if ( "" == $("#lgst_id_"+i).val().trim() )
	        {
	        	rdShowMessageDialog("�������ű������룡",0);
	        	obj.disabled = false
	        	return false;
	        }
        
		 	timeout( i,lgst_id,phone , express , orderId ,"" );
        }
        else //˳��ֱ��ȷ��
        {
        	timeout( i,"",phone , express , orderId ,"" );
        }
        queryInfo();
      }
      
      function timeout(statusCode,orderNos,phone,express,orderId,orderItemId , contactOrderNos) {
  	    
  	    var packet = new AJAXPacket("ajax_sub_MakeOrder.jsp","���ڽ����µ��������Ե�......");
  	    packet.data.add("phone",phone); //�������
				packet.data.add("orderId",orderId); //����ƽ̨����ID
				packet.data.add("orderItemId",orderItemId); //����ƽ̨��������ID
				packet.data.add("express",express); //���
				packet.data.add("contactOrderNos", orderNos); //��ݱ��
				core.ajax.sendPacket(packet,function(packet){
					var retCode = packet.data.findValueByName("retCode");
					var retMsg = packet.data.findValueByName("retMsg");
					if(retCode == "000000"){
						rdShowMessageDialog("�µ������ɹ���",2);
						$("#printBtn"+statusCode).removeAttr("disabled");
						$("#makeOrderBtn"+statusCode).attr("disabled",true);
						$("#preparedDoBtn"+statusCode).attr("disabled",true);
					}else{
						rdShowMessageDialog("�µ�ʧ�ܣ�������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
					}
				});
  		}
  		
  		//��ӡ ֱ����ת��miso�ṩ��ҳ�棬���Ǵ����ӡ
  		function printInfo(obj,i){
			var orderId = obj.v_orderId; //����ƽ̨����ID
			var orderItemId = obj.v_orderItemId; //����ƽ̨��������ID
			var phone = obj.v_phone; 
			var express = obj.v_express;
			$("#orderIdHid").val(orderId);
			$("#orderItemIdHid").val(orderItemId);
			$("#phoneHid").val(phone);
			$("#expressHid").val(express);
			var iWidth = window.screen.availWidth-50; //�������ڵĿ��;
			var iHeight = window.screen.availHeight-50; //�������ڵĸ߶�;
   			var path="http://10.111.67.140:8086/delivery/waybill"
   				+"?mobile="+obj.v_lnk_pho; // phone
			window.open(path,"newwindow"
				,"height="+iHeight+", width="+iWidth+",top=10,left=10,"
				+"scrollbars=no, resizable=no,location=no, status=no");
       
  		}
      
      /***����������Ҫ�õ��Ĺ��˺���**/
      function codeChg(s)
      {
        var str = s.replace(/%/g, "%25").replace(/\+/g, "%2B").replace(/\s/g, "+"); // % + \s
        str = str.replace(/-/g, "%2D").replace(/\*/g, "%2A").replace(/\//g, "%2F"); // - * /
        str = str.replace(/\&/g, "%26").replace(/!/g, "%21").replace(/\=/g, "%3D"); // & ! =
        str = str.replace(/\?/g, "%3F").replace(/:/g, "%3A").replace(/\|/g, "%7C"); // ? : |
        str = str.replace(/\,/g, "%2C").replace(/\./g, "%2E").replace(/#/g, "%23"); // , . #
        return str;
      }

		function firstPage() //��ҳ
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
          <td class="blue" width="15%">��ѯ����</td>
          <td colspan = '5'>
              <select align="left" id="operType" name="operType" onchange="chgOperType()">
               	<option class="button" value="1">�����ֻ�����</option>
                <option class="button" value="0">��������</option>
                <option class="button" value="2">�µ�ʱ��</option>
              </select>
          </td>
        </tr>
        <tr id = "tr_ord" >
          <td width="15%" class="blue" id="operNoTd">�ֻ�����</td>
          <td  colspan = '5'>
            <input type="text" id="operNo" name="operNo" value="" v_must="1" />
          </td>
        </tr>
        <tr id = 'tr_tm' style='display:none'>
          <td width="15%" class="blue" id="">�µ���ʼʱ��</td>
          <td>
            <input type="text" id="tm_b"  name="tm_b" readOnly onclick="WdatePicker({el:'tm_b',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true,maxDate:'#F{$dp.$D(\'tm_e\')||\'%y-%M-%d\'}',minDate:'#{%y-6}-01-01'})"/>
							<img id = "imgCustStart" 
								onclick="WdatePicker({el:'tm_b',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true,maxDate:'#F{$dp.$D(\'tm_e\')||\'%y-%M-%d\'}',minDate:'#{%y-6}-01-01'})" 
			 					src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">

          </td>

          <td width="15%" class="blue" id="">�µ�����ʱ��</td>
          <td>
            <input type="text" id="tm_e"  name="tm_e" readOnly onclick="WdatePicker({el:'tm_e',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true,minDate:'#F{$dp.$D(\'tm_b\')}',maxDate:'%y-%M-%d'})"/>
							<img id = "imgCustEnd" 
								onclick="WdatePicker({el:'tm_e',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true,minDate:'#F{$dp.$D(\'tm_b\')}',maxDate:'%y-%M-%d'})" 
			 					src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">

          </td>      
          <td width="15%" class="blue" id="">��������</td>
          <td>
          	<select id = 'qry_op_code' name = 'qry_op_code'>
          		<option value= 'g528'>g528-->ʡ��18Ԫ�׿�</option>
          		<option value = 'i279' >i279-->�ƶ��̳ǿ���</option>
          	</select>
     		</td>       
        </tr>          
      </table>
      <table cellspacing="0">
        <tr>
          <td noWrap id="footer">
            <div align="center">
              <input type="button" id="qryBtn"  name="qryBtn" class="b_foot" value="��ѯ" 
              		onclick="queryInfo()" />		
            &nbsp;
              <input name="back" onClick="doReset()" type="button" class="b_foot"  value="���">
            &nbsp;
              <input type="button" name="close" class="b_foot" value="�ر�" onClick="removeCurrentTab();"/>
            </div>
          </td>
        </tr>
      </table>
      <div id="gongdans">
      </div>	 
		<div  id="operation_pagination" style="display:none">
	 		[<a href="#" onclick="firstPage()"> ��ҳ</a>]
			[<a href="#" onclick="pageUp()" > ��һҳ</a>]
			[<a href="#" onclick="pageDown()"> ��һҳ</a>]
			[<a href="#" onclick="lastPage()" > βҳ</a>]
			&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;
			<input readonly type="text" size="4" class="likebutton2" name="tatolPages" 
				value="1">ҳ
			&nbsp; ��ǰ��&nbsp;
			<input  readonly type="text" size="4" class="likebutton2" name="nowPage" 
				value="1">ҳ 
			&nbsp;&nbsp;ת����&nbsp;
			<input type="text" size="4" name="jump" value="1" 
				onkeydown="if(event.keyCode==13)query_jump()">ҳ
			&nbsp
			<input type="button"class="b_text" name="jump_button" value="��ת" 
				onclick="query_jump();"/>
			&nbsp;&nbsp;��&nbsp;
			<input type="text" readonly size="4" class="likebutton2" 
				name="recodeNum" value="0">����¼
		</div>	
      
      <%@ include file="/npage/include/footer.jsp" %>
    </form>
  </body>
</html>