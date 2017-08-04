<%
  /*
   * 功能: 智能网vpmn闭合群资费管理 d211
   * 版本: 1.8.2
   * 日期: 2011/2/24
   * 作者: huangrong
   * 版权: si-tech
   * update:
  */
%>

              
<%
  String opCode = "d211";
  String opName = "智能网vpmn闭合群资费管理";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=GBK"%>

<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.text.*"%>

<%

	String op_code="d211";
	
	
	//读取用户session信息
	String region_code = (String)session.getAttribute("regCode");
	
	String work_no   = (String)session.getAttribute("workNo");
  String hightSql = "select trim(op_code) from shighlogin where login_no='"+work_no+"'";
  String hightStr[][] = new String[][]{};
  String provinceFlg = "0";
  
%>
<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=region_code%>">
  	           <wtc:sql><%=hightSql%></wtc:sql>
 	    </wtc:pubselect>
	    <wtc:array id="result_hight" scope="end"/>
<%
	if(code.equals("000000")&&result_hight.length>0){
		hightStr = result_hight;
			for(int i=0;i < hightStr.length;i ++){
				if(op_code.equals(hightStr[i][0])){
					provinceFlg = "1";
				}
			}
	}
	
	String regionName = "";
	if("1".equals(provinceFlg)){
		regionName="select region_code,region_name from sregioncode where region_code in('01','02','03','04','05','06','07','08','09','10','11','12','13') order by to_number(region_code)";
	}else{
		regionName="select region_code,region_name from sregioncode where region_code='"+region_code+"'";
	}
	
	
		//String closeFeeString = "  select trim(feeindex),trim(feeindex)||'-->'||trim(feeindex_name) from sclosefeeindex where region_code = '"+region_code+"'order by to_number(feeindex) ";
		//String closeFeeString1 = "  select trim(feeindex),trim(feeindex)||'-->'||trim(feeindex_name) from sclosefeeindex where region_code = '01'order by to_number(feeindex) ";
		//String closeFeeString2 = "  select trim(feeindex),trim(feeindex)||'-->'||trim(feeindex_name) from sclosefeeindex where region_code = '02'order by to_number(feeindex) ";
		//String closeFeeString3 = "  select trim(feeindex),trim(feeindex)||'-->'||trim(feeindex_name) from sclosefeeindex where region_code = '03'order by to_number(feeindex) ";
		//String closeFeeString4 = "  select trim(feeindex),trim(feeindex)||'-->'||trim(feeindex_name) from sclosefeeindex where region_code = '04'order by to_number(feeindex) ";
		//String closeFeeString5 = "  select trim(feeindex),trim(feeindex)||'-->'||trim(feeindex_name) from sclosefeeindex where region_code = '05'order by to_number(feeindex) ";
		//String closeFeeString6 = "  select trim(feeindex),trim(feeindex)||'-->'||trim(feeindex_name) from sclosefeeindex where region_code = '06'order by to_number(feeindex) ";
		//String closeFeeString7 = "  select trim(feeindex),trim(feeindex)||'-->'||trim(feeindex_name) from sclosefeeindex where region_code = '07'order by to_number(feeindex) ";
		//String closeFeeString8 = "  select trim(feeindex),trim(feeindex)||'-->'||trim(feeindex_name) from sclosefeeindex where region_code = '08'order by to_number(feeindex) ";
		//String closeFeeString9 = "  select trim(feeindex),trim(feeindex)||'-->'||trim(feeindex_name) from sclosefeeindex where region_code = '09'order by to_number(feeindex) ";
		//String closeFeeString10 = "  select trim(feeindex),trim(feeindex)||'-->'||trim(feeindex_name) from sclosefeeindex where region_code = '10'order by to_number(feeindex) ";
		//String closeFeeString11 = "  select trim(feeindex),trim(feeindex)||'-->'||trim(feeindex_name) from sclosefeeindex where region_code = '11'order by to_number(feeindex) ";
		//String closeFeeString12 = "  select trim(feeindex),trim(feeindex)||'-->'||trim(feeindex_name) from sclosefeeindex where region_code = '12'order by to_number(feeindex) ";
		//String closeFeeString13 = "  select trim(feeindex),trim(feeindex)||'-->'||trim(feeindex_name) from sclosefeeindex where region_code = '13'order by to_number(feeindex) ";
		String closeFeeString="select a.offer_id,to_char(a.offer_id)||'-->'||trim(a.offer_name) from product_offer a,region b,sregioncode c where a.offer_attr_type='VpB0' and a.eff_date<sysdate and a.exp_date>sysdate and a.offer_id=b.offer_id and b.group_id=c.group_id and c.region_code='"+region_code+"'order by a.offer_id ";
		String closeFeeString1 = "select a.offer_id,to_char(a.offer_id)||'-->'||trim(a.offer_name) from product_offer a,region b,sregioncode c where a.offer_attr_type='VpB0' and a.eff_date<sysdate and a.exp_date>sysdate and a.offer_id=b.offer_id and b.group_id=c.group_id and c.region_code='01'order by a.offer_id ";
		String closeFeeString2 = "select a.offer_id,to_char(a.offer_id)||'-->'||trim(a.offer_name) from product_offer a,region b,sregioncode c where a.offer_attr_type='VpB0' and a.eff_date<sysdate and a.exp_date>sysdate and a.offer_id=b.offer_id and b.group_id=c.group_id and c.region_code='02'order by a.offer_id ";
		String closeFeeString3 = "select a.offer_id,to_char(a.offer_id)||'-->'||trim(a.offer_name) from product_offer a,region b,sregioncode c where a.offer_attr_type='VpB0' and a.eff_date<sysdate and a.exp_date>sysdate and a.offer_id=b.offer_id and b.group_id=c.group_id and c.region_code='03'order by a.offer_id ";
		String closeFeeString4 = "select a.offer_id,to_char(a.offer_id)||'-->'||trim(a.offer_name) from product_offer a,region b,sregioncode c where a.offer_attr_type='VpB0' and a.eff_date<sysdate and a.exp_date>sysdate and a.offer_id=b.offer_id and b.group_id=c.group_id and c.region_code='04'order by a.offer_id ";
		String closeFeeString5 = "select a.offer_id,to_char(a.offer_id)||'-->'||trim(a.offer_name) from product_offer a,region b,sregioncode c where a.offer_attr_type='VpB0' and a.eff_date<sysdate and a.exp_date>sysdate and a.offer_id=b.offer_id and b.group_id=c.group_id and c.region_code='05'order by a.offer_id ";
		String closeFeeString6 = "select a.offer_id,to_char(a.offer_id)||'-->'||trim(a.offer_name) from product_offer a,region b,sregioncode c where a.offer_attr_type='VpB0' and a.eff_date<sysdate and a.exp_date>sysdate and a.offer_id=b.offer_id and b.group_id=c.group_id and c.region_code='06'order by a.offer_id ";
		String closeFeeString7 = "select a.offer_id,to_char(a.offer_id)||'-->'||trim(a.offer_name) from product_offer a,region b,sregioncode c where a.offer_attr_type='VpB0' and a.eff_date<sysdate and a.exp_date>sysdate and a.offer_id=b.offer_id and b.group_id=c.group_id and c.region_code='07'order by a.offer_id ";
		String closeFeeString8 = "select a.offer_id,to_char(a.offer_id)||'-->'||trim(a.offer_name) from product_offer a,region b,sregioncode c where a.offer_attr_type='VpB0' and a.eff_date<sysdate and a.exp_date>sysdate and a.offer_id=b.offer_id and b.group_id=c.group_id and c.region_code='08'order by a.offer_id ";
		String closeFeeString9 = "select a.offer_id,to_char(a.offer_id)||'-->'||trim(a.offer_name) from product_offer a,region b,sregioncode c where a.offer_attr_type='VpB0' and a.eff_date<sysdate and a.exp_date>sysdate and a.offer_id=b.offer_id and b.group_id=c.group_id and c.region_code='09'order by a.offer_id ";
		String closeFeeString10 ="select a.offer_id,to_char(a.offer_id)||'-->'||trim(a.offer_name) from product_offer a,region b,sregioncode c where a.offer_attr_type='VpB0' and a.eff_date<sysdate and a.exp_date>sysdate and a.offer_id=b.offer_id and b.group_id=c.group_id and c.region_code='10'order by a.offer_id ";
		String closeFeeString11 ="select a.offer_id,to_char(a.offer_id)||'-->'||trim(a.offer_name) from product_offer a,region b,sregioncode c where a.offer_attr_type='VpB0' and a.eff_date<sysdate and a.exp_date>sysdate and a.offer_id=b.offer_id and b.group_id=c.group_id and c.region_code='11'order by a.offer_id ";
		String closeFeeString12 ="select a.offer_id,to_char(a.offer_id)||'-->'||trim(a.offer_name) from product_offer a,region b,sregioncode c where a.offer_attr_type='VpB0' and a.eff_date<sysdate and a.exp_date>sysdate and a.offer_id=b.offer_id and b.group_id=c.group_id and c.region_code='12'order by a.offer_id ";
		String closeFeeString13 ="select a.offer_id,to_char(a.offer_id)||'-->'||trim(a.offer_name) from product_offer a,region b,sregioncode c where a.offer_attr_type='VpB0' and a.eff_date<sysdate and a.exp_date>sysdate and a.offer_id=b.offer_id and b.group_id=c.group_id and c.region_code='13'order by a.offer_id ";

