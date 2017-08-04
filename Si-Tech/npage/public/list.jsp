<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/public/3des_enc.jsp" %>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %> 
<%@ page import="com.sitech.crmpd.core.wtc.util.*"%>
<%@ page import="import java.util.regex.Matcher"%>
<%@ page import="import java.util.regex.Pattern"%>


<%
	
	Map map = request.getParameterMap();
	
	  String pageTitle = request.getParameter("pageTitle");
	  String pageSize = request.getParameter("pageSize");
    String fieldName = request.getParameter("fieldName");
    String sqlStr = request.getParameter("sqlStr");
    String selType = request.getParameter("selType");
    String retQuence = request.getParameter("retQuence");
    String currentPage = request.getParameter("currentPage") == null ? "1" : request.getParameter("currentPage") ;
    
    sqlStr = uncMe_nokey(sqlStr);
    sqlStr = sqlStr.trim();
    
    
    System.out.println("pageTitle=="+pageTitle);
    System.out.println("pageSize=="+pageSize);
    System.out.println("fieldName=="+fieldName);
    System.out.println("sqlStr==[[【"+sqlStr+"】]]");
    System.out.println("selType=="+selType);
    System.out.println("retQuence=="+retQuence);
    System.out.println("currentPage=="+currentPage);
	
	//selType控制列表类型，S为单选，M为多选，空为列表
	if(selType.equals("S")){
		selType = "radio";    
	}
    else if(selType.equals("M")){
    	selType = "checkbox";   
    }
    else
    {   
    	selType = "";   
    }
    
    String countSql = PageFilterSQL.getCountSQL(sqlStr);
    
    System.out.println("countSql==="+countSql);
	    
    String[] nameList = fieldName.split("\\|");
    int colNum = nameList.length;
	    
%>

	<wtc:pubselect name="sPubSelect" outnum="1" >
		<wtc:sql><%=countSql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="rowCount" scope="end"/>
<%
    String querySql = PageFilterSQL.getOraQuerySQL(sqlStr,currentPage,pageSize,rowCount[0][0]);
     
    System.out.println("querySql==="+querySql);
    
    System.out.println("rowCount[0][0]==="+rowCount[0][0]);
%>		
	<wtc:pubselect name="sPubSelect" outnum="<%=String.valueOf(colNum+1)%>" >
		<wtc:sql><%=querySql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="queryList" scope="end"/>
<%

        String test[][] = queryList;

        System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++");
        for(int outer=0 ; test != null && outer< test.length; outer++)
        {
                for(int inner=0 ; test[outer] != null && inner< test[outer].length; inner++)
                {
                        System.out.print(" | "+test[outer][inner]);
                }
                System.out.println(" | ");
        }
        System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++");

%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<link rel="stylesheet" type="text/css" href="/nresources/default/css/fenye.css" media="all" />
<link href="/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="/nresources/default/css/portalet.css" rel="stylesheet" type="text/css"></link>
<script type="text/javascript" src="/njs/extend/jquery/jquery123_pack.js"></script>	
<script type="text/javascript" src="/njs/si/core_sitech_pack.js"></script>	
<script type="text/javascript" src="/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="/njs/extend/jquery/block/jquery.blockUI.js"></script>
<script language="JavaScript" src="/njs/si/validate_pack.js"></script>
	<style type="text/css">
		body
		{
			margin-left: 0px;
			padding-left: 0px;
		}
	</style>
	
	<SCRIPT type=text/javascript>
		function saveTo(){
			
			var rIndex;        //选择框索引
			var retValue = ""; //返回值
			var obj;
			var retQuence = "<%=retQuence%>";  //返回字段域的序列
			
			var retQuenceArray =retQuence.split("\|");
			//返回单条记录
			var fPubSimpSels = document.getElementsByName("List");
			for(var i=0;i<fPubSimpSels.length;i++){ 
			   //判断是否被选中
			   if (fPubSimpSels[i].checked==true){
			         rIndex = fPubSimpSels[i].RIndex;
			         for(n=0;n<retQuenceArray.length;n++){   
			            obj = "Rinput" + rIndex + "_" + (parseInt(retQuenceArray[n])+1);
			            
			            retValue += document.all(obj).value + "|";
			         }
					 parent.window.returnValue= retValue     
			   }
			}
			if(retValue == ""){
			    rdShowMessageDialog("请选择信息项！",0);
			    return false;
			}
			window.close(); 
		}
		
		function allSel(obj){   
			//复选框全部选中
			if(obj.checked == true){
				flag=true;
			}else{
				flag=false;
			}
			
		    for(i=0;i<document.fPubSimpSel.elements.length;i++){ 
		        if(document.fPubSimpSel.elements[i].type=="checkbox"){    //判断是否是单选或复选框
		            document.fPubSimpSel.elements[i].checked = flag;
		        }
		    }  
		}
		
		onload=function(){
			window.document.title="1111";
		}
		
		
