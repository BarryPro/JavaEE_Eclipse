<%
/********************
 version v2.0
开发商: si-tech
update:liutong@2008.08.26
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>

<%@ include file="/npage/include/public_title_name.jsp" %>
<% request.setCharacterEncoding("GBK");%>

<%!
    //得到输入参数
   // Logger logger = Logger.getLogger("fgetsimno_1104.jsp");
   // ArrayList retArray = new ArrayList();
   // String return_code,return_message;
   // String[][] result = new String[][]{};
    //String[][] retInfo = new String[][]{};
   // S1100View callView = new S1100View();
    int chPos = 0;
    String typeStr = "";
    String inputStr = "";
    String valueStr = "";  
    String sys_Date = "";
    String showType = "";
      
%> 


<%  
String regioncode=request.getParameter("regioncode");
 String rescode=request.getParameter("rescode");
    
    String  sqlStr = "select res_code,res_name from srescode where kind_code='1' and res_code in ("+rescode+")";
    System.out.println("sqlStrsqlStrsqlStr="+sqlStr);

	 /**
	 	try
	 	{	//得到系统时间
      		String  sqlStr = "select res_code,res_name from srescode where kind_code='1'";
      		retArray = callView.view_spubqry32("2",sqlStr);
      		result = (String[][])retArray.get(0);   		
            //Sys_Date = result[0][0];
     	}catch(Exception e){
       		logger.error("Call sunView is Failed!");
     	} 
     	 **/
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regioncode%>"  retcode="return_code" retmsg="return_message" outnum="5">
	<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result" scope="end" />
<%



    String pageTitle = request.getParameter("pageTitle");
    String fieldNum = "";
   
    String phone = request.getParameter("phone");
 

      //显示类型 All：显示全部;Default:只显示默认的   
    String tital = request.getParameter("pageTitle");   //显示类型 All：显示全部;Default:只显示默认的   
    String opName =tital;
    String selType = "M";
%>

<HTML><HEAD><TITLE>黑龙江移动BOSS<%=pageTitle%></TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<BODY>

<SCRIPT type=text/javascript>
 

  onload=function()
  {
   	
  
  }
  function doProcess(packet)
 {
 	var errCode=packet.data.findValueByName("retCode");
	var errMsg=packet.data.findValueByName("retMessage");
	var retType=packet.data.findValueByName("retType");
 	
	if(retType=="getSimn"){
		if(parseInt(errCode)!=0)
		{
		rdShowMessageDialog(errCode+":"+errMsg,0)
();
		return false;
		}
		  var simsim_no = packet.data.findValueByName("sim_no");   
		 
		  document.all.sim_no.value=simsim_no;	  
	}
	
	if(retType=="jySim"){
		if(parseInt(errCode)!=00000)
		{
		rdShowMessageDialog(errCode+":"+errMsg,0);
		return false;
		}
		turnToDepend();
	}
 }
