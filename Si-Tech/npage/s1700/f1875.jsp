<%request.setCharacterEncoding("GB2312");%>
<%@ page contentType="text/html; charset=GB2312"%>
<%@ page import="com.sitech.boss.s5010.viewBean.*"%>
<%@ page import="com.sitech.boss.amd.viewbean.*"%>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page errorPage="/page/common/errorpage.jsp"%>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue"%>

<%
    ArrayList arr = (ArrayList)session.getAttribute("allArr");
    String[][] baseInfo = (String[][])arr.get(0);
    String workno = baseInfo[0][2];
    String workname = baseInfo[0][3];
    String belongName = baseInfo[0][16];
    String sOrgCode = baseInfo[0][16];

	ArrayList retArray = new ArrayList();
    String sqlStr = "";
    int recordNum = 0;
	String rowNum = "16";
    String dateStr=new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    
	ScallSvrViewBean viewBean = new ScallSvrViewBean();//实例化viewBean
	CallRemoteResultValue callRemoteResultValue = null;

	/*银行代码*/    
  String[][] result = new String[][]{};
	String[] inParas = new String[]{""};
	inParas[0] = "select agt_capture,agt_capture||'->'||agt_name from sBankAgtCapture where agt_capture='6D'";
	callRemoteResultValue = viewBean.callService("0", null, "sPubSelect", "2", inParas);
  result = callRemoteResultValue.getData();

	/*统计类型：查询到地市级别*/
	String[][] result1 = new String[][]{};
	String[] inParas1 = new String[]{""};
	inParas1[0] = "select region_code,region_code||'->'||region_name from spostregioncode order by region_code";
	callRemoteResultValue = viewBean.callService("0", null, "sPubSelect", "2", inParas1);	
	result1 = callRemoteResultValue.getData();

	/*统计类型：查询到区县级别*/
	String[][] result2 = new String[][]{};
	String[] inParas2 = new String[]{""};
	inParas2[0] = "select district_code,district_code||'->'||district_name from spostdiscode where region_code = '"+ result1[0][0] +"' order by district_code";
	callRemoteResultValue = viewBean.callService("0", null, "sPubSelect", "2", inParas2);	
	result2 = callRemoteResultValue.getData();

	/*统计类型：查询到网点级别*/
	String[][] result3 = new String[][]{};
	String[] inParas3 = new String[]{""};
/*	inParas3[0] = "select region_code||district_code||town_code,town_code||'-->'||TOWN_NAME from spostTownCode where region_code = '"+ result1[0][0] +"' and district_code = '"+ result2[0][0] +"' Order By town_code";*/
	inParas3[0] = "select town_code,town_code||'->'||TOWN_NAME from spostTownCode where region_code = '"+ result1[0][0] +"' and district_code = '"+ result2[0][0] +"' Order By town_code";
	callRemoteResultValue = viewBean.callService("0", null, "sPubSelect", "2", inParas3);	
	result3 = callRemoteResultValue.getData();


	/*统计类型：查询到网点级别*/
	String[][] result4 = new String[][]{};
	String[] inParas4 = new String[]{""};
/*	inParas3[0] = "select region_code||district_code||town_code,town_code||'-->'||TOWN_NAME from spostTownCode where region_code = '"+ result1[0][0] +"' and district_code = '"+ result2[0][0] +"' Order By town_code";*/
	inParas4[0] = "select town_code,town_code||'->'||TOWN_NAME from spostTownCode where region_code = '"+ result1[0][0] +"' and district_code = '"+ result2[0][0] +"' Order By town_code";
	callRemoteResultValue = viewBean.callService("0", null, "sPubSelect", "2", inParas4);	
	result4 = callRemoteResultValue.getData();	

%>

<HTML><HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<script language="JavaScript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/common/common.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/common/date/date.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/rpc/src/core_c.js"></script>
<script language="JavaScript"  src="<%=request.getContextPath()%>/page/s1400/pub.js"></script>