%>


      <wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=region_code%>">
  	           <wtc:sql><%=closeFeeString1%></wtc:sql>
 	    </wtc:pubselect>
	    <wtc:array id="result_closeFee1" scope="end"/>
	    	

      <wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=region_code%>">
  	           <wtc:sql><%=closeFeeString2%></wtc:sql>
 	    </wtc:pubselect>
	    <wtc:array id="result_closeFee2" scope="end"/>
    	
      <wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=region_code%>">
  	           <wtc:sql><%=closeFeeString3%></wtc:sql>
 	    </wtc:pubselect>
	    <wtc:array id="result_closeFee3" scope="end"/>
   	
	    <wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=region_code%>">
  	           <wtc:sql><%=closeFeeString4%></wtc:sql>
 	    </wtc:pubselect>
	    <wtc:array id="result_closeFee4" scope="end"/>
	  	
	    <wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=region_code%>">
  	           <wtc:sql><%=closeFeeString5%></wtc:sql>
 	    </wtc:pubselect>
	    <wtc:array id="result_closeFee5" scope="end"/>
	    	
	    <wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=region_code%>">
  	           <wtc:sql><%=closeFeeString6%></wtc:sql>
 	    </wtc:pubselect>
	    <wtc:array id="result_closeFee6" scope="end"/>
	    	
	    <wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=region_code%>">
  	           <wtc:sql><%=closeFeeString7%></wtc:sql>
 	    </wtc:pubselect>
	    <wtc:array id="result_closeFee7" scope="end"/>
	
	    <wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=region_code%>">
  	           <wtc:sql><%=closeFeeString8%></wtc:sql>
 	    </wtc:pubselect>
	    <wtc:array id="result_closeFee8" scope="end"/>
	    	
	    	<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=region_code%>">
  	           <wtc:sql><%=closeFeeString9%></wtc:sql>
 	    </wtc:pubselect>
	    <wtc:array id="result_closeFee9" scope="end"/>
	    	
	    	<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=region_code%>">
  	           <wtc:sql><%=closeFeeString10%></wtc:sql>
 	    </wtc:pubselect>
	    <wtc:array id="result_closeFee10" scope="end"/>
	    
	    	<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=region_code%>">
  	           <wtc:sql><%=closeFeeString11%></wtc:sql>
 	    </wtc:pubselect>
	    <wtc:array id="result_closeFee11" scope="end"/>
	    
	    	<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=region_code%>">
  	           <wtc:sql><%=closeFeeString12%></wtc:sql>
 	    </wtc:pubselect>
	    <wtc:array id="result_closeFee12" scope="end"/>
	  
	    	<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=region_code%>">
  	           <wtc:sql><%=closeFeeString13%></wtc:sql>
 	    </wtc:pubselect>
	    <wtc:array id="result_closeFee13" scope="end"/>			    		    	


