<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="import java.text.SimpleDateFormat;"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title></title>
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
  

  String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
  String workNo = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");

%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>"  id="loginAccept" />
  <script language="javascript">
    var ioprcode="";
    function save(){
    
  if(document.all.custname.value.trim() ==""){
  rdShowMessageDialog("请填写用户姓名！",1);
  return false;
  }
    if(document.all.idType.value =="00"){//二代证
   		if( document.all.idIccid.value.trim().len() != 18) 	{
		  rdShowMessageDialog("身份证证件号码长度必须是18位！");
		  return false;
		}
  }else {
  	if(document.all.idIccid.value.trim()=="") {
  			  rdShowMessageDialog("请输入证件号码！");
  			   return false;
  			}
		 
  	}
  if(document.all.yhzh.value.trim() ==""){
  rdShowMessageDialog("请填写银行账号！",1);
  return false;
  }
  
  if(document.all.jffs.value.trim()=="0") {
  	
  }else {
  		if(document.all.RechAmount.value.trim()=="") {
  			  rdShowMessageDialog("请填写充值金额！",1);
  				return false;
  		}
  		 if(document.all.RechThreshold.value.trim()=="") {
  			  rdShowMessageDialog("请填写阀值！",1);
  				return false;
  		}
  }
/*
      var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
      if(typeof(ret)!="undefined"){
        if((ret=="confirm")){
          if(rdShowConfirmDialog('确认电子免填单吗？')==1){
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
			*/
      frmCfm();
    }
    /*
    function doProcess(packet){
      var retCode = packet.data.findValueByName("retcode");
      var retMsg = packet.data.findValueByName("retmsg");
      if(retCode == "000000"){
        rdShowMessageDialog("功能申请成功！",2);
      }else{
        rdShowMessageDialog("错误代码：" + retCode + "，错误信息：" + retMsg,0);
        return false;
      }
    }
    */
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
      var sysAccept =<%=loginAccept%>;             	//流水号
      if(ioprcode=="03"){//申请
        var printStr = printInfo(printType);
      }
      if(ioprcode=="04"){//取消
        var printStr = printInfo1(printType);
      }		 		                      //调用printinfo()返回的打印内容
      var mode_code=null;           							  //资费代码
      var fav_code=null;                				 		//特服代码
      var area_code=null;             				 		  //小区代码
      var opCode="<%=opCode%>" ;                   			 	//操作代码
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
      var offerIdSelVal = $("#offerIdHiden").val();
      var cust_info="";
      var opr_info="";
      var note_info1="";
      var note_info2="";
      var note_info3="";
      var note_info4="";
      var retInfo = "";
      
      cust_info+="手机号码：   "+"<%=activePhone%>"+"|";
      cust_info+="客户姓名：   "+$("#custname").val()+"|";
      opr_info+="业务类型：国际漫游GPRS开通"+"|";
        
      //note_info1+="备注：尊敬的客户，您订购的国际及港澳台漫游数据流量日套餐已经生效，您在香港、澳门、台湾、韩国、新加坡、马来西亚、泰国7个国家和地区特定运营商网络上漫游时可以无限量使用移动数据流量，其中香港方向按照88元/日标准收取，其他方向按照98元/日标准收取费用，当日不产生流量不收取日套餐费，当日在两个以上方向产生流量则按照多个方向分别收取。发送QXGJGPRS1至10086可以取消日套餐。"+"|";
      if(offerIdSelVal=="35688"){ //日套餐
        note_info1+="备注：尊敬的客户，您订购的国际及港澳台漫游数据流量日套餐已经生效，您在香港、澳门、台湾、韩国、新加坡、马来西亚、泰国、巴基斯坦、日本、印尼和菲律宾11个国家和地区特定运营商网络上漫游时可以无限量使用移动数据流量，按照88元/日标准收取，当日不产生流量不收取日套餐费，当日在两个以上方向产生流量则按照多个方向分别收取。发送QXGJGPRS1至10086可以取消日套餐。"+"|";
      }

      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    }
    function printInfo1(printType){
      var offerIdSelVal = $("#offerIdHiden").val();
      var cust_info="";
      var opr_info="";
      var note_info1="";
      var note_info2="";
      var note_info3="";
      var note_info4="";
      
      var retInfo = "";
      
      cust_info+="手机号码：   "+"<%=activePhone%>"+"|";
      cust_info+="客户姓名：   "+$("#custname").val()+"|";
      opr_info+="业务类型：国际漫游GPRS开通取消"+"|";
        
      //note_info1+="备注：尊敬的客户，您订购的国际及港澳台漫游数据流量日套餐已经取消，感谢您对中国移动的支持。发送KTGJGPRS1至10086可以再次订购日套餐。"+"|";
      if(offerIdSelVal=="35688"){ //日套餐
        note_info1+="备注：尊敬的客户，您订购的国际及港澳台漫游数据流量日套餐已经取消，感谢您对中国移动的支持。发送KTGJGPRS1至10086可以再次订购日套餐。"+"|";
      }
      
      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    }
    
  
    

    
    function reSetTab(){
      window.location.href="fg940.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=activePhone%>";
    }
    
    function change_idType()//二代证
{   

      
    if(document.all.idType.value=="00")
    { 
    $("#iccidShowFlag").show();
     document.all.idIccid.v_type = "idcard";
    }
    else{
      $("#iccidShowFlag").hide();
      document.all.idIccid.v_type = "string";
   
  }
}
	function jiaofei() {
			    if(document.all.jffs.value=="0")
    { 
    $("#zdjf").hide();
    }
    else{
      $("#zdjf").show();
  
  }
	
	}
	
	function chenckyh() {
		  var yhzh = $("#yhzh").val();
		  var phoneNo = $("#phoneNo").val();
		  var idType = $("#idType").val();
		  var idIccid = $("#idIccid").val();
		  var custname = $("#custname").val();
		  var yhbm = $("#yhbm").val();
		  var yhzh = $("#yhzh").val();
		  var yhzhlx = $("#yhzhlx").val();
	  if(custname.trim() ==""){//二代证
	  rdShowMessageDialog("请填写用户姓名！",1);
	  return false;
	  }
    if(idType =="00"){//二代证
   		if(idIccid.trim().len() != 18) 	{
		  rdShowMessageDialog("身份证证件号码长度必须是18位！");
		  return false;
		  }
  }else {
  	if(idIccid.trim()=="") {
  			  rdShowMessageDialog("请输入证件号码！");
  			   return false;
  			}
		 
  	}
  if(yhzh.trim() ==""){//二代证
  rdShowMessageDialog("请填写银行账号！",1);
  return false;
  }
        var packet = new AJAXPacket("fg940_check.jsp","正在获得数据，请稍候......");
      	packet.data.add("phoneNo","<%=activePhone%>");
      	packet.data.add("yhzh",yhzh);
      	packet.data.add("idType",idType);
      	packet.data.add("custname",custname);
      	packet.data.add("yhbm",yhbm);
      	packet.data.add("yhzh",yhzh);
      	packet.data.add("yhzhlx",yhzhlx);
      	packet.data.add("idIccid",idIccid);
      	packet.data.add("opCode","<%=opCode%>");
      	packet.data.add("opName","<%=opName%>");
      	core.ajax.sendPacket(packet,dogetOfferInfo);
      	packet = null;
      
			
	}
