<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<!-------------------------------------------->
<%/*
* 功能    : 
* 版本    : 1.0
* 日期    : 2003-11-01
* 作者    : zhangwjl
* 版权    : si-tech
* update  @ 2008-5-20
*/%>
<!-------------------------------------------->

<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
	System.out.println("================gejing============进入sShortNoSel.jsp");
	String workPwd = WtcUtil.repNull((String)session.getAttribute("password")); 
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
    String iGrpId = WtcUtil.repNull((String)request.getParameter("grpId"));
    String iRegionCode = WtcUtil.repNull((String)request.getParameter("regionCode"));
    String iGroupNo = WtcUtil.repNull((String)request.getParameter("groupNo"));
    String iUpdateNoType = WtcUtil.repNull((String)request.getParameter("updateNoType"));
    String iOfferId = WtcUtil.repNull((String)request.getParameter("offerId"));
    String iOldNo = WtcUtil.repNull((String)request.getParameter("oldNo"));
    String iSmCode = request.getParameter("smCode");	//wanghfa添加 j1接入BOSS
    String opCode = request.getParameter("opCode");

    String opName = request.getParameter("pageTitle");
    String pageTitle = request.getParameter("pageTitle");
    String fieldNum = "";
    String fieldName = request.getParameter("fieldName");

    String selType = request.getParameter("selType");
    String retQuence = request.getParameter("retQuence");
	
	String update_no_type = request.getParameter("update_no_type");
	String call_type = request.getParameter("call_type");
	String service_no = request.getParameter("service_no");
	String id_no = request.getParameter("id_no");
	String product_id = request.getParameter("product_id");
	String oldNo = request.getParameter("oldNo");
	String newNo = request.getParameter("newNo");
	
	String sqlStr ="   select short_num,ACC_NBR,'" + service_no + "' from group_instance_member a ,product_offer_instance b where b.serv_id='" + id_no + "' and  b.offer_id='" + product_id + "' and a.group_id =b.group_id " ;		 
		
	if(call_type.equals("0")){//被修改号码
	  if((update_no_type.equals("00")) || (update_no_type.equals("01"))) {
			sqlStr =  sqlStr + " and short_num like '%" + (oldNo).trim() + "%'" ;
		} else	{
			sqlStr =  sqlStr + " and ACC_NBR like '%" + (oldNo).trim() + "%'" ;
		}
	}	else {//修改后号码
	  if((update_no_type.equals("00")) || (update_no_type.equals("10"))) {
			sqlStr =  sqlStr + " and short_num like '%" + (newNo).trim() + "%'" ;
		} else {
			sqlStr =  sqlStr + " and ACC_NBR like '%" + (newNo).trim() + "%'" ; 
		}
	}

	sqlStr = sqlStr + " order by short_num " ;
	
    System.out.print("==============gejing============"+sqlStr);
    if(selType.compareTo("S") == 0)
    {   selType = "radio";    }
    if(selType.compareTo("M") == 0)
    {   selType = "checkbox";   }
    if(selType.compareTo("N") == 0)
    {   selType = "";   }
    int chPos = 0;
    String typeStr = "";
    String inputStr = "";
    String valueStr = "";   
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>黑龙江BOSS-<%=pageTitle%></TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<SCRIPT type=text/javascript>
function saveTo()
{
      var rIndex;        //选择框索引
      var retValue = ""; //返回值
      var chPos;         //字符位置
      var obj;
      var fieldNo;        //返回域序列号
      var retFieldNum = document.fPubSimpSel.retFieldNum.value;
      var retQuence = document.fPubSimpSel.retQuence.value;  //返回字段域的序列
      var retNum = retQuence.substring(0,retQuence.indexOf("|"));
      retQuence = retQuence.substring(retQuence.indexOf("|")+1);
      //var tempQuence;
      var tmpArr = retQuence.split('|');
      if(retFieldNum == "")	
      {     return false;   }
       //返回单条记录
          for(i=0;i<document.fPubSimpSel.elements.length;i++)
          { 
    		      if (document.fPubSimpSel.elements[i].name=="List")
    		      {    //判断是否是单选或复选框
    				   if (document.fPubSimpSel.elements[i].checked==true)
    				   {     //判断是否被选中
        			         rIndex = document.fPubSimpSel.elements[i].RIndex;
        			         //tempQuence = retQuence;
        			         for(n=0;n<retNum;n++)
        			         {   
        			            //chPos = tempQuence.indexOf("|");
        			            //fieldNo = tempQuence.substring(0,chPos); 
        			            obj = "Rinput" + rIndex + tmpArr[n];
        			            retValue = retValue + document.all(obj).value + "|";
        			            //tempQuence = tempQuence.substring(chPos + 1);
        			         }
        					 window.returnValue= retValue;
                       }
    		    }
    		}		
		if(retValue =="")
		{
		    rdShowMessageDialog("请选择信息项！",0);
		    return false;
		}

		window.close(); 
}

