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
	*��Ըù����������ĵ��н���һ�������ڵ��˻�ת�����޶
	*��Ԥ������޶��Ԥ������޶�����ã����ʱ��α����ǵ�ǰ�������ڵ�һ�����ڣ�
	*��������£���3��4�����ᵽ���޶�Ϊ��׼�����޸Ķ�����Ч���ڽ������Զ��ָ�Ϊ3��4�еĻ�׼�޶�
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
		<TITLE>������BOSS-ת���˷��޶�����</TITLE>
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
					alert("�������޶��Ϊ�գ�");
					return false;
				}
				
				if(limit_day_spe.length !=0 && limit_day_spe < 0){
					alert("�������޶��С��0��");
					return false;
				}
				
				if(limit_month_spe == "" || limit_month_spe.length==0 ){
					alert("�������޶��Ϊ�գ�");
					return false;
				}
				
				if(limit_month_spe.length!=0 && limit_month_spe < 0){
					alert("�������޶��С��0��");
					return false;
				}
				
				if(!(limit_day_beg == "" || limit_day_beg.length==0) && (limit_day_end == "" || limit_day_end.length==0 )){
					alert("�������޶�ʱ�䲻��Ϊ�գ�");
					return false;
				}
				
				
				if(!(limit_month_beg == "" || limit_month_beg.length==0) && (limit_month_end == "" || limit_month_end.length==0 )){
					alert("�������޶�ʱ�䲻��Ϊ�գ�");
					return false;
				}
				
				if((limit_month_beg == "" || limit_month_beg.length==0) && !(limit_month_end == "" || limit_month_end.length==0 )){
					alert("�������޶�ʱ�䲻��Ϊ�գ�");
					return false;
				}
		
		    if(limit_day_beg.length!=0){
		    	if(limit_day_beg.length != 8){
						alert("�Բ�����������������޶ʼʱ���ʽ���ԣ��밴����ȷ�ĸ�ʽ(YYYYMMDD)��д!");
						return false;
					}
					if(limit_day_beg.substring(0,6) != thisMonth){
		     	   alert("�Բ����������ʱ�䲻�Ǳ���ʱ�䣡"); 
		     	   return false;
		      }
		       var reg = /^(\d{1,4})(\d{1,2})(\d{1,2})$/;     
		       var r = limit_day_beg.match(reg);
		       if(r==null){
		         alert("�Բ�����������������޶ʼʱ���ʽ����ȷ���밴����ȷ�ĸ�ʽ(YYYYMMDD)��д!");
		         return false;
		       }
		     }
		     
		     if(limit_day_end.length!=0 ){
		     	if(limit_day_end.length != 8){
						alert("�Բ�����������������޶����ʱ���ʽ���ԣ��밴����ȷ�ĸ�ʽ(YYYYMMDD)��д!");
						return false;
					}
					if(limit_day_end.substring(0,6) != thisMonth){
		     	   alert("�Բ����������ʱ�䲻�Ǳ���ʱ�䣡"); 
		     	   return false;    		
		       }
		       var reg = /^(\d{1,4})(\d{1,2})(\d{1,2})$/;     
		       var r = limit_day_beg.match(reg);     
		       if(r==null){
		         alert("�Բ�����������������޶����ʱ���ʽ����ȷ���밴����ȷ�ĸ�ʽ(YYYYMMDD)��д!");
		         return false;
		       }
		     }
		     
		     if(limit_month_beg.length!=0){
		     	if(limit_month_beg.length != 6){
						alert("�Բ�����������������޶ʼʱ���ʽ���ԣ��밴����ȷ�ĸ�ʽ(YYYYMM)��д!");
						return false;
					}
				//	if(limit_month_beg != thisMonth){
		   //  			alert("�Բ����������ʱ�䲻�Ǳ���ʱ�䣡"); 
		    // 			return false;
		   //  	}
		       var reg = /^(\d{1,4})(\d{1,2})$/;
		       var r = limit_month_beg.match(reg);     
		       if(r==null){
		         alert("�Բ�����������������޶ʼʱ���ʽ����ȷ���밴����ȷ�ĸ�ʽ(YYYYMM)��д!");
		         return false;
		       }
		     }
		     
		     if(limit_month_end.length!=0){
		     	if(limit_month_end.length != 6){
						alert("�Բ�����������������޶����ʱ���ʽ���ԣ��밴����ȷ�ĸ�ʽ(YYYYMM)��д!");
						return false;
					}
					//if(limit_month_end != thisMonth){
		     	//		alert("�Բ����������ʱ�䲻�Ǳ���ʱ�䣡"); 
		     	//		return false;    		
		     //	}
		       var reg = /^(\d{1,4})(\d{1,2})$/;     
		       var r = limit_month_end.match(reg);
		       if(r==null){
		         alert("�Բ�����������������޶����ʱ���ʽ����ȷ���밴����ȷ�ĸ�ʽ(YYYYMM)��д!");
		         return false;
		       }
		     }
		     
		     if((limit_day_beg.length !=0 ) && (limit_day_end.length !=0)){
		     	 if(limit_day_beg < thisDay){
		     	 	 alert("�Բ����������޶ʼ���ڲ������ڽ��죡");
		     	   return false;
		     	 }
		       if(limit_day_beg > limit_day_end){
		     	   alert("�Բ����������޶ʼʱ�䲻�ܴ��ڻ�����������޶����ʱ�䣡");
		     	   return false; 		
		     	 }	     
		     }		     
		     	
		     if((limit_month_beg.length!=0) && (limit_month_end.length != 0)){
		     		if(limit_month_beg < thisMonth){
		     			alert("�Բ����������޶ʼ���ڲ������ڱ��£�");
		     		  return false;
		     		}
		     		if(limit_month_beg > limit_month_end){
		     		  alert("�Բ����������޶ʼʱ�䲻�ܴ��ڻ�����������޶����ʱ�䣡");
		     		  return false;
		     	  }
		     }		     
		    var phone_no = document.form1.msg_no.value;
				if(phone_no == null || phone_no.length == 0){
					alert("���벻��Ϊ�գ�");
					document.form1.msg_no.focus();
					return false;
				}				
				
				if(phone_no.length>11 || phone_no.length<11 || isNumberString(phone_no,"1234567890")!=1 ) {
					alert("������������,����Ϊ11λ���� !!");
					document.form1.msg_no.focus();
					return false;
				}else if (parseInt(phone_no.substring(0,3),10)<134 || (parseInt(phone_no.substring(0,3),10)>139&&parseInt(phone_no.substring(0,2),10)!=15&&parseInt(phone_no.substring(0,2),10)!=18&&parseInt(phone_no.substring(0,2),10)!=14)){
					alert("������134-139����15��ͷ�ķ������ !!");
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
				var myPacket = new RPCPacket("s4871_2.jsp","���ڻ����Ϣ�����Ժ�......");
				var sqlStr = "select  to_char(nvl(limit_day_def,0)),to_char(nvl(limit_month_def,0)),to_char(nvl(LIMIT_DAY_BEG,0)),to_char(nvl(LIMIT_DAY_END,0)),to_char(nvl(LIMIT_DAY_SPE,0)),to_char(nvl(LIMIT_MONTH_BEG,0)),to_char(nvl(LIMIT_MONTH_END,0)),to_char(nvl(LIMIT_MONTH_SPE,0)),to_char(phone_no) from slimitpay	where region_code=(select distinct substr(org_code,1,2) from dloginmsg where group_id = '"+group_id+"') and 	limit_type ='"+limit_type+"'";
				//alert(sqlStr);
				myPacket.data.add("sqlStr",sqlStr);
				core.rpc.sendPacket(myPacket);
				//delete(myPacket);
				document.getElementById("tb").style.display = "block";		
			}
			
			
			function doProcess(packet){
			  document.getElementById("limit_day_def").innerHTML = packet.data.findValueByName("aaa")+"Ԫ";
			  document.getElementById("limit_month_def").innerHTML = packet.data.findValueByName("bbb")+"Ԫ";			  
			  
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
          <td width="55%" align="right"><img src="<%=request.getContextPath()%>/images/jl_ico_1.gif" width="13" height="14" hspace="3" align="absmiddle">���ţ�<%=workno%><img src="<%=request.getContextPath()%>/images/jl_ico_1.gif" width="13" height="14" hspace="3" align="absmiddle">����Ա��<%=workname%></td>
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
                      <td background="<%=request.getContextPath()%>/images/jl_background_4.gif"><font color="FFCC00"><b>ת���˷��޶�����</b></font></td>
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
                  <td>���У�&nbsp;&nbsp;
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
                  &nbsp;&nbsp;�޶����ͣ�
                    <select name="limit_type">
                    	<option class=button value="tf">�˷�</option>
                    	<option class=button value="zz">ת��</option>
                    </select>
                    &nbsp;&nbsp;&nbsp;
										<input class="button" type=button value=��ѯ onClick="doquery();">
                  </td>
              </tr>
            </table>
          
          	<div id="tb" style="display:none">
            <table id=tbs9 width=100% height=25 border=0 align="center" cellspacing=2>
            	
              <tr bgcolor="#E8E8E8"> 
                  <td width="15%">Ĭ�����޶</td><td width="33%" ><div id="limit_day_def"></div></td>
                  <td width="15%">Ĭ�����޶</td><td width="34%" ><div id="limit_month_def"></div></td>
              </tr>
         
              <tr bgcolor="#E8E8E8">
                  <td width="15%">�������޶�ʱ��Σ�</td>
                  <td width="33%" >
                  	<input type="text" name="limit_day_beg" id="limit_day_beg" size="8">--
                  	<input type="text" name="limit_day_end" id="limit_day_end" size="8">
                  </td>
                  <td width="15%">�������޶��޶</td>
                  <td width="34%">
                    <input type="text" name="limit_day_spe" id="limit_day_spe" class="button">Ԫ
                  </td>
              </tr>
           
              <tr bgcolor="#E8E8E8">
                  <td width="15%">�������޶�ʱ��Σ�</td>
                  <td width="33%" >
                  	<input type="text" name="limit_month_beg" id="limit_month_beg" size="8">--
                  	<input type="text" name="limit_month_end" id="limit_month_end" size="8">
                  </td>  
                  <td width="15%">�������޶��޶</td>
                  <td width="34%">
                    <input type="text" name="limit_month_spe" id="limit_month_spe" class="button">Ԫ
                  </td>
              </tr>
              
              <tr bgcolor="#E8E8E8">
                  <td width="15%">��Ϣ���ͽ��պ��룺</td>
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
                  <input class="button" name=sure type=button value=ȷ�� onClick="dosubmit();">&nbsp;
                  <input class="button" name=reset type=reset value=�ر� onClick="window.close();">
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
