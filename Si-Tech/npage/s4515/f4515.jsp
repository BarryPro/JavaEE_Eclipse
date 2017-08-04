   
<%
/********************
 version v2.0
 开发商 si-tech
 create wanghlc@2009-8-26
********************/
%>
              
<%
  String opCode = "4515";
  String opName = "智能网VPMN资费配置";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=GBK"%>

<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.text.*"%>

<%

	String op_code="4515";
	
	
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
	
	
		//String pkgString = "  select trim(pkg_code),trim(pkg_code)||'-->'||trim(pkg_name) from svpmnpkgcode where region_code = '"+region_code+"'order by to_number(pkg_code) ";
		//String pkgString1 = "  select trim(pkg_code),trim(pkg_code)||'-->'||trim(pkg_name) from svpmnpkgcode where region_code = '01'order by to_number(pkg_code) ";
		//String pkgString2 = "  select trim(pkg_code),trim(pkg_code)||'-->'||trim(pkg_name) from svpmnpkgcode where region_code = '02'order by to_number(pkg_code) ";
		//String pkgString3 = "  select trim(pkg_code),trim(pkg_code)||'-->'||trim(pkg_name) from svpmnpkgcode where region_code = '03'order by to_number(pkg_code) ";
		//String pkgString4 = "  select trim(pkg_code),trim(pkg_code)||'-->'||trim(pkg_name) from svpmnpkgcode where region_code = '04'order by to_number(pkg_code) ";
		//String pkgString5 = "  select trim(pkg_code),trim(pkg_code)||'-->'||trim(pkg_name) from svpmnpkgcode where region_code = '05'order by to_number(pkg_code) ";
		//String pkgString6 = "  select trim(pkg_code),trim(pkg_code)||'-->'||trim(pkg_name) from svpmnpkgcode where region_code = '06'order by to_number(pkg_code) ";
		//String pkgString7 = "  select trim(pkg_code),trim(pkg_code)||'-->'||trim(pkg_name) from svpmnpkgcode where region_code = '07'order by to_number(pkg_code) ";
		//String pkgString8 = "  select trim(pkg_code),trim(pkg_code)||'-->'||trim(pkg_name) from svpmnpkgcode where region_code = '08'order by to_number(pkg_code) ";
		//String pkgString9 = "  select trim(pkg_code),trim(pkg_code)||'-->'||trim(pkg_name) from svpmnpkgcode where region_code = '09'order by to_number(pkg_code) ";
		//String pkgString10 = "  select trim(pkg_code),trim(pkg_code)||'-->'||trim(pkg_name) from svpmnpkgcode where region_code = '10'order by to_number(pkg_code) ";
		//String pkgString11 = "  select trim(pkg_code),trim(pkg_code)||'-->'||trim(pkg_name) from svpmnpkgcode where region_code = '11'order by to_number(pkg_code) ";
		//String pkgString12 = "  select trim(pkg_code),trim(pkg_code)||'-->'||trim(pkg_name) from svpmnpkgcode where region_code = '12'order by to_number(pkg_code) ";
		//String pkgString13 = "  select trim(pkg_code),trim(pkg_code)||'-->'||trim(pkg_name) from svpmnpkgcode where region_code = '13'order by to_number(pkg_code) ";
		
		String pkgString="select a.offer_id,to_char(a.offer_id)||'-->'||trim(a.offer_name) from product_offer a,region b,sregioncode c where a.offer_attr_type='VpG0' and a.offer_id=b.offer_id and b.group_id=c.group_id and a.eff_date<sysdate and a.exp_date>sysdate and c.region_code='"+region_code+"'order by a.offer_id ";
		String pkgString1 = "select  a.offer_id,to_char(a.offer_id)||'-->'||trim(a.offer_name) from product_offer a,region b,sregioncode c where a.offer_attr_type='VpG0' and a.offer_id=b.offer_id and b.group_id=c.group_id and a.eff_date<sysdate and a.exp_date>sysdate and c.region_code='01'order by a.offer_id ";
		String pkgString2 = "select  a.offer_id,to_char(a.offer_id)||'-->'||trim(a.offer_name) from product_offer a,region b,sregioncode c where a.offer_attr_type='VpG0' and a.offer_id=b.offer_id and b.group_id=c.group_id and a.eff_date<sysdate and a.exp_date>sysdate and c.region_code='02'order by a.offer_id ";
		String pkgString3 = "select  a.offer_id,to_char(a.offer_id)||'-->'||trim(a.offer_name) from product_offer a,region b,sregioncode c where a.offer_attr_type='VpG0' and a.offer_id=b.offer_id and b.group_id=c.group_id and a.eff_date<sysdate and a.exp_date>sysdate and c.region_code='03'order by a.offer_id ";
		String pkgString4 = "select  a.offer_id,to_char(a.offer_id)||'-->'||trim(a.offer_name) from product_offer a,region b,sregioncode c where a.offer_attr_type='VpG0' and a.offer_id=b.offer_id and b.group_id=c.group_id and a.eff_date<sysdate and a.exp_date>sysdate and c.region_code='04'order by a.offer_id ";
		String pkgString5 = "select  a.offer_id,to_char(a.offer_id)||'-->'||trim(a.offer_name) from product_offer a,region b,sregioncode c where a.offer_attr_type='VpG0' and a.offer_id=b.offer_id and b.group_id=c.group_id and a.eff_date<sysdate and a.exp_date>sysdate and c.region_code='05'order by a.offer_id ";
		String pkgString6 = "select  a.offer_id,to_char(a.offer_id)||'-->'||trim(a.offer_name) from product_offer a,region b,sregioncode c where a.offer_attr_type='VpG0' and a.offer_id=b.offer_id and b.group_id=c.group_id and a.eff_date<sysdate and a.exp_date>sysdate and c.region_code='06'order by a.offer_id ";
		String pkgString7 = "select  a.offer_id,to_char(a.offer_id)||'-->'||trim(a.offer_name) from product_offer a,region b,sregioncode c where a.offer_attr_type='VpG0' and a.offer_id=b.offer_id and b.group_id=c.group_id and a.eff_date<sysdate and a.exp_date>sysdate and c.region_code='07'order by a.offer_id ";
		String pkgString8 = "select  a.offer_id,to_char(a.offer_id)||'-->'||trim(a.offer_name) from product_offer a,region b,sregioncode c where a.offer_attr_type='VpG0' and a.offer_id=b.offer_id and b.group_id=c.group_id and a.eff_date<sysdate and a.exp_date>sysdate and c.region_code='08'order by a.offer_id ";
		String pkgString9 = "select  a.offer_id,to_char(a.offer_id)||'-->'||trim(a.offer_name) from product_offer a,region b,sregioncode c where a.offer_attr_type='VpG0' and a.offer_id=b.offer_id and b.group_id=c.group_id and a.eff_date<sysdate and a.exp_date>sysdate and c.region_code='09'order by a.offer_id ";
		String pkgString10 ="select  a.offer_id,to_char(a.offer_id)||'-->'||trim(a.offer_name) from product_offer a,region b,sregioncode c where a.offer_attr_type='VpG0' and a.offer_id=b.offer_id and b.group_id=c.group_id and a.eff_date<sysdate and a.exp_date>sysdate and c.region_code='10'order by a.offer_id ";
		String pkgString11 ="select  a.offer_id,to_char(a.offer_id)||'-->'||trim(a.offer_name) from product_offer a,region b,sregioncode c where a.offer_attr_type='VpG0' and a.offer_id=b.offer_id and b.group_id=c.group_id and a.eff_date<sysdate and a.exp_date>sysdate and c.region_code='11'order by a.offer_id ";
		String pkgString12 ="select  a.offer_id,to_char(a.offer_id)||'-->'||trim(a.offer_name) from product_offer a,region b,sregioncode c where a.offer_attr_type='VpG0' and a.offer_id=b.offer_id and b.group_id=c.group_id and a.eff_date<sysdate and a.exp_date>sysdate and c.region_code='12'order by a.offer_id ";
		String pkgString13 ="select  a.offer_id,to_char(a.offer_id)||'-->'||trim(a.offer_name) from product_offer a,region b,sregioncode c where a.offer_attr_type='VpG0' and a.offer_id=b.offer_id and b.group_id=c.group_id and a.eff_date<sysdate and a.exp_date>sysdate and c.region_code='13'order by a.offer_id ";