function allChoose()
{   //复选框全部选中
    for(i=0;i<document.fPubSimpSel.elements.length;i++)
    { 
        if(document.fPubSimpSel.elements[i].type=="checkbox")
        {    //判断是否是单选或复选框
            document.fPubSimpSel.elements[i].checked = true;
        }
    }  
}

function cancelChoose()
{   //取消复选框全部选中
    for(i=0;i<document.fPubSimpSel.elements.length;i++)
    { 
        if(document.fPubSimpSel.elements[i].type =="checkbox")
        {    //判断是否是单选或复选框
            document.fPubSimpSel.elements[i].checked = false;
        }
    }  
}
</SCRIPT>
</HEAD>
<body style="overflow-x:hidden">
<FORM method=post name="fPubSimpSel">   
	<%@ include file="/npage/include/header_pop.jsp" %>
	<div class="title">
		<div id="title_zi">查询结果</div>
	</div>	
  <table cellspacing="0">
    <tr>
<%  //绘制界面表头  
     chPos = fieldName.indexOf("|");
     out.print("<TR>");
     String titleStr = "";
     int tempNum = 0;
     while(chPos != -1)
     {  
        valueStr = fieldName.substring(0,chPos);
        titleStr = "<TH nowrap>&nbsp;&nbsp;" + valueStr + "</TH>";
        out.print(titleStr);
        fieldName = fieldName.substring(chPos + 1);
        tempNum = tempNum +1;
        chPos = fieldName.indexOf("|");
     }
     out.print("</TR>");
	if ("j1".equals(iSmCode)) {
		fieldNum = String.valueOf(tempNum + 1);
	} else {
		fieldNum = String.valueOf(tempNum);
	}
	System.out.println("====wanghfa====sShortNoSel====sGetShortNoList====0==== iGrpId = " + iGrpId);
	System.out.println("====wanghfa====sShortNoSel====sGetShortNoList====1==== iRegionCode = " + iRegionCode);
	System.out.println("====wanghfa====sShortNoSel====sGetShortNoList====2==== iGroupNo = " + iGroupNo);
	System.out.println("====wanghfa====sShortNoSel====sGetShortNoList====3==== iUpdateNoType = " + iUpdateNoType);
	System.out.println("====wanghfa====sShortNoSel====sGetShortNoList====4==== iOfferId = " + iOfferId);
	System.out.println("====wanghfa====sShortNoSel====sGetShortNoList====5==== iOldNo = " + iOldNo);
