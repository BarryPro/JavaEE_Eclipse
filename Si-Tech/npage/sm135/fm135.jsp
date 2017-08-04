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
  

  String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
  String workNo = (String)session.getAttribute("workNo");
  String  iLoginPwd = (String) session.getAttribute("password");
  String regionCode= (String)session.getAttribute("regCode");
  String custname="";
  String beizhuss="根据activePhone:"+activePhone+"进行查询";
  
   
%>
  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>"  id="loginAccept" />
  	<!--2013/11/01 12:39:08 gaopeng 客户敏感信息第三次改造需求 -->
  	<wtc:service name="sUserCustInfo" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="RetCode1" retmsg="RetMsg1"  outnum="40" >
      <wtc:param value=""/>
      <wtc:param value="01"/>
      <wtc:param value="<%=opCode%>"/>
      <wtc:param value="<%=workNo%>"/>
      <wtc:param value="<%=iLoginPwd%>"/>
      <wtc:param value="<%=activePhone%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value="<%=beizhuss%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
  </wtc:service>
    
	<wtc:array id="result1" scope="end" >
	</wtc:array>
	
<%
  if(RetCode1.equals("000000")) {
    custname=result1[0][5];
    System.out.println("gaopengSeeLog:"+custname);
  }else{
%>
  <script language="javascript">
    rdShowMessageDialog("错误代码：" + RetCode1 + "，错误信息：" + RetMsg1,0);
    window.close();
  </script>
<%
	}