<html>
<head>
<base target="_self">
<title>智能网vpmn闭合群资费配置</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script language="JavaScript"> 
//定义全局变量
  var arrCloseFee1id = new Array();
  var arrCloseFee1value = new Array();
  var arrCloseFee2id = new Array();
  var arrCloseFee2value = new Array();
  var arrCloseFee3id = new Array();
  var arrCloseFee3value = new Array();
  var arrCloseFee4id = new Array();
  var arrCloseFee4value = new Array();
  var arrCloseFee5id = new Array();
  var arrCloseFee5value = new Array();
  var arrCloseFee6id = new Array();
  var arrCloseFee6value = new Array();
  var arrCloseFee7id = new Array();
  var arrCloseFee7value = new Array();
  var arrCloseFee8id = new Array();
  var arrCloseFee8value = new Array();
  var arrCloseFee9id = new Array();
  var arrCloseFee9value = new Array();
  var arrCloseFee10id = new Array();
  var arrCloseFee10value = new Array();
  var arrCloseFee11id = new Array();
  var arrCloseFee11value = new Array();
  var arrCloseFee12id = new Array();
  var arrCloseFee12value = new Array();
  var arrCloseFee13id = new Array();
  var arrCloseFee13value = new Array();
  var strCloseFeeValue = new Array();
  var strCloseFeeID = new Array();
  
  var strUrl="";


  <%
    for(int i=0;i<result_closeFee1.length;i++){
			out.println("arrCloseFee1id["+i+"]='"+result_closeFee1[i][0]+"';\n");
			out.println("arrCloseFee1value["+i+"]='"+result_closeFee1[i][1]+"';\n");
  }
  for(int i=0;i<result_closeFee2.length;i++){
			out.println("arrCloseFee2id["+i+"]='"+result_closeFee2[i][0]+"';\n");
			out.println("arrCloseFee2value["+i+"]='"+result_closeFee2[i][1]+"';\n");
  }
  for(int i=0;i<result_closeFee3.length;i++){
			out.println("arrCloseFee3id["+i+"]='"+result_closeFee3[i][0]+"';\n");
			out.println("arrCloseFee3value["+i+"]='"+result_closeFee3[i][1]+"';\n");
  }
  for(int i=0;i<result_closeFee4.length;i++){
			out.println("arrCloseFee4id["+i+"]='"+result_closeFee4[i][0]+"';\n");
			out.println("arrCloseFee4value["+i+"]='"+result_closeFee4[i][1]+"';\n");
  }
  for(int i=0;i<result_closeFee5.length;i++){
			out.println("arrCloseFee5id["+i+"]='"+result_closeFee5[i][0]+"';\n");
			out.println("arrCloseFee5value["+i+"]='"+result_closeFee5[i][1]+"';\n");
  }
  for(int i=0;i<result_closeFee6.length;i++){
			out.println("arrCloseFee6id["+i+"]='"+result_closeFee6[i][0]+"';\n");
			out.println("arrCloseFee6value["+i+"]='"+result_closeFee6[i][1]+"';\n");
  }
  for(int i=0;i<result_closeFee7.length;i++){
			out.println("arrCloseFee7id["+i+"]='"+result_closeFee7[i][0]+"';\n");
			out.println("arrCloseFee7value["+i+"]='"+result_closeFee7[i][1]+"';\n");
  }
  for(int i=0;i<result_closeFee8.length;i++){
			out.println("arrCloseFee8id["+i+"]='"+result_closeFee8[i][0]+"';\n");
			out.println("arrCloseFee8value["+i+"]='"+result_closeFee8[i][1]+"';\n");
  }
  for(int i=0;i<result_closeFee9.length;i++){
			out.println("arrCloseFee9id["+i+"]='"+result_closeFee9[i][0]+"';\n");
			out.println("arrCloseFee9value["+i+"]='"+result_closeFee9[i][1]+"';\n");
  }
  for(int i=0;i<result_closeFee10.length;i++){
			out.println("arrCloseFee10id["+i+"]='"+result_closeFee10[i][0]+"';\n");
			out.println("arrCloseFee10value["+i+"]='"+result_closeFee10[i][1]+"';\n");
  }
  for(int i=0;i<result_closeFee11.length;i++){
			out.println("arrCloseFee11id["+i+"]='"+result_closeFee11[i][0]+"';\n");
			out.println("arrCloseFee11value["+i+"]='"+result_closeFee11[i][1]+"';\n");
  }
  for(int i=0;i<result_closeFee12.length;i++){
			out.println("arrCloseFee12id["+i+"]='"+result_closeFee12[i][0]+"';\n");
			out.println("arrCloseFee12value["+i+"]='"+result_closeFee12[i][1]+"';\n");
  }
  for(int i=0;i<result_closeFee13.length;i++){
			out.println("arrCloseFee13id["+i+"]='"+result_closeFee13[i][0]+"';\n");
			out.println("arrCloseFee13value["+i+"]='"+result_closeFee13[i][1]+"';\n");
  }
  for(int i=0;i<13;i++){
  		out.println("strCloseFeeID["+i+"]='arrCloseFee"+(i+1)+"id';\n");
			out.println("strCloseFeeValue["+i+"]='arrCloseFee"+(i+1)+"value';\n");
  }
  
  %>
  
  function setCloseFeeCode(p)
  {
  	var r = p.value;
    var strfeeid = new Array();
    var strfeevalue = new Array();
   
   if(r ==01){
   strfeeid = arrCloseFee1id;
   strfeevalue = arrCloseFee1value
  }else if(r ==02){
    strfeeid = arrCloseFee2id;
   strfeevalue = arrCloseFee2value
  }else if(r ==03){
   strfeeid = arrCloseFee3id;
   strfeevalue = arrCloseFee3value
  }else if(r ==04){
   strfeeid = arrCloseFee4id;
   strfeevalue = arrCloseFee4value
  }else if(r ==05){
   strfeeid = arrCloseFee5id;
   strfeevalue = arrCloseFee5value
  }else if(r ==06){
   strfeeid = arrCloseFee6id;
   strfeevalue = arrCloseFee6value
  }else if(r ==07){
   strfeeid = arrCloseFee7id;
   strfeevalue = arrCloseFee7value
  }else if(r ==08){
   strfeeid = arrCloseFee8id;
   strfeevalue = arrCloseFee8value
  }else if(r ==09){
   strfeeid = arrCloseFee9id;
   strfeevalue = arrCloseFee9value
  }else if(r ==10){
   strfeeid = arrCloseFee10id;
   strfeevalue = arrCloseFee10value
  }else if(r ==11){
   strfeeid = arrCloseFee11id;
   strfeevalue = arrCloseFee11value
  }else if(r ==12){
   strfeeid = arrCloseFee12id;
   strfeevalue = arrCloseFee12value
  }else{
   strfeeid = arrCloseFee13id;
   strfeevalue = arrCloseFee13value
  }
  var myEle;
  var str = document.form1.closeFee_code;
  for (var q=str.options.length;q>=0;q--) str.options[q]=null;
  myEle = document.createElement("option") ;
	myEle.value = "$$$$$$";
	myEle.text ="-----------------请选择-----------------";
	str.add(myEle);		
		for ( var x = 0 ; x < strfeeid.length  ; x++ )
	{
        myEle = document.createElement("option") ;
        myEle.value = strfeeid[x];
        myEle.text = strfeevalue[x] ;
        str.add(myEle) ;
	}
  	
  	var div_body = document.getElementById("divBody");
			div_body.style.display="none";
  }

	function getCloseFeeConfig(p){
		
		var div_body = document.getElementById("divBody");
			div_body.style.display="";
			
			
		var region_code = document.form1.region_code.value;
		var closeFee_code = document.form1.closeFee_code.value;
		
		if(p.value =="$$$$$$"){
			rdShowMessageDialog("请您选择智能网VPMN的资费!");
			return false;
		}	else{	
			 // if(strUrl =='3'){
				 document.middle.location="fd211_main.jsp?regionCode="+region_code+"&closeFeeCode="+closeFee_code;
			  //}else{
			  	//document.middle.location="fd211_updateCloseFee.jsp?regionCode="+region_code+"&closeFeeCode="+closeFee_code;
			  //}
		}
	}
	
	function addCloseFee(){
			var div_body = document.getElementById("divBody");
			var provinceFlg = '<%=provinceFlg%>';
			div_body.style.display="";
			var add_region_code = <%=region_code%>;
			document.middle.location="fd211_addCloseFee.jsp?add_region_code="+add_region_code+"&provinceFlg="+provinceFlg;
		
	}
	
	function setOpType(p){
		

	var num = document.form1.op_type.length;
		
			//处理资费添加时原有信息的问题
			document.form1.add_region_code.value="$$$$$$";
			var s = '<%=region_code%>';
			document.form1.region_code.value=s;
			document.form1.closeFee_code.value="$$$$$$";
			
		
			var div_body = document.getElementById("divBody");
			div_body.style.display="none";
			
			  var str = p.value;
			  strUrl = p.value;
				var div_one = document.getElementById("divOne");	
				var div_two = document.getElementById("divTwo");
			if(str=='1'){
				div_one.style.display="none";				
				div_two.style.display="none";
				addCloseFee();
			}else if(str=='0'){
				div_one.style.display="none"
				div_two.style.display="none";
			}
			else{
				div_one.style.display="none";
				div_two.style.display="";
			}
	}

