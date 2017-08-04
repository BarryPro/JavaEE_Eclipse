<%
/********************
 version v2.0
开发商: si-tech
update:liutong@2008.08.29
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<% request.setCharacterEncoding("gb2312");%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%!
    String[][] retInfo = new String[][]{};
    int chPos = 0;
    String typeStr = "";
    String inputStr = "";
    String valueStr = "";  
    String sys_Date = "";
    String showType = "";
     
    String fieldNum = "";
    String s2= new String();
    StringBuffer s1 = new StringBuffer(1000);
   
   String strDllData = new String();
   String tmpStr1 = new String();
   String tmpStr2 = new String();  
%> 
<%  String path=request.getRealPath(""); 
    String op_code=request.getParameter("op_code");
    String opName = "SIM卡写卡";
    String pageTitle = request.getParameter("pageTitle");
    String regioncode = request.getParameter("regioncode");
    String phone = request.getParameter("phone");
    String sim_type=request.getParameter("sim_type");
    String sim_no=request.getParameter("sim_no");
    String sim_data="";
    String eki_no="";
    String sim_data1="";
    String imsi_no="";
    String new_simdata="";
    String work_no =(String)session.getAttribute("workNo");
	 	
	 		//得到写卡数据
	 	String sqlStr="select trim(imsi_no),trim(sim_no)||','||trim(imsi_no)||','||trim(eki_no)||','||trim(smsc_no)||','||trim(pin1_no)||','||trim(pin2_no)||','||trim(puk1_no)||','||trim(puk2_no)  from dBlkCardData where  sim_status='9' and sim_no='"+sim_no+"' and  phoneno_head in (select phoneno_head from shlrcode "
 				+" where hlr_code = (select hlr_code from shlrcode where phoneno_head=substr('"+phone+"',1,7)))";     
     		System.out.println(sqlStr+"                         sqlStr in fwritecard.jsp");
      		//retArray = callView.view_spubqry32("2",sqlStr);
      		//result = (String[][])retArray.get(0); 
%>
       <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regioncode%>"  retcode="retCode" retmsg="retMessage" outnum="2">
		<wtc:sql><%=sqlStr%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end" />
<%

      	if(retCode.equals("0")||retCode.equals("000000")){	
      		if(result.length==0)
			{
              		  	retCode="000001";
			        	retMessage="SIM卡号码不存在！"; %>
					 	<script>
							rdShowMessageDialog("SIM卡号码信息错误！");
							window.close();
						</script>	
			  <%		  
			}
			else
			{
              		  	retCode="000000";
			  	retMessage="SIM卡号码查找成功！";
			  
			  	imsi_no=result[0][0];
			  	sim_data=result[0][1];
      				
			  
			}
                      
         }else{
			retCode="000002";
			retMessage="SIM卡号码信息错误！";
			
			%>
			<script>
			rdShowMessageDialog("SIM卡号码不存在！");
			window.close();
			</script>
			<%
	}		
	
           
%>
	
<%

      //显示类型 All：显示全部;Default:只显示默认的   
    String tital = request.getParameter("pageTitle");   //显示类型 All：显示全部;Default:只显示默认的   
    String selType = "M";
	
%>

<HTML><HEAD><TITLE>黑龙江移动BOSS<%=pageTitle%></TITLE>
<BODY>
<SCRIPT type=text/javascript>
function writecard()
{
	//alert("ccccccccccc");
	var simdata="<%=sim_data%>";
	//alert(simdata);
	var simsim1=simdata.substring(0,12);
	//alert(simsim1);
	//alert(simdata.length);
	var simsim3=simdata.substring(13,simdata.length);
	//alert("cccccccc="+simsim3);
	//alert("dddd="+document.all.prov_code.value);
	if(document.all.card_no.value=="" || document.all.card_no.value=="FFFFFFFFFFFFFFFF")
	{
		document.all.simdata.value=simdata;
	}else
	{
		//alert("fffffffffff");
		document.all.simdata.value=simsim1+document.all.prov_code.value+simsim3;
		//alert("gggggggggg");
	}
	//alert(document.all.simdata.value);

  /* 
  * diling update for 修改营业系统访问远程写卡系统的访问地址，由现在的10.110.0.125地址修改成10.110.0.100！@2012/6/4
  */
	path = "http://10.110.0.100:33000/writecard/writecard/NewWriteCard.jsp"
    path = path + "?datatype=1&operid=<%=work_no%>&homecity=451";
    path = path + "&phonenum=<%=phone%>" + "&res_code=<%=sim_type%>" ;
    path = path + "&data="+document.all.simdata.value;
   // alert("path="+path);
    var retInfo = window.showModalDialog("Trans.html",path,"","dialogWidth:50;dialogHeight:40;");
	//alert("retInfo="+retInfo);
	if(typeof(retInfo) == "undefined")     
    {	
    	rdShowMessageDialog("写卡出错!");
    	return false;   }
    var chPos;
    chPos = retInfo.indexOf("&");
    if(chPos < 0)
    {	
    	rdShowMessageDialog("写卡出错!");
    	return false ;	}
    //alert( retInfo.substring(0,chPos));
    retInfo=retInfo+"&";
    var retVal=new Array();   
    for(i=0;i<12;i++)
    {   	   
    	
    	var chPos = retInfo.indexOf("&");
        valueStr = retInfo.substring(0,chPos);
        var chPos1 = valueStr.indexOf("=");
        valueStr1 = valueStr.substring(chPos1+1);
        retInfo = retInfo.substring(chPos+1);
        retVal[i]=valueStr1;
        //alert("retVal["+i+"]="+retVal[i]);
    } 
    //return;
    if(retVal[0]!="0")
    {
			

		rdShowMessageDialog("写卡失败，错误代码"+retVal[0]+"请重写");
		document.all.writecardbz.value="1";
		return false;
				 
	}else
	{
		var imsino=writecardocx.GetSIMIMSI();
		document.all.write_sim.value=retVal[5];
		//alert("document.all.write_sim.value="+document.all.write_sim.value);
		//alert("imsino="+imsino)
		//imsino="<%=imsi_no%>"
		if(imsino=="<%=imsi_no%>")
		{
			rdShowMessageDialog("写卡成功,开始修改卡状态");
			document.all.writecardbz.value="2";
			savedata();
					
		}else
		{
			rdShowMessageDialog("写卡失败，此卡已坏，不能再用");
			document.all.writecardbz.value="1";
			return false;
		}
			
	}
}
 function  doProcess(packet)
 {
 	var errCode=packet.data.findValueByName("retCode");
	var errMsg=packet.data.findValueByName("retMessage");
	var retType=packet.data.findValueByName("retType");
 	
	if(retType=="getwritename")
	{

		if(parseInt(errCode)!=0)
		{
		rdShowMessageDialog(errCode+":"+errMsg);
		return false;
		}
		else
		{
			var cardstatus = packet.data.findValueByName("cardstatus");  
			
			document.all.cardstatus.value= cardstatus;
			writecard();
		}
	}
	
	if(retType=="updatedata")
	{
		//alert(errCode);
		if(parseInt(errCode)!=0)
		{
			rdShowMessageDialog(errCode+":"+errMsg);
			document.all.writecardbz.value="3";
			return false;
		}
			document.all.writecardbz.value="0";
		
		turnToDepend();
	}
 }
 
