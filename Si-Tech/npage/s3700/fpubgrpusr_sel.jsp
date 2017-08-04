 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-01-20 页面改造,修改样式
	********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%
	String opCode = "4112";	
	String opName = "批量付费计划变更";	//header.jsp需要的参数   
	String regionCode = (String)session.getAttribute("regCode") ;
	
    //得到输入参数
    ArrayList retArray = new ArrayList();
    ArrayList retArray1 = new ArrayList();
    String return_code,return_message;
    //String[][] result = new String[][]{};
    //String[][] allNumStr =  new String[][]{};
    //SPubCallSvrImpl callView = new SPubCallSvrImpl();
%>

<%
	/*
	SQL语句        sql_content
	选择类型       sel_type
	标题           title
	字段1名称      field_name1
	*/
    	String pageTitle = request.getParameter("pageTitle");
    	String fieldNum = "";
    	String fieldName = request.getParameter("fieldName");
	String idIccid = request.getParameter("iccid");
    	String custId = request.getParameter("cust_id");
    	String unitId = request.getParameter("unit_id");
    	String grpOutNo = request.getParameter("grpOutNo");
    	String sqlFilter = "";


   	 	String selType = request.getParameter("selType");
    		String retQuence = request.getParameter("retQuence");
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

<HTML>
	<HEAD>
	<TITLE>黑龙江BOSS-集团客户查询</TITLE>
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
		      var tempQuence;
		      if(retFieldNum == "")
		      {     return false;   }
		       //返回单条记录
		          for(i=0;i<document.fPubSimpSel.elements.length;i++)
		          {
		                  if (document.fPubSimpSel.elements[i].name=="List")
		                  {    //判断是否是单选或复选框
		                       if (document.fPubSimpSel.elements[i].checked==true)
		                       {     //判断是否被选中
		                             //alert(document.fPubSimpSel.elements[i].value);
		                             rIndex = document.fPubSimpSel.elements[i].RIndex;
		                             tempQuence = retQuence;
		                             for(n=0;n<retNum;n++)
		                             {
		                                chPos = tempQuence.indexOf("|");
		                                fieldNo = tempQuence.substring(0,chPos);
		                                //alert(fieldNo);
		                                obj = "Rinput" + rIndex + fieldNo;
		                                //alert(obj);
		                                retValue = retValue + document.all(obj).value + "|";
		                                tempQuence = tempQuence.substring(chPos + 1);
		                             }
		                             //alert(retValue);
		                             window.returnValue= retValue;
		                       }
		                }
		            }
		        if(retValue =="")
		        {
		            rdShowMessageDialog("请选择信息项！",0);
		            return false;
		        }
		        opener.getvaluecust(retValue);
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

<BODY>
	<FORM method=post name="fPubSimpSel">
	<%@ include file="/npage/include/header_pop.jsp" %> 
	<div class="title">
			<div id="title_zi">集团客户查询 </div>
	</div>	
  	<table cellspacing="0">
    		<tr>
    			<Th>证件号码</Th>
				<Th>集团客户ID</Th>
				<Th>集团产品ID</Th>
				<Th>集团用户编码</Th>
				<Th>集团编码</Th>
				<Th>集团产品名称</Th>
				<Th>集团名称</TD></Th>
	<%  		//绘制界面表头
		     chPos = fieldName.indexOf("|");
		     out.print("");
		     String titleStr = "";
		     int tempNum = 0;
		     while(chPos != -1)
		     {
		        valueStr = fieldName.substring(0,chPos);
		        titleStr = "";
		        out.print(titleStr);
		        fieldName = fieldName.substring(chPos + 1);
		        tempNum = tempNum +1;
		        chPos = fieldName.indexOf("|");
		     }
		     out.print("");
		     fieldNum = String.valueOf(tempNum+1);
	%>

<%
    //根据传人的Sql查询数据库，得到返回结果
    
           // retArray = callView.sPubSelect(fieldNum,sqlStr1);
           // retArray1 = callView.sPubSelect("1",sqlStr);
           System.out.println("===================");
            
 %>
 	<wtc:service name="s4112Init" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="8">
        <wtc:param value="<%=idIccid%>"/>
        <wtc:param value="<%=custId%>"/>
        <wtc:param value="<%=unitId%>"/>
        <wtc:param value="<%=grpOutNo%>"/>
        <wtc:param value="<%=regionCode%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end" />
 <%
            int recordNum =0;
            if("000000".equals(retCode1)){
            	recordNum=result.length;
            }
            for(int i=0;i<recordNum;i++)
            {
            	if(result!=null&&result.length>0){
                typeStr = "";
                inputStr = "";
                out.print("<TR>");
                for(int j=0;j<Integer.parseInt(fieldNum)-1;j++)
                {
                    if(j==0)
                    {
                        typeStr = "<TD>&nbsp;";
                        if(selType.compareTo("") != 0)
                        {
                            typeStr = typeStr + "<input type='" + selType +
                                "' name='List' style='cursor:hand' RIndex='" + i + "'" +
                                "onkeydown='if(event.keyCode==13)saveTo();'" + ">";
                        }
                        typeStr = typeStr + (result[i][j]).trim() + "<input type='hidden' " +
                            " id='Rinput" + i + j + "'  value='" +
                            (result[i][j]).trim() + "'readonly></TD>";
                            
                    }else if(j==7){
                      if(result[i][j]!=null){
                         inputStr = inputStr + "<TD style='display:none'>&nbsp;" + (result[i][j]).trim() + "<input type='hidden' " +
                        " id='Rinput" + i + j + "'  value='" +
                        (result[i][j]).trim() + "'readonly></TD>";
                      }else{
                        inputStr = inputStr + "<TD style='display:none'>&nbsp;" + "dd" + "<input type='hidden' " +
                        " id='Rinput" + i + j + "'  value='" +
                        "" + "'readonly></TD>";
                      }
                    }
                    else
                    {
                      if(result[i][j]!=null){
                         inputStr = inputStr + "<TD>&nbsp;" + (result[i][j]).trim() + "<input type='hidden' " +
                            " id='Rinput" + i + j + "'  value='" +
                            (result[i][j]).trim() + "'readonly></TD>";
                      }else{
                        inputStr = inputStr + "<TD>&nbsp;" + "" + "<input type='hidden' " +
                            " id='Rinput" + i + j + "'  value='" +
                            ""+ "'readonly></TD>";
                      }
                    }
                }
                out.print(typeStr + inputStr);
                out.print("</TR>");
                }
            }
        
        
%>
<%


%>
   	</tr>
 </table>

 <TABLE  cellspacing="0">    
        <TR>
            <TD id="footer">
	<%
	    if(selType.compareTo("checkbox") == 0)
	    {
	        out.print("<input  name=allchoose onClick='allChoose()' style='cursor:hand' class=b_foot type=button value=全选>&nbsp");
	        out.print("<input  name=cancelAll onClick='cancelChoose()' style='cursor:hand' class=b_foot type=button value=取消全选>&nbsp");
	    }
	%>

<%
                if(selType.compareTo("") != 0){%>
                <input  name=commit onClick="saveTo()" style="cursor:hand" class="b_foot" type=button value=确认>&nbsp;
<%
  		}
%>
                <input  name=back onClick="window.close()" class="b_foot" style="cursor:hand" class="" type=button value=返回>&nbsp;
            </TD>
        </TR>   
</TABLE>
  <input type="hidden" name="retFieldNum" value=<%=fieldNum%>>
  <input type="hidden" name="retQuence" value=<%=retQuence%>>
  <%@ include file="/npage/include/footer_pop.jsp" %> 
</FORM>
</BODY>
</HTML>
