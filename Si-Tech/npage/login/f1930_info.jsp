<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.01.14
 模块:统一查询退订
********************/
%>
<%
  /*
   * 功能: 用户定购关系查询显示页面
   * 版本: 1.8.2
   * 日期: 2005/11/09
   * 作者: huyan
   * 版权: si-tech
  */
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=gbk"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%     

	String opName = "统一查询退订";
	String opCode = "1930";
	
	String work_no = (String)session.getAttribute("workNo");
    String workName = (String)session.getAttribute("workName");
    String org_code = (String)session.getAttribute("orgCode");
	String password = (String)session.getAttribute("password");
	String ip_address = (String)session.getAttribute("ipAddr");
	
	String op_code = "1930";
	String op_note = "";
	String phone_no =request.getParameter("activePhone");
	String begin_pos = "";
	String maxretnum = "";
	//String retCode = "";
	//String retMsg ="";
		String errcode="000000";
	String errmsg="";
	String retMessage="";

%>
 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=activePhone%>" id="sLoginAccept"/>
	<%
		String loginAccept = sLoginAccept;
	%>
	
			<wtc:service name="sUnifyQry" outnum="17" routerKey="phone" routerValue="<%=phone_no%>">
			<wtc:param value="<%=loginAccept%>"/>
			<wtc:param value="01"/>
			<wtc:param value="<%=op_code%>"/>
			<wtc:param value="<%=work_no%>"/>
			<wtc:param value="<%=password%>"/>
			<wtc:param value="<%=phone_no%>"/>
			<wtc:param value=""/>
		</wtc:service>

	<wtc:array id="result1Temp" start="0" length="2" scope="end"/>
	<wtc:array id="result2Temp" start="2" length="15" scope="end"/>