%>


      <wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=region_code%>">
  	           <wtc:sql><%=pkgString1%></wtc:sql>
 	    </wtc:pubselect>
	    <wtc:array id="result_pkg1" scope="end"/>
	    	

      <wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=region_code%>">
  	           <wtc:sql><%=pkgString2%></wtc:sql>
 	    </wtc:pubselect>
	    <wtc:array id="result_pkg2" scope="end"/>
    	
      <wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=region_code%>">
  	           <wtc:sql><%=pkgString3%></wtc:sql>
 	    </wtc:pubselect>
	    <wtc:array id="result_pkg3" scope="end"/>
   	
	    <wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=region_code%>">
  	           <wtc:sql><%=pkgString4%></wtc:sql>
 	    </wtc:pubselect>
	    <wtc:array id="result_pkg4" scope="end"/>
	  	
	    <wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=region_code%>">
  	           <wtc:sql><%=pkgString5%></wtc:sql>
 	    </wtc:pubselect>
	    <wtc:array id="result_pkg5" scope="end"/>
	    	
	    <wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=region_code%>">
  	           <wtc:sql><%=pkgString6%></wtc:sql>
 	    </wtc:pubselect>
	    <wtc:array id="result_pkg6" scope="end"/>
	    	
	    <wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=region_code%>">
  	           <wtc:sql><%=pkgString7%></wtc:sql>
 	    </wtc:pubselect>
	    <wtc:array id="result_pkg7" scope="end"/>
	
	    <wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=region_code%>">
  	           <wtc:sql><%=pkgString8%></wtc:sql>
 	    </wtc:pubselect>
	    <wtc:array id="result_pkg8" scope="end"/>
	    	
	    	<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=region_code%>">
  	           <wtc:sql><%=pkgString9%></wtc:sql>
 	    </wtc:pubselect>
	    <wtc:array id="result_pkg9" scope="end"/>
	    	
	    	<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=region_code%>">
  	           <wtc:sql><%=pkgString10%></wtc:sql>
 	    </wtc:pubselect>
	    <wtc:array id="result_pkg10" scope="end"/>
	    
	    	<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=region_code%>">
  	           <wtc:sql><%=pkgString11%></wtc:sql>
 	    </wtc:pubselect>
	    <wtc:array id="result_pkg11" scope="end"/>
	    
	    	<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=region_code%>">
  	           <wtc:sql><%=pkgString12%></wtc:sql>
 	    </wtc:pubselect>
	    <wtc:array id="result_pkg12" scope="end"/>
	  
	    	<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=region_code%>">
  	           <wtc:sql><%=pkgString13%></wtc:sql>
 	    </wtc:pubselect>
	    <wtc:array id="result_pkg13" scope="end"/>			    		    	