function chggetsim(){
	document.all.sim_no.value="";
	if((document.all.phone_no.value).trim()==""){
		rdShowMessageDialog("请先取得服务号码!");
		}
	 if(document.all.getsim[0].checked==true&&(document.all.phone_no.value).trim()!="")  //随机抽取调rpc页面得到sim卡号码
  	{	
  	  var getAccountId_Packet = new AJAXPacket("<%=request.getContextPath()%>/npage/innet/fgetsimran_1104.jsp","正在获得sim卡号码，请稍候......");
    		getAccountId_Packet.data.add("retType","getSimn");
			getAccountId_Packet.data.add("region_code","<%=regioncode%>");
			getAccountId_Packet.data.add("phone_no",(document.all.phone_no.value).trim());
			getAccountId_Packet.data.add("sim_type",(document.all.sim_type.value).trim());
			core.ajax.sendPacket(getAccountId_Packet);
			getAccountId_Packet=null;
  	}

}
function turnToDepend1(){//检查SIM卡号是否正确
		if((document.all.sim_no.value).trim()==""){
			rdShowMessageDialog("Sim卡号不能为空!");
			return false;
			
		}
	
  		var getjysim_Packet = new AJAXPacket("<%=request.getContextPath()%>/npage/innet/fjysimtyp_1104.jsp","正在检查sim卡号码，请稍候......");
    		getjysim_Packet.data.add("retType","jySim");
			getjysim_Packet.data.add("region_code","<%=regioncode%>");
			getjysim_Packet.data.add("phone_no",(document.all.phone_no.value).trim());
			getjysim_Packet.data.add("sim_type",(document.all.sim_type.value).trim());
			getjysim_Packet.data.add("sim_no",(document.all.sim_no.value).trim());
		
		core.ajax.sendPacket(getjysim_Packet);
		getjysim_Packet=null;
  	

}

	
function turnToDepend()
{
	var retCode_Now=(document.all.sim_no.value).trim();
	var sim_typename=document.all.sim_type.options[document.all.sim_type.selectedIndex].text
	var cardtype=document.all.sim_type.value;
	
    var retCode = retCode_Now+"~"+sim_typename+"~"+cardtype+"~"; 
	//var retName = retName_Now + retName_After + retName_AddNo;
    if(retCode == "")
    {	
    	rdShowMessageDialog("请选择特服信息！",0);
    	return false;
    }
    var retInfo = retCode;
    window.returnValue= retInfo;  
    window.close(); 

}
//-----------------------------------------------

</SCRIPT>

<!--**************************************************************************************-->
</HEAD>
<BODY>
<FORM method=post name="getsimno">
 
     <%@ include file="/npage/include/header_pop.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=pageTitle%></div>
		</div>
	
	 <table cellspacing="0">
	 	<tbody>
          <tr> 
   
	
            <td nowrap width="16%" class="blue" > 
              <div align="left">SIM卡类型</div>
            </td>
            <td nowrap > 
              <select name="sim_type" index="7">
                        <%
					  for(int i=0;i<result.length;i++)
					  {
						  if(i==0)
						  {
					  %>
                        <option value="<%=result[i][0].trim()%>" selected><%=result[i][1].trim()%></option>
                        <%
						  }
						  else
						  {
					   %>
                        <option value="<%=result[i][0].trim()%>"><%=result[i][1].trim()%></option>
                        <%
						  }
					  }
					  %>
                      </select>
            </td>
            <td nowrap width="16%" class="blue"> 
              <div align="left">服务号码</div>
              </td>
              <td nowrap>
              <input type="text" name="phone_no" readonly value="<%=phone%>">
            </td>
          </tr>
          <tr>
           <td nowrap colspan="2" width="19%"> <input type="radio" name="getsim" value="N"  onclick="chggetsim()" index="-4">
                    随机抽取 
                    <input type="radio" name="getsim" value="Y" onclick="chggetsim()" index="-3">
                    精确输入</td>
                    <td nowrap width="16%" class="blue"> 
              <div align="left">sim卡号码</div>
              </td>
             <td nowrap > 
             <input type="text" name="sim_no" maxlength="20">
             </td>
             </tr>
           </tbody>
	</table>

    <TABLE cellSpacing="0">
    <TBODY>
        <TR> 
            <TD align=center id="footer">
       
                <input class="b_foot" name=commit onClick="turnToDepend1()" style="cursor:hand" type=button value=确认>&nbsp;
                <input class="b_foot" name=back onClick="window.close()" style="cursor:hand" type=button value=返回>&nbsp;
            </TD>
        </TR>
    </TBODY>
    </TABLE>
   
  <!------------------------> 
  <input type="hidden" name="modeCode" >
  <input type="hidden" name="modeName" >
  <!------------------------>  
  <%@ include file="/npage/include/footer_pop.jsp" %>   
</FORM>
</BODY></HTML>    