<%	
	    errcode=retCode;
		errmsg=retMsg;
 System.out.println("------------lipf f1930_info.jsp retCode-------------"+retCode +"====retMsg === "+retMsg+"==loginAccept == "+loginAccept);
	
	retCode = retCode;
	retMessage = retMsg;
	//System.out.println("lipf result2Temp==="+result2Temp.length);		
	
	if(!retCode.equals("000000"))
	{%>
	 <script language='jscript'>
		rdShowMessageDialog('<%=retMessage%>' + '[' + '<%=retCode%>' + ']',0);
	</script>
	<%}else{
%>
<html  xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>统一查询退订</TITLE>
</HEAD>

<script language="JavaScript">
<!--


onload=function()
{		
	var newHeight = document.body.scrollHeight  + "px";
		var newWidth = document.body.scrollWidth  +"px";
		window.parent.document.getElementById("showCustWTab").style.height = newHeight;
		window.parent.document.getElementById("showCustWTab").style.width = newWidth;
		window.parent.document.getElementById("iFrame1").style.height = newHeight;
		window.parent.document.getElementById("iFrame1").style.width = newWidth;
}
	function go_1(){
	location = "f1930.jsp?flag=1&activePhone=<%=phone_no%>"
}


function docheckbox(seq,ojb){
    

	if(ojb.checked){
	    
		var biztype="name"+seq+"0";
		var spid="name"+seq+"1";
		var spbizcode="name"+seq+"3";
		var iJtId="name"+seq+"7";
		var iIntelNkId="name"+seq+"8";
		var iFlag="name"+seq+"9";
		var JtId=form1[eval('iJtId')].value;
		var IntelNkId=form1[eval('iIntelNkId')].value;
		var Flag=form1[eval('iFlag')].value;
		if(JtId.length<=0){
		    JtId = " ";
	    }
	    if(IntelNkId.length<=0){
		    IntelNkId = " ";
	    }
	    if(Flag.length<=0){
		    Flag = " ";
	    }
		ojb.value=form1[eval('biztype')].value+","+form1[eval('spid')].value+","+form1[eval('spbizcode')].value
		    +","+JtId+","+IntelNkId+","+Flag;
		
	}
}
function doconfirm(){
	var flag=0;
	if(document.all.cancle.length==undefined)
	{
		if(document.form1.cancle.checked){
			flag=1;
		}	
	}	
	else{
		for(var i=0;i<document.form1.cancle.length;i++)	{
			if(document.form1.cancle[i].checked){
				flag=1;
				break;
			}
		}
	}
	if(flag==0){
		rdShowMessageDialog("请选择要退订的订购关系!!");
		return false;
	}	
	var ret=rdShowConfirmDialog("是否退订?");
    if(typeof(ret)!="undefined")
    {
        if(ret==1)                      //点击认可
        {
            document.form1.action="f1930_cfm.jsp";
	        document.form1.submit();
        }
        else if(ret==0)                 //点击取消,问是否提交
        {    
            //window.location.href="f9130.jsp?activePhone=<%=phone_no%>"
        }
    }
}

var allSelFlag=true;
function selAll1()
{
        if(document.all.cancle.length==undefined)
        {
                document.all.cancle.checked=allSelFlag;
                docheckbox(document.all.cancle[i].vFlag.trim(),document.all.cancle[i]);
        }
        for(i=0;i<document.all.cancle.length;i++)
        {
                document.all.cancle[i].checked=allSelFlag;
                docheckbox(document.all.cancle[i].vFlag.trim(),document.all.cancle[i]);
        }
       allSelFlag=!allSelFlag;
}

</script>
<body>
<FORM method=post name="form1" onKeyUp="chgFocus(form1)">
	<DIV id="Operation_Table" >  
  	
		<div class="title">
			<div id="title_zi"><%=opName%> (他机验证密码)</div>
		</div>

			 <table cellspacing="0">		  
        	<TBODY> 
        	<tr>  
        		<td align="center">退订</td>      		
        	<%
            String sqlStr1="select dispflag,item_name from oneboss.SOBORDERQUERYLIST where item_type='ORDER' and qryflag='1' order by item_index";
            //ArrayList al=callSvrImpl.sPubSelect("2",sqlStr1);
%>
			<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phone_no%>"  retcode="retCode2" retmsg="retMsg2" outnum="2">
			<wtc:sql><%=sqlStr1%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="alTemp" scope="end" />
<%
			
            if(alTemp.length>0){
            	String[][] tmp=alTemp;
                for(int i=0;i<tmp.length;i++){
	              	String dispflag=tmp[i][0];	                  	
	              	String item_name=tmp[i][1];
              		if(Integer.parseInt(dispflag)==1){
              %>
              			<th align=center><%=item_name%></th>
              <%
              	}
              }
            }
          	%>
          	
			</tr>				
				
			<%
				String[][] countArray=result1Temp;
				 System.out.println("------------lipf f1930_info.jsp retCode2-------------"+retCode2 +"====retMsg2 === "+retMsg2);
				int retNum=Integer.parseInt(countArray[0][0]);
				
				//System.out.println("lipf retNum="+retNum);
				String sqlStr2="select dispflag,item_seq from oneboss.SOBORDERQUERYLIST where item_type='ORDER' and qryflag='1' order by item_index";
    			//ArrayList result=callSvrImpl.sPubSelect("2",sqlStr2);
%>
				<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phone_no%>"  retcode="retCode3" retmsg="retMsg3" outnum="2">
				<wtc:sql><%=sqlStr2%></wtc:sql>
				</wtc:pubselect>
				<wtc:array id="tmpArrTemp" scope="end" />
<%
System.out.println("------------lipf f1930_info.jsp retCode3-------------"+retCode3 +"====retMsg3 === "+retMsg3);
				for(int k=0;k<retNum;k++){
													
			%>
			<tr>	
				<td align=center><input type="checkbox" name="cancle" style="display" vFlag="<%=k%> "value="" onclick="docheckbox('<%=k%>',this)"></td>						
			<%            
            if(tmpArrTemp.length>0){
            	String[][] tmpArr=tmpArrTemp;
            	
              	for(int i=0;i<tmpArr.length;i++){	
              	String dispflag=tmpArr[i][0];                  	
              	String item_seq=tmpArr[i][1];
              	String centername="";
              	
              	int item_seqTemp = Integer.parseInt(item_seq);
              	
              	String[][] tmpresult=result2Temp;     
              	 	//System.out.println("lipf  tmpresult.length====="+tmpresult.length);
              	 	//System.out.println("lipf  k====="+k);
              	 	//System.out.println("lipf  item_seqTemp====="+item_seqTemp);
              	if(Integer.parseInt(dispflag)==1){
              		if(item_seqTemp==99){
              		    if(tmpresult[k][0].equals("JT")||tmpresult[k][0].equals("ZY")){
              		        centername = tmpresult[k][4];
              		    }
              		    else{
              		        centername = tmpresult[k][4]+"("+tmpresult[k][2]+")";
              		    }
              		}
              		else if(item_seqTemp==5){
              		    centername = tmpresult[k][item_seqTemp]+"元/月";
              		}else if(item_seqTemp==6){
              			SimpleDateFormat formatter;
    									formatter = new SimpleDateFormat ("yyyyMMddHHmmss");
    									Date ctime = formatter.parse(tmpresult[k][6].toString());
    									formatter = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
    									String ctime1=formatter.format(ctime);
              				centername = ctime1;
              		}else if (item_seqTemp==13){
              			SimpleDateFormat formatter;
    									formatter = new SimpleDateFormat ("yyyyMMddHHmmss");
              				Date ctime2 = formatter.parse(tmpresult[k][13].toString());
              				formatter = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
              				String ctime3=formatter.format(ctime2);
              				centername = ctime3;
              		}
              		else if(item_seqTemp==98){
              		    centername = k+1+"";
              		}else if (item_seqTemp == 12){
										if(tmpresult[k][item_seqTemp]==null||tmpresult[k][item_seqTemp].equals("NULL")){
											centername = "";
										}else{
											centername = tmpresult[k][item_seqTemp]; 
										}
									}else{
            	        centername = tmpresult[k][item_seqTemp];
            	        System.out.println("tmpresult["+k +"]["+item_seqTemp+ "] : "  + tmpresult[k][item_seqTemp]);
            	    }
              		System.out.println(centername);
              %>
              	<td style="display:none">
              		<input type=hidden name="name<%=k%><%=item_seq%>" value="<%=centername%>">
              	</td>
              	<TD align=center><%=centername%>&nbsp;</TD> 
              <%
              	}
              	else{
              %>
              	<td style="display:none">
              		<input type=hidden name="name<%=k%><%=item_seq%>" value="<%=tmpresult[k][item_seqTemp]%>">
              	</td>
              <%		
              	}
              }
            }
            	
          	%>          		
		  	</tr>
		   <%}%>
          </TBODY>
        </TABLE>
        <table cellspacing="0">
            <TR> 
              <TD align=center id="footer">
              	  <input class="b_foot" name=selAll type=button value=全选 onclick="selAll1()">
              	  <input class="b_foot" name=sure type=button value=确认 onclick="doconfirm()">
                  <input class="b_foot" name=reset type=reset value=关闭 onClick="window.close()">
			  </td>	
            </TR>
        </TABLE>
        <input type="hidden" name="phoneno" value="<%=phone_no%>">
 </div>
</form>
</body>
</html>
<%}%>
