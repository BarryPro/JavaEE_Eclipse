<%
   /*名称：集团客户项目申请 - 查看
　 * 版本: v1.0
　 * 日期: 2007/2/7
　 * 作者: wuln
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
	ArrayList retArray = new ArrayList();
	String[][] result = new String[][]{};
		String regCode = (String)session.getAttribute("regCode"); 
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode=org_code.substring(0,2);	
	String workNo = (String)session.getAttribute("workNo");
	String workPwd = (String)session.getAttribute("password");

	String grpParamSet="";
  String grpParamSetName="";
	String[] inParams = new String[2];
	String sqlStr ="";	
	String opCode = "2896";
	String opName = "合作伙伴业务暂停恢复";
	
	String strDate = new SimpleDateFormat("yyyyMMdd").format(new Date());

	String parterId = request.getParameter("parterId");
	String trId = request.getParameter("trId");
	String operId = request.getParameter("operId");
	String parterName = request.getParameter("parterName");
	
	%>
	 
	<wtc:service name="s2889QryOperMsg" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="41" >
            	<wtc:param value=""/>
            	<wtc:param value=""/>
              <wtc:param value="2889"/>
              <wtc:param value="<%=workNo%>"/>
              <wtc:param value="<%=workPwd%>"/>
              <wtc:param value=""/>
              <wtc:param value=""/>
              <wtc:param value="<%=operId%>"/>
              <wtc:param value="<%=parterId%>"/>
   </wtc:service>
   <wtc:array id="colNameArrTemp" scope="end" />
	<%
	String[][] colNameArr = colNameArrTemp;
	System.out.println("retCode = ===="+retCode);
	if(retCode.equals("000000")){	
	
	if (colNameArr != null)
		{
			if (colNameArr[0][0].equals("")) 
			{
				colNameArr = null;
				System.out.println("colNameArr = null");
			}
		}
	inParams[0] = "select set_name  from sBizParamSet  where  param_set=:param_set";
	inParams[1] = "param_set="+colNameArr[0][1];	 
	 %>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1"> 
	<wtc:param value="<%=inParams[0]%>"/>
	<wtc:param value="<%=inParams[1]%>"/> 
	</wtc:service> 
	<wtc:array id="setnameTemp" scope="end" />
  <%
	 String[][] setname = setnameTemp;
	 grpParamSetName=setname[0][0];
	  
	 sqlStr = "select net_attr,net_name from sNetAttr";	
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="2">
	<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="netArrTemp" scope="end" />
<%
	 String[][] netArr = netArrTemp;
	 
	 if (netArr.length==0)
	 {
		netArr = null;
	 }	  
		
	    
  if(colNameArr==null)
 	{
 		System.out.println("colNameArr = null");
%>
		<script language='jscript'>
			rdShowMessageDialog("没有查到相关记录！",0);
			window.close();
		</script>
<%  
	return;
	}else
    {
      
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
<script>

onload=function(){	   
			if(("<%=trId%>"=="2")&&("<%=colNameArr[0][11]%>"=="0") )
			{
 
				document.getElementById("YYYY").style.display="none";
			  document.getElementById("XXXX").style.display="none";
			  document.getElementById("cylx1").style.display="none";		
			}else if(("<%=trId%>"=="2")&&("<%=colNameArr[0][11]%>"=="1") ){
 
				document.getElementById("cylx1").style.display="none";
				var timelist="";			
				var startime="<%=colNameArr[0][31]%>";
				var endtime="<%=colNameArr[0][32]%>";		
				var starr = new Array();
				var etarr = new Array();
				starr=startime.split("|");
				etarr=endtime.split("|");
 
				for(var a=0; a< starr.length-1 ;a++)
				{
					timelist=timelist+starr[a]+"|"+etarr[a]+"|";
				}

			document.form1.InvalidTimeSpanList.value=timelist;
			document.form1.MOList.value="<%=colNameArr[0][33]%>";
			}

	    $("#bizTypeL").val("<%=colNameArr[0][38]%>");
	    $("#bizTypeS").val("<%=colNameArr[0][39]%>");	
	    $("#bizPRI").val("<%=colNameArr[0][40]%>");  

	    //changeBizTypeL();
}
function changeBizTypeL(){
    var vBizTypeL = $("#bizTypeL").val();

    var vBussId = document.form1.bussId.value;
	vBussId=vBussId.substring(0,1);
    
    var packet = new AJAXPacket("fgetBizTypeS.jsp","请稍后...");
    packet.data.add("bizMode" ,vBussId);
    packet.data.add("bizTypeL" ,vBizTypeL);
    core.ajax.sendPacket(packet,doChangeBizTypeL,false);
    packet = null;
}

function doChangeBizTypeL(packet){
    var retCode = packet.data.findValueByName("retCode");
    var retMessage=packet.data.findValueByName("retMessage");
    self.status="";
    
    if(retCode == "000000")
    {
		var backString = packet.data.findValueByName("backString");
     	var temLength = backString.length;
		var arr = new Array(temLength);
		for(var i = 0 ; i < temLength ; i ++)
		{
			arr[i] = "<OPTION value="+backString[i][0]+">" +backString[i][1] + "</OPTION>";
		}
		$("#bizTypeS").empty();
      	$(arr.join()).appendTo("#bizTypeS");
	}
    else
    {
        rdShowMessageDialog("获取业务小类失败[错误代码："+retCode+",错误信息："+retMessage+"]",0);
		return false;
    }
}

</script>

</head> 

<body>

<form name="form1" method="post" action="">	

<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">业务信息</div>
</div>
			<TABLE cellSpacing="0">
             <TR id="line_1">
             	<TD class="blue">EC/SI编码 </TD>
	            <TD>
	              	<input type="text" name="spId" readonly class="InputGrey" v_type="string" v_must="1" v_minlength="1" v_maxlength="6"  value="<%=parterId %>" >
	            </TD> 
				<TD class="blue">业务编码 </TD>
	            <TD>
	              	<input type="text" name="bizCode" readonly class="InputGrey" v_type="string" v_must="1" v_minlength="1" v_maxlength="18"   value="<%=operId %>" >&nbsp;
	            </TD> 	         								    		            	              
	         </TR>
	         
	          <TR id="line_1">           	
				<TD class="blue">业务名称</TD>
	            <TD >
	              	<input type="text" name="bizName" v_type="string" v_must="1" v_minlength="1" v_maxlength="256"   value="<%=colNameArr[0][5]%>" >&nbsp;<font color="orange">*</font>	
	            </TD>
				<TD class="blue">业务代码</TD>
	            <TD> <input type="text" name="bussId"  v_type="string" v_must="1" v_minlength="1" v_maxlength="10"   value="<%=colNameArr[0][4]%>" readonly class="InputGrey">&nbsp;<font color="orange">*</font>
	            </TD>
	         </TR>
	         <tr>
	            <td class='blue'>业务大类</td>
	            <td>
	                <%
	                    String smCode = "";
	                    if("M".equals(colNameArr[0][38].substring(0,1))){
	                        smCode = "ML";
	                    }else{
	                        smCode = "AD";
	                    }
	                %>
	                <select name="bizTypeL" id="bizTypeL" onChange="changeBizTypeL()">
    	  			<wtc:qoption name="sPubSelect" outnum="2">
    				<wtc:sql>select distinct main_type,main_type||'->'||main_name from sbiztypecode where sm_code='<%=smCode%>'</wtc:sql>
    				</wtc:qoption>
    				</select>
    				&nbsp;<font class='orange'>*</font>
	            </td>
	            <td class='blue'>业务小类</td>
	            <td>
	                <select name="bizTypeS" id="bizTypeS">
    	  			<wtc:qoption name="sPubSelect" outnum="2">
    				<wtc:sql> select biztype,biztype||'->'||biztypename from sbiztypecode where sm_code='<%=smCode%>' and main_type='<%=colNameArr[0][38]%>'</wtc:sql>
    				</wtc:qoption>
    				</select>
    				&nbsp;<font class='orange'>*</font>
	            </td>
	        </tr>
	         <TR id="line_1"> 
	         	<TD class="blue">EC/SI名称</TD>
	            <TD>
	              	<input type="text" readonly class="InputGrey" name="spBizName" v_type="string" v_must="1" v_minlength="1" v_maxlength="256"  maxlength="256" value="<%=parterName%>" >
	            </TD>
				<TD class="blue">访问模式</TD>
	            <TD>
	            		<select name="accessModel" disabled>
	            		<%
	            		String accessModel1="";
	            		String accessModel2="";
	            		String accessModel3="";
	            		String accessModel4="";
	            		
	            		if(colNameArr[0][10].equals("01"))
	            		{
	            			accessModel1="selected";
	            		}else if(colNameArr[0][10].equals("02"))
	            		{
	            			accessModel2="selected";
	            		}else if(colNameArr[0][10].equals("03"))
	            		{
	            			accessModel3="selected";
	            		}
	            		else if(colNameArr[0][10].equals("04"))
	            		{
	            			accessModel4="selected";
	            		}
	            	%>
          					<option value='01' <%=accessModel1%>  >SMS</option>
          					<option value='02' <%=accessModel2%>  >WAP</option>
          					<option value='03' <%=accessModel3%>  >MMS</option>
          					<option value='04' <%=accessModel4%>  >其他</option>
	              	</select>
	            </TD>	         								    		            	              
	         </TR>
	         
	         <TR id="line_1">
	         	<TD class="blue">基本接入号</TD>
	            <TD>
	              	<input type="text" name="accNum"  v_type="int" v_must="1" v_minlength="8" v_maxlength="128"  maxlength="128" value="<%=colNameArr[0][2]%>" class="InputGrey" readonly >	
	            </TD> 
	             <TD class="blue">接入号属性：</TD>
				<TD>  
					<select name="BaseServCodeProp" style="width:133px;" disabled > 
	        <%          String accessType1="";
	            		String accessType2="";
	            		String accessType3="";
	            		
	            		
	            		if(colNameArr[0][3].equals("01"))
	            		{
	            			accessType1="selected";
	            		}else if(colNameArr[0][3].equals("02"))
	            		{
	            			accessType2="selected";
	            		} else if(colNameArr[0][3].equals("03"))
	            		{
	            			accessType3="selected";
	            		}   
	         %>   		  
	         			<option value='01' <%=accessType1%>  >短信</option>
          				<option value='02' <%=accessType2%>  >彩信</option>
          				<option value='03' <%=accessType3%>  >WAPPush</option> 
          		</select>
	            </TD>	
	            </TR>
	             <TR id="YYYY" name="YYYY" class="YYYY">					
								<TD class="blue">单价</TD>
	            	<TD>
	              	<input type="text" name="price" v_type="0_9" v_must="1" v_minlength="1" v_maxlength="9" maxlength="9" value="<%=colNameArr[0][16]%>" >&nbsp;<font color="orange">*</font>	
	            	(元)
	            	</TD>	 
	         			<TD class="blue">计费类型</TD>
	            	<TD>
	            	<%
	            		String btFlag1="";
	            		String btFlag2="";
	            		String btFlag3="";
	            		
	            		if(colNameArr[0][17].equals("00"))
	            		{
	            			btFlag1="selected";
	            		}else if(colNameArr[0][17].equals("01"))
	            		{
	            			btFlag2="selected";
	            		}else if(colNameArr[0][17].equals("02"))
	            		{
	            			btFlag3="selected";
	            		}
	            	%>
	            	<select name="billingType"  onchange="changeRBList()" >
          					<option value='00' <%=btFlag1%> >免费</option>
          					<option value='01' <%=btFlag2%> >包月</option>
          					<option value='02' <%=btFlag3%> >按次</option>
	              	</select>&nbsp;<font color="orange">*</font>
	            </TD>
	         </TR>
	         <TR>
				<TD class="blue">业务优先级</TD>
	            <TD>
	              	<select name="bizPRI">
	           		 	<option value='00'>00</option>
	      					<option value='01'>01</option>
	      					<option value='02'>02</option>
	      					<option value='03'>03</option>
	      					<option value='04'>04</option>
	      					<option value='05'>05</option>
	      					<option value='06'>06</option>
	      					<option value='07'>07</option>
	      					<option value='08'>08</option>
	      					<option value='09'>09</option>
	              	</select>&nbsp;<font color="orange">*</font>
	            </TD>	         								    		            	              
	         
	         
	          
	         	<TD class="blue">业务状态</TD>
	            <TD>
	            	
	            	<%
	            		String bsFlag1="";
	            		String bsFlag2="";
	            		String bsFlag3="";
	            		String bsFlag4="";
	            		
	            		if(colNameArr[0][18].equals("A"))
	            		{
	            			bsFlag1="selected";
	            		}else if(colNameArr[0][18].equals("S"))
	            		{
	            			bsFlag2="selected";
	            		}else if(colNameArr[0][18].equals("T"))
	            		{
	            			bsFlag3="selected";
	            		}
	            		else if(colNameArr[0][18].equals("R"))
	            		{
	            			bsFlag4="selected";
	            		}
	            	%>
	            	<select name="bizStatus">
      					<option value='A' <%=bsFlag1%> >正常商用</option>
      					<option value='S' <%=bsFlag2%> >内部测试</option>
      					<option value='T' <%=bsFlag3%> >测试待审</option>
      					<option value='R' <%=bsFlag4%> >试商用</option>
	              	</select>&nbsp;<font color="orange">*</font>
	            </TD>
	           </TR>
	         
	       
	            
	         <TR id="line_1"> 
	            <TD class="blue">网络属性</TD>
	            <TD>
	            	<select name="netAttr" style="width:133px;" disabled >
	            		<%
	            		if(netArr!=null) {
		            		for(int i = 0; i < netArr.length; i++)
										{		  
		            		%>
          					<option value="<%=netArr[i][0]%>" <%if(colNameArr[0][9].equals(netArr[i][0])){out.println("selected");}%> )><%=netArr[i][1]%></option>
          			<%	}
          			}else
          				{
          				%>
          				<option ></option>
          				<%
          				}
          			%>	
	              	</select>
	            </TD>	  	         								    		            	              
	         
	         	<TD class="blue" >业务开放类别：</TD>
                   <TD > 
              	<%
              	if(colNameArr[0][11].equals("0"))
	            		{%>
	            			<input type="hidden" name="bizType" value="0" >面向EC
	            			<%
	            		}else if(colNameArr[0][11].equals("1"))
	            		{%>
	            			<input type="hidden" name="bizType" value="1" >面向个人
	            			<%
	            		}
	            		%>
	            </TD>		 		
	         </TR>
	         <TR>
	        
	            <TD class="blue">生效时间</TD>
	            <TD>
	              	<input type="text" name="oprEffTime" maxlength="8" value="<%=colNameArr[0][14].substring(0,8)%>" >&nbsp;<font color="orange">*</font>&nbsp;(格式：yyyymmdd)	
	            </TD>			
	            <TD class="blue">参数类型 </TD>
	          <TD>
					<input name="grpParamSet" type="hidden" value="<%=colNameArr[0][1]%>" size="16" maxlength=8 readonly v_type="string">
					<input name="grpParamSetName" type="text" value="<%=grpParamSetName%>" size="16" v_must="1"  maxlength=8 readonly class="InputGrey" v_type="string">
					<input type="button" class="b_text" name="checkFatherBtn1" value="查询" onClick="getParamSet(1)" >&nbsp;<font color="orange">*</font>
	        </TD>	 
	       </TR>
	       <TR id="XXXX" name="XXXX" class="XXXX"> 
							<TD class="blue">业务属性</TD>
	             <TD >
	            	<%
	            		String rBList1="";
	            		String rBList2="";
	            		String rBList3="";
	            		String rBList4="";
	            	if(colNameArr[0][19].equals("1"))
	            		{
	            			rBList1="selected";
	            		}else if(colNameArr[0][19].equals("2"))
	            		{
	            			rBList2="selected";
	            		}else if(colNameArr[0][19].equals("3"))
	            		{
	            			rBList3="selected";
	            		}else if(colNameArr[0][19].equals("4"))
	            		{
	            			rBList4="selected";
	            		}
	            		
	            	%>
	            	<select name="rBList" style="width:133px;" disabled >
          					<option value='1' <%=rBList1%> >永久性白名单</option>
          					<option value='2' <%=rBList2%> >黑名单</option>
          					<option value='3' <%=rBList3%> >限制次数白名单</option>
          					<option value='4' <%=rBList4%> >点播业务</option>
	              	</select>&nbsp;
	            	
	            </TD>	 
	         		<TD class="blue">限制下发次数：</TD>
	            <TD  height = 20>
	              	<input type="text" name="LimitAmount"  maxlength="12" v_type="0_9" v_must="0" v_minlength="0" v_maxlength="12" v_name="限制下发次数" value="<%=colNameArr[0][22]%>">&nbsp;
	           </TD>	
	         	 
	         		
	            </TR>
	          <TR id="cylx1"  name="cylx1" >	
	          	<TD class="blue" >成员类型</TD>
              <TD  colspan="3" > 
              	<%
              	if(colNameArr[0][20].equals("0"))
	            		{%>
	            			<input type="hidden" name="CreateFlag" value="0"  >B-C/P类
	            			<%
	            		}else if(colNameArr[0][20].equals("1"))
	            		{%>
	            			<input type="hidden" name="CreateFlag" value="1"  >B-E/M类
	            			<%
	            		}
	            		%>
	            </TD>
	          	</TR>    
	         <TR id="line_1">	         	
				<TD class="blue">SIProvision的URL</TD>
	            <TD colspan="3">
	              	<input type="text" name="provURL" maxlength="128" value="<%=colNameArr[0][6]%>" size="101">&nbsp;&nbsp;(限120个字符)
	            </TD>	         								    		            	              
	         </TR>
	         
	         <TR id="line_1">
	         	<TD class="blue">业务使用方法描述</TD>
	            <TD colspan="3">
	              	<input type="text" name="usageDesc" v_type="string"  v_minlength="1" v_maxlength="512" maxlength="512" value="<%=colNameArr[0][7]%>" size="101">&nbsp;&nbsp;(限500个字符)	
	            </TD> 					         								    		            	              
	         </TR>
	         
	         <TR id="line_1">	         	 
				<TD class="blue">业务的介绍网址</TD>
	            <TD colspan="3">
	              	<input type="text" name="introURL" maxlength="128" value="<%=colNameArr[0][8]%>" size="101">&nbsp;&nbsp;(限120个字符)
	            </TD>	         								    		            	              
	         </TR>
	         
	        <%          if("1".equals(colNameArr[0][11]))
             {
%>
				<TR   id="line_1">
	         	<TD class="blue" >是否是预付费业务：</TD>
	            <TD >
	              	<%
	              	   String isPreflag1="";
	              	   String isPreflag2="";
	              	   if(colNameArr[0][29].equals("0"))
	              	   {
	              	       isPreflag1="selected";
	              	   }else if(colNameArr[0][29].equals("1"))
	              	   {
	              	   	   isPreflag2="selected";
	              	   }
	                %>
	              	  <select name="isPrepay" style="width:133px; "  >
          					<option value='0' <%=isPreflag1%> >否</option>
          					<option value='1' <%=isPreflag2%> >是</option>
          					
	              	</select>&nbsp; 
	            </TD>
	            <TD class="blue">缺省签名语言：</TD>
	            <TD>
	            	<%
	            		String DefaultSignflag1="";
	            		String DefaultSignflag2="";
	            		
	            		
	            		if(colNameArr[0][26].equals("1"))
	            		{
	            			DefaultSignflag1="selected";
	            		}else if(colNameArr[0][26].equals("2"))
	            		{
	            			DefaultSignflag2="selected";
	            		}
	            	%>
	            	<select name="defaultSign" style="width:133px;"   >
          					<option value='1' <%=DefaultSignflag1%> >中文</option>
          					<option value='2' <%=DefaultSignflag2%> >英文</option>	
	              	</select>&nbsp;
	            </TD>
	        </TR>
				<TR   id="line_1"> 
	          	<TD class="blue" >英文正文签名：</TD>
	            <TD  height = 20>
	              	<input type="text" name="TextSignEn"  maxlength="30" v_type="string" v_must="1" v_minlength="1" v_maxlength="30" v_name="英文正文签名" value="<%=colNameArr[0][27]%>">&nbsp;<font color="#FF0000">*</font>
	           </TD>	
                <TD class="blue" >中文正文签名：</TD>
	            <TD >
	              	<input type="text" name="TextSignZh"  v_type="string" v_must="1" v_minlength="1" v_maxlength="30" v_name="中文正文签名" maxlength="30" value="<%=colNameArr[0][28]%>" >&nbsp;	<font color="#FF0000">*</font>
	            </TD>	         								    		            	              
	         </TR>
	         <TR   id="line_1">
	         	<TD class="blue" >是否支持正文签名：</TD>
	            <TD >
	              	<%
	              	   String ISTextSignflag1="";
	              	   String ISTextSignflag2="";
	              	   if(colNameArr[0][25].equals("0"))
	              	   {
	              	       ISTextSignflag1="selected";
	              	   }else if(colNameArr[0][25].equals("1"))
	              	   {
	              	   	   ISTextSignflag2="selected";
	              	   }
	                %>
	              	  <select name="ISTextSign" style="width:133px;"   >
          					<option value='0' <%=ISTextSignflag1%> >不支持</option>
          					<option value='1' <%=ISTextSignflag2%> >支持</option>
          					
	              	</select>&nbsp; 
	            </TD>
	            <TD class="blue">业务接入号鉴权方式：</TD>
	            <TD >
	            	<%
	            		String AuthModeflag1="";
	            		String AuthModeflag2="";
	            		
	            		
	            		if(colNameArr[0][21].equals("1"))
	            		{
	            			AuthModeflag1="selected";
	            		}else if(colNameArr[0][21].equals("2"))
	            		{
	            			AuthModeflag2="selected";
	            		}
	            	%>
	            	<select name="AuthMode" style="width:133px;"  >
          					<option value='1' <%=DefaultSignflag1%> >精确匹配</option>
          					<option value='2' <%=DefaultSignflag2%> >模糊匹配</option>	
	              	</select>&nbsp;
	            </TD>
	        </TR>
				<TR   id="line_1"> 
	          	<TD class="blue" >每日下发的最大条数：</TD>
	            <TD  >
	              	<input type="text" name="MaxItemPerDay"  maxlength="12" v_type="0_9" v_must="1" v_minlength="1" v_maxlength="12" v_name="每日下发的最大条数" value="<%=colNameArr[0][23]%>">&nbsp;<font color="#FF0000">*</font>
	           </TD>	
                <TD class="blue" >每月下发的最大条数：</TD>
	            <TD >
	              	<input type="text" name="MaxItemPerMon"　 v_type="0_9" v_must="1" v_minlength="0" v_maxlength="12" v_name="每月下发的最大条数" maxlength="12" value="<%=colNameArr[0][24]%>" >&nbsp;<font color="#FF0000">*</font>	
	            </TD>	         								    		            	              
	         </TR>
	         <TR   id="line_1"> 
	          	 <TD class="blue" >业务接入号：</TD>
	            <TD colspan="3" >
	              	<input type="text" name="accessNumber" readonly class="InputGrey" v_type="string" v_must="1" v_minlength="1" v_maxlength="128" v_name="业务接入号"  value="<%=colNameArr[0][30]%>" >&nbsp;<font color="#FF0000">*</font>	
	            </TD>	         								    		            	              
	         </TR>
	         <TD class="blue" >不允许下发时间段列表：</TD>
	              <TD colspan="3" >
	              	<input type="text" name="InvalidTimeSpanList" maxlength="128" value="" size="60" readOnly>&nbsp;	              
	                </TD>	
	                        								    		            	              
	         </TR>
	         <TR bgcolor="#F5F5F5" id="line_1">	         	 
				   <TD  class="blue">上行业务指令：</TD>
	              <TD colspan="3" >
	              	<input type="text" name="MOList" maxlength="128" value="" size="60" readOnly>&nbsp;	            
	                </TD>	
	                       								    		            	              
	         </TR>
	        
<%          }
%>	  
	         
		</TABLE>	       
		

		<TABLE cellSpacing=0>
			 <TR id='footer'> 
	         	<TD> 		      
	         	    <input name="backBtn" style="cursor:hand" type="button" class="b_foot" value="关闭" onClick="javascript:window.close()">	         	    	         	     		         	     	         	   
			 	</TD>
	       </TR>
	    </TABLE>	   	
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
<%}
}else{%>

	<script language='jscript'>
	          rdShowMessageDialog("错误信息：<%=retMsg%>",0);		          
	           parent.location="f2896_1.jsp"; 
	      </script>   
	<% }%>