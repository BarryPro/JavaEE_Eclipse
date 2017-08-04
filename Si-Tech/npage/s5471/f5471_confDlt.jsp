<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
/********************
 version v3.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
 		String opCode = request.getParameter("opCode");
  	String opName = request.getParameter("opName"); 	
  
 		String opFlag = request.getParameter("op_flag");
		String loginNo = (String)session.getAttribute("workNo");
		String workName = (String)session.getAttribute("workName");
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode  = (String)session.getAttribute("regCode");
		String belongName = (String)session.getAttribute("orgCode");
		String groupId = (String)session.getAttribute("groupId");
		String pass = (String)session.getAttribute("password");
		
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		
		String inputArry[] = new String[1];
		String Tmsql="select to_char(sysdate,'yyyymmdd hh24:mi:ss') from dual";
		inputArry[0] = Tmsql;
%> 
<wtc:service name="sPubSelect" retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:param value="<%=inputArry[0]%>"/>	
	</wtc:service>	
	<wtc:array id="tempArr1"  scope="end"/>
<%
	String beginTime = tempArr1[0][0];
	/****得系统流水****/
		String printAccept="";		
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="sLoginAccept"/>
<%		
		printAccept = sLoginAccept;  
%>

	<head>
	<title>资费套餐包月费删除</title>
	<META content=no-cache http-equiv=Pragma>
	<META content=no-cache http-equiv=Cache-Control>
	<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

	<script language="javascript">
		<!--
		
			function doQuery(){				 					
					var region_code = document.all.region_code.value;
					var mode_code = document.all.mode_code.value;
					var opNote = document.all.opNote.value;
					var begin_time = document.all.begin_time.value;
					var stream = document.all.stream.value;
					document.getElementById("qryOprInfoFrame").style.display="block";
					//alert(region_code+"|"+mode_code+"|"+begin_time+"|"+opNote);
					document.qryOprInfoFrame.location = "f5471_getModeChkInfo.jsp?mode_code="+mode_code+"&region_code="+region_code+"&opNote="+opNote+"&begin_time="+begin_time+"&stream="+stream;
				}
		function queryRegionCode()
		{
			document.all.queryButton.disabled=false;
			var regionCode = "<%=regionCode%>";
			var pageTitle = "资费查询";
    	var fieldName = "地区代码|地区名称";//弹出窗口显示的列、列名 
    	var sqlStr ="select  region_code, region_name from(select a.region_code region_code , a.region_name region_name from sRegionCode a, sProdLoginCtrl b where decode(b.region_code,'99',b.region_code,a.region_code) = b.region_code and b.login_no ='" + document.all.loginNo.value + "' union select a.region_code region_code , a.region_name region_name from sRegionCode a where region_code ='"+ regionCode+ "') where rownum < 14 order by region_code " ;
    	var selType = "S";    //'S'单选；'M'多选
    	var retQuence = "0|1";//返回字段
    	var retToField = "region_code|region_name";//返回赋值的域    
    	if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
			var region_code = document.all.region_code.value;
			if(region_code=="请点选择" || region_code =="")
			{
				document.all.queryButton.disabled=true;	
			}
			//window.open("f5471_qryRegionCode.jsp?clear_sm_code=1&clear_mode_use=1","","height=400,width=400,scrollbars=yes");
		}	
		function salechage()
		{   
		  	var regionCode = document.all.region_code.value;	
				var modeCode=document.all.mode_code.value;	
				var pageTitle = "资费查询";
  			var fieldName = "主资费代码|主资费名称";//弹出窗口显示的列、列名 
  			//var sqlStr ="select mode_code,trim(mode_name),mode_flag from sBillModeCode where region_code='" + document.form1.region_code.value + "' and mode_code like '";
  			//sqlStr = sqlStr+codeChg("%" + modeCode + "%").trim() ;
  			//sqlStr = sqlStr+"' and region_code||mode_code not in(select trim(group_id)||mode_code from sbillmoderelease)" ;
			var sqlStr = "select a.offer_id,a.offer_name ";
			    sqlStr = sqlStr+ "from product_offer a, region b,sregioncode c ";
			    sqlStr = sqlStr+ "where a.offer_id = b.offer_id and  b.group_id = c.group_id ";
			    sqlStr = sqlStr+ "and c.region_code = '" + document.form1.region_code.value + "' and a.offer_id like '"+codeChg("%" + modeCode + "%").trim()+"'";
			    sqlStr = sqlStr+ "and a.offer_id not in (select offer_id from product_offer_attr where offer_attr_seq= '5070')";  			
  			var selType = "S";    //'S'单选；'M'多选
  			var retQuence = "2|0|1|";//返回字段
  			var retToField = "mode_code|mode_name|";//返回赋值的域    
  			if(PubSimpSelTwo(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
		}	
			/**重置页面**/
			function doReset(){
				//因为document.all.confirmFlag.value随着切换拥有不同的值
				//如果form1.reset(),则容易错误.
				//可废弃以下的代码,修改成:window.location.reload()或者window.location.href="xxxx"
				var e = document.forms[0].elements;
				for(var i=0;i<e.length;i++){
				  if(e[i].type=="select-one"){
				  	e[i].value="";
				  	e[i].disabled=false;
				  }
				  if(e[i].type=="text"){
				  	e[i].value="";
				  	e[i].disabled=false;
				  }
				}
				
				//隐藏所有的显示的iframe
				var iframes = document.getElementsByTagName("iframe");
				for(var i=0;i<iframes.length;i++){
					iframes[i].style.display = "none";	
				}
				document.form1.opNote.value = "<%=loginNo%>：执行了资费套餐包月费删除操作";
			}
			function PubSimpSelTwo(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
			{
			    var path = "<%=request.getContextPath()%>/npage/public/fPubSimpSel_1270.jsp";
			    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
			    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
			    path = path + "&selType=" + selType + "&opCode=5471";  
			    retInfo = window.showModalDialog(path,"","dialogWidth:60");
			    if(retInfo ==undefined)      
			    {   return false;   }
			    var chPos_field = retToField.indexOf("|");
			    var chPos_retStr;
			    var valueStr;
			    var obj;
			    while(chPos_field > -1)
			    {
			        obj = retToField.substring(0,chPos_field);
			        chPos_retInfo = retInfo.indexOf("|");
			        valueStr = retInfo.substring(0,chPos_retInfo);
			        document.all(obj).value = valueStr;
			        retToField = retToField.substring(chPos_field + 1);
			        retInfo = retInfo.substring(chPos_retInfo + 1);
			        chPos_field = retToField.indexOf("|");
			        
			    }
				return true;
			}
			function codeChg(s)
			{
			  var str = s.replace(/%/g, "%25").replace(/\+/g, "%2B").replace(/\s/g, "+"); // % + \s
			  str = str.replace(/-/g, "%2D").replace(/\*/g, "%2A").replace(/\//g, "%2F"); // - * /
			  str = str.replace(/\&/g, "%26").replace(/!/g, "%21").replace(/\=/g, "%3D"); // & ! =
			  str = str.replace(/\?/g, "%3F").replace(/:/g, "%3A").replace(/\|/g, "%7C"); // ? : |
			  str = str.replace(/\,/g, "%2C").replace(/\./g, "%2E").replace(/#/g, "%23"); // , . #
			  return str;
			}
			/**关闭页面**/
			function doClose(){
				parent.removeTab("<%=opCode%>");
			}
			/******为备注赋值********/
			function setOpNote(){
				if(document.form1.opNote.value=="")
				{
				  document.form1.opNote.value = "<%=loginNo%>：执行了资费套餐包月费删除操作"; 
				}
				return true;
			}
					//-->
	</script>
	
	<!--这段css样式是用来设置切换标签的样式,,,如果有更好的切换标签来替换,,,请删除这段样式,不影响页面其他内容-->
	<style type="text/css">
	<!--
    body {
      margin:0;
      padding:0;
      font:  12px/1.5em Verdana;
    }
		
    #tabsJ {
      float:left;
      width:100%;
      background:#f6f6f6;
      font-size:93%;
      line-height:normal;
    }
    #tabsJ ul {
      margin:0;
      padding:10px 10px 0 5px;
      list-style:none;
    }
    #tabsJ li {
      display:inline;
      margin:0;
      padding:0;
    }
    #tabsJ a {
      float:left;
      background:url("/nresources/default/images/tableftJ.gif") no-repeat left top;
      margin:0;
      padding:0 0 0 5px;
      text-decoration:none;
      cursor:hand;
    }
    #tabsJ a span {
      float:left;
      display:block;
      background:url("/nresources/default/images/tabrightJ.gif") no-repeat right top;
      padding:5px 15px 4px 6px;
      color:#24618E;
    }
    /* Commented Backslash Hack hides rule from IE5-Mac \*/
    #tabsJ a span {
    	float:none;
    }
    /* End IE5-Mac hack */
    #tabsJ a:hover span {
      color:#FFF;
    }
    #tabsJ a:hover {
      background-position:0% -42px;
    }
    #tabsJ a:hover span {
      background-position:100% -42px;
    }

    #tabsJ .current a {
      background-position:0% -42px;
    }
    #tabsJ .current a span {
			font: bold;
      background-position:100% -42px;
      color:#FFF;
    }
	-->
	</style>