<SCRIPT type="text/javascript">
function dosubmit() {
   var rpt_flag  = document.form.rpt_flag.options[document.form.rpt_flag.selectedIndex].value;
   var bank_code = document.form.bank_code.options[document.form.bank_code.selectedIndex].value;
   var bregionCode = document.form.bregionCode.options[document.form.bregionCode.selectedIndex].value;
//   var eregionCode = document.form.eregionCode.options[document.form.eregionCode.selectedIndex].value;

   var bdistrictCode = document.form.bdistrictCode.options[document.form.bdistrictCode.selectedIndex].value;
//   var edistrictCode = document.form.edistrictCode.options[document.form.edistrictCode.selectedIndex].value;
 
   var btownCode = document.form.btownCode.options[document.form.btownCode.selectedIndex].value;
   var etownCode = document.form.etownCode.options[document.form.etownCode.selectedIndex].value;   
   
   var bdateyear = document.form.bdateyear.value;
   var edateyear = document.form.edateyear.value;
   
   document.form.hParams1.value= "prc_1875_rpt('"+rpt_flag+"','"+bank_code+"','"+bregionCode+"','"+bdistrictCode+"','"+btownCode+"','"+etownCode+"','"+bdateyear+"','"+edateyear+"' ";

   document.form.sure.disabled=true;
   form.submit();
}
</script>

<title>黑龙江BOSS-中国邮政储蓄代收统计报表</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="<%=request.getContextPath()%>/css/jl.css" rel="stylesheet" type="text/css">
</head>