function getwritename(){
	
		
  		 var getAccountId_Packet = new AJAXPacket("<%=request.getContextPath()%>/npage/innet/fgetwritename_1104.jsp","正在获得写卡组件，请稍候......");
    		getAccountId_Packet.data.add("retType","getwritename");
		getAccountId_Packet.data.add("region_code","<%=regioncode%>");
		getAccountId_Packet.data.add("sim_type",(document.all.sim_type.value).trim());
		getAccountId_Packet.data.add("prov_code",(document.all.prov_code.value).trim());
		getAccountId_Packet.data.add("card_type",(document.all.card_type.value).trim());
		getAccountId_Packet.data.add("card_no",(document.all.card_no.value).trim());
		//alert(document.all.card_no.value);
		getAccountId_Packet.data.add("sim_data","<%=sim_data%>");
		core.ajax.sendPacket(getAccountId_Packet);
		
		getAccountId_Packet=null;
  	

}
function turnToDepend1()
{//写卡
 		
 	try{	
		var ocxver=writecardocx.GetVersion();
		var isgoodcard=writecardocx.IsCardExist();
		
		
		isgoodcard=0;
		if(isgoodcard==0)
		{
			var card_bz=writecardocx.GetSIMICCID();
			//alert(card_bz);
			if(document.all.sim_type.value!="10006")
			{
				if(card_bz.substring(0,4)=="8986")
				{
					rdShowMessageDialog("请插入空卡");
					document.all.writecardbz.value="1";
					return false;
				}
			}
			var card_no=writecardocx.GetICCSerial();//取空卡序列号
			//card_no='0806000150001189';//模拟空卡号
			rdShowMessageDialog("card_no="+card_no);
			document.all.card_no.value=card_no;
			if(card_no==""||card_no=="FFFFFFFFFFFFFFFF")
			{
				document.all.cardstatus.value="3";
				writecard();
			}
			else
			{
				var prov_code=card_no.substring(8,9);
				var card_type=card_no.substring(6,8);
				if(card_type!=(document.all.sim_type.value).trim().substring(3,5))
				{
					rdShowMessageDialog(card_type+"  card_type");
					rdShowMessageDialog((document.all.sim_type.value).trim().substring(3,5)+"    document.all.sim_type.value).trim().substring(3,5");
					rdShowMessageDialog("卡类型与实际类型不符！",0);
					return false;
				}
				document.all.prov_code.value=prov_code;
				document.all.card_type.value=card_type;
				getwritename();//检查空卡资源
			
			}
		}
		else
		{
			rdShowMessageDialog("请插入卡!");
			document.all.writecardbz.value="1";
			return false;
		}
	}catch(e)
  	{
 		rdShowMessageDialog("正在加载驱动,请稍候！",0);
 	}
}
		