function dogetOfferInfo(packet){
      var retcode = packet.data.findValueByName("retcode");
      var retmsg = packet.data.findValueByName("retmsg");
      if(retcode != "000000"){
        rdShowMessageDialog("校验银行账号失败！错误代码：" + retcode + "，错误信息：" + retmsg,0);
        document.all.quchoose.disabled=true;
      }else{
     		rdShowMessageDialog("校验银行账号成功",2);
 				document.all.quchoose.disabled=false;
      }
    }

		</script>
		<body>
		  <form name="frm" method="POST" action="fg940Cfm.jsp">
	    <%@ include file="/npage/include/header.jsp" %>
		    <div class="title">
		      <div id="title_zi"><%=opName%></div><p align="center"></p>
	      </div>
        <table cellspacing="0">
				  <tr>
			      <td class="blue" width="16%">手机号码</td>
			      <td>
						  <input type="text" id="phoneNo" name="phoneNo"  v_must="1" 	v_type="mobphone" maxlength="11" onblur="checkElement(this)" readOnly  Class="InputGrey" value ="<%=activePhone%>"/>
			        <font class="orange">*</font>
	          </td>
	          <td class="blue" width="16%">用户姓名</td>
			      <td>
							<input type="text" id="custname" name="custname"   value =""/>
			        <font class="orange">*</font>
	          </td>
		      </tr>
          <tr>
                 <td width=16% class="blue" > 
                    <div align="left">证件类型</div>
                  </td>
                  <td > 
                    <select align="left" name=idType id="idType" onChange="change_idType()" width=50 index="10">
                      <%
                      
        //得到输入参数
         String sqlStr3 ="select trim(ID_TYPE), ID_NAME,ID_LENGTH from sIdType order by id_type";           
 %>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode3" retmsg="retMsg3" outnum="3">