%>


  <script language="javascript">

    function save(){
     
     		var offerIdSel = $("#offerIdSel").val();
				if(offerIdSel=="-1") {
					rdShowMessageDialog("请选择要办理的可选资费！" ,1);
          return false;	
				}


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
      var sysAccept =<%=loginAccept%>;             	//流水号
        var printStr = printInfo(printType);
      
	 		                      //调用printinfo()返回的打印内容
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
      var cust_info="";
      var opr_info="";
      var note_info1="";
      var note_info2="";
      var note_info3="";
      var note_info4="";
      var retInfo = "";
      
      cust_info+="手机号码：   "+"<%=activePhone%>"+"|";
      cust_info+="客户姓名：   "+"<%=custname%>"+"|";
      opr_info +="业务类型：终端型号捆绑套餐办理    操作流水: "+"<%=loginAccept%>" +"|";
      opr_info += "业务受理时间：" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + "   " + "用户品牌：" + $('#band_ids').text()+ "|";
      opr_info += "本次申请可选套餐："+$('#offerIdSel').find('option:selected').text()+"|";
      opr_info += "IMEI码:"+$("#imeino").val()+"|";
      opr_info += "资费描述："+ $('#offercomments').text()+"|";
      
      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    }
   
    
    function selectCheckSimNo(){

				var phoneNo = $("#phoneNo").val();
				var imeino=$("#imeino").val();
       if(imeino.trim()==""){ 
          rdShowMessageDialog("请输入IMEI码！" ,1);
          return false;
        }
				
        var packet = new AJAXPacket("fm135_qry.jsp","正在获得数据，请稍候......");
      	packet.data.add("phoneNo",phoneNo);
      	packet.data.add("imeino",imeino);
      	packet.data.add("opCode","<%=opCode%>");
      	packet.data.add("opName","<%=opName%>");
      	core.ajax.sendPacket(packet,docheckreturn);
      	packet = null;
      
    }
    
     function showOffer(){

				var offerIdSel = $("#offerIdSel").val();
				if(offerIdSel=="-1") {
							$('#iofferid').val("");
						  $('#offercomments').text("");	
				}else {
						var sm= new Array();
						sm =offerIdSel.split("|");
						
							$('#iofferid').val(sm[0]);
						  $('#offercomments').text(sm[1]);
				}
      
    }
    
    	
	
    function docheckreturn(packet){
      var retcode = packet.data.findValueByName("retCode");
      var retmsg = packet.data.findValueByName("retMsg");
      var result = packet.data.findValueByName("result");
      var bandnamess = packet.data.findValueByName("bandnames");
			$("#offerIdSel").empty();
      if(retcode != "000000"){
        rdShowMessageDialog("错误代码：" + retcode + "，错误信息：" + retmsg,0);
        //reSetTab();
      }else{
      
			var txt = '<option value="-1" >--请选择--</option>';
			for(var i=0,len=result.length;i<len;i++) {
				txt += '<option value="' + result[i].offerid + '|'+result[i].offercomments+' ">';
				txt += result[i].offerid+'-->'+result[i].offername;
				txt += '</option>'
			}
			$('#offerIdSel').append(txt);
			$('#band_ids').text(bandnamess);
       
       if(result.length>0) {
			document.all.imeino.readOnly=true;
			document.all.imeino.className="InputGrey";	
			document.all.checksimN.disabled=false;	
			//document.all.quchoose.disabled=false;
			}
			 
      }
    }
    
    function checkjiaoyan() {
    		
    		var phoneNo = $("#phoneNo").val();
				var imeino=$("#imeino").val();
       if(imeino.trim()==""){ 
          rdShowMessageDialog("请输入IMEI码！" ,1);
          return false;
        }
       var offer_id = $("#iofferid").val();
				if(offer_id=="") {
					rdShowMessageDialog("请选择要办理的可选资费！" ,1);
          return false;	
				}

				
        var packet = new AJAXPacket("fm135_check.jsp","正在校验中，请稍候......");
      	packet.data.add("phoneNo",phoneNo);
      	packet.data.add("imeino",imeino);
      	packet.data.add("iofferid",offer_id);
      	packet.data.add("opCode","<%=opCode%>");
      	packet.data.add("opName","<%=opName%>");
      	core.ajax.sendPacket(packet,docheckreturnsss);
      	packet = null;
      	
      	
    }
    
    function docheckreturnsss(packet){
      var retcode = packet.data.findValueByName("retCode");
      var retmsg = packet.data.findValueByName("retMsg");

      if(retcode != "000000"){
        rdShowMessageDialog("校验失败！错误代码：" + retcode + "，错误信息：" + retmsg,0);
        //reSetTab();
      }else{
      		rdShowMessageDialog("校验成功！",2);
					document.all.quchoose.disabled=false;
			}
			 
      
    }
    
    function reSetTab(){
      window.location.href="fm135.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=activePhone%>";
    }
		</script>
		<body>
		  <form name="frm" method="POST" action="fm135Cfm.jsp">
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
	          <td class="blue" width="16%">客户姓名</td>
			      <td>
							<input type="text" id="custname" name="custname"   onblur="checkElement(this)" readOnly  Class="InputGrey" value ="<%=custname%>"/>
			        <font class="orange">*</font>
	          </td>
		      </tr>

          <tr>
          	<td class="blue" width="16%">IMEI码</td>
            <td colspan="3">
            	<input type='text' name='imeino' id='imeino'class="required numOrLetter" value=""><font class="orange">*</font>
						<input type="button" id="checksimN" name="checksimN" value="资费查询" class="b_text" onClick="selectCheckSimNo()"> 
            </td>

          </tr>
           <tr>
                <td class="blue" width="16%">可选资费</td>
            <td colspan="3">
                <select id="offerIdSel" name="offerIdSel"  style="width:250px" onChange="showOffer()">
                 
                </select>
            </td>
            </tr>
            
             <tr>
                 <td class="blue" width="16%">用户品牌：</td>
            <td colspan="3" id id="band_ids">

            </td>
            </tr>
            
            <tr>
                 <td class="blue" width="16%">资费描述：</td>
            <td colspan="3" id="offercomments">

            </td>
            </tr>
            
        </table>
        <table cellspacing="0">
          <tr>
            <td noWrap id="footer">
              <div align="center">	
              	<input type="button" name="sdf" class="b_foot" value="校验" onclick="checkjiaoyan()" />		
                &nbsp;
                <input type="button" name="quchoose" class="b_foot" value="确定&打印" onclick="save()" disabled/>		
                &nbsp;
                	<input class="b_foot" type=button name="reset_btn" id="reset_btn" onclick="reSetTab()" value="清除"">
                	&nbsp;
                <input type="button" name="close" class="b_foot" value="关闭" onClick="removeCurrentTab();">
              </div>
            </td>
          </tr>
        </table>
        <input type="hidden" id="opCode" name="opCode"  value="<%=opCode%>" />
        <input type="hidden" id="opName" name="opName"  value="<%=opName%>" />
      	<input type="hidden" id="iofferid"name="iofferid"  value="" />
      	<input type="hidden" name="loginAccept"  value="<%=loginAccept%>">

      </form>
    </body>
</html>