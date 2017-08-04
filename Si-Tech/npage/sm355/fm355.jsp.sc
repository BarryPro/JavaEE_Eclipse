<%
/********************
 version v2.0
开发商: si-tech
create by wanglm 20110321
********************/
%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
  request.setCharacterEncoding("GBK");
  String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String current_timeNAME=new SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date());
		String regionCode= (String)session.getAttribute("regCode");
		String loginNoPass = (String)session.getAttribute("password");
		String ipAddrss = (String)session.getAttribute("ipAddr");
		
		String[][]  temfavStr1 = (String[][])session.getAttribute("favInfo");
    String[] favStr1=new String[temfavStr1.length];

    String currentTime = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date()); //当前时间
    String haveA555="no";

  for(int i=0;i<favStr1.length;i++){
     favStr1[i]=temfavStr1[i][0].trim();

	}
	if(WtcUtil.haveStr(favStr1,"a555")){
		haveA555="yes";
		}
		/*
	if("no".equals(haveA555)){
		%>
		<script type="text/javascript">
			rdShowMessageDialog("该工号无a555优惠权限，不能办理该业务！",1);
			removeCurrentTab();
		</script>
		<%
	
	}
	*/
%>
  
	
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<script type="text/javascript">
  onload=function()
  {

  
  }
				
 
 function deleteoffer(acceptss,bands,usernames,usericcid,usericcidtypes,moneys,phoneno,kuandainos,belongcode,id_nos,liushui){
	 		if(bands == "ki" && "<%=haveA555%>" == "no"){
	 			rdShowMessageDialog("该工号无a555优惠权限，不能办理该业务！",1);
				return false;
	 		}
	 		if("<%=haveA555%>" == "yes" && bands!="ki"){
	 			rdShowMessageDialog("具有a555优惠权限，不能办理集团宽带（ki）以外业务！",1);
				return false;
	 		}
			  	//if(confirm("确定取消此条资费？"))
			  	if(rdShowConfirmDialog("确定进行押金返还？")==1)
			{
				$("#acceptss").val("");
				$("#bands").val("");
				$("#usernames").val("");
				$("#usericcidtypes").val("");
				$("#usericcid").val("");
				$("#moneys").val("");
				$("#phoneno").val("");
				$("#kuandainos").val("");
				$("#belongcode").val("");
				$("#id_nos").val("");
				
				
				$("#acceptss").val(acceptss);
				$("#bands").val(bands);
				$("#usernames").val(usernames);
				$("#usericcidtypes").val(usericcidtypes);
				$("#usericcid").val(usericcid);
				$("#moneys").val(moneys);
				$("#phoneno").val(phoneno);
				$("#kuandainos").val(kuandainos);
				$("#belongcode").val(belongcode);
				$("#id_nos").val(id_nos);
				$("#liushui").val(liushui);
				
       document.form1.action="fm355Cfm.jsp";
       document.form1.submit();
      }
					
 }
    
 
    
		function querinfo(data){
				//找到添加表格的div
				var markDiv=$("#showTab"); 
				markDiv.empty();
				markDiv.append(data);
				
		}
		
			


 	function resetPage(){
 		window.location.href = "f<%=opCode%>.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	}
	
	
	
		function doquery()
		{
		
		  var querymsg2 = $("#querymsg2").val();
			if(querymsg2.trim()==""){
				rdShowMessageDialog("请输入宽带账号进行查询操作！",1);
				return false;
			}
    
        var myPacket = new AJAXPacket("fm355Qry.jsp","正在查询信息，请稍候......");
        myPacket.data.add("querymsg2",querymsg2);
				core.ajax.sendPacketHtml(myPacket,querinfo,true);
				getdataPacket = null;		
		
		}

</script>
</head>
<body>
<form name="form1" id="form1" method="POST" >
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
              
       <table id="add" style="display:block">
       	        <tr>
					        <td class='blue' width=16%>宽带账号</td>
					        <td>
									<input type="text" value="" name="querymsg2" id="querymsg2" size="30"   maxlength="30" /><font class="orange">*</font>
									<input  name="quchoose" id="quchoose" class="b_text" type=button value=查询  onclick="doquery()" >
					        </td>					        

					        </tr> 
					        <tr>
					        	<td colspan="3">
					        		<font class="orange">用户离网后90天内（包括90天）可办理宽带设备押金返还，不可退押金记录已置灰。<br/>如果押金是在移机中收取的，请移机撤单后再办理押金返还。</font>
					        	</td>	
					        </tr>  
        				
              </table>

        				  

	<div id="showTab" ></div>
	

              <table cellspacing="0">
          <tr>
            <td noWrap id="footer">
              <div align="center">	
              <input class="b_foot" type=button name=back value="清除" onClick="resetPage()">
		      <input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab()">
              </div>
            </td>
          </tr>
        </table>
      <input type="hidden" name="opCode" id="opCode" value="<%=opCode%>" />
      <input type="hidden" name="opName" id="opName" value="<%=opName%>" />
      <input type="hidden" name="acceptss" id="acceptss"  />
      <input type="hidden" name="bands" id="bands"  />
      <input type="hidden" name="usernames" id="usernames"  />
      <input type="hidden" name="usericcidtypes" id="usericcidtypes"  />
      <input type="hidden" name="usericcid" id="usericcid"  />
      <input type="hidden" name="moneys" id="moneys"  />
      <input type="hidden" name="phoneno" id="phoneno"  />
      <input type="hidden" name="kuandainos" id="kuandainos"  />
      <input type="hidden" name="belongcode" id="belongcode"  />
      <input type="hidden" name="id_nos" id="id_nos"  />
      <input type="hidden" name="liushui" id="liushui"  />

    <%@ include file="/npage/include/footer_simple.jsp"%>
   </form>
</body>
</html>