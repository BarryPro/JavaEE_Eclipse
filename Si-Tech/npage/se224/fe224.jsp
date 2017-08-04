<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/common/pwd_comm.jsp" %>
<%@ include file="/npage/sq100/getIccidFtpPas.jsp" %>
<%@ page import="import java.text.SimpleDateFormat;"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>国际漫游GPRS套餐办理</title>
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
  
  String opCode = "e224";
  String opName = "国际漫游GPRS套餐办理";
  //String opCode = (String)request.getParameter("opCode");
  //String opName = (String)request.getParameter("opName");
  String workNo = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String) session.getAttribute("password");
  String nianyueri="";
  String current_timeNAME1=new SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date());
  String current_timeNAME2=new SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date());
  String current_timeNAME3=new SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date());
  nianyueri=current_timeNAME1+"年"+current_timeNAME2+"月"+current_timeNAME3+"日";
  //String sql1 ="select  a.cust_name  from dcustdoc a, dcustmsg b where a.cust_id = b.cust_id  and phone_no='"+activePhone+"'";
  
  String  inParams [] = new String[2];
  inParams[0] = "select  a.cust_name  from dcustdoc a, dcustmsg b where a.cust_id = b.cust_id  and phone_no=:phoneno";
  inParams[1] = "phoneno="+activePhone;
  String custname="";
  String ZSCustName11="";
  
  /* 获取 资费编码，资费名称@2013/1/25 */
  String sql_offerIds = "select a.offer_id, " 
                        +" a.offer_name, "     
                        +" a.offer_comments, "   
                        +" a.offer_attr_type, " 
                        +" a.eff_type, "        
                        +" a.exp_type "        
                        +" from product_offer  a " 
                        +" where a.offer_attr_type ='YnRM' " 
                        +" and a.eff_date<sysdate "
                        +" and a.exp_date>sysdate ";
   String contrySql = "SELECT code_id,code_name FROM pd_unicodedef_dict WHERE code_class = 'CODE01'";                   


	 String  inParamsGetCountry [] = new String[2];
	 inParamsGetCountry[0] = 
	 "SELECT m.code_id, m.code_name																							"
	+"  FROM pd_unicodedef_dict m                                                "
	+" WHERE m.code_class = 'CODE01'                                             "
	+"   and m.code_id not in                                                    "
	+"       (select b.code_id                                                   "
	+"          from product_offer_instance a, pd_unicodedef_dict b              "
	+"         where a.serv_id =                                                 "
	+"               (select id_no from dcustmsg where phone_no =:phoneNo) "
	+"           and a.offer_id = to_number(trim(b.code_value))                  "
	+"           and b.code_class = 'CODE02'                                     "
	+"           and a.exp_date > sysdate)                                      ";


	 inParamsGetCountry[1] = "phoneNo="+activePhone;
%>
  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>"  id="loginAccept" />
  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="RetCode1" retmsg="RetMsg1" outnum="1"> 
    <wtc:param value="<%=inParams[0]%>"/>
    <wtc:param value="<%=inParams[1]%>"/> 
  </wtc:service>  
  <wtc:array id="result1"  scope="end"/>
  	
  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_mail" retmsg="retMessage_mail" outnum="2"> 
    <wtc:param value="<%=inParamsGetCountry[0]%>"/>
    <wtc:param value="<%=inParamsGetCountry[1]%>"/> 
  </wtc:service>  
  <wtc:array id="result_GetCountry"  scope="end"/>
  	
  
<%
  if(RetCode1.equals("000000")) {
    custname=result1[0][0];
    
    	if(!("").equals(custname)) {
	
			if(custname.length() == 2 ){
				ZSCustName11 = custname.substring(0,1)+"*";
			}
			if(custname.length() == 3 ){
				ZSCustName11 = custname.substring(0,1)+"**";
			}
			if(custname.length() == 4){
				ZSCustName11 = custname.substring(0,2)+"**";
			}
			if(custname.length() > 4){
				ZSCustName11 = custname.substring(0,2)+"******";
			}
		}
  }else{
%>
  <script language="javascript">
    rdShowMessageDialog("错误代码：" + RetCode1 + "，错误信息：" + RetMsg1,0);
  </script>
<%
	}
%>
 
  	
  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_contry" retmsg="retMsg_contry" outnum="2"> 
    <wtc:param value="<%=contrySql%>"/>
  </wtc:service>  
  <wtc:array id="contryArr"  scope="end"/>

   