<BODY bgColor=#FFFFFF leftmargin="0" topmargin="0" background="<%=request.getContextPath()%>/images/jl_background_2.gif">
<FORM action="/page/rpt/print_rpt.jsp" method="post" name="form" >
<input type="hidden" name="hDbLogin" value ="dbcustopr">
<input type="hidden" name="hParams1" value="">
<input type="hidden" name="hTableName" value="dReportTable">
<table width="767" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
      <td background="<%=request.getContextPath()%>/images/jl_background_1.gif" bgcolor="#E8E8E8"> 
        <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr> 
          <td align="right" width="45%"> 
            <p><img src="<%=request.getContextPath()%>/images/jl_chinamobile.gif" width="226" height="26"></p>
            </td>
            <td width="55%" align="right"><img src="<%=request.getContextPath()%>/images/jl_ico_1.gif" width="13" height="14" hspace="3" align="absmiddle">工号：<%=workno%><img src="<%=request.getContextPath()%>/images/jl_ico_1.gif" width="13" height="14" hspace="3" align="absmiddle">操作员：<%=workname%></td>
        </tr>
      </table>
      <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr> 
            <td align="right" background="<%=request.getContextPath()%>/images/jl_background_3.gif" height="69"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td><img src="<%=request.getContextPath()%>/images/jl_logo.gif"></td>
                <td align="right"><img src="<%=request.getContextPath()%>/images/jl_head_1.gif"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
        <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
          <tr> 
            <td align="right" width="73%"> 
              <table width="535" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td width="42"><img src="<%=request.getContextPath()%>/images/jl_ico_2.gif" width="42" height="41"></td>
                  <td valign="bottom" width="493"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr> 
                        <td background="<%=request.getContextPath()%>/images/jl_background_4.gif"><font color="FFCC00"><b>中国邮政储蓄代收统计报表</b></font></td>
                        <td><img src="<%=request.getContextPath()%>/images/jl_ico_3.gif" width="389" height="30"></td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
            </td>
            <td width="27%"> 
              <table border="0" cellspacing="0" cellpadding="4" align="right">
                <tr> 
                  <td><img src="<%=request.getContextPath()%>/images/jl_ico_4.gif" width="60" height="50"></td>
                  <td><img src="<%=request.getContextPath()%>/images/jl_ico_5.gif" width="60" height="50"></td>
                  <td><img src="<%=request.getContextPath()%>/images/jl_ico_6.gif" width="60" height="50"></td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      <table width=98% height=25 border=0 align="center" cellspacing=1 cellpadding="4" bgcolor="#FFFFFF">
        <tbody> 
              <tr bgcolor="649ECC"> 
                
            <td width="16%">操作类型：</td>
                
            <td width="32%"> 中国邮政储蓄代收统计报表
			 </td>
                
            <td width="15%">&nbsp;</td>
                
            <td width="37%">&nbsp;</td>
        </tbody> 
      </table>
        <table width=98% height=25 border=0 align="center" cellspacing=1 bgcolor="#FFFFFF">
		  		<tr bgcolor="#E8E8E8"> 
            <td width="16%" nowrap>银行代码：</td>
            <td width="32%"> 
                <select size="1" name="bank_code">
				   <%for(int i=0; i<result.length; i++) {%>
				       <option class=button value="<%=result[i][0]%>"><%=result[i][1]%></option>
				   <%}%>
				</select>
            </td>
            <td width="15%" nowrap></td>
            <td width="37%">			    
            </td>
          </tr>         
         
          <tr bgcolor="#E8E8E8"> 
            <td width="16%" nowrap>统计类型：</td>
            <td width="32%"> 
                <select size="1" name="rpt_flag">
				   <option class=button value="01">01->查询到地市级别</option>
				   <option class=button value="02">02->查询到区县级别</option>    
				   <option class=button value="03">03->查询到营业点级别</option>  
				   <option class=button value="04">04->查询具体营业网点</option>              
				</select>
            </td>
            <td width="15%" nowrap></td>
            <td width="37%">
            </td>
          </tr>


		  	<tr bgcolor="#E8E8E8"> 
            <td width="16%" nowrap>地  市:</td>
            <td width="32%"> 
                <select size="1" name="bregionCode" onChange="tochange('change_dis')" >
                    <%for(int i=0; i<result1.length; i++) {%>
				       <option class=button value="<%=result1[i][0]%>"><%=result1[i][1]%></option>
				    <%}%>
                </select>
            </td>
            <td width="15%" nowrap></td>
            <td width="37%">
            </td>            
          </tr>

		  	<tr bgcolor="#E8E8E8"> 
            <td width="16%" nowrap>区  县:</td>
            <td width="32%"> 
                <select size="1" name="bdistrictCode" onChange="tochange('change_town')" >
                    <%for(int i=0; i<result2.length; i++) {%>
				       <option class=button value="<%=result2[i][0]%>"><%=result2[i][1]%></option>
				    <%}%>
                </select>
            </td>
             <td width="15%" nowrap></td>
            <td width="37%">
            </td>            
          </tr>
     
     		<tr bgcolor="#E8E8E8"> 
            <td width="16%" nowrap>起始网点:</td>
            <td width="32%"> 
                <select size="1" name="btownCode" onChange="tochange('change_town1')">
                    <%for(int i=0; i<result3.length; i++) {%>
				       <option class=button value="<%=result3[i][0]%>"><%=result3[i][1]%></option>
				    <%}%>
                </select>
            </td>
            <td width="15%" nowrap>结束网点：</td>
            <td width="37%">
               <select size="1" name="etownCode">
                     <%for(int j=0; j<result4.length; j++) {%>
				       <option class=button value="<%=result4[j][0]%>"><%=result4[j][1]%></option>
				     <%}%>
              </select>			 
            </td>
          </tr>   
			


		  <tr bgcolor="#E8E8E8"> 
            <td width="16%" nowrap>开始帐务日期:</td>
            <td width="32%"> 
                <input type="text" name="bdateyear" maxlength="8" class="button" onKeyPress="return isKeyNumberdot(0)" value="<%=dateStr%>">
            </td>
            <td width="15%" nowrap>结束帐务日期：</td>
			<td width="37%">
                <input type="text" name="edateyear" maxlength="8" class="button" onKeyPress="return isKeyNumberdot(0)" value="<%=dateStr%>">
			</td>
          </tr>

        </table>
		  
        <TABLE width=98% height=27 border=0 align="center" cellSpacing="1" bgcolor="#FFFFFF">
          <TBODY> 
          <TR > 
            <TD noWrap bgcolor="#E8E8E8" colspan="6"> 
              <div align="center"> 
                <input type="button" name="sure" class="button" value="确认"  onClick="dosubmit()">
                &nbsp;
                <input type="reset"  name="reset"   class="button" "  value="清除" >
                &nbsp;
                <input type="button" name="return" class="button" value="返回" onClick="window.close()">
              </div>
            </TD>
          </TR>
          </TBODY> 
        </TABLE>
      <p> </p>
    </td>
  </tr>
