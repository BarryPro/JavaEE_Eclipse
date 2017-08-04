<%
  /*************************************
  * 功  能: APN代码维护 3474
  * 版  本: version v1.0
  * 开发商: si-tech
  * 创建者: @ 2012-2-28
  **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  System.out.println("s3440_1.jsp开始");%>
<%

	String opCode = (String)request.getParameter("opCode");
	String opName = (String)request.getParameter("opName");
	
  String loginName =(String)session.getAttribute("workName");
  String orgCode =(String)session.getAttribute("orgCode");
  String loginNo = (String)session.getAttribute("workNo");
  String ip_Addr = request.getRemoteAddr();
  String regCode = (String)session.getAttribute("regCode");
  String rpt_right = (String)session.getAttribute("rptRight");
  int    recordNum=0;
  
  String orgCodeSql = regCode; 
  String sqlStr ="select region_code,region_code||'-- >'||nvl(region_name,region_code) from sRegionCode where use_flag='Y' Order By region_code";
  String[] inParam = new String[2];
  inParam[0] ="select region_code,region_name from sRegionCode where region_code=:orgCodeSql  Order By region_code";
  inParam[1] = "orgCodeSql="+orgCodeSql;
  
  
  String yjhjds="01,02,03,04,05,06,07,08,09,10,11,12,13";/*有交换机的地市*/
  
  
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="2"> 
<%
  if(rpt_right.compareTo("2")<0){   //省级工号权限
%>
    <wtc:param value="<%=sqlStr%>"/>
<%
  }else{   //非省级工号权限
%>
    <wtc:param value="<%=inParam[0]%>"/>
    <wtc:param value="<%=inParam[1]%>"/> 
<%
  }
%>
</wtc:service>  
<wtc:array id="result"  scope="end"/>
  