<%
  
%>

  <script language="javascript">
  	
  	$(document).ready(function(){
			selOpFlag();
		});
		
    var ioprcode="01";
    function save(){
    	
    	/*国家下拉列表*/
  		var contrySel = $.trim($("select[name='contrySel']").find("option:selected").val());
  		/*国家下拉列表*/
  		var contrySelText = $.trim($("select[name='contrySel']").find("option:selected").text());
  		/*天数下拉列表*/
  		var daynumSel = $.trim($("select[name='daynumSel']").find("option:selected").val());
  		
  		if(contrySel == "$$"){
  			rdShowMessageDialog("请选择国家、地区！",1);
  			reSetOffer();
  			return false;
  		}
  		if(daynumSel == "$$"){
  			rdShowMessageDialog("请选择天数！",1);
  			reSetOffer();
  			return false;
  		}
  		
  		var offerIdHiden = $.trim($("#offerIdHiden").val());
  		var offerName = $.trim($("#offerName").val());
      var needMoney = $.trim($("#needMoney").val());
      
      if(offerIdHiden.length == 0 ){
      	rdShowMessageDialog("国家、地区："+contrySelText+"，"+daynumSel+"天未查询到资费信息，请重试！",1);
      	reSetOffer();
  			return false;
      }
    	
     	$("#ioprcode").val("01");
     	
      var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
      if(typeof(ret)!="undefined"){
        if((ret=="confirm")){
          if(rdShowConfirmDialog('确认要提交信息吗？')==1){
            frmCfm();
          }
        }
        if(ret=="continueSub"){
          if(rdShowConfirmDialog('确认要提交信息吗？')==1){
            frmCfm();
          }
        }
      }else{
        if(rdShowConfirmDialog('确认要提交信息吗？')==1){
          frmCfm();
        }
      }
    }
      
		function frmCfm(){
      frm.submit();
      return true;
    }

    function showPrtDlg(printType,DlgMessage,submitCfm){  //显示打印对话框 
      var h=180;
      var w=350;
      var t=screen.availHeight/2-h/2;
      var l=screen.availWidth/2-w/2;		   	   
      var pType="subprint";             				 	//打印类型：print 打印 subprint 合并打印
      var billType="1";              				 			  //票价类型：1电子免填单、2发票、3收据
      var sysAccept =<%=loginAccept%>;   
      var printStr = printInfo(printType);
      var mode_code=null;           							  //资费代码
      var fav_code=null;                				 		//特服代码
      var area_code=null;             				 		  //小区代码
      var opCode="e224" ;                   			 	//操作代码
      var phoneNo="<%=activePhone%>";                  //客户电话
      
      var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
      var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
      path+="&mode_code="+mode_code+
      	"&fav_code="+fav_code+"&area_code="+area_code+
      	"&opCode=<%=opCode%>&sysAccept="+sysAccept+
      	"&phoneNo="+phoneNo+
      	"&submitCfm="+submitCfm+"&pType="+
      	pType+"&billType="+billType+ "&printInfo=" + printStr;
      var ret=window.showModalDialog(path,printStr,prop);
      return ret;
    }				
			
    function printInfo(printType){
    	
    	/*国家下拉列表*/
  		var contrySel = $.trim($("select[name='contrySel']").find("option:selected").val());
  			/*国家下拉列表*/
  		var contrySelText = $.trim($("select[name='contrySel']").find("option:selected").text());
  		/*天数下拉列表*/
  		var daynumSel = $.trim($("select[name='daynumSel']").find("option:selected").val());
  		
  		var offerName = $("#offerName").val();
  		var needMoney = $("#needMoney").val();
    	
      var cust_info="";
      var opr_info="";
      var note_info1="";
      var note_info2="";
      var note_info3="";
      var note_info4="";
      var retInfo = "";
      
      cust_info+="手机号码：   "+"<%=activePhone%>"+"|";
      cust_info+="客户姓名：   "+"<%=custname%>"+"|";
      opr_info+="业务类型：国际漫游GPRS开通"+"|";
      opr_info+="国家、地区："+contrySelText+"|";
      opr_info+="天数："+daynumSel+"天|";
      opr_info+="金额："+needMoney+"元|";
        
      if("AYX" == contrySel)
			{
				note_info1+="备注：尊敬的客户，您订购的"+offerName+"已经生效，开通此项业务后，您在"+contrySelText+"与中国移动达成漫游协议的运营商网络上漫游时，从首次产生流量当天起，"+daynumSel+"个自然天内在所有适用地区使用流量不再额外收费，通常情况下可无限使用数据流量。套餐费用"+needMoney+"元一次性收取，支付成功后，业务订购成功，购买成功后不可退订。该套餐需在9月30日前使用，到期套餐失效且不予退费。不限流量套餐服务可能受当地运营商网络运营商公平使用原则约束，当客户于短时间内使用过多流量或达到公平使用量，当地运营商可能会对客户暂停上网服务或进行限速，敬请知晓。"+"|";
      	
      }else{
      	note_info1+="备注：尊敬的客户，您订购的"+offerName+"已经生效，开通此项业务后，您在"+contrySelText+"与中国移动达成漫游协议的运营商网络上漫游时，从首次产生流量当天起连续"+daynumSel+"天内，通常情况下，可无限量使用移动数据流量。套餐费"+needMoney+"元一次性收取，支付成功后业务订购成功；购买成功后不可退订。如在订购成功后１８０天内未使用套餐内容的，套餐失效且不予退费。不限流量套餐服务可能受各地运营商网络公平使用原则约束，当客户于短时间内使用过多流量或达到公平使用量，当地运营商可能会对客户暂停上网服务或进行限速，敬请知晓。  "+"|";
    	}
      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    }
    
    /*2015/12/25 10:50:16 gaopeng 查询已办理和可办理 */
    function selOpFlag(){
      
      
    }
    
    function dogetOfferInfo(packet){
			var retCode = packet.data.findValueByName("retCode");
      var retMsg = packet.data.findValueByName("retMsg");
      
      if(retCode == "000000"){
      	var offerId = packet.data.findValueByName("offerId");
      	var offerName = packet.data.findValueByName("offerName");
      	var offerFee = packet.data.findValueByName("offerFee");
      	
      	$("#offerIdHiden").val(offerId);
      	$("#offerName").val(offerName);
      	$("#needMoney").val(offerFee);
      }else{
      	rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
      	reSetOffer();
      }
     
    }
    
    function reSetOffer(){
    	$("#offerIdHiden").val("");
    	$("#offerName").val("");
      $("#needMoney").val("");
    }
    
    function reSetTab(){
      window.location.href="fe224.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=activePhone%>";
    }
    var daynumArrayNormal = [3,5,7];
    var daynumArraySpecial = [7];
    var daynumArraySpecialA = [7,15];
    function changeCountry(){
    	reSetOffer();
    	var daynumSelObj = $("select[name='daynumSel']");
    	daynumSelObj.empty();
  		$("<option value='$$'>--请选择--</option>").appendTo(daynumSelObj);
  		
    	/*国家下拉列表*/
  		var contrySel = $.trim($("select[name='contrySel']").find("option:selected").val());
    	if(contrySel == "$$"){
  			rdShowMessageDialog("请选择国家、地区！",1);
  			reSetOffer();
  			return false;
  		}
  		/*赋值天数*/
  		if("AYX" == contrySel)
			{
				for(var i=0 ;i<daynumArraySpecialA.length;i++){
      			$("<option value='"+daynumArraySpecialA[i]+"' >"+daynumArraySpecialA[i]+"</option>").appendTo(daynumSelObj);
      		}
			}
  		else if("EU" != contrySel){
      		for(var i=0 ;i<daynumArrayNormal.length;i++){
      			$("<option value='"+daynumArrayNormal[i]+"' >"+daynumArrayNormal[i]+"</option>").appendTo(daynumSelObj);
      		}
  		}
  		else{
      		for(var i=0 ;i<daynumArraySpecial.length;i++){
      			$("<option value='"+daynumArraySpecial[i]+"' >"+daynumArraySpecial[i]+"</option>").appendTo(daynumSelObj);
      		}
  		}
  		
    }
    
   	/**/
    function giveMoneyFee(){
    	
    	/*国家下拉列表*/
  		var contrySel = $.trim($("select[name='contrySel']").find("option:selected").val());
  		/*天数下拉列表*/
  		var daynumSel = $.trim($("select[name='daynumSel']").find("option:selected").val());
  		
  		if(contrySel == "$$"){
  			rdShowMessageDialog("请选择国家、地区！",1);
  			reSetOffer();
  			return false;
  		}
  		if(daynumSel == "$$"){
  			rdShowMessageDialog("请选择天数！",1);
  			reSetOffer();
  			return false;
  		}
  		var phoneNo = $("#phoneNo").val();
  		/*调用方法查询资费和金额*/
  		var packet = new AJAXPacket("/npage/se224/fe224Qry.jsp","正在获得数据，请稍候......");
    	packet.data.add("phoneNo",phoneNo);
    	packet.data.add("opCode","<%=opCode%>");
    	packet.data.add("opName","<%=opName%>");
    	
    	packet.data.add("countryCode",contrySel);
    	packet.data.add("dayNum",daynumSel);
    	
    	core.ajax.sendPacket(packet,dogetOfferInfo);
    	packet = null;
  		
    	
    }
   
		</script>
		<body>
		  <form name="frm" method="POST" action="fe224_1.jsp">
	    <%@ include file="/npage/include/header.jsp" %>
		    <div class="title">
		      <div id="title_zi"><%=opName%></div><p align="center"></p>
	      </div>
        <table cellspacing="0">
				  <tr>
			      <td class="blue" width="25%">手机号码</td>
			      <td>
						  <input type="text" id="phoneNo" name="phoneNo"  v_must="1" 	v_type="mobphone" maxlength="11" onblur="checkElement(this)" readOnly  Class="InputGrey" value ="<%=activePhone%>"/>
			        <font class="orange">*</font>
	          </td>
	          <td class="blue" width="25%">客户姓名</td>
			      <td>
							<input type="text" id="custname" name="custname"  v_must="1" v_type="mobphone" maxlength="11" onblur="checkElement(this)" readOnly  Class="InputGrey" value ="<%=ZSCustName11%>"/>
			        <font class="orange">*</font>
	          </td>
		      </tr>
          <tr>
            <td class="blue" width="25%">操作类型</td>
            <td colspan="3">
              <input type="radio" name="opFlag" id="11" value="one"   checked onclick="selOpFlag()" />申请&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <!-- <input type="radio" name="opFlag" id="22" value="two" onclick="selOpFlag()" />取消-->
            </td>
          </tr>
          <tr>
          	<td class="blue" width="25%">国家、地区</td>
          	<td width="25%">
          		<select id="contrySel" name="contrySel"  style="width:220px" onchange="changeCountry();">
          			<option value="$$" selected>--请选择--</option>
                <%
                	if(result_GetCountry.length > 0 && retCode_mail.equals("000000")){
                		for(int i=0;i<result_GetCountry.length;i++){
                		%>
                			<option value="<%=result_GetCountry[i][0]%>" ><%=result_GetCountry[i][1]%></option>
                		<%
                		}
                	}
                
                %>
          		</select>	
          	</td>
          	<td class="blue" width="25%">天数</td>
          	<td width="25%">
          		<select id="daynumSel" name="daynumSel"  style="width:220px" onchange="giveMoneyFee();">
          			<option value="$$" selected>--请选择--</option>
                  
          		</select>	
          	</td>
          </tr>
          
          <tr id="needMoneyShow" style="display:block">
          	<td class="blue" width="25%">资费名称</td>
          	<td>
          		<input type="text" name="offerName" id="offerName" value="" style="width:250px;" class="InputGrey" size="40" readonly/>
          	</td>
          	<td class="blue" width="25%">金额</td>
          	<td>
          		<input type="text" name="needMoney" id="needMoney" value="" class="InputGrey" readonly/>（单位：元）
          	</td>
          	
          </tr>
          
        </table>
        <table cellspacing="0">
          <tr>
            <td noWrap id="footer">
              <div align="center">	
                <input type="button" name="quchoose" class="b_foot" value="确定&打印" onclick="save()" />		
                &nbsp;
                <input type="button" name="close" class="b_foot" value="关闭" onClick="removeCurrentTab();">
              </div>
            </td>
          </tr>
        </table>
        <input type="hidden" id="opCode" name="opCode"  value="<%=opCode%>" />
        <input type="hidden" id="opName" name="opName"  value="<%=opName%>" />
      	<input type="hidden" name="phoneNo"  value="<%=activePhone%>" />
      	<input type="hidden" id="ioprcode" name="ioprcode"  value="" />
      	<input type="hidden" name="loginAccept"  value="<%=loginAccept%>">
      	<input type="hidden" id="offerIdHiden" name="offerIdHiden"  value="" />
      	<input type="hidden" id="effectWayHiden" name="effectWayHiden"  value="" />
      </form>
    </body>
</html>