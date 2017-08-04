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
    frmCfm();
    
  }
    function frmCfm(){
      frm.submit();
      return true;
    }
			
		
    
    function dogetOfferInfo(packet){
      var retcode = packet.data.findValueByName("retcode");
      var retmsg = packet.data.findValueByName("retmsg");

      if(retcode != "000000"){
        rdShowMessageDialog("校验银行账号失败！错误代码：" + retcode + "，错误信息：" + retmsg,0);
        
      }else{
				 rdShowMessageDialog("校验银行账号成功！",2);
      }
    }
    
    function reSetTab(){
      window.location.href="fg967.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=activePhone%>";
    }
    
    function change_idType()//二代证
{   

      
    if(document.all.idType.value=="0")
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
      if(yhzh.trim()==""){ //操作类型为申请
        
      }else{ //操作类型为取消
        var packet = new AJAXPacket("fg224_ajax_getOfferInfo.jsp","正在获得数据，请稍候......");
      	packet.data.add("phoneNo",yhzh);
      	packet.data.add("opCode","<%=opCode%>");
      	packet.data.add("opName","<%=opName%>");
      	core.ajax.sendPacket(packet,dogetOfferInfo);
      	packet = null;
      }
			
	}

		</script>
		<body>
		  <form name="frm" method="POST" action="fg967Cfm.jsp">
	    <%@ include file="/npage/include/header.jsp" %>
		    <div class="title">
		      <div id="title_zi"><%=opName%></div><p align="center"></p>
	      </div>
        <table cellspacing="0">
			    
          <tr>
          				      <td class="blue" width="15%">手机号码</td>
			      <td>
						  <input type="text" id="phoneNo" name="phoneNo"  v_must="1" 	v_type="mobphone" maxlength="11" onblur="checkElement(this)" readOnly  Class="InputGrey" value ="<%=activePhone%>"/>
			        
	          </td>
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
						  <input type="text" id="RechAmount" name="RechAmount"  maxlength="9" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)" value =""/>
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
                <input type="button" name="quchoose" class="b_foot" value="确定" onclick="save()" />		
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