</SCRIPT>

<script language="javascript">
	function gotoPage(pageId)
	{
		document.form2.currentPage.value= pageId;
		document.form2.submit();
		return true;
		
	}
</script>
</head>
<body>
	
	<div id="POPUP_TOP">
		<div class="logo"></div>
	</div>
	<form name="fPubSimpSel">
	      	<%=PageListNav.pageNav(rowCount[0][0],pageSize,currentPage)%><a>总计<B class="orange"><%=rowCount[0][0]%></B>条记录</a>
	      	<br>
	      	<br>
				<div id="form" >
			  <table width="100%" border="0" cellpadding="0" cellspacing="0">
	            <tr>
	          <%
                if(selType.equals("checkbox"))
                { 
              %>          
              
					<th><input type="checkbox" name="allSelBut" onclick="allSel(this)"><span class="orange">全选</span></th>
              <%
                }
            	else if(selType.equals("radio")){
              %> 
					<th>&nbsp;</th>
              <%
                }
              %>
	            	
	          <%
	            for(int i=0;i<colNum;i++){
	          %>
	              
	              <th><%=nameList[i]%></th>
	          <%
	            }
	          %>
	            </tr>
	            
			<%
				for(int i=0;i<queryList.length;i++){
			%>
					<tr>
			<%
					String classes;
					if(i%2==0){
						classes="grey";
					}
					else{
						classes="";
					}
					if(!selType.equals("")){
			%>
						<TD align="center" class="<%=classes%>"><input type="<%=selType%>" name='List' style='cursor:hand' RIndex=<%=i%> onkeydown="if(event.keyCode==13) saveTo()" ></td>
			<%
					}					
					for(int j=0;j<colNum;j++){
			%>		
						<TD class="<%=classes%>"><%=queryList[i][j]%><input type="hidden" id="Rinput<%=i%>_<%=j+1%>" value="<%=queryList[i][j]%>" readonly></TD> 
			<%		
					}
			%>
					</tr>
			<%
				}
			%>
	            
	          </table>
			</div>
			
			<TABLE width="100%" border=0 align=center cellpadding="0" cellSpacing=0 >
		        <TR height="30"> 
		            <TD id="footer" >			
		                <input class="b_foot" name=commit1 onClick="saveTo()" style="cursor:hand" type=button value=确认>&nbsp;
		                &nbsp;&nbsp;&nbsp;&nbsp;
		                <input class="b_foot" name=back1 onClick="window.close()" style="cursor:hand" type=button value=返回>&nbsp;      
		                <input type="hidden" name="retFieldNum" id="retFieldNum"  value=<%=colNum%>>  
		            </TD>
		        </TR>
	      	</TABLE>
	      	<br>
			<%=PageListNav.pageNav(rowCount[0][0],pageSize,currentPage)%><a>总计<B class="orange"><%=rowCount[0][0]%></B>条记录</a>
			<br>
			<br>
	</form>
	<form name="form2" method="post">
		
<%=PageListNav.writeRequestString(map,currentPage)%>
		
	</form>
</body>
</html>