%>
    <wtc:service name="sGetShortNoList" retcode="retCode" retmsg="retMsg" outnum="<%=fieldNum%>" routerKey="region" routerValue="<%=iRegionCode%>">
    	<wtc:param value="0"/>
    	<wtc:param value=""/>
    	<wtc:param value="<%=opCode%>"/>
    	<wtc:param value="<%=workNo%>"/>
    	<wtc:param value="<%=workPwd%>"/>
    	<wtc:param value=""/>
    	<wtc:param value=""/>
    	<wtc:param value="<%=iGrpId%>"/>
    	<wtc:param value="<%=iRegionCode%>"/> 
        <wtc:param value="<%=iGroupNo%>"/> 
        <wtc:param value="<%=iUpdateNoType%>"/> 
        <wtc:param value="<%=iOfferId%>"/> 
        <wtc:param value="<%=iOldNo%>"/>  
    </wtc:service>
    <wtc:array id="result" scope="end"/>
<%
	System.out.println("====wanghfa====sShortNoSel====sGetShortNoList==== " + retCode + ", " + retMsg);
	for (int i = 0; i < result.length; i ++) {
		for (int j = 0; j < result[i].length; j ++) {
			System.out.println("====wanghfa====sShortNoSel====sGetShortNoList==== result["+i+"]["+j+"]" + result[i][j]);
			if ("j1".equals(iSmCode) && j > 2) {
				result[i][j - 1] = result[i][j];
			}
		}
	}
	if ("j1".equals(iSmCode)) {
		fieldNum = String.valueOf(Integer.parseInt(fieldNum) - 1);
	}
    //根据传人的Sql查询数据库，得到返回结果

      		int recordNum = result.length;
      		for(int i=0;i<recordNum;i++)
      		{
      		   String tdClass = ((i%2)==1)?"Grey":"";
      		    typeStr = "";
      		    inputStr = "";
      		    out.print("<TR>");
      		    for(int j=0;j<Integer.parseInt(fieldNum);j++)
      		    {
                    if(j==0)
                    {
                        typeStr = "<TD title=\'"+(result[i][j]).trim()+"\' class='"+tdClass+"'>&nbsp;";
                        if(selType.compareTo("") != 0)
                        {
	                        typeStr = typeStr + "<input type='" + selType +  
	          		            "' name='List' style='cursor:hand' RIndex='" + i + "'" + 
	          		            "onkeydown='if(event.keyCode==13)saveTo();'" + ">"; 
						}	          		            
                        typeStr = typeStr + (result[i][j]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + j + "'  value='" + 
          		            (result[i][j]).trim() + "'readonly></TD>";          		            
                    }
                    else
                    {
                    	if (result[i][j] == null) {
                    		result[i][j] = "";
                    	}
          		        inputStr = inputStr + "<TD title=\'"+(result[i][j]).trim()+"\' class='"+tdClass+"'>&nbsp;" + (result[i][j]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + j + "'  value='" + 
          		            (result[i][j]).trim() + "'readonly></TD>";          		            
                    }          		            
      		    }
      		    out.print(typeStr + inputStr);
      		    out.print("</TR>");
      		    }
%>
  
   </tr>
  </table>


<!------------------------------------------------------>
    <TABLE cellspacing="0">
        <TR> 
            <TD id="footer">
<%
    if(selType.compareTo("checkbox") == 0)
    {           
        out.print("<input  name=allchoose onClick='allChoose()' style='cursor:hand' type=button value=全选>&nbsp");
        out.print("<input  name=cancelAll onClick='cancelChoose()' style='cursor:hand' type=button value=取消全选>&nbsp");       
    } 
%> 

<%
				if(selType.compareTo("") != 0)
				{
%>              
                <input  name=commit onClick="saveTo()" class="b_foot" style="cursor:hand" type=button value=确认>&nbsp;
<%
				}
%>             
                <input  name=back onClick="window.close()" class="b_foot" style="cursor:hand" type=button value=返回>&nbsp;        
            </TD>
        </TR>
    </TABLE>

  <!------------------------> 
  <input type="hidden" name="retFieldNum" value=<%=fieldNum%>>
  <input type="hidden" name="retQuence" value=<%=retQuence%>>
  <!------------------------>  
 <%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</body></HTML>    