</head>

<body>
	<form action="" method="post" name="form1">
		<%@ include file="/npage/include/header.jsp" %>
		
		<input type="hidden" name="confirmFlag" value="oprPromptConfirm">

		<div class="title">
			<div id="title_zi">资费套餐包月费删除</div>
		</div>
		<!--
			/*@service information
			 *@name						s9616
			 *@description				审核记录查询
			 *@author					yangrq
			 *@created	2008-10-19 17:21:22
			 *@version %I%, %G%
			 *@since 1.00
			 *@input parameter information
 			 *@inparam			audit_accept 查询流水
			 *@inparam			op_time      操作时间（创建时间、或修改时间）
			 *@inparam			op_code      操作代码
			
			 *@inparam			prompt_type  提示类型
			 *@inparam			login_no     发起人工号：（创建人、修改人、删除人）
			 *@return SVR_ERR_NO 
 			 */
		-->
			<table cellspacing="0">
				<tr>
					<td width="15%" class="blue">地市代码</td>
					<td width="35%">	
						<input class="button" type="text"  v_type="string" size="8" v_must=0 v_minlength=0 v_maxlength=10 v_name="地区代码"  name=region_code value="请点选择"  maxlength=20 readonly></input><font color="#FF0000">*</font>
						<input class="button" type="button" name="query_regioncode" onclick="queryRegionCode()" value="选择">
					</td>  
					<td width="15%" class="blue">地市名称</td>  	
					<td width="35%">	
					<input name="region_name" type="text" class="InputGrey" id="region_name" maxlength=20 size="30" v_must=1 v_minlength=1 v_maxlength=30 readonly>    
        	</td>
        </tr>
        	<td width="15%" class="blue">
            	资费代码
            </td>
            <td width="35%">
            	<input type="text" name="mode_code" id="mode_code" size="9" class="button" maxlength=9 >   
            	<input class="button" type="hidden" name="query_regioncode" onclick="salechage()" value="选择">       
            </td>   
            <td width="15%" class="blue">
            	资费名称
            </td>
            <td width="35%">
				<input name="mode_name" type="text" class="InputGrey" id="mode_name" maxlength=60 readonly>
			</td>	
        </tr>
			<tr>
    			<td width="15%" class="blue">备注</td>
      		<td colspan="3">
       		<input name="opNote" type="text" id="opNote" value="<%=loginNo%>：执行了资费套餐包月费删除操作" onFocus="setOpNote();" size="60" class="InputGrey" > 
      		</td>           
			</tr>								
			</table>
			<table cellSpacing="0">
		      <tr> 
		        <td id="footer"> 
		           <input type="button" name="resetButton"  class="b_foot" value="重置" style="cursor:hand;" onclick="doReset()">&nbsp;
		           <input type="button" name="queryButton"  class="b_foot" value="查询" style="cursor:hand;" onclick="doQuery()" disabled>&nbsp;
		           <input type="button" name="closeButton" class="b_foot" value="关闭" style="cursor:hand;" onClick="doClose()">&nbsp; 
               <input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="返回">
		        </td>
		      </tr>
		    </table>

     		<table cellspacing="0">
				<tr>
					<td style="height:0;">
						<iframe frameBorder="0" id="qryOprInfoFrame" align="center" name="qryOprInfoFrame" scrolling="yes" style="height:300px;overflow-y:auto; visibility:inherit; width:99%; z-index:1; display:none;"  onload="document.getElementById('qryOprInfoFrame').style.height=qryOprInfoFrame.document.body.scrollHeight+'px'"></iframe>
					</td>
				</tr>
			</table>
		</div>
<div name="gonght" id="gonght">
			<input type="hidden" name="iOpCode" value="">
			<input type="hidden" name="loginNo" value="<%=loginNo%>">
			<input type="hidden" name="orgCode" value="<%=orgCode%>">			
			<input name="op_flag" type="hidden"  id="op_flag" value="<%=opFlag%>">  		
			<input type="hidden" name= "tmpPrepay" value="" >
			<input type="hidden" name="begin_time" id="begin_time" value="<%=beginTime%>" >
			<input type="hidden" name="stream" value="<%=printAccept%>">
			<input type="hidden" name="ipAddr" value="<%=(String)session.getAttribute("ipAddr")%>" >	
			<input type="hidden" name="return_page" value="/npage/s5471/f5471login.jsp?opName=<%=opName%>&opCode=<%=opCode%>">
</div>		
		<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>