</table>
</FORM>
</body>
</html>

<script language="javascript">
/*----------------------------调用RPC处理连动问题------------------------------------------*/

 core.loadUnit("debug");
 core.loadUnit("rpccore");
 onload=function(){
 	  //form.reset();
		core.rpc.onreceive = doProcess;
	}
var change_flag = "";//定义RPC联动全局变量 查询区县:flag_dis  查询营业厅:flag_town 默认:""
function tochange(par)
{   
	if(par == "change_dis")//查询区县
			{                  
				change_flag = "flag_dis";      
				var region_code = document.form.bregionCode.options[document.form.bregionCode.selectedIndex].value;
				var myPacket = new RPCPacket("select_rpc.jsp","正在获得区县信息，请稍候......");
/*				var sqlStr = "select region_code||district_code,district_code||'-->'||district_name from sPostDisCode where region_code = '"+region_code+"' Order By district_code";*/
				var sqlStr = "select district_code,district_code||'-->'||district_name from sPostDisCode where region_code = '"+region_code+"' Order By district_code";	
			}
/*		else if(par == "change_dis1")//查询区县
			{

				change_flag = "flag_dis1";
				var region_code = document.form.eregionCode.options[document.form.eregionCode.selectedIndex].value;
				var myPacket = new RPCPacket("select_rpc.jsp","正在获得区县信息，请稍候......");
				var sqlStr = "select region_code||district_code,district_code||'-->'||district_name from sPostDisCode where region_code = '"+region_code+"' Order By district_code";
			}
*/
		else if(par == "change_town")//查询营业厅
			{
				change_flag = "flag_town";
				var region_code = document.form.bregionCode.options[document.form.bregionCode.selectedIndex].value;
	/*			var district_code = document.form.bdistrictCode.options[document.form.bdistrictCode.selectedIndex].value.substring(1,5);*/
  			var district_code = document.form.bdistrictCode.options[document.form.bdistrictCode.selectedIndex].value;
				var myPacket = new RPCPacket("select_rpc.jsp","正在获得营业厅信息，请稍候......");
				var sqlStr = "select town_code,town_code||'-->'||TOWN_NAME from sPostTownCode where region_code = '"+region_code+"' and district_code = '"+district_code+"' Order By town_code";
				/*var sqlStr = "select region_code||district_code||town_code,town_code||'-->'||TOWN_NAME from sPostTownCode where region_code = '"+region_code+"' and district_code = '"+district_code+"' Order By town_code";*/
			}
		else if(par == "change_town1")//查询营业厅
			{
				change_flag = "flag_town1";
				var region_code = document.form.bregionCode.options[document.form.bregionCode.selectedIndex].value;
				var district_code = document.form.bdistrictCode.options[document.form.bdistrictCode.selectedIndex].value;
				var myPacket = new RPCPacket("select_rpc.jsp","正在获得营业厅信息，请稍候......");
				var sqlStr = "select town_code,town_code||'-->'||TOWN_NAME from sPostTownCode where region_code = '"+region_code+"' and district_code = '"+district_code+"' Order By town_code";
				/*var sqlStr = "select region_code||district_code||town_code,town_code||'-->'||TOWN_NAME from sPostTownCode where region_code = '"+region_code+"' and district_code = '"+district_code+"' Order By town_code";*/
			}

		myPacket.data.add("sqlStr",sqlStr);
		core.rpc.sendPacket(myPacket);
		delete(myPacket);

}