<html>
<head>
<base target="_self">
<title>智能网VPMN配置</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script language="JavaScript"> 
//定义全局变量
  var arrPkg1id = new Array();
  var arrPkg1value = new Array();
  var arrPkg2id = new Array();
  var arrPkg2value = new Array();
  var arrPkg3id = new Array();
  var arrPkg3value = new Array();
  var arrPkg4id = new Array();
  var arrPkg4value = new Array();
  var arrPkg5id = new Array();
  var arrPkg5value = new Array();
  var arrPkg6id = new Array();
  var arrPkg6value = new Array();
  var arrPkg7id = new Array();
  var arrPkg7value = new Array();
  var arrPkg8id = new Array();
  var arrPkg8value = new Array();
  var arrPkg9id = new Array();
  var arrPkg9value = new Array();
  var arrPkg10id = new Array();
  var arrPkg10value = new Array();
  var arrPkg11id = new Array();
  var arrPkg11value = new Array();
  var arrPkg12id = new Array();
  var arrPkg12value = new Array();
  var arrPkg13id = new Array();
  var arrPkg13value = new Array();
  var strPkgValue = new Array();
  var strPkgID = new Array();
  
  var strUrl="";


  <%
    for(int i=0;i<result_pkg1.length;i++){
			out.println("arrPkg1id["+i+"]='"+result_pkg1[i][0]+"';\n");
			out.println("arrPkg1value["+i+"]='"+result_pkg1[i][1]+"';\n");
  }
  for(int i=0;i<result_pkg2.length;i++){
			out.println("arrPkg2id["+i+"]='"+result_pkg2[i][0]+"';\n");
			out.println("arrPkg2value["+i+"]='"+result_pkg2[i][1]+"';\n");
  }
  for(int i=0;i<result_pkg3.length;i++){
			out.println("arrPkg3id["+i+"]='"+result_pkg3[i][0]+"';\n");
			out.println("arrPkg3value["+i+"]='"+result_pkg3[i][1]+"';\n");
  }
  for(int i=0;i<result_pkg4.length;i++){
			out.println("arrPkg4id["+i+"]='"+result_pkg4[i][0]+"';\n");
			out.println("arrPkg4value["+i+"]='"+result_pkg4[i][1]+"';\n");
  }
  for(int i=0;i<result_pkg5.length;i++){
			out.println("arrPkg5id["+i+"]='"+result_pkg5[i][0]+"';\n");
			out.println("arrPkg5value["+i+"]='"+result_pkg5[i][1]+"';\n");
  }
  for(int i=0;i<result_pkg6.length;i++){
			out.println("arrPkg6id["+i+"]='"+result_pkg6[i][0]+"';\n");
			out.println("arrPkg6value["+i+"]='"+result_pkg6[i][1]+"';\n");
  }
  for(int i=0;i<result_pkg7.length;i++){
			out.println("arrPkg7id["+i+"]='"+result_pkg7[i][0]+"';\n");
			out.println("arrPkg7value["+i+"]='"+result_pkg7[i][1]+"';\n");
  }
  for(int i=0;i<result_pkg8.length;i++){
			out.println("arrPkg8id["+i+"]='"+result_pkg8[i][0]+"';\n");
			out.println("arrPkg8value["+i+"]='"+result_pkg8[i][1]+"';\n");
  }
  for(int i=0;i<result_pkg9.length;i++){
			out.println("arrPkg9id["+i+"]='"+result_pkg9[i][0]+"';\n");
			out.println("arrPkg9value["+i+"]='"+result_pkg9[i][1]+"';\n");
  }
  for(int i=0;i<result_pkg10.length;i++){
			out.println("arrPkg10id["+i+"]='"+result_pkg10[i][0]+"';\n");
			out.println("arrPkg10value["+i+"]='"+result_pkg10[i][1]+"';\n");
  }
  for(int i=0;i<result_pkg11.length;i++){
			out.println("arrPkg11id["+i+"]='"+result_pkg11[i][0]+"';\n");
			out.println("arrPkg11value["+i+"]='"+result_pkg11[i][1]+"';\n");
  }
  for(int i=0;i<result_pkg12.length;i++){
			out.println("arrPkg12id["+i+"]='"+result_pkg12[i][0]+"';\n");
			out.println("arrPkg12value["+i+"]='"+result_pkg12[i][1]+"';\n");
  }
  for(int i=0;i<result_pkg13.length;i++){
			out.println("arrPkg13id["+i+"]='"+result_pkg13[i][0]+"';\n");
			out.println("arrPkg13value["+i+"]='"+result_pkg13[i][1]+"';\n");
  }
  for(int i=0;i<13;i++){
  		out.println("strPkgID["+i+"]='arrPkg"+(i+1)+"id';\n");
			out.println("strPkgValue["+i+"]='arrPkg"+(i+1)+"value';\n");
  }
  
  %>
  
  function setPkgCode(p)
  {
  	var r = p.value;
    var strkgid = new Array();
    var strkgvalue = new Array();
   
   if(r ==01){
   strkgid = arrPkg1id;
   strkgvalue = arrPkg1value
  }else if(r ==02){
    strkgid = arrPkg2id;
   strkgvalue = arrPkg2value
  }else if(r ==03){
   strkgid = arrPkg3id;
   strkgvalue = arrPkg3value
  }else if(r ==04){
   strkgid = arrPkg4id;
   strkgvalue = arrPkg4value
  }else if(r ==05){
   strkgid = arrPkg5id;
   strkgvalue = arrPkg5value
  }else if(r ==06){
   strkgid = arrPkg6id;
   strkgvalue = arrPkg6value
  }else if(r ==07){
   strkgid = arrPkg7id;
   strkgvalue = arrPkg7value
  }else if(r ==08){
   strkgid = arrPkg8id;
   strkgvalue = arrPkg8value
  }else if(r ==09){
   strkgid = arrPkg9id;
   strkgvalue = arrPkg9value
  }else if(r ==10){
   strkgid = arrPkg10id;
   strkgvalue = arrPkg10value
  }else if(r ==11){
   strkgid = arrPkg11id;
   strkgvalue = arrPkg11value
  }else if(r ==12){
   strkgid = arrPkg12id;
   strkgvalue = arrPkg12value
  }else{
   strkgid = arrPkg13id;
   strkgvalue = arrPkg13value
  }
  var myEle;
  var str = document.form1.pkg_code;
  for (var q=str.options.length;q>=0;q--) str.options[q]=null;
  myEle = document.createElement("option") ;
	myEle.value = "$$$$$$";
	myEle.text ="-----------------请选择-----------------";
	str.add(myEle);		
		for ( var x = 0 ; x < strkgid.length  ; x++ )
	{
        myEle = document.createElement("option") ;
        myEle.value = strkgid[x];
        myEle.text = strkgvalue[x] ;
        str.add(myEle) ;
	}
  	
  	var div_body = document.getElementById("divBody");
			div_body.style.display="none";
  }

	function getPkgConfig(p){
		
		var div_body = document.getElementById("divBody");
			div_body.style.display="";
			
			
		var region_code = document.form1.region_code.value;
		var pkg_code = document.form1.pkg_code.value;
		
		if(p.value =="$$$$$$"){
			rdShowMessageDialog("请您选择智能网VPMN的资费!");
			return false;
		}	else{	
			 // if(strUrl =='3'){
				 document.middle.location="f4515_main.jsp?regionCode="+region_code+"&pkgCode="+pkg_code;
			 // }else{
			  //	document.middle.location="f4515_updatePkg.jsp?regionCode="+region_code+"&pkgCode="+pkg_code;
			  //}
		}
	}
	
	function addPkg(){
			var div_body = document.getElementById("divBody");
			var provinceFlg = '<%=provinceFlg%>';
			div_body.style.display="";
			var add_region_code = <%=region_code%>;
			document.middle.location="f4515_addPkg.jsp?add_region_code="+add_region_code+"&provinceFlg="+provinceFlg;
		
	}
	
	function setOpType(p){
		

	var num = document.form1.op_type.length;
		
			//处理资费添加时原有信息的问题
			document.form1.add_region_code.value="$$$$$$";
			var s = '<%=region_code%>';
			document.form1.region_code.value=s;
			document.form1.pkg_code.value="$$$$$$";
			
		
			var div_body = document.getElementById("divBody");
			div_body.style.display="none";
			
			  var str = p.value;
			  strUrl = p.value;
				var div_one = document.getElementById("divOne");	
				var div_two = document.getElementById("divTwo");
			if(str=='1'){
				div_one.style.display="none";				
				div_two.style.display="none";
				addPkg();
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
	var pkg_code = middle.form1.pkg_code.value;
	var pkg_name = middle.form1.pkg_name.value;
	var stop_time = middle.form1.stop_time.value;
	var power_right = middle.form1.power_right.value;
	
	
	document.form2.region_code.value = region_code;
	document.form2.pkg_code.value = pkg_code;
	document.form2.pkg_name.value = pkg_name;
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
		<div id="title_zi">智能网VPMN资费配置</div>
	</div>


	<table cellspacing="1" >
						
					
	 
	  				
	  				
	  				
					<tr  height="22"  id="divTwo">
	  					<TD width="15%" class="blue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  						<B>地市</B></TD>
	  					<TD width="25%">
	  						
	  						<select name="region_code" v_name="地市" onchange="setPkgCode(this)">
	  						
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
					    <TD width="15%" class="blue">
					    	&nbsp;&nbsp;<B>智能网VPMN资费</B></TD>
				        <TD width="45%">
				        	   <select name="pkg_code" v_name="智能网VPMN资费" onchange="getPkgConfig(this)">
				        	<option value="$$$$$$">-----------------请选择-----------------</option>
				       
				       <wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=region_code%>">
  	           <wtc:sql><%=pkgString%></wtc:sql>
 	              </wtc:pubselect>
	             <wtc:array id="result_pkg" scope="end"/>
	             	<%
 							
 								String[][] pkgListString = new String[][]{};
 								if(code.equals("000000")&&result_pkg.length>0)
 								pkgListString = result_pkg;
								for(int i=0;i < pkgListString.length;i ++)
								{
							%>
								<option value='<%=pkgListString[i][0]%>'><%=pkgListString[i][1]%></option>
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
 <form name="form2" method="post" action="f4515_addPkg_submit.jsp">
 	
 	<input type="hidden" name="region_code"/>
 	<input type="hidden" name="pkg_code"/>
 	<input type="hidden" name="pkg_name"/>
 	<input type="hidden" name="stop_time"/>
 	<input type="hidden" name="power_right"/>
 	
</form>
</body>
</html>