<%
  if(!"000000".equals(retCode)){
%>
    <script language=javascript>
      rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
      window.location.href="/s3430/s3440_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
    </script>
<%
  }else{
    recordNum = result.length;
%>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>APN代码维护</title>
    <META content="text/html; charset=gb2312" http-equiv=Content-Type>
    <meta http-equiv="Expires" content="0">
    <SCRIPT LANGUAGE=javascript FOR=document EVENT=onkeydown>
      window.onkeydown(window.event) 
    </SCRIPT>
  </head> 
  <script language=javascript>
    window.onload=function(){
      tbs1.style.display="";
    	tbs4.style.display="none";
    	tbsUpt.style.display="none";
    	                	

    	  var region_codess = $("#region_code").val();
    	
	    	if("<%=yjhjds%>".indexOf(region_codess)!=-1) {
	    		 $("#gapnbiaoshi4g option").remove();
	    		 $("#gapnbiaoshi4g").append("<option value='0' >2/3G</option><option value='1' >2/3/4G</option>");					 
	    	}else {
					 $("#gapnbiaoshi4g option").remove();
	    		 $("#gapnbiaoshi4g").append("<option value='0' >2/3G</option>");		
	    	}
	    	schangemsg22();
      
    }
  
    function onkeydown(event) 
    {
    	if (event.srcElement.type!="button")
    	{
    		if (event.keyCode == 13)
    		{
    			event.keyCode = 9;
    		}
    	}
    }
    
    function isPosInteger(inputVal)
    {
    	inputStr=inputVal.toString();
    	for (var i = 0;i < inputStr.length;i++ )
    	{
    		var oneChar = inputStr.charAt(i);
    		if (oneChar < "0" || oneChar > "9" )
    		{
    			return false;
    		}	
    	}
    	return true;
    }
    
    function fsubmit()
    {
    	String.prototype.trim = function() 
    	{ 
    		return this.replace(/(^\s*)|(\s*$)/g, ""); 
    	}
    	
    	var apn_namess = document.form1.apn_name.value;
    	
    	var patrn111 = /^[A-Za-z0-9]+$/;
    	var patrn222 = /^\.*$/;
    	var hanzis = /^[\u4e00-\u9fa5]*$/;

					var zimus1=0;
					var dians1=0;
					var hanzi1=0;
					for (var i = 0; i < apn_namess.trim().length; i ++){
			          var code = apn_namess.trim().charAt(i);//分别获取输入内容
			
			          var flag111=patrn111.test(code);
			          var flag222=patrn222.test(code);
			          var flag333=hanzis.test(code);
			          
			            if(flag111){
			          	zimus1++;
			          }
			          	if(flag222){
			          	dians1++;
			          }
			          if(flag333){
			          	hanzi1++;
			          }
			    }
		    
			    if(apn_namess.trim().length!=zimus1+dians1+hanzi1){
			    			rdShowMessageDialog("APN名称必须为字母、数字、汉字或“.”组成！");
				        return false;
			    }
			    
    	 
    
    	var apn_script = document.form1.apn_script.value;
    	/*4G项目改造，对全省所有地市均为必填项*/
    	if (apn_script.trim() == "")
    	{ 
    		rdShowMessageDialog("APN标识（华为交换机专用）,不能为空");
    		return;
    	}
    	else if (apn_script.trim() == "")
    	{
    		document.form1.apn_script.value = 'null';		
    	}
    	else
    	{
    		document.form1.apn_script.value = apn_script.trim();
    	}
    	
    	var patrn11 = /^[A-Za-z0-9]+$/;
    	var patrn22 = /^\.*$/;

					var zimus=0;
					var dians=0;
					for (var i = 0; i < apn_script.trim().length; i ++){
			          var code = apn_script.trim().charAt(i);//分别获取输入内容
			
			          var flag11=patrn11.test(code);
			          var flag22=patrn22.test(code);
			          
			             if(flag11){
			          	zimus++;
			          }
			          	if(flag22){
			          	dians++;
			          }
			    }
		    
			    if(apn_script.trim().length!=zimus+dians){
			    			rdShowMessageDialog("APN标识（华为交换机专用）,必须为字母、数字或“.”组成！");
				        return false;
			    }
			    
    	
    	var gapnbiaoshi4gss = $("#gapnbiaoshi4g").val();
    	if(gapnbiaoshi4gss=="1") {
    		if($("#apn4gbiaozhis").val().trim()=="") {
    		rdShowMessageDialog("4G APN标识,不能为空");
    		return;   
    		}  
    		
    	var apn_scriptsss = $("#apn4gbiaozhis").val(); 		
    	
    	var patrn1111 = /^[A-Za-z0-9]+$/;
    	var patrn2222 = /^\.*$/;

					var zimus11=0;
					var dians11=0;
					for (var i = 0; i < apn_scriptsss.trim().length; i ++){
			          var code = apn_scriptsss.trim().charAt(i);//分别获取输入内容
			
			          var flag1111=patrn1111.test(code);
			          var flag2222=patrn2222.test(code);
			          
			            if(flag1111){
			          	zimus11++;
			          }
			          	if(flag2222){
			          	dians11++;
			          }
			    }
		    
			    if(apn_scriptsss.trim().length!=zimus11+dians11){
			    			rdShowMessageDialog("4G APN标识必须为字母、数字或“.”组成！");
				        return false;
			    }

	 	
    	}
    	
    	
    	
      if(rdShowConfirmDialog("是否确定提交？") == 1){
      	document.form1.action="f3440_2.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
      	document.form1.submit();
      	document.form1.bSubmit.disabled=true;
      }
    }
    function fsubmitUpt(bSubmit1){
      /* 按钮延迟 */
  			controlButt(bSubmit1);
  			/* 事后提醒 */
  			getAfterPrompt();
  			
      var apn_code_upt = $("#apn_code_upt").val();
      var apn_id_upt = $("#apn_id_upt").val();
      var region_code_upt = $("#region_code_upt").val();
      
      $("#regionCodeUptHidd").val(region_code_upt);
      $("#apnCodeUptHidd").val(apn_code_upt);
      $("#apnIdUptHidd").val(apn_id_upt);
        
      var markDiv=$("#intablediv"); 
      markDiv.empty();
      var packet = new AJAXPacket("f3440_ajax_qryInfo.jsp","正在获得数据，请稍候......");
      packet.data.add("opCode","<%=opCode%>");
      packet.data.add("opName","<%=opName%>");
      packet.data.add("region_code_upt",region_code_upt);
      packet.data.add("apn_code_upt",apn_code_upt);
      core.ajax.sendPacketHtml(packet,doGryUptInfo);
      packet = null;
    }
    
    function doGryUptInfo(data){
      //找到添加表格的div
			var markDiv=$("#intablediv"); 
			markDiv.empty();
  		markDiv.append(data);
      var retCode = $("#retCode").val();
      var retMsg = $("#retMsg").val();
      if(retCode!="000000"){
        rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
        return false;
      }
    }
    
    var flag = 1;
    /*修改查询信息*/
    function uptQryInfo(obj){
    	
      var childs = obj.parentNode.parentNode.childNodes;
      if(flag == 1){
        for(var i=0;i<childs.length;i++){
          var childNode =childs[i].firstChild; 
          $(childNode).removeAttr("readOnly");
          $(childNode).attr("readOnly","");
          $(childNode).removeAttr("class");
          $(childNode).removeAttr("disabled");
          $(childNode).attr("class","");
          if($(childNode).attr("type")=="button"){
            $(childNode).val("确认");
            $(childNode).attr("class","b_foot");
          }
        }
        flag = 2;
      }else if(flag == 2){
      	
    	
        var regionCodeUptHidd = $("#regionCodeUptHidd").val();
        var apnCodeUptHidd = $("#apnCodeUptHidd").val();
        var childNodeStr = "";
        for(var i=0;i<childs.length;i++){
          var childNode =childs[i].firstChild;
          childNodeStr = childNodeStr + $(childNode).val()+"|";
        }
        
        var v_apn_is_change = $(obj).parent().parent().find("td:eq(3)").attr("v_apn_is_change");
        if("0"==v_apn_is_change){
        	v_apn_is_change = "";
        }
        var packet = new AJAXPacket("f3440_ajax_subUptInfo.jsp","正在获得数据，请稍候......");
        packet.data.add("opCode","<%=opCode%>");
        packet.data.add("opName","<%=opName%>");
        packet.data.add("regionCodeUptHidd",regionCodeUptHidd);
        packet.data.add("apnCodeUptHidd",apnCodeUptHidd);
        packet.data.add("childNodeStr",childNodeStr);
        packet.data.add("v_apn_is_change",v_apn_is_change);
        core.ajax.sendPacket(packet,doSubUptInfo);
        packet = null;
      }
    }
    
    function doSubUptInfo(packet){
      var retCode = packet.data.findValueByName("retCode");
      var retMsg = packet.data.findValueByName("retMsg");
      var regionCodeUptHidd = $("#regionCodeUptHidd").val();
      var apnCodeUptHidd = $("#apnCodeUptHidd").val();
      var apnIdUptHidd = $("#apnIdUptHidd").val();
      
      if(retCode!="000000"){
           rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
           window.location.href="s3440_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
      }else{
        rdShowMessageDialog("修改成功！",2);
        flag=1;
        var markDiv=$("#intablediv"); 
        markDiv.empty();
        var packet = new AJAXPacket("f3440_ajax_qryInfo.jsp","正在获得数据，请稍候......");
        packet.data.add("opCode","<%=opCode%>");
        packet.data.add("opName","<%=opName%>");
        packet.data.add("region_code_upt",regionCodeUptHidd);
        packet.data.add("apn_code_upt",apnCodeUptHidd);
        core.ajax.sendPacketHtml(packet,doGryUptInfo);
        packet = null;
      }
    }
  
    function fsubmit3()
    {
    	document.form3.action="f3440_4.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
    	document.form3.submit();
    	document.form3.bSubmit3.disabled=true;
    }
  
    function showtbs1(){	
    		tbs1.style.display="";
    		tbs4.style.display="none";
    		tbsUpt.style.display="none";
    		
    	
    	  var region_codess = $("#region_code").val();
    	
	    	if("<%=yjhjds%>".indexOf(region_codess)!=-1) {
	    		 $("#gapnbiaoshi4g option").remove();
	    		 $("#gapnbiaoshi4g").append("<option value='0' >2/3G</option><option value='1' >2/3/4G</option>");					 
	    	}else {
					 $("#gapnbiaoshi4g option").remove();
	    		 $("#gapnbiaoshi4g").append("<option value='0' >2/3G</option>");		
	    	}
	    	schangemsg22();
      
    }
    
    function showtbs4(){	
    		tbs1.style.display="none";
    		tbs4.style.display="";
    		tbsUpt.style.display="none";
    }
    
    function showtbsUpt(){
        tbs1.style.display="none";
    		tbs4.style.display="none";
    		tbsUpt.style.display="";
    }
  	
    function  modify()
    {
             var a =  parseInt(document.all.valid_flag.value,10) ;
             if(a != 0 || a!=1 )
    	{
    		rdShowMessageDialog("对不起！有效标志只能为0或1");
    		document.all.valid_flag.focus();
    		document.all.valid_flag.value="0";
    	}
    }
    
    function  modify_apncode()
    {
        var a =  parseInt(document.all.apn_code.value,10) ;
        document.all.apn_id.value=a;
        if(a <1 )
    	{
    		rdShowMessageDialog("对不起！apn_code设置有误");
    		document.all.apn_code.focus();
    		document.all.apn_code.value="";
    	}
    }
         
    function autowrite()
    {
    	
    	var apn_code=document.all.apn_code.value;
    	var apn_id=apn_code;
    	if(apn_code!="")
    	{
    		while(apn_id.substr(0,1)=="0")
    		{
    			apn_id=apn_id.substr(1,apn_id.length-1);
    		}
    	}
    	document.all.apn_id.value=apn_id;
    }
  
    function goBack(){
    	window.location.href="s3440_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
    }
    
    function schangemsg() {
    
        var region_codess = $("#region_code").val();
    	
	    	if("<%=yjhjds%>".indexOf(region_codess)!=-1) {
	    		 $("#gapnbiaoshi4g option").remove();
	    		 $("#gapnbiaoshi4g").append("<option value='0' >2/3G</option><option value='1' >2/3/4G</option>");					 
	    	}else {
					 $("#gapnbiaoshi4g option").remove();
	    		 $("#gapnbiaoshi4g").append("<option value='0' >2/3G</option>");		
	    	}
	    	schangemsg22();
    
    }
    
    function schangemsg22() {
    	var gapnbiaoshi4gss = $("#gapnbiaoshi4g").val();
    	if(gapnbiaoshi4gss=="1") {
    		$("#apn4gbiaozhis11").css("display","");
    		$("#apn4gbiaozhis22").css("display","");
    	
    	}else {
    		$("#apn4gbiaozhis11").css("display","none");
    		$("#apn4gbiaozhis22").css("display","none"); 
    		$("#apn4gbiaozhis").val("");   		
    	}
    }
    

   function check_this_change(bt){
   	
   	var currnet_apn_flag_sel_j = $(bt).val();
   	
   	if(currnet_apn_flag_sel_j=="0"){
   		rdShowMessageDialog("只能从2/3G 修改为2/3/4G");
   		$(bt).val("1");
   	}else{
   		//进行了更改
   		//不可能从1改为0，只有从0改为1的情况才传1，其他情况传空
   		$(bt).parent().attr("v_apn_is_change","1");
   	}
   } 
  </script>

  <body>
    <%@ include file="/npage/include/header.jsp" %>
    <div class="title">
		<div id="title_zi">APN代码维护</div>
	</div>
    <div id=tbs1 style=display="">
		  <form name="form1" method="post" action="">
    		<input type="hidden" name="orgCode" id="orgCode" value="<%=orgCode%>" />
    		<input type="hidden" name="loginNo" id="loginNo" value="<%=loginNo%>" />
      	<input type="hidden" name="ip_Addr" id="ip_Addr" value="<%=ip_Addr%>" />
    		<input type="hidden" name="rpt_right" value="<%=rpt_right.trim()%>" />
    		<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>" />
    		<input type="hidden" name="opName" name="opName" value="<%=opName%>" />
    		
  			  <TABLE>
            <tr>
              <TD  style="height=100%" width="5%" nowrap><a id="tabhead1" style="CURSOR: hand; TEXT-DECORATION: none" class="tabnodisp" href="javascript:onclick=showtbs1()" value="1">&nbsp;&nbsp;<font id="font1" >增加&nbsp;&nbsp;</font></a></TD>
              <TD  width="5%" nowrap><a id="tabhead2" style="CURSOR: hand; TEXT-DECORATION: none" class="tabnodisp" href="javascript:onclick=showtbs4()" value="1">&nbsp;&nbsp;<font id="font2" >查询&nbsp;&nbsp;</font></a></TD>
              <TD  width="5%" nowrap><a id="tabhead3" style="CURSOR: hand; TEXT-DECORATION: none" class="tabnodisp" href="javascript:onclick=showtbsUpt()" value="1">&nbsp;&nbsp;<font id="font3" >修改&nbsp;&nbsp;</font></a></TD>
              <td width="80%"></td> 
              </tr>
          </TABLE>
  		    <TABLE>
            <TBODY>
              <TR> 
  			        <TD width=10% height = 20 >地区：</td>     
                <TD width=20%>	
  		            <select name=region_code id="region_code" onChange="schangemsg()">
  <%                 
                        for(int i=0;i<recordNum;i++)
                        {
                          out.println("<option class='button' value='" + result[i][0] + "'>" + result[i][1] + "</option>");
                        }
  %>
                  </select>
  			        </TD>            
  		          <TD width=10% height = 20 >APN代码：</TD>
                <TD width=20% height = 20>
                  <input class="button" type=text  v_type="0_9"  v_must=1 v_minlength=4 v_maxlength=6 v_name="APN代码"  name="apn_code"  maxlength=4 >
                  <font class="orange">*</font>
                </TD>              
           	    <TD width=10% height = 20 >APN名称：</TD>
                <TD width=20% height = 20>
                	<input class="button" type=text  v_type="string"  v_must=1  v_name="APN名称"  name="apn_name"  maxlength = 14 >
                	<font class="orange">*</font>
                </TD>    
              </TR>
              <TR> 
  			        <TD width=10% height = 20 >APN_ID：</TD>
                <TD width=20% height = 20>
                	<input class="button" type=text  v_type="0_9"  v_must=1  v_name="APN_ID" v_minlength=2 v_maxlength=6 name=apn_id maxlength=6  onMouseDown="autowrite()">
                	<font class="orange">*</font>
                </TD>                
  		          <TD width=10% height = 20 >有效标志：</TD>
                <TD width=20% height = 20>
                	<select name=valid_flag >
                		<option value="0">无效</option>
                		<option value="1" selected >有效</option>
                	</select>
                </TD>              
           	    <TD width=10% height = 20 >是否可重用：</TD>
                <TD width=20% height = 20>
                	<select name="repeatFlag">
                		<option value="0" selected >否</option>
                		<option value="1" >是</option>
                	</select>
                </TD>    
              </TR>
              <TR>
              	<TD width=15% height = 20 >APN标识（华为交换机专用）:</TD>
              	<TD  width=20% height = 20  >
              		<input class="button" type=text  v_type="string" v_name="APN标识（华为交换机专用）"  name="apn_script" maxlength = 20 >
              		<font class="orange">*</font>
              	</TD>
              	<TD  >4G APN标志:</TD>
              	<TD  width=20% height = 20  >
                	<select name="gapnbiaoshi4g" id="gapnbiaoshi4g" onChange="schangemsg22()">

                	</select>
              	</TD>
              	
              	<TD width=15% height = 20 id="apn4gbiaozhis11" style="display:none">4G APN标识:</TD>
                <TD width=20% height = 20 id="apn4gbiaozhis22" style="display:none">
                	<input class="button" type=text    v_type="string" v_name="4G APN标识" v_maxlength=20 name="apn4gbiaozhis" id="apn4gbiaozhis" maxlength=20  ><font class="orange">*</font>
                </TD> 
                
              </TR> 
            </TBODY>
          </TABLE> 
  		    <TABLE>
        		<tr> 
          		<td align = center height="40" id="footer">
          		<input type="hidden" name="areacode" id="areacode" value="<%=regCode%>" />
          		<input type="button" name="bSubmit" class="b_foot" onclick="if(check(form1)) fsubmit()" value="确定" />
          		<input type="button" name="Return" class="b_foot"  onclick="goBack()" value="重置" />
          		</td>
        		</tr>
  		    </TABLE>
        </form>
	    </div>

      <div id=tbs4 style=display="none">
        <form name="form3" method="post" action="">
          <table>
            <tr> 
              <td colspan="4" align="center" id="footer">
                <input type="hidden" name="areacode" id="areacode" value="<%=regCode%>">
                <input type="button" name="bSubmit3" class="b_foot"  onclick="if(check(form3)) fsubmit3()" value="列表">
                <input type="button" name="Return" class="b_foot"  onclick="goBack()" value="返回">
              </td>
            </tr>
           
          </table>
        </form>
      </div>
      
       <div id="tbsUpt" style=display:"none">
        <form name="formUpt" method="post" action="">
         <input type="hidden" name="orgCode" id="orgCode" value="<%=orgCode%>">
          <input type="hidden" name="loginNo" id="loginNo" value="<%=loginNo%>">
          <input type="hidden" name="ip_Addr" id="ip_Addr" value="<%=ip_Addr%>">
  		    <TABLE  width=98% height=25 border=0 align="center" cellSpacing=0 >
              <TR> 
  			        <TD width=15% height = 20 >地区：</td>     
                <TD width=20%>	
  		            <select name="region_code_upt" id="region_code_upt" >
  <%                 
                        for(int i=0;i<recordNum;i++)
                        {
                          out.println("<option class='button' value='" + result[i][0] + "'>" + result[i][1] + "</option>");
                          System.out.println("-------s3440------11");
                        }
  %>
                  </select>
  			        </TD>            
  		          <TD width=15% height = 20 >APN代码：</TD>
                <TD width=20% height = 20>
                  <input class="button" type="text"  v_type="0_9"  v_minlength="4" v_maxlength="6" v_name="APN代码"  name="apn_code_upt" id="apn_code_upt"  maxlength="4" />
                  <font class="orange">*</font>
                </TD>              
                <input type="hidden" name="regionCodeUptHidd" id="regionCodeUptHidd" value="" />
                <input type="hidden" name="apnCodeUptHidd" id="apnCodeUptHidd" value="" />
                <input type="hidden" name="apnIdUptHidd" id="apnIdUptHidd" value="" />
              </TR>
              
              
          </TABLE> 
      		<table>
        		<tr> 
          		<td align = center height="40">
            		<input type="button" name="bSubmit1" class="b_foot"  onclick="if(check(formUpt)) fsubmitUpt(bSubmit1)" value="确定" />
            		<input type="button" name="Return" class="b_foot"  onclick="goBack()" value="返回" />
          		</td>
        		</tr>
      		</table>
      		<div id="intablediv"></div>
        </form>
      </div>

    <%@ include file="/npage/include/footer.jsp" %>
</body>
</html>
<%
}
%>