/*-----------------------------RPC处理函数------------------------------------------------*/
  function doProcess(packet)
  {
	  var rpc_page=packet.data.findValueByName("rpc_page");

	  var triListData = packet.data.findValueByName("tri_list");

  	var triList=new Array(triListData.length);
//   	alert(change_flag);
//  	alert(triListData);
//	  alert(triListData.length);
// 	alert(triListData[0].length);
// 	window.status = "";
		if(change_flag == "flag_dis")
		{
			  triList[0]="bdistrictCode";
			  document.all("bdistrictCode").options.length=0;
			  document.all("bdistrictCode").options.length=triListData.length;//triListData[i].length;
			  for(j=0;j<triListData.length;j++)
			  {
				document.all("bdistrictCode").options[j].text=triListData[j][1];
				document.all("bdistrictCode").options[j].value=triListData[j][0];
			  }//区县结果集
			  document.all("bdistrictCode").options[0].selected=true;
			  tochange("change_town");
//			  tochange("change_town1");
		}
/*		else if(change_flag == "flag_dis1")
		{
			  triList[0]="edistrictCode";
			  document.all("edistrictCode").options.length=0;
			  document.all("edistrictCode").options.length=triListData.length;//triListData[i].length;
			  for(j=0;j<triListData.length;j++)
			  {
				document.all("edistrictCode").options[j].text=triListData[j][1];
				document.all("edistrictCode").options[j].value=triListData[j][0];
			  }//区县结果集
			  document.all("edistrictCode").options[0].selected=true;
			  tochange("change_town1");
		}
*/
		else if(change_flag == "flag_town")
		{
			  triList[0]="btownCode";
			  document.all("btownCode").options.length=0;
			  document.all("btownCode").options.length=triListData.length;//triListData[i].length;
//				document.all("btownCode").options[0].text='未选定';
//				document.all("btownCode").options[0].value=document.form.bdistrictCode[document.form.bdistrictCode.selectedIndex].value.substring(2,4);

			  for(j=0;j<triListData.length;j++)
			  {
				document.all("btownCode").options[j].text=triListData[j][1];
				document.all("btownCode").options[j].value=triListData[j][0];
			  }//开始营业厅结果集
//			  document.all("btownCode").options.length=0;
//			  document.all("btownCode").options.length=triListData.length+1;//triListData[i].length;
//				document.all("btownCode").options[0].text='未选定';
//				document.all("btownCode").options[0].value=document.form.bdistrictCode[document.form.bdistrictCode.selectedIndex].value.substring(2,4);
//			  for(j=triListData.length-1;j>=0;j--)
//			  {
//			  	k=triListData.length-1-j;
//				document.all("btownCode").options[k+1].text=triListData[j][1];
//				document.all("btownCode").options[k+1].value=triListData[j][0];
//			  }//结束营业厅结果集
			  document.all("btownCode").options[0].selected=true;
			  tochange("change_town1");
		}
		else if(change_flag == "flag_town1")
		{
			  triList[0]="etownCode";
			  document.all("etownCode").options.length=0;
			  document.all("etownCode").options.length=triListData.length;//triListData[i].length;
//				document.all("etownCode").options[0].text='未选定';
//				document.all("etownCode").options[0].value=document.form.bdistrictCode[document.form.bdistrictCode.selectedIndex].value.substring(2,4);
			  for(j=0;j<triListData.length;j++)
			  {
				document.all("etownCode").options[j].text=triListData[j][1];
				document.all("etownCode").options[j].value=triListData[j][0];
			  }//开始营业厅结果集
			  

//		  document.all("etownCode").options.length=0;
//		  document.all("etownCode").options.length=triListData.length+1;//triListData[i].length;
//				document.all("etownCode").options[0].text='未选定';
//			document.all("etownCode").options[0].value=document.form.bdistrictCode[document.form.bdistrictCode.selectedIndex].value.substring(2,4);
//		  for(j=triListData.length-1;j>=0;j--)
//		  {
//		  	k=triListData.length-1-j;
//			document.all("etownCode").options[k+1].text=triListData[j][1];
//			document.all("etownCode").options[k+1].value=triListData[j][0];
//		  }//结束营业厅结果集
		}
//////////////////////////////////////////////////////////////////////////////////////////


   }
</script>