function add_submit11(){
	
	var region_code = middle.form1.region_code.value;
	var closeFee_code = middle.form1.closeFee_code.value;
	var closeFee_name = middle.form1.closeFee_name.value;
	var stop_time = middle.form1.stop_time.value;
	var power_right = middle.form1.power_right.value;
	
	
	document.form2.region_code.value = region_code;
	document.form2.closeFee_code.value = closeFee_code;
	document.form2.closeFee_name.value = closeFee_name;
	document.form2.stop_time.value = stop_time;
	document.form2.power_right.value = power_right;
	document.form2.submit();
}
</script>
</head>

<body>

  <form name="form1"  method="post" action="">
     
	  	<%@ include file="/npage/include/header.jsp" %>                         


	<div class="title">
		<div id="title_zi">智能网vpmn闭合群资费配置</div>
	</div>


	<table cellspacing="1" >
						
					
	  				
	  				
	  				
	  				
					<tr  height="22"  id="divTwo">
	  					<TD width="20%" class="blue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  						<B>地市</B></TD>
	  					<TD width="25%">
	  						
	  						<select name="region_code" v_name="地市" onchange="setCloseFeeCode(this)">
	  						
	  						<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=region_code%>">
  	           <wtc:sql><%=regionName%></wtc:sql>
 	              </wtc:pubselect>
	             <wtc:array id="result_t" scope="end"/>
	             <%
 							
 								 String[][] retListString = new String[][]{};
 								if(code.equals("000000")&&result_t.length>0)
 								retListString = result_t;
								for(int i=0;i < retListString.length;i ++)
								{
									String selectStr="";
									if(region_code.equals(retListString[i][0])){
										selectStr="selected";
									}else{
										selectStr="";
										}
							%>
    		          				<option value='<%=retListString[i][0]%>' <%=selectStr%> ><%=retListString[i][1]%></option>
							<%		
								}
							%>
	  					</select>
	  					</TD>
					    <TD width="20%" class="blue">
					    	&nbsp;&nbsp;<B>智能网VPMN闭合群资费</B></TD>
				        <TD width="35%">
				        	   <select name="closeFee_code" v_name="智能网VPMN闭合群资费" onchange="getCloseFeeConfig(this)">
				        	<option value="$$$$$$">-----------------请选择-----------------</option>
				       
				       <wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=region_code%>">
  	           <wtc:sql><%=closeFeeString%></wtc:sql>
 	              </wtc:pubselect>
	             <wtc:array id="result_closeFee" scope="end"/>
	             	<%
 							
 								String[][] closeFeeListString = new String[][]{};
 								if(code.equals("000000")&&result_closeFee.length>0)
 								closeFeeListString = result_closeFee;
								for(int i=0;i < closeFeeListString.length;i ++)
								{
							%>
								<option value='<%=closeFeeListString[i][0]%>'><%=closeFeeListString[i][1]%></option>
							<%		
								}
							%>
				        	
				        </select>
				        </TD>
				    </tr>
					
				</table>
				
	  			
	  				
	  			
	  			
	 <div style="height:380px;overflow: auto" id="divBody">
 	<IFRAME frameBorder=0 id=middle name=middle scrolling="yes"  
	 style="HEIGHT: 100%; VISIBILITY: inherit; WIDTH: 100%; Z-INDEX:1">
	</IFRAME>
</div>
		
	 <%@ include file="/npage/include/footer.jsp" %>
	  </form>
 <form name="form2" method="post" action="fd211_addCloseFee_submit.jsp">
 	
 	<input type="hidden" name="region_code"/>
 	<input type="hidden" name="closeFee_code"/>
 	<input type="hidden" name="closeFee_name"/>
 	<input type="hidden" name="stop_time"/>
 	<input type="hidden" name="power_right"/>
 	
</form>
</body>
</html>