<wtc:sql><%=sqlStr3%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result3" scope="end" /> 
 <%
 /*
      if(retCode3.equals("000000")){
     
      System.out.println("调用服务成功！");
              int recordNum3 = result3.length;                  
                for(int i=0;i<recordNum3;i++){
                  //liujian 2013-5-15 9:41:05 默认第一项选中
                  if(i == 0) {
                    out.println("<option class='button' value='" + result3[i][0]  + "' selected>" + result3[i][1] + "</option>");
                  }else {
                    out.println("<option class='button' value='" + result3[i][0] + "'>"+ result3[i][0]+""+ result3[i][1] + "</option>");
                  }
                       
                }
      
       }else{
       System.out.println("***********************************************************************");
         System.out.println("调用服务失败！");
         
      }              
     */          
           
%>
										<option class='button' value='00'>居民身份证</option>
										<option class='button' value='01'>临时居民身份证</option>
										<option class='button' value='02'>户口簿（仅用于未成年客户）</option>
										<option class='button' value='03'>军人身份证件</option>
										<option class='button' value='04'>武装警察身份证件</option>
										<option class='button' value='05'>港澳居民往来内地通行证</option>
										<option class='button' value='06'>台湾居民来往大陆通行证</option>
										<option class='button' value='07'>护照</option>
										<option class='button' value='99'>其他证件</option>
                    </select>
                  </td>
                   <td width=16% class="blue" > 
                    <div align="left">证件号码</div>
                  </td>
                  <td > 
                    <input name="idIccid"  id="idIccid"   value=""  v_type="string"  maxlength="32"  value="" >
                    <font class=orange>*<span id="iccidShowFlag">请输入18位</span></font> 
                    
                    </td>
                    </tr>
                    <tr>
                 <TD width=16% class="blue" > 
                    <div align="left">银行编码</div>
                  </TD>
                  <TD >
                    <select align="left" id="yhbm" name="yhbm" onChange="reSetCustName()" width=50 index="6">
                      <option class="button" value="0004">建设银行</option>
                      <option class="button" value="0005">浦发银行</option>
                    </select>
                  </TD>
                                   <TD width=16% class="blue" > 
                    <div align="left">银行账号类型</div>
                  </TD>
                  <TD >
                    <select align="left" id="yhzhlx" name="yhzhlx" onChange="reSetCustName()" width=50 index="6">
                      <option class="button" value="0">借记卡</option>
                    </select>
                  </TD>
                  
          </tr>
          <tr>
          	
                 <TD width=16% class="blue" > 
                    <div align="left">银行账号</div>
                  </TD>
                  <TD >
							<input name="yhzh"  id="yhzh"   value=""  ><font class="orange">*</font>
							<input type="button"  class="b_text" value="校验" onclick="chenckyh()" >
                   
                  </TD>
                  <TD width=16% class="blue" > 
                    <div align="left">缴费方式</div>
                  </TD>
                  <TD >
                    <select align="left" id="jffs" name="jffs" onChange="jiaofei()" width=50 index="6">
                      <option class="button" value="0">主动缴费</option>
                      <option class="button" value="1">自动缴费</option>
                    </select>
                  </TD>
                  
         
          </tr>
          	<tr id="zdjf" style="display:none">
			      <td class="blue" width="16%">充值金额</td>
			      <td>
						  <input type="text" id="RechAmount" name="RechAmount"   maxlength="9" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)" value =""/>
			        <font class="orange">*单位为（分）</font>
	          </td>
	          <td class="blue" width="16%">阀值</td>
			      <td>
							<input type="text" id="RechThreshold" name="RechThreshold" maxlength="9" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)"  value ="" />
			        <font class="orange">*单位为（分）</font>
	          </td>
		      </tr>
          
        </table>
        <table cellspacing="0">
          <tr>
            <td noWrap id="footer">
              <div align="center">	
                <input type="button" id="quchoose" name="quchoose" class="b_foot" value="确定&打印" onclick="save()" disabled/>		
                &nbsp;
                <input type="button" name="close" class="b_foot" value="关闭" onClick="removeCurrentTab();">
              </div>
            </td>
          </tr>
        </table>
        <input type="hidden" id="opCode" name="opCode"  value="<%=opCode%>" />
        <input type="hidden" id="opName" name="opName"  value="<%=opName%>" />
      	<input type="hidden" name="phoneNo"  value="<%=activePhone%>" />
      	<input type="hidden" name="ioprcode"  value="" />
      	<input type="hidden" name="loginAccept"  value="<%=loginAccept%>">
      	<input type="hidden" id="offerIdHiden" name="offerIdHiden"  value="" />
      	<input type="hidden" id="effectWayHiden" name="effectWayHiden"  value="" />
      </form>
    </body>
</html>