function savedata(){
//alert("savedata");

	var getjysim_Packet = new AJAXPacket("<%=request.getContextPath()%>/npage/innet/fsavecard_1104.jsp","正在修改空卡状态，请稍候......");
    		getjysim_Packet.data.add("retType","updatedata");
		getjysim_Packet.data.add("region_code","<%=regioncode%>");
		getjysim_Packet.data.add("phone_no",(document.all.phone_no.value).trim());
		getjysim_Packet.data.add("sim_no",(document.all.write_sim.value).trim());
		getjysim_Packet.data.add("card_no",(document.all.card_no.value).trim());
		getjysim_Packet.data.add("op_code","<%=op_code%>");
		getjysim_Packet.data.add("sim_type",(document.all.sim_type.value).trim());
		//alert(document.all.card_no.value);
		
		core.ajax.sendPacket(getjysim_Packet);
		getjysim_Packet=null;
		
}
	
function turnToDepend()
{
	var retCode_Now=(document.all.writecardbz.value).trim();
	//alert("sss="+document.all.simdata.value);
	
	var returnsim=document.all.write_sim.value;
	//alert("returnsim="+returnsim);
	
    var retCode = retCode_Now; 
	//var retName = retName_Now + retName_After + retName_AddNo;
    if(retCode =="1")
    {	
    	rdShowMessageDialog("写卡失败！",0);
    	return false;
    }
    if(retCode =="3")
    {	
    	rdShowMessageDialog("写卡成功,修改卡状态失败！",0);
    	return false;
    }
    var retInfo = retCode+"|"+returnsim+"|"+document.all.cardstatus.value+"|";
    //alert(retInfo);
    window.returnValue= retInfo;  
    window.close(); 

}
//-----------------------------------------------

</SCRIPT>

<!--**************************************************************************************-->
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
</HEAD>

<BODY>
<FORM method=post name="getsimno">
    <%@ include file="/npage/include/header_pop.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">SIM卡写卡</div>
		</div>
	
	 <table cellspacing="0">
          <tr> 
            <td nowrap width="16%" > 
              <div align="left">SIM卡类型</div>
            </td>
            <td nowrap > 
             <input type="text" name="sim_type" readonly value="<%=sim_type%>">
            </td>
            <td nowrap width="16%" > 
              <div align="left">服务号码</div>
              </td>
              <td nowrap >
              <input type="text" name="phone_no" readonly value="<%=phone%>">
            </td>
          </tr>
          <tr>
          <td nowrap width="16%" > 
          <div align="left">sim卡号码</div>
              </td>
             <td nowrap > 
             <input type="text" name="sim_no" readonly value="<%=sim_no%>">
             <input type="hidden" name="prov_code" >
             <input type="hidden" name="returnsim" >
             <input type="hidden" name="simdata" >
             <input type="hidden" name="card_no" >
             <input type="hidden" name="writecardbz" value="1" >
             <input type="hidden" name="card_type">
             <input type="hidden" name="cardstatus">
            <input type="hidden" name="write_sim" >
             </td>
           <td nowrap width="16%" > 
           
           </td>
           
                    <td nowrap  > 
                    </td>
                     
              
             </tr>
	</table>

    <TABLE  cellSpacing="0">
    <TBODY>
        <TR > 
            <TD align=center id="footer" >
                <input class="b_text" name=commit onClick="turnToDepend1()" style="cursor:hand" type=button value=写卡>&nbsp;
                <input class="b_text" name=back onClick="window.close()" style="cursor:hand" type=button value=返回>&nbsp;
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

<OBJECT
ID= "writecardocx"
CLASSID="clsid:930C8A98-EC73-4C37-9E20-9F4E0A5F93C4"
CODEBASE="/ocx/hljqqx.cab#version=1,0,0,1"
WIDTH = 0
HEIGHT = 0
ALIGN = center
HSPACE = 0
VSPACE = 0>
</OBJECT>
</BODY></HTML>    
