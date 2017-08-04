   
<%
/********************
 version v3.0
 开发商 si-tech
 create wangzn 2011/8/7 14:34:51
 opCode	b809
 opName 智能网VPMN主套餐管理
********************/
%>
              
<%
  String opCode = "b809";
  String opName = "智能网VPMN主套餐管理";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=GBK"%>
<%
	//读取用户session信息
	String region_code = (String)session.getAttribute("regCode");
	String work_no   = (String)session.getAttribute("workNo");
 	
 	String hightSql = "select count(*) from shighlogin where login_no='"+work_no+"' and op_code = '"+opCode+"'" ;
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
		if(Integer.parseInt(hightStr[0][0])>0)
		{
			provinceFlg = "1";
		}
	}
	System.out.println("@:***provinceFlg***["+provinceFlg+"]***");
	String regionName = "";
	if("1".equals(provinceFlg)){
		regionName="select region_code,region_name from sregioncode where region_code in('01','02','03','04','05','06','07','08','09','10','11','12','13') order by to_number(region_code)";
	}else{
		regionName="select region_code,region_name from sregioncode where region_code='"+region_code+"'";
	}
	
	String feeIndexString = "  SELECT SUBSTR(C.BOSS_ORG_CODE, 1, 2) AS REGION_CODE,  "+ 
							"	       trim(A.OFFER_ATTR_TYPE),                      "+
							"	       A.OFFER_ID,                                   "+
							"	       A.OFFER_ID || '-->' || trim(A.OFFER_NAME)     "+
							"	  FROM PRODUCT_OFFER A, REGION B, DCHNGROUPMSG C     "+
							"	 WHERE A.OFFER_ID = B.OFFER_ID                       "+
							"	   AND A.OFFER_ATTR_TYPE = ANY('VpJ0', 'VpW0','VpZ0')       "+
							"	   AND B.GROUP_ID = C.GROUP_ID                       "+
							"	   AND C.ROOT_DISTANCE = 2                           "+
							"	   AND C.GROUP_TYPE = '2'                            "+
							"	 ORDER BY REGION_CODE, OFFER_ID					     ";
%>	 
 <wtc:pubselect name="sPubSelect" outnum="4" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=region_code%>">
	<wtc:sql><%=feeIndexString%></wtc:sql>
	</wtc:pubselect>
<wtc:array id="result_feeIndex" scope="end"/>   		    	
<html>
<head>
<base target="_self">
<title>智能网VPMN主套餐管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script language="JavaScript"> 
//定义全局变量
	var arrFeeIndex=new Array();
<%
	for(int i=0;i<result_feeIndex.length;i++){
			out.println("var feeIndex = new Array(); \n");
			out.println("feeIndex[0]='"+result_feeIndex[i][0]+"';\n");
			out.println("feeIndex[1]='"+result_feeIndex[i][1]+"';\n");
			out.println("feeIndex[2]='"+result_feeIndex[i][2]+"';\n");
			out.println("feeIndex[3]='"+result_feeIndex[i][3]+"';\n");
			out.println("arrFeeIndex["+i+"]=feeIndex;\n");
	}
%>	

function setOpType(opType,OfferTypeName){
	
	$("#offerTypeName").text(OfferTypeName);
		
	$("#divBody").css("display","none");
	$("#divTwo").css("display","");
	
	setFeeIndexCode();
}

function setFeeIndexCode(){
	$("#feeIndex_code").val("$$$$$$");
	$("#feeIndex_code").find("option:not(:selected)").remove();
		
	var opType = $('input[@name=op_type][@checked]').val();
	var regionCode = $("select[@name=region_code] option[@selected]").val();
	
	for( var i = 0 ;i < arrFeeIndex.length; i++)
	{
		if(opType==arrFeeIndex[i][1]&&regionCode==arrFeeIndex[i][0])
		{
			$("#feeIndex_code").get(0).options.add(new Option(arrFeeIndex[i][3],arrFeeIndex[i][2])); 
		}
			
	}
	
}

function getFeeIndexConfig(){
	$("#divBody").css("display","");
	var region_code = $("#region_code").val(); 
	var feeIndex_code = $("#feeIndex_code").val(); 
	if(feeIndex_code =="$$$$$$"){
		rdShowMessageDialog("请您选择智能网VPMN的资费!");
		return false;
	}else{	
		document.middle.location="fb809_main.jsp?regionCode="+region_code+"&feeIndexCode="+feeIndex_code;
	}	
}

</script>
</head>

<body>
<form name="form1"  method="post" action="">     
	  	<%@ include file="/npage/include/header.jsp" %>                         
	<div class="title">
		<div id="title_zi">智能网VPMN主套餐管理</div>
	</div>

	<table cellspacing="1" >
		<tr height="30">
			<td class="blue" width="20%" >
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<B>请您选择操作类型:</B>
			</td>
			<td class="blue">
				<input type="radio" name="op_type" onclick="setOpType(0,'网内资费');"  value="VpJ0"/><B>添加智能网VPMN主套餐网内资费详细配置</B>
			</td>
			<td class="blue">
				<input type="radio" name="op_type" onclick="setOpType(1,'网外号码组');"  value="VpW0"/><B>添加智能网VPMN主套餐网外号码组详细配置</B>
			</td>
			<td class="blue">
				<input type="radio" name="op_type" onclick="setOpType(2,'综合V网');"  value="VpZ0"/><B>添加智能网VPMN综合V网资费详细配置</B>
			</td>
		</tr>
	</table>
	<table cellspacing="0" >					
		<tr  height="22" style="display:none" id="divTwo">
			<TD width="15%" class="blue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<B>地市</B></TD>
			<TD width="25%">
				<select id="region_code" name="region_code" v_name="地市" onchange="setFeeIndexCode(this)">		
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
				&nbsp;&nbsp;<B id="offerTypeName">&nbsp;</B>
			</TD>
			<TD width="45%">
				<select id="feeIndex_code" name="feeIndex_code" v_name="智能网VPMN主套餐" onchange="getFeeIndexConfig()">
					<option value="$$$$$$">-----------------请选择-----------------</option>
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
</body>
</html>