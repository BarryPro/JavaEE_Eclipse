<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page errorPage="/page/common/errorpage.jsp" %>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="java.text.*" %>

<%
/*
 * author  : liuxmc
 * created : 2010-03
 * revised : 2010-03
 */
 
 /*
	*针对该工号所归属的地市进行一定日期内的账户转账月限额、
	*退预存款日限额、退预存款月限额的设置，这个时间段必须是当前所在月内的一段日期，
	*不允许跨月，以3、4中所提到的限额为基准，在修改动作有效日期结束后，自动恢复为3、4中的基准限额
	*/
%>
<%
    ArrayList arr = (ArrayList)session.getAttribute("allArr");
    String[][] baseInfo = (String[][])arr.get(0);
    String workno = baseInfo[0][2];
    String workname = baseInfo[0][3];
		String op_code = "4871";
		String regionCode= (String)session.getAttribute("regCode");
		String [][] result = new String[][]{};
		
		String sqlStr="";
		
		Date date = new Date();
    DateFormat df = new SimpleDateFormat("yyyyMMdd");
		String now = df.format(date);
		String thisMonth = now.substring(0,6);
%>

<HTML>
	<HEAD>
		<TITLE>黑龙江BOSS-转账退费限额设置</TITLE>
		<META content="text/html; charset=gb2312" http-equiv=Content-Type>
		<META content=no-cache http-equiv=Pragma>
		<META content=no-cache http-equiv=Cache-Control>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_util.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_single.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_check.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/date/iOffice_Popup.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/rpc/src/core_c.js"></script>
		<script language=javascript>
			
			function isNumberString (InString,RefString){
				if(InString.length==0) return (false);
				for (Count=0; Count < InString.length; Count++)  {
				       TempChar= InString.substring (Count, Count+1);
				       if (RefString.indexOf (TempChar, 0)==-1)  
				       return (false);
				}
				return (true);
			}
	
			core.loadUnit("debug");
			core.loadUnit("rpccore");
	
			function dosubmit(){		
				var thisMonth = "<%=thisMonth%>";
				var thisDay = "<%=now%>";
				var limit_day_beg = document.form1.limit_day_beg.value;
				var limit_day_end = document.form1.limit_day_end.value;
				var limit_day_spe = document.form1.limit_day_spe.value;
				var limit_month_beg = document.form1.limit_month_beg.value;
				var limit_month_end = document.form1.limit_month_end.value;
				var limit_month_spe = document.form1.limit_month_spe.value;
				
				if(limit_day_spe == "" || limit_day_spe.length==0 ){
					alert("特殊日限额不能为空！");
					return false;
				}
				
				if(limit_day_spe.length !=0 && limit_day_spe < 0){
					alert("特殊日限额不能小于0！");
					return false;
				}
				
				if(limit_month_spe == "" || limit_month_spe.length==0 ){
					alert("特殊日限额不能为空！");
					return false;
				}
				
				if(limit_month_spe.length!=0 && limit_month_spe < 0){
					alert("特殊日限额不能小于0！");
					return false;
				}
				
				if(!(limit_day_beg == "" || limit_day_beg.length==0) && (limit_day_end == "" || limit_day_end.length==0 )){
					alert("特殊日限额时间不能为空！");
					return false;
				}
				
				
				if(!(limit_month_beg == "" || limit_month_beg.length==0) && (limit_month_end == "" || limit_month_end.length==0 )){
					alert("特殊月限额时间不能为空！");
					return false;
				}
				
				if((limit_month_beg == "" || limit_month_beg.length==0) && !(limit_month_end == "" || limit_month_end.length==0 )){
					alert("特殊月限额时间不能为空！");
					return false;
				}
		
		    if(limit_day_beg.length!=0){
		    	if(limit_day_beg.length != 8){
						alert("对不起，您输入的特殊日限额开始时间格式不对，请按照正确的格式(YYYYMMDD)填写!");
						return false;
					}
					if(limit_day_beg.substring(0,6) != thisMonth){
		     	   alert("对不起，您输入的时间不是本月时间！"); 
		     	   return false;
		      }
		       var reg = /^(\d{1,4})(\d{1,2})(\d{1,2})$/;     
		       var r = limit_day_beg.match(reg);
		       if(r==null){
		         alert("对不起，您输入的特殊日限额开始时间格式不正确，请按照正确的格式(YYYYMMDD)填写!");
		         return false;
		       }
		     }
		     
		     if(limit_day_end.length!=0 ){
		     	if(limit_day_end.length != 8){
						alert("对不起，您输入的特殊日限额结束时间格式不对，请按照正确的格式(YYYYMMDD)填写!");
						return false;
					}
					if(limit_day_end.substring(0,6) != thisMonth){
		     	   alert("对不起，您输入的时间不是本月时间！"); 
		     	   return false;    		
		       }
		       var reg = /^(\d{1,4})(\d{1,2})(\d{1,2})$/;     
		       var r = limit_day_beg.match(reg);     
		       if(r==null){
		         alert("对不起，您输入的特殊日限额结束时间格式不正确，请按照正确的格式(YYYYMMDD)填写!");
		         return false;
		       }
		     }
		     
		     if(limit_month_beg.length!=0){
		     	if(limit_month_beg.length != 6){
						alert("对不起，您输入的特殊月限额开始时间格式不对，请按照正确的格式(YYYYMM)填写!");
						return false;
					}
				//	if(limit_month_beg != thisMonth){
		   //  			alert("对不起，您输入的时间不是本月时间！"); 
		    // 			return false;
		   //  	}
		       var reg = /^(\d{1,4})(\d{1,2})$/;
		       var r = limit_month_beg.match(reg);     
		       if(r==null){
		         alert("对不起，您输入的特殊月限额开始时间格式不正确，请按照正确的格式(YYYYMM)填写!");
		         return false;
		       }
		     }
		     
		     if(limit_month_end.length!=0){
		     	if(limit_month_end.length != 6){
						alert("对不起，您输入的特殊月限额结束时间格式不对，请按照正确的格式(YYYYMM)填写!");
						return false;
					}
					//if(limit_month_end != thisMonth){
		     	//		alert("对不起，您输入的时间不是本月时间！"); 
		     	//		return false;    		
		     //	}
		       var reg = /^(\d{1,4})(\d{1,2})$/;     
		       var r = limit_month_end.match(reg);
		       if(r==null){
		         alert("对不起，您输入的特殊月限额结束时间格式不正确，请按照正确的格式(YYYYMM)填写!");
		         return false;
		       }
		     }
		     
		     if((limit_day_beg.length !=0 ) && (limit_day_end.length !=0)){
		     	 if(limit_day_beg < thisDay){
		     	 	 alert("对不起，特殊日限额开始日期不能晚于今天！");
		     	   return false;
		     	 }
		       if(limit_day_beg > limit_day_end){
		     	   alert("对不起，特殊日限额开始时间不能大于或等于特殊日限额结束时间！");
		     	   return false; 		
		     	 }	     
		     }		     
		     	
		     if((limit_month_beg.length!=0) && (limit_month_end.length != 0)){
		     		if(limit_month_beg < thisMonth){
		     			alert("对不起，特殊月限额开始日期不能晚于本月！");
		     		  return false;
		     		}
		     		if(limit_month_beg > limit_month_end){
		     		  alert("对不起，特殊月限额开始时间不能大于或等于特殊月限额结束时间！");
		     		  return false;
		     	  }
		     }		     
		    var phone_no = document.form1.msg_no.value;
				if(phone_no == null || phone_no.length == 0){
					alert("号码不能为空！");
					document.form1.msg_no.focus();
					return false;
				}				
				
				if(phone_no.length>11 || phone_no.length<11 || isNumberString(phone_no,"1234567890")!=1 ) {
					alert("请输入服务号码,长度为11位数字 !!");
					document.form1.msg_no.focus();
					return false;
				}else if (parseInt(phone_no.substring(0,3),10)<134 || (parseInt(phone_no.substring(0,3),10)>139&&parseInt(phone_no.substring(0,2),10)!=15&&parseInt(phone_no.substring(0,2),10)!=18&&parseInt(phone_no.substring(0,2),10)!=14)){
					alert("请输入134-139或是15开头的服务号码 !!");
					document.form1.msg_no.focus();
					return false;
				}		     
				 document.form1.action="s4871_3.jsp";
				 document.form1.submit();
				 return true;
				 
			}
			
			function doquery(){
				var group_id = document.form1.group_id.value;
				var limit_type = document.form1.limit_type.value;
				var myPacket = new RPCPacket("s4871_2.jsp","正在获得信息，请稍候......");
				var sqlStr = "select  to_char(nvl(limit_day_def,0)),to_char(nvl(limit_month_def,0)),to_char(nvl(LIMIT_DAY_BEG,0)),to_char(nvl(LIMIT_DAY_END,0)),to_char(nvl(LIMIT_DAY_SPE,0)),to_char(nvl(LIMIT_MONTH_BEG,0)),to_char(nvl(LIMIT_MONTH_END,0)),to_char(nvl(LIMIT_MONTH_SPE,0)),to_char(phone_no) from slimitpay	where region_code=(select distinct substr(org_code,1,2) from dloginmsg where group_id = '"+group_id+"') and 	limit_type ='"+limit_type+"'";
				//alert(sqlStr);
				myPacket.data.add("sqlStr",sqlStr);
				core.rpc.sendPacket(myPacket);
				//delete(myPacket);
				document.getElementById("tb").style.display = "block";		
			}
			
			
			function doProcess(packet){
			  document.getElementById("limit_day_def").innerHTML = packet.data.findValueByName("aaa")+"元";
			  document.getElementById("limit_month_def").innerHTML = packet.data.findValueByName("bbb")+"元";			  
			  
			  document.form1.limit_day_spe.value = packet.data.findValueByName("eee");			  
			  
			  document.form1.limit_month_spe.value = packet.data.findValueByName("hhh");
			  
			  if(packet.data.findValueByName("ccc") != 0){
			  	document.form1.limit_day_beg.value = packet.data.findValueByName("ccc");
			  }
			  
			  if(packet.data.findValueByName("ddd") != 0){
			  	document.form1.limit_day_end.value = packet.data.findValueByName("ddd");
			  }
			  
			  if(packet.data.findValueByName("fff") != 0){
			  	document.form1.limit_month_beg.value = packet.data.findValueByName("fff");
			  }
			  
			  if(packet.data.findValueByName("ggg") != 0){
			  	document.form1.limit_month_end.value = packet.data.findValueByName("ggg");
			  }
			  
			  if(packet.data.findValueByName("phone_no") != 0){
			  	document.form1.msg_no.value = packet.data.findValueByName("phone_no");
			  }
			  
			}
			
			onload=function(){
				self.status="";
				core.rpc.onreceive = doProcess;
		 }

		</script>

		<link href="<%=request.getContextPath()%>/css/jl.css" rel="stylesheet" type="text/css">
	</HEAD>
<BODY bgColor=#FFFFFF leftmargin="0" topmargin="0" background="<%=request.getContextPath()%>/images/jl_background_2.gif" onMouseDown="hideEvent()" onKeyDown="hideEvent()">
<FORM action="" method=post name=form1 >
<table width="767" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td background="<%=request.getContextPath()%>/images/jl_background_1.gif">
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
                      <td background="<%=request.getContextPath()%>/images/jl_background_4.gif"><font color="FFCC00"><b>转账退费限额设置</b></font></td>
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
      <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr> 
          <td width="45%">
          	<br>
            <table id=tbs9 width=100% height=25 border=0 align="center" cellspacing=2>
            	<tr bgcolor="#E8E8E8" >
                  <td>地市：&nbsp;&nbsp;
                  	<select size="1" name="group_id">
				              <%
				                  sqlStr= "select group_id,group_name from dchngroupmsg where group_id in (select distinct(a.group_id) from dchngroupinfo a where a.parent_group_id in (select group_id from dloginmsg where login_no ='"+workno+"')) and class_code='6' and root_distance='2' order by group_id";
				                  
				                  try{
				              %>				                  
					                <wtc:pubselect name="TlsPubSelBoss" outnum="2">
														<wtc:sql><%=sqlStr%></wtc:sql>
													</wtc:pubselect>
													<wtc:array id="result1" scope="end" />
											<%
														System.out.println(result1[0][0]);
														int recordNum = result1.length;
														result = result1;
														for(int i=0;i<recordNum;i++){
															out.print("<option class=button value='" + result[i][0] + "'>" + result[i][1] + "</option>");
														}
													}catch(Exception e){}
											%>
										</select>										
                  &nbsp;&nbsp;限额类型：
                    <select name="limit_type">
                    	<option class=button value="tf">退费</option>
                    	<option class=button value="zz">转账</option>
                    </select>
                    &nbsp;&nbsp;&nbsp;
										<input class="button" type=button value=查询 onClick="doquery();">
                  </td>
              </tr>
            </table>
          
          	<div id="tb" style="display:none">
            <table id=tbs9 width=100% height=25 border=0 align="center" cellspacing=2>
            	
              <tr bgcolor="#E8E8E8"> 
                  <td width="15%">默认日限额：</td><td width="33%" ><div id="limit_day_def"></div></td>
                  <td width="15%">默认月限额：</td><td width="34%" ><div id="limit_month_def"></div></td>
              </tr>
         
              <tr bgcolor="#E8E8E8">
                  <td width="15%">特殊日限额时间段：</td>
                  <td width="33%" >
                  	<input type="text" name="limit_day_beg" id="limit_day_beg" size="8">--
                  	<input type="text" name="limit_day_end" id="limit_day_end" size="8">
                  </td>
                  <td width="15%">特殊日限额限额：</td>
                  <td width="34%">
                    <input type="text" name="limit_day_spe" id="limit_day_spe" class="button">元
                  </td>
              </tr>
           
              <tr bgcolor="#E8E8E8">
                  <td width="15%">特殊月限额时间段：</td>
                  <td width="33%" >
                  	<input type="text" name="limit_month_beg" id="limit_month_beg" size="8">--
                  	<input type="text" name="limit_month_end" id="limit_month_end" size="8">
                  </td>  
                  <td width="15%">特殊月限额限额：</td>
                  <td width="34%">
                    <input type="text" name="limit_month_spe" id="limit_month_spe" class="button">元
                  </td>
              </tr>
              
              <tr bgcolor="#E8E8E8">
                  <td width="15%">信息发送接收号码：</td>
                  <td width="33%" colspan="3">
                  	<input type="text" name="msg_no" id="msg_no" size="11">                  	
                  </td>                    
              </tr>
            </table>
            </div>
            <table width="100%" border=0 align="center" cellpadding="4" cellspacing="1" >
              <tbody> 
              <tr bgcolor="#EEEEEE">
                <td align=center bgcolor="F5F5F5" width="100%">
                  <input class="button" name=sure type=button value=确认 onClick="dosubmit();">&nbsp;
                  <input class="button" name=reset type=reset value=关闭 onClick="window.close();">
                  &nbsp; 
                </td>
              </tr>
              </tbody>
            </table>
          </div>
          <p>&nbsp;</p>
          </td>
        </tr>
      </table>
      <br>
    </td>
  </tr>
</table>
</FORM>
</BODY>
</HTML